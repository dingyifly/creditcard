/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.dao;

import java.util.List;

import com.dyf.creditcard.common.persistence.CrudDao;
import com.dyf.creditcard.common.persistence.annotation.MyBatisDao;
import com.dyf.creditcard.modules.work.entity.CardTransaction;

/**
 * 交易管理DAO接口
 * @author dyf
 * @version 2017-08-01
 */
@MyBatisDao
public interface CardTransactionDao extends CrudDao<CardTransaction> {
	
	/**
	 * 查找未操作的交易
	 * @param cardTransaction
	 * @return
	 */
	List<CardTransaction> findPendingList(CardTransaction cardTransaction);
	
	/**
	 * 改变状态
	 * @param cardTransaction
	 */
	void changeState(CardTransaction cardTransaction);

	/**
	 * 真实删除
	 * @param transaction
	 */
	void deleteTrue(CardTransaction transaction);
	
}