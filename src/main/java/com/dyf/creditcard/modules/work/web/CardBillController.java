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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dyf.creditcard.common.config.Global;
import com.dyf.creditcard.common.persistence.Page;
import com.dyf.creditcard.common.web.BaseController;
import com.dyf.creditcard.common.utils.StringUtils;
import com.dyf.creditcard.modules.sys.utils.DictUtils;
import com.dyf.creditcard.modules.work.entity.Card;
import com.dyf.creditcard.modules.work.entity.CardBill;
import com.dyf.creditcard.modules.work.service.CardBillService;

/**
 * 信用卡管理Controller
 * @author dyf
 * @version 2017-04-24
 */
@Controller
@RequestMapping(value = "${adminPath}/work/cardBill")
public class CardBillController extends BaseController {

	@Autowired
	private CardBillService cardBillService;
	
	@ModelAttribute
	public CardBill get(@RequestParam(required=false) String id) {
		CardBill entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cardBillService.get(id);
		}
		if (entity == null){
			entity = new CardBill();
		}
		return entity;
	}
	
	@RequiresPermissions("work:cardBill:view")
	@RequestMapping(value = {"list", ""})
	public String list(CardBill cardBill, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CardBill> page = cardBillService.findPage(new Page<CardBill>(request, response), cardBill); 
		model.addAttribute("page", page);
		model.addAttribute("state", cardBill.getState());
		return "modules/work/cardBillList";
	}

	@RequiresPermissions("work:cardBill:view")
	@RequestMapping(value = "form")
	public String form(CardBill cardBill, Model model) {
		model.addAttribute("cardBill", cardBill);
		return "modules/work/cardBillForm";
	}
	
	@RequiresPermissions("work:cardBill:view")
	@RequestMapping(value = "info")
	public String info(CardBill cardBill, Model model) {
		model.addAttribute("cardBill", cardBill);
		return "modules/work/cardBillInfo";
	}

	@RequiresPermissions("work:cardBill:edit")
	@RequestMapping(value = "save")
	public String save(CardBill cardBill, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cardBill)){
			return form(cardBill, model);
		}
		if(CommonUtils.isBlank(cardBill.getState())) {
			cardBill.setState("1" );
		}
		cardBillService.save(cardBill);
		addMessage(redirectAttributes, "保存信用卡成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardBill/?repage";
	}
	
	@RequiresPermissions("work:cardBill:edit")
	@RequestMapping(value = "delete")
	public String delete(CardBill cardBill, RedirectAttributes redirectAttributes) {
		cardBillService.delete(cardBill);
		addMessage(redirectAttributes, "删除信用卡成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardBill/?repage";
	}
	
	@RequiresPermissions("work:cardBill:edit")
	@RequestMapping(value = "convert")
	public String convert(CardBill cardBill, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, cardBill)){
			return form(cardBill, model);
		}*/
		cardBillService.save(cardBill);
		addMessage(redirectAttributes, "操作成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardBill/list?state="+request.getParameter("billState")+"&repage";
	}
	
	@RequiresPermissions("work:cardBill:edit")
	@RequestMapping(value = "subAccount")
	public String subAccount(CardBill cardBill, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, cardBill)){
			return form(cardBill, model);
		}*/
		cardBillService.subAccount(cardBill);
		addMessage(redirectAttributes, "操作成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardBill/list?state="+request.getParameter("billState")+"&repage";
	}
	
	@RequiresPermissions("work:card:edit")
	@RequestMapping(value = "updateBatch")
	public String updateBatch(Card card, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response, String billIds) {
//		cardService.save(card);
		String changeState = request.getParameter("changeState");
		cardBillService.updateBatch(billIds, changeState);
		addMessage(redirectAttributes, "批量操作成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardBill/list?state="+request.getParameter("billState")+"&repage";
	}
	
	

}