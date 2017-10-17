/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.dyf.creditcard.modules.work.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.dyf.creditcard.common.persistence.DataEntity;

/**
 * 信用卡管理Entity
 * @author dyf
 * @version 2017-04-24
 */
public class Card extends DataEntity<Card> {
	
	private static final long serialVersionUID = 1L;
	private String no;		// 卡号
	private String name;		// 卡主姓名
	private String phone;		// 卡主电话
	private String bank;		// 银行
	private String saleDepartment;		// 营业部
	private String saleManager;		// 销售经理------->修改为卡编号
	private String saleDirector;		// 销售主管
	private String receiver;		// 收单专员
	private String accountant;		// 对接会计
	private String tradePwd;		// 交易密码
	private String queryPwd;		// 查询密码
	private String loanAmount;		// 贷款金额
	private String billDate;		// 账单日
	private String loanDate;		// 放款日
	private String solidDay;		// 实还天数
	private String repaymentDay;		// 还款日期
	private Date modifyDate;		// 修改日期
	private String openNo;		// 开户行号
	private String cardAttr;		// 卡属性
	private String lendingRates;		// 贷款利率
	private String riskControl;		// 风控等级
	private String cardSource;		// 卡来源
	private Date effectiveDate;		// 有效日期
	private String identifier;		// 识别码
	private String paymentTime;		// 收款日期
	private String cardQuota;		// 卡片额度
	private String receiveInterest;		// 应收利息
	private String paidInterest;		// 实收利息
	private String paymentWay;		// 收款方式
	private String idNumber;		// 身份证号
	private String paymentDetail;		// 收款明细
	private String state;		// 状态
	
	public Card() {
		super();
	}

	public Card(String id){
		super(id);
	}

	@Length(min=0, max=64, message="卡号长度必须介于 0 和 64 之间")
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
	
	@Length(min=0, max=20, message="卡主姓名长度必须介于 0 和 20 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=20, message="卡主电话长度必须介于 0 和 20 之间")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@Length(min=0, max=64, message="银行长度必须介于 0 和 64 之间")
	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}
	
	@Length(min=0, max=100, message="营业部长度必须介于 0 和 100 之间")
	public String getSaleDepartment() {
		return saleDepartment;
	}

	public void setSaleDepartment(String saleDepartment) {
		this.saleDepartment = saleDepartment;
	}
	
	@Length(min=0, max=64, message="销售经理长度必须介于 0 和 64 之间")
	public String getSaleManager() {
		return saleManager;
	}

	public void setSaleManager(String saleManager) {
		this.saleManager = saleManager;
	}
	
	@Length(min=0, max=64, message="销售主管长度必须介于 0 和 64 之间")
	public String getSaleDirector() {
		return saleDirector;
	}

	public void setSaleDirector(String saleDirector) {
		this.saleDirector = saleDirector;
	}
	
	@Length(min=0, max=64, message="收单专员长度必须介于 0 和 64 之间")
	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	
	@Length(min=0, max=64, message="对接会计长度必须介于 0 和 64 之间")
	public String getAccountant() {
		return accountant;
	}

	public void setAccountant(String accountant) {
		this.accountant = accountant;
	}
	
	@Length(min=0, max=64, message="交易密码长度必须介于 0 和 64 之间")
	public String getTradePwd() {
		return tradePwd;
	}

	public void setTradePwd(String tradePwd) {
		this.tradePwd = tradePwd;
	}
	
	@Length(min=0, max=64, message="查询密码长度必须介于 0 和 64 之间")
	public String getQueryPwd() {
		return queryPwd;
	}

	public void setQueryPwd(String queryPwd) {
		this.queryPwd = queryPwd;
	}
	
	@Length(min=0, max=64, message="贷款金额长度必须介于 0 和 64 之间")
	public String getLoanAmount() {
		return loanAmount;
	}

	public void setLoanAmount(String loanAmount) {
		this.loanAmount = loanAmount;
	}
	
//	@JsonFormat(pattern = "dd")
	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}
	
//	@JsonFormat(pattern = "dd")
	public String getLoanDate() {
		return loanDate;
	}

	public void setLoanDate(String loanDate) {
		this.loanDate = loanDate;
	}
	
	@Length(min=0, max=20, message="实还天数长度必须介于 0 和 20 之间")
	public String getSolidDay() {
		return solidDay;
	}

	public void setSolidDay(String solidDay) {
		this.solidDay = solidDay;
	}
	
	@Length(min=0, max=20, message="还款日期长度必须介于 0 和 20 之间")
	public String getRepaymentDay() {
		return repaymentDay;
	}

	public void setRepaymentDay(String repaymentDay) {
		this.repaymentDay = repaymentDay;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	
	@Length(min=0, max=64, message="开户行号长度必须介于 0 和 64 之间")
	public String getOpenNo() {
		return openNo;
	}

	public void setOpenNo(String openNo) {
		this.openNo = openNo;
	}
	
	@Length(min=0, max=20, message="卡属性长度必须介于 0 和 20 之间")
	public String getCardAttr() {
		return cardAttr;
	}

	public void setCardAttr(String cardAttr) {
		this.cardAttr = cardAttr;
	}
	
	@Length(min=0, max=20, message="贷款利率长度必须介于 0 和 20 之间")
	public String getLendingRates() {
		return lendingRates;
	}

	public void setLendingRates(String lendingRates) {
		this.lendingRates = lendingRates;
	}
	
	@Length(min=0, max=20, message="风控等级长度必须介于 0 和 20 之间")
	public String getRiskControl() {
		return riskControl;
	}

	public void setRiskControl(String riskControl) {
		this.riskControl = riskControl;
	}
	
	@Length(min=0, max=64, message="卡来源长度必须介于 0 和 64 之间")
	public String getCardSource() {
		return cardSource;
	}

	public void setCardSource(String cardSource) {
		this.cardSource = cardSource;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEffectiveDate() {
		return effectiveDate;
	}

	public void setEffectiveDate(Date effectiveDate) {
		this.effectiveDate = effectiveDate;
	}
	
	@Length(min=0, max=10, message="识别码长度必须介于 0 和 10 之间")
	public String getIdentifier() {
		return identifier;
	}

	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}
	
	@Length(min=0, max=20, message="收款日期长度必须介于 0 和 20 之间")
	public String getPaymentTime() {
		return paymentTime;
	}

	public void setPaymentTime(String paymentTime) {
		this.paymentTime = paymentTime;
	}
	
	@Length(min=0, max=20, message="卡片额度长度必须介于 0 和 20 之间")
	public String getCardQuota() {
		return cardQuota;
	}

	public void setCardQuota(String cardQuota) {
		this.cardQuota = cardQuota;
	}
	
	@Length(min=0, max=30, message="应收利息长度必须介于 0 和 30 之间")
	public String getReceiveInterest() {
		return receiveInterest;
	}

	public void setReceiveInterest(String receiveInterest) {
		this.receiveInterest = receiveInterest;
	}
	
	@Length(min=0, max=30, message="实收利息长度必须介于 0 和 30 之间")
	public String getPaidInterest() {
		return paidInterest;
	}

	public void setPaidInterest(String paidInterest) {
		this.paidInterest = paidInterest;
	}
	
	@Length(min=0, max=30, message="收款方式长度必须介于 0 和 30 之间")
	public String getPaymentWay() {
		return paymentWay;
	}

	public void setPaymentWay(String paymentWay) {
		this.paymentWay = paymentWay;
	}
	
	@Length(min=0, max=20, message="身份证号长度必须介于 0 和 20 之间")
	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}
	
	@Length(min=0, max=255, message="收款明细长度必须介于 0 和 255 之间")
	public String getPaymentDetail() {
		return paymentDetail;
	}

	public void setPaymentDetail(String paymentDetail) {
		this.paymentDetail = paymentDetail;
	}
	
	@Length(min=0, max=10, message="状态长度必须介于 0 和 10 之间")
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
}