/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.dao;

import java.util.List;

import com.dyf.creditcard.common.persistence.CrudDao;
import com.dyf.creditcard.common.persistence.annotation.MyBatisDao;
import com.dyf.creditcard.modules.work.entity.CardInoperation;

/**
 * 不操作日管理DAO接口
 * @author dyf
 * @version 2017-08-28
 */
@MyBatisDao
public interface CardInoperationDao extends CrudDao<CardInoperation> {

	/**
	 * 查询不操作日列表
	 * @param cardInoperation
	 * @return
	 */
	List<CardInoperation> getLimitDateList(CardInoperation cardInoperation);
	
}