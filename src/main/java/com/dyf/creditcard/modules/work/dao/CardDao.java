/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.dao;

import java.util.List;

import com.dyf.creditcard.common.persistence.CrudDao;
import com.dyf.creditcard.common.persistence.Page;
import com.dyf.creditcard.common.persistence.annotation.MyBatisDao;
import com.dyf.creditcard.modules.work.entity.Card;

/**
 * 信用卡管理DAO接口
 * @author dyf
 * @version 2017-04-24
 */
@MyBatisDao
public interface CardDao extends CrudDao<Card> {

	/**
	 * 查询过期卡
	 * @param card
	 * @return
	 */
	List<Card> findExpireList(Card card);

	/**
	 * 查询未通知账单
	 * @param card
	 * @return
	 */
	List<Card> findUnAdviceList(Card card);

	/**
	 * 检查卡编号是否存在
	 * @param card
	 * @return
	 */
	Card checkSaleManager(Card card);
	
}