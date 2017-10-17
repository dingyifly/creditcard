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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dyf.creditcard.common.config.Global;
import com.dyf.creditcard.common.persistence.Page;
import com.dyf.creditcard.common.utils.DateUtils;
import com.dyf.creditcard.common.utils.StringUtils;
import com.dyf.creditcard.common.utils.excel.ExportExcel;
import com.dyf.creditcard.common.web.BaseController;
import com.dyf.creditcard.modules.sys.entity.User;
import com.dyf.creditcard.modules.sys.utils.DictUtils;
import com.dyf.creditcard.modules.work.entity.Card;
import com.dyf.creditcard.modules.work.entity.CardTransaction;
import com.dyf.creditcard.modules.work.service.CardTransactionService;

/**
 * 信用卡管理Controller
 * @author dyf
 * @version 2017-04-24
 */
@Controller
@RequestMapping(value = "${adminPath}/work/cardTransaction")
public class CardTransactionController extends BaseController {

	@Autowired
	private CardTransactionService cardTransactionService;
	
	@ModelAttribute
	public CardTransaction get(@RequestParam(required=false) String id) {
		CardTransaction entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cardTransactionService.get(id);
		}
		if (entity == null){
			entity = new CardTransaction();
		}
		return entity;
	}
	
	@RequiresPermissions("work:cardTransaction:view")
	@RequestMapping(value = {"list", ""})
	public String list(CardTransaction cardTransaction, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CardTransaction> page = cardTransactionService.findPage(new Page<CardTransaction>(request, response), cardTransaction); 
		model.addAttribute("page", page);
		model.addAttribute("state", cardTransaction.getState());
		return "modules/work/cardTransactionList";
	}

	@RequiresPermissions("work:cardTransaction:view")
	@RequestMapping(value = "form")
	public String form(CardTransaction cardTransaction, Model model) {
		model.addAttribute("cardTransaction", cardTransaction);
		return "modules/work/cardTransactionForm";
	}
	
	@RequiresPermissions("work:cardTransaction:view")
	@RequestMapping(value = "info")
	public String info(CardTransaction cardTransaction, Model model) {
		model.addAttribute("cardTransaction", cardTransaction);
		return "modules/work/cardTransactionInfo";
	}

	@RequiresPermissions("work:cardTransaction:edit")
	@RequestMapping(value = "save")
	public String save(CardTransaction cardTransaction, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cardTransaction)){
			return form(cardTransaction, model);
		}
		if(CommonUtils.isBlank(cardTransaction.getState())) {
			cardTransaction.setState("1" );
		}
		cardTransactionService.save(cardTransaction);
		addMessage(redirectAttributes, "保存信用卡成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardTransaction/?repage";
	}
	
	@RequiresPermissions("work:cardTransaction:edit")
	@RequestMapping(value = "delete")
	public String delete(CardTransaction cardTransaction, RedirectAttributes redirectAttributes) {
		cardTransactionService.delete(cardTransaction);
		addMessage(redirectAttributes, "删除信用卡成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardTransaction/?repage";
	}
	
	@RequiresPermissions("work:cardTransaction:edit")
	@RequestMapping(value = "convert")
	public String convert(CardTransaction cardTransaction, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, cardTransaction)){
			return form(cardTransaction, model);
		}*/
		cardTransactionService.save(cardTransaction);
		addMessage(redirectAttributes, "操作成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardTransaction/list?state="+request.getParameter("transactionState")+"&repage";
	}
	
	@RequiresPermissions("work:cardTransaction:edit")
	@RequestMapping(value = "subAccount")
	public String subAccount(CardTransaction cardTransaction, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, cardTransaction)){
			return form(cardTransaction, model);
		}*/
//		cardTransactionService.subAccount(cardTransaction);
		addMessage(redirectAttributes, "操作成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardTransaction/list?state="+request.getParameter("transactionState")+"&repage";
	}
	
	@RequiresPermissions("work:cardTransaction:edit")
	@RequestMapping(value = "updateBatch")
	public String updateBatch(Card card, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response, String transactionIds) {
//		cardService.save(card);
		String changeState = request.getParameter("changeState");
		cardTransactionService.updateBatch(transactionIds, changeState);
		System.out.println("选中的id：" + transactionIds);
		addMessage(redirectAttributes, "批量操作成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardTransaction/list?state="+request.getParameter("transactionState")+"&repage";
	}
	
	@RequiresPermissions("work:cardTransaction:edit")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(CardTransaction cardTransaction, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "交易数据.xlsx";
            Page<CardTransaction> page = cardTransactionService.findPage(new Page<CardTransaction>(request, response), cardTransaction); 
    		new ExportExcel(DictUtils.getDictLabel(cardTransaction.getState(), "transaction_state", "全部")+"数据", CardTransaction.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出交易数据！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/work/cardTransaction/list?state="+request.getParameter("transactionState")+"&repage";
    }
	
	@RequiresPermissions("work:cardTransaction:edit")
    @RequestMapping(value = "deleteUnActive")
	public String deleteUnActive(CardTransaction cardTransaction, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		cardTransactionService.deleteTrue(cardTransaction);
		return "redirect:"+Global.getAdminPath()+"/work/cardTransaction/list?state=0&repage";
	}
	
	@RequiresPermissions("work:cardTransaction:edit")
    @RequestMapping(value = "deleteUnActiveBatch")
	public String deleteUnActiveBatch(CardTransaction cardTransaction, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes, String transactionIds) {
		cardTransactionService.deleteTrueBatch(transactionIds);
		return "redirect:"+Global.getAdminPath()+"/work/cardTransaction/list?state=0&repage";
	}
	
	@RequiresPermissions("work:cardTransaction:edit")
	@RequestMapping(value = "addRemarks")
	public String addRemarks(CardTransaction cardTransaction, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, cardTransaction)){
			return form(cardTransaction, model);
		}*/
		cardTransactionService.save(cardTransaction);
		addMessage(redirectAttributes, "操作成功");
		return "redirect:"+Global.getAdminPath()+"/work/cardTransaction/list?state=4&repage";
	}

}