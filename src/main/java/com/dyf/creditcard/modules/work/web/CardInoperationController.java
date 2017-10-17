/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
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
import com.dyf.creditcard.modules.work.entity.CardInoperation;
import com.dyf.creditcard.modules.work.service.CardInoperationService;

/**
 * 不操作日管理Controller
 * @author dyf
 * @version 2017-08-28
 */
@Controller
@RequestMapping(value = "${adminPath}/work/cardInoperation")
public class CardInoperationController extends BaseController {

	@Autowired
	private CardInoperationService cardInoperationService;
	
	@ModelAttribute
	public CardInoperation get(@RequestParam(required=false) String id) {
		CardInoperation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cardInoperationService.get(id);
		}
		if (entity == null){
			entity = new CardInoperation();
		}
		return entity;
	}
	
	@RequiresPermissions("work:cardInoperation:view")
	@RequestMapping(value = {"list", ""})
	public String list(CardInoperation cardInoperation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CardInoperation> page = cardInoperationService.findPage(new Page<CardInoperation>(request, response), cardInoperation); 
		model.addAttribute("page", page);
		return "modules/work/cardInoperationList";
	}

	@RequiresPermissions("work:cardInoperation:view")
	@RequestMapping(value = "form")
	public String form(CardInoperation cardInoperation, Model model) {
		model.addAttribute("cardInoperation", cardInoperation);
		return "modules/work/cardInoperationForm";
	}

	@RequiresPermissions("work:cardInoperation:edit")
	@RequestMapping(value = "save")
	public String save(CardInoperation cardInoperation, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cardInoperation)){
			return form(cardInoperation, model);
		}
		cardInoperationService.save(cardInoperation);
		addMessage(redirectAttributes, "保存不操作日成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardInoperation/?repage";
	}
	
	@RequiresPermissions("work:cardInoperation:edit")
	@RequestMapping(value = "delete")
	public String delete(CardInoperation cardInoperation, RedirectAttributes redirectAttributes) {
		cardInoperationService.delete(cardInoperation);
		addMessage(redirectAttributes, "删除不操作日成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardInoperation/?repage";
	}

}