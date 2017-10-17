/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.entity;

import org.hibernate.validator.constraints.Length;

import com.dyf.creditcard.common.persistence.DataEntity;

/**
 * 账单管理Entity
 * @author dyf
 * @version 2017-07-05
 */
public class CardBill extends DataEntity<CardBill> {
	
	private static final long serialVersionUID = 1L;
	private String state;		// 账单状态
	private String month;		//月份
	private int days;			//分账天数
	private String amount;		//还款金额
	private Card card;		// 信用卡id 父类
	
	public CardBill() {
		super();
	}

	public CardBill(String id){
		super(id);
	}

	public CardBill(Card card){
		this.card = card;
	}

	@Length(min=0, max=2, message="账单状态长度必须介于 0 和 2 之间")
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	@Length(min=0, max=10, message="账单月份长度必须介于 0 和 10 之间")
	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	@Length(min=0, max=10, message="分账天数长度必须介于 0 和 10 之间")
	public int getDays() {
		return days;
	}

	public void setDays(int days) {
		this.days = days;
	}

	@Length(min=0, max=10, message="还款金额长度必须介于 0 和 10 之间")
	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	@Length(min=0, max=64, message="信用卡id长度必须介于 0 和 64 之间")
	public Card getCard() {
		return card;
	}

	public void setCard(Card card) {
		this.card = card;
	}
	
}