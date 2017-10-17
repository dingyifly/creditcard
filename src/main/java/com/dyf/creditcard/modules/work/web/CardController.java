/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.jasig.cas.client.util.CommonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dyf.creditcard.common.config.Global;
import com.dyf.creditcard.common.persistence.Page;
import com.dyf.creditcard.common.utils.CommonUtil;
import com.dyf.creditcard.common.utils.StringUtils;
import com.dyf.creditcard.common.web.BaseController;
import com.dyf.creditcard.modules.sys.utils.DictUtils;
import com.dyf.creditcard.modules.work.entity.Card;
import com.dyf.creditcard.modules.work.service.CardService;

/**
 * 信用卡管理Controller
 * @author dyf
 * @version 2017-04-24
 */
@Controller
@RequestMapping(value = "${adminPath}/work/card")
public class CardController extends BaseController {

	@Autowired
	private CardService cardService;
	
	@ModelAttribute
	public Card get(@RequestParam(required=false) String id) {
		Card entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cardService.get(id);
		}
		if (entity == null){
			entity = new Card();
		}
		return entity;
	}
	
	@RequiresPermissions("work:card:view")
	@RequestMapping(value = {"list", ""})
	public String list(Card card, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Card> page = cardService.findPage(new Page<Card>(request, response), card); 
		model.addAttribute("page", page);
		model.addAttribute("state", card.getState());
		return "modules/work/cardList";
	}

	@RequiresPermissions("work:card:view")
	@RequestMapping(value = "form")
	public String form(Card card, Model model) {
		model.addAttribute("card", card);
		return "modules/work/cardForm";
	}
	
	@RequiresPermissions("work:card:view")
	@RequestMapping(value = "info")
	public String info(Card card, Model model) {
		model.addAttribute("card", card);
		return "modules/work/cardInfo";
	}

	@RequiresPermissions("work:card:edit")
	@RequestMapping(value = "save")
	public String save(Card card, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, card)){
			return form(card, model);
		}
		if(CommonUtils.isBlank(card.getState())) {
			card.setState("1" );
		}
		cardService.save(card);
		addMessage(redirectAttributes, "保存信用卡成功");
		return "redirect:"+Global.getAdminPath()+"/work/card/list?state="+card.getState()+"&repage";
	}
	
	@RequiresPermissions("work:card:edit")
	@RequestMapping(value = "delete")
	public String delete(Card card, RedirectAttributes redirectAttributes) {
		cardService.delete(card);
		addMessage(redirectAttributes, "删除信用卡成功");
		return "redirect:"+Global.getAdminPath()+"/work/card/?repage";
	}
	
	@RequiresPermissions("work:card:view")
	@RequestMapping(value = {"expire"})
	public String expire(Card card, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Card> page = cardService.findExpirePage(new Page<Card>(request, response), card); 
		model.addAttribute("page", page);
		return "modules/work/expireList";
	}
	
	@RequiresPermissions("work:card:edit")
	@RequestMapping(value = "convert")
	public String convert(Card card, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, card)){
			return form(card, model);
		}
		cardService.save(card);
		addMessage(redirectAttributes, "转换信用卡成功");
		return "redirect:"+Global.getAdminPath()+"/work/card/list?state="+request.getParameter("preState")+"&repage";
	}
	
	@RequiresPermissions("work:card:view")
	@RequestMapping(value = {"bill"})
	public String bill(Card card, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Card> page = cardService.unAdvice(new Page<Card>(request, response), card); 
		model.addAttribute("page", page);
		return "modules/work/unAdviceList";
	}
	
	@RequiresPermissions("work:card:edit")
	@RequestMapping(value = "createBill")
	public String createBill(Card card, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		String billState = request.getParameter("billState");
		if (!beanValidator(model, card)){
			return form(card, model);
		}
		addMessage(redirectAttributes, DictUtils.getDictLabel(billState, "bill_state", "0") + "成功");
		cardService.createBill(card, billState);
		return "redirect:"+Global.getAdminPath()+"/work/card/bill";
	}
	
	@RequiresPermissions("work:card:edit")
	@RequestMapping(value = "updateBatch")
	public String updateBatch(Card card, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response, String cardIds) {
//		cardService.save(card);
		String changeState = request.getParameter("changeState");
		cardService.updateBatch(cardIds, changeState);
		addMessage(redirectAttributes, "批量操作成功");
		return "redirect:"+Global.getAdminPath()+"/work/card/list?state="+request.getParameter("preState")+"&repage";
	}
	
	@RequiresPermissions("work:card:edit")
	@RequestMapping(value = "checkSaleManager")
	@ResponseBody
	public String checkSaleManager(Card card, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) {
		Card c = cardService.checkSaleManager(card);
		if (c == null || CommonUtil.isEmpty(c.getId())){
			return "true";
		}
		return "false";
	}
	
}