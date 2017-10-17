/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.service;

import java.util.List;

import org.jasig.cas.client.util.CommonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dyf.creditcard.common.persistence.Page;
import com.dyf.creditcard.common.service.CrudService;
import com.dyf.creditcard.common.utils.CommonUtil;
import com.dyf.creditcard.modules.work.dao.CardTransactionDao;
import com.dyf.creditcard.modules.work.entity.Card;
import com.dyf.creditcard.modules.work.entity.CardTransaction;

import freemarker.template.utility.StringUtil;

/**
 * 信用卡管理Service
 * @author dyf
 * @version 2017-04-24
 */
@Service
@Transactional(readOnly = true)
public class CardTransactionService extends CrudService<CardTransactionDao, CardTransaction> {
	
	@Autowired
	
	public CardTransaction get(String id) {
		return super.get(id);
	}
	
	public List<CardTransaction> findList(CardTransaction transaction) {
		return super.findList(transaction);
	}
	
	public Page<CardTransaction> findPage(Page<CardTransaction> page, CardTransaction transaction) {
		return super.findPage(page, transaction);
	}
	
	@Transactional(readOnly = false)
	public void save(CardTransaction transaction) {
		super.save(transaction);
	}
	
	@Transactional(readOnly = false)
	public void delete(CardTransaction transaction) {
		super.delete(transaction);
	}
	
	/**
	 * 查找待处理交易，并将之状态改为操作中
	 * @param transaction
	 */
	@Transactional(readOnly = false)
	public void pendingToAction(CardTransaction transaction) {
		List<CardTransaction> transactionList = dao.findPendingList(transaction);
		if(CommonUtil.notEmpty(transactionList)) {
			for (CardTransaction t : transactionList) {
				t.preUpdate();
				t.setState("1");
				dao.update(t);
			}
		}
	}

	/**
	 * 批量修改状态
	 * @param transactionIds
	 * @param changeState
	 */
	@Transactional(readOnly = false)
	public void updateBatch(String transactionIds, String changeState) {
		if(CommonUtil.notEmpty(transactionIds) && CommonUtil.notEmpty(changeState)) {
			String[] ids = StringUtil.split(transactionIds, ',');
			for (String id : ids) {
				CardTransaction transaction = super.get(id);
				transaction.setState(changeState);
				super.save(transaction);
			}
		}
	}

	/**
	 * 真实删除
	 */
	@Transactional(readOnly = false)
	public void deleteTrue(CardTransaction transaction) {
		dao.deleteTrue(transaction);
	}
	
	/**
	 * 真实删除(批量)
	 */
	@Transactional(readOnly = false)
	public void deleteTrueBatch(String transactionIds) {
		if(CommonUtil.notEmpty(transactionIds)) {
			String[] ids = StringUtil.split(transactionIds, ',');
			for (String id : ids) {
				dao.deleteTrue(new CardTransaction(id));
			}
		}
	}

}