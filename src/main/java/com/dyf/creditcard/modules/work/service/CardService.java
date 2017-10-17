/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dyf.creditcard.common.persistence.Page;
import com.dyf.creditcard.common.service.CrudService;
import com.dyf.creditcard.common.utils.CommonUtil;
import com.dyf.creditcard.common.utils.DateUtils;
import com.dyf.creditcard.modules.work.dao.CardBillDao;
import com.dyf.creditcard.modules.work.dao.CardDao;
import com.dyf.creditcard.modules.work.entity.Card;
import com.dyf.creditcard.modules.work.entity.CardBill;

import freemarker.template.utility.StringUtil;

/**
 * 信用卡管理Service
 * @author dyf
 * @version 2017-04-24
 */
@Service
@Transactional(readOnly = true)
public class CardService extends CrudService<CardDao, Card> {
	
	@Autowired
	private CardBillDao billDao;

	public Card get(String id) {
		return super.get(id);
	}
	
	public List<Card> findList(Card card) {
		return super.findList(card);
	}
	
	public Page<Card> findPage(Page<Card> page, Card card) {
		return super.findPage(page, card);
	}
	
	@Transactional(readOnly = false)
	public void save(Card card) {
		super.save(card);
	}
	
	@Transactional(readOnly = false)
	public void delete(Card card) {
		super.delete(card);
	}

	public Page<Card> findExpirePage(Page<Card> page, Card card) {
		card.setPage(page);
		page.setList(dao.findExpireList(card));
		return page;
	}

	/**
	 * 查询未通知账单
	 * @param page
	 * @param card
	 * @return
	 */
	public Page<Card> unAdvice(Page<Card> page, Card card) {
		card.setPage(page);
		page.setList(dao.findUnAdviceList(card));
		return page;
	}

	/**
	 * 创建当月菜单
	 * @param card
	 * @param billState
	 */
	@Transactional(readOnly = false)
	public void createBill(Card card, String billState) {
		CardBill bill = new CardBill();
		bill.setState(billState);
		bill.setMonth(DateUtils.getDate("yyyy-MM"));
		bill.setCard(card);
		bill.preInsert();
		billDao.insert(bill);
		if ("5".equals(billState)){
			card.setState("4");
			super.save(card);
		}
	}

	/**
	 * 批量修改状态
	 * @param cardIds
	 * @param changeState
	 */
	@Transactional(readOnly = false)
	public void updateBatch(String cardIds, String changeState) {
		if(CommonUtil.notEmpty(cardIds) && CommonUtil.notEmpty(changeState)) {
			String[] ids = StringUtil.split(cardIds, ',');
			for (String id : ids) {
				Card card = super.get(id);
				card.setState(changeState);
				super.save(card);
			}
		}
	}

	/**
	 * 检查卡编号是否存在
	 * @param card
	 * @return
	 */
	public Card checkSaleManager(Card card) {
		Card c = dao.checkSaleManager(card);
		return c;
	}
	
}