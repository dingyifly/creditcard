/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.entity;

import org.hibernate.validator.constraints.Length;

import com.dyf.creditcard.common.persistence.DataEntity;
import com.dyf.creditcard.common.utils.excel.annotation.ExcelField;

/**
 * 交易管理Entity
 * @author dyf
 * @version 2017-08-01
 */
public class CardTransaction extends DataEntity<CardTransaction> {
	
	private static final long serialVersionUID = 1L;
	private String account;		// 金额
	private String state;		// 账单状态
	private String month;		// 月份
	private CardBill bill;		// 账单ID 父类
	private String oneIn;		// 一进
	private Card card;		// 信用卡id
	private String oneOut;		// 一出
	private String costOne;		// 成本一
	private String twoIn;		// 二进
	private String twoOut;		// 二出
	private String costTwo;		// 成本二
	private String dealDate;	//处理日期
	private String cardName;	//卡主姓名
	
	public CardTransaction() {
		super();
	}

	public CardTransaction(String id){
		super(id);
	}

	public CardTransaction(CardBill bill){
		this.bill = bill;
	}

	@Length(min=0, max=20, message="金额长度必须介于 0 和 20 之间")
	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}
	
	@Length(min=0, max=2, message="账单状态长度必须介于 0 和 2 之间")
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	@Length(min=0, max=10, message="月份长度必须介于 0 和 10 之间")
	@ExcelField(title="月份", align=2, sort=20)
	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}
	
	@Length(min=0, max=64, message="账单ID长度必须介于 0 和 64 之间")
	public CardBill getBill() {
		return bill;
	}

	public void setBill(CardBill bill) {
		this.bill = bill;
	}
	
	@Length(min=0, max=10, message="一进长度必须介于 0 和 10 之间")
	@ExcelField(title="一进", align=2, sort=40)
	public String getOneIn() {
		return oneIn;
	}

	public void setOneIn(String oneIn) {
		this.oneIn = oneIn;
	}
	
	@Length(min=0, max=64, message="信用卡id长度必须介于 0 和 64 之间")
	@ExcelField(value="card.no", title="卡号", align=2, sort=10)
	public Card getCard() {
		return card;
	}

	public void setCard(Card card) {
		this.card = card;
	}
	
	@Length(min=0, max=10, message="一出长度必须介于 0 和 10 之间")
	@ExcelField(title="一出", align=2, sort=50)
	public String getOneOut() {
		return oneOut;
	}

	public void setOneOut(String oneOut) {
		this.oneOut = oneOut;
	}
	
	@Length(min=0, max=10, message="成本一长度必须介于 0 和 10 之间")
	@ExcelField(title="成本1", align=2, sort=60)
	public String getCostOne() {
		return costOne;
	}

	public void setCostOne(String costOne) {
		this.costOne = costOne;
	}
	
	@Length(min=0, max=10, message="二进长度必须介于 0 和 10 之间")
	@ExcelField(title="二进", align=2, sort=70)
	public String getTwoIn() {
		return twoIn;
	}

	public void setTwoIn(String twoIn) {
		this.twoIn = twoIn;
	}
	
	@Length(min=0, max=10, message="二出长度必须介于 0 和 10 之间")
	@ExcelField(title="二出", align=2, sort=80)
	public String getTwoOut() {
		return twoOut;
	}

	public void setTwoOut(String twoOut) {
		this.twoOut = twoOut;
	}
	
	@Length(min=0, max=10, message="成本二长度必须介于 0 和 10 之间")
	@ExcelField(title="成本2", align=2, sort=90)
	public String getCostTwo() {
		return costTwo;
	}

	public void setCostTwo(String costTwo) {
		this.costTwo = costTwo;
	}

	@Length(min=0, max=10, message="处理日期长度必须介于 0 和 20 之间")
	@ExcelField(title="处理日期", align=2, sort=30)
	public String getDealDate() {
		return dealDate;
	}

	public void setDealDate(String dealDate) {
		this.dealDate = dealDate;
	}
	@ExcelField(value="card.name", title="所属账号", align=2, sort=5)
	public String getCardName() {
		return cardName;
	}

	public void setCardName(String cardName) {
		this.cardName = cardName;
	}
	
	private String amount;

	@ExcelField(value="bill.amount", title="贷款金额", align=2, sort=25)
	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	@ExcelField(title="备注", align=2, sort=120)
	private String remarks;

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	@ExcelField(value="card.bank", title="银行", align=2, sort=11)
	private String bank;
	@ExcelField(value="card.tradePwd", title="交易密码", align=2, sort=12)
	private String tradePwd;
	@ExcelField(value="card.saleManager", title="卡编号", align=2, sort=13)
	private String saleManager;
	@ExcelField(value="card.billDate", title="账单日", align=2, sort=26)
	private String billDate;
	@ExcelField(value="card.repaymentDay", title="还款日期", align=2, sort=27)
	private String repaymentDay;

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getTradePwd() {
		return tradePwd;
	}

	public void setTradePwd(String tradePwd) {
		this.tradePwd = tradePwd;
	}

	public String getSaleManager() {
		return saleManager;
	}

	public void setSaleManager(String saleManager) {
		this.saleManager = saleManager;
	}

	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	public String getRepaymentDay() {
		return repaymentDay;
	}

	public void setRepaymentDay(String repaymentDay) {
		this.repaymentDay = repaymentDay;
	}
	
}