/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.dao;

import com.dyf.creditcard.common.persistence.CrudDao;
import com.dyf.creditcard.common.persistence.annotation.MyBatisDao;
import com.dyf.creditcard.modules.work.entity.CardBill;

/**
 * 账单管理DAO接口
 * @author dyf
 * @version 2017-07-05
 */
@MyBatisDao
public interface CardBillDao extends CrudDao<CardBill> {
	
}