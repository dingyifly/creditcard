/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.entity;

import org.hibernate.validator.constraints.Length;

import com.dyf.creditcard.common.persistence.DataEntity;

/**
 * 不操作日管理Entity
 * @author dyf
 * @version 2017-08-28
 */
public class CardInoperation extends DataEntity<CardInoperation> {
	
	private static final long serialVersionUID = 1L;
	private String limitDate;		// 限制日期
	
	public CardInoperation() {
		super();
	}

	public CardInoperation(String id){
		super(id);
	}

	@Length(min=0, max=10, message="限制日期长度必须介于 0 和 10 之间")
	public String getLimitDate() {
		return limitDate;
	}

	public void setLimitDate(String limitDate) {
		this.limitDate = limitDate;
	}
	
}