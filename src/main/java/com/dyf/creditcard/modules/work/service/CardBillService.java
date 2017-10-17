/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.service;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
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
import com.dyf.creditcard.modules.work.dao.CardInoperationDao;
import com.dyf.creditcard.modules.work.dao.CardTransactionDao;
import com.dyf.creditcard.modules.work.entity.Card;
import com.dyf.creditcard.modules.work.entity.CardBill;
import com.dyf.creditcard.modules.work.entity.CardInoperation;
import com.dyf.creditcard.modules.work.entity.CardTransaction;
import com.dyf.creditcard.modules.work.tools.DateUtil;
import com.google.common.collect.Lists;

import freemarker.template.utility.StringUtil;

/**
 * 信用卡管理Service
 * @author dyf
 * @version 2017-04-24
 */
@Service
@Transactional(readOnly = true)
public class CardBillService extends CrudService<CardBillDao, CardBill> {
	
	@Autowired
	private CardTransactionDao tDao;
	@Autowired
	private CardDao cDao;
	@Autowired
	private CardInoperationDao iDao;
	
	public CardBill get(String id) {
		return super.get(id);
	}
	
	public List<CardBill> findList(CardBill bill) {
		return super.findList(bill);
	}
	
	public Page<CardBill> findPage(Page<CardBill> page, CardBill bill) {
		return super.findPage(page, bill);
	}
	
	@Transactional(readOnly = false)
	public void save(CardBill bill) {
		super.save(bill);
	}
	
	@Transactional(readOnly = false)
	public void delete(CardBill bill) {
		super.delete(bill);
	}

	@Transactional(readOnly = false)
	public void subAccount(CardBill bill) {
		bill.setState("6");//状态变为已分账
		super.save(bill);
		Card c = cDao.get(bill.getCard().getId());
		c.setLoanAmount(bill.getAmount());
		cDao.update(c);
		List<CardTransaction> list = generateTransaction(bill);
		for (CardTransaction transaction : list) {
			transaction.preInsert();
			tDao.insert(transaction);
		}
//		System.out.println(list.size());
	}
	
	/**
	 * 生成交易记录
	 * @param bill
	 * @return
	 */
	public List<CardTransaction> generateTransaction(CardBill bill) {
		List<CardTransaction> list = Lists.newArrayList();
		Card card = bill.getCard();
		String loanAmount = bill.getAmount();
		int days = bill.getDays();
		int d = days * 2;
//		float first = Float.parseFloat(new DecimalFormat("#.00").format(Float.valueOf(loanAmount) * 0.006f));
		float first = (float)Math.ceil(Float.valueOf(loanAmount) * 0.006f);
		int m = (int)Math.floor(((Float.valueOf(loanAmount) - first) / (d-1)));
		int wave = (int)Math.floor(Float.valueOf(loanAmount) * 0.01f);
//		Float sub = Float.valueOf(loanAmount) / (d);
		float t = 0f;
		float ot = 0f;
		float c = 0f;
		List<CardInoperation> limitDateList = iDao.getLimitDateList(new CardInoperation());
		List<String> dealDateList = new ArrayList<String>();
		dealDateList = generateDealDateList(dealDateList, new Date(), days, days, limitDateList);
		Iterator<String> it = dealDateList.iterator();
		for (int i = 0; i < d; i = i+2) {
			CardTransaction transaction = new CardTransaction();
			float m1, m2, o1, o2;//一进， 二进， 一出， 二出
			if (i == 0) {
				m1 = first;
				t += m1;
				float r = (float)Math.floor(Math.random()*wave);
				o1 = (first - r) > 0 ? first - r : (first - (r = (float)Math.floor(Math.random()*5)));
				ot += o1;
				if (d == 2) {
					m2 = Float.valueOf(loanAmount) - t;
					o2 = Float.valueOf(loanAmount) - ot;
				} else {
					m2 = m + (float)(Math.floor(Math.random()*wave) * (Math.random() > 0.5 ? 1 : -1));
					t += m2;
					float r2 = (float)Math.floor(Math.random()*wave);
					o2 = (m2 + r) - r2;
					ot += o2;
					c = r2;
				}
			} else if (i == d - 2) {
				float r = (float)Math.floor(Math.random()*wave);
				m1 = m + (float)(Math.floor(Math.random()*wave) * (Math.random() > 0.5 ? 1 : -1));
				t += m1;
				o1 = (m1 + c) - r;
				ot += o1;
				//m2 = Float.valueOf(loanAmount) - t;
				String m2Str = new DecimalFormat("#.00").format(new BigDecimal(loanAmount).subtract(new BigDecimal(t)));
				m2 = Float.parseFloat(m2Str.endsWith("0") ? m2Str.substring(0, m2Str.lastIndexOf("0")) : m2Str);
//				o2 = Float.valueOf(loanAmount) - ot;
				String o2Str = new DecimalFormat("#.00").format(new BigDecimal(loanAmount).subtract(new BigDecimal(ot)));
				o2 = Float.parseFloat(o2Str.endsWith("0") ? o2Str.substring(0, o2Str.lastIndexOf("0")) : o2Str);
			} else {
				float r = (float)Math.floor(Math.random()*wave);
				m1 = m + (float)(Math.floor(Math.random()*wave) * (Math.random() > 0.5 ? 1 : -1));
				t += m1;
				o1 = (m1 + c) - r;
				ot += o1;
				float r2 = (float)Math.floor(Math.random()*wave);
				m2 = m + (float)(Math.floor(Math.random()*wave) * (Math.random() > 0.5 ? 1 : -1));
				t += m2;
				o2 = (m2 + r) - r2;
				ot += o2;
				c = r2;
			}
			transaction.setOneIn(String.valueOf(m1));
			transaction.setOneOut(String.valueOf(o1));
			transaction.setTwoIn(String.valueOf(m2));
			transaction.setTwoOut(String.valueOf(o2));
			transaction.setAccount(String.valueOf(new BigDecimal(m1).add(new BigDecimal(m2)).toString()));
			transaction.setCostOne(String.valueOf(new DecimalFormat("#0.00").format(new BigDecimal(m1+"").multiply(new BigDecimal("0.06")))));
			transaction.setCostTwo(String.valueOf(new DecimalFormat("#0.00").format(new BigDecimal(m2+"").multiply(new BigDecimal("0.06")))));
			transaction.setCard(card);
			transaction.setBill(bill);
			transaction.setDealDate(it.next());
			transaction.setState("0");
			transaction.setMonth(DateUtils.getDate("yyyy-MM"));
			list.add(transaction);
		}
		return list;
	}
	
	/**
	 * 生成操作日期
	 * @param d
	 * @param limitDateList
	 * @return
	 */
	public List<String> generateDealDateList(List<String> dealDateList, Date day, int d, int l, List<CardInoperation> limitDateList) {
		for (int i = 0; i < l; i++) {
			dealDateList.add(DateUtil.formatDate(DateUtil.addDay(day, i + 1)));
		}
		List<String> limitDates = null;
		if (CommonUtil.notEmpty(limitDateList)) {
			limitDates = new ArrayList<String>();
			for (CardInoperation ci : limitDateList) {
				limitDates.add(ci.getLimitDate());
			}
		}
		Iterator<String> it = dealDateList.iterator();
		while (it.hasNext()) {
			String dd = (String) it.next();
			/*if (!DateUtil.isWorkDay(DateUtil.parseDate(dd))) {
				it.remove();
				continue;
			}*/
			if (CommonUtil.notEmpty(limitDates) && limitDates.contains(dd)) {
				it.remove();
				continue;
			}
		}
		if (dealDateList.size() == d) {
			return dealDateList;
		}
		/*if (DateUtil.isFriday(DateUtil.parseDate(dealDateList.get(dealDateList.size() - 1)))) {
			day = DateUtil.addDay(DateUtil.parseDate(dealDateList.get(dealDateList.size() - 1)), 2);
		} else {
		}*/
		day = DateUtil.parseDate(dealDateList.get(dealDateList.size() - 1));
		l = d - dealDateList.size();
		return generateDealDateList(dealDateList, day, d, l, limitDateList);
	}

	/**
	 * 批量修改状态
	 * @param billIds
	 * @param changeState
	 */
	@Transactional(readOnly = false)
	public void updateBatch(String billIds, String changeState) {
		if(CommonUtil.notEmpty(billIds) && CommonUtil.notEmpty(changeState)) {
			String[] ids = StringUtil.split(billIds, ',');
			for (String id : ids) {
				CardBill card = super.get(id);
				card.setState(changeState);
				super.save(card);
			}
		}
	}
	
}