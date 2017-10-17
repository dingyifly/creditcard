<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>信用卡管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">信用卡详情</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="card" action="${ctx}/work/card/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">卡号：</label>
			<div class="controls">
				<form:input readonly="true" path="no" htmlEscape="false" maxlength="64" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">卡主姓名：</label>
			<div class="controls">
				<form:input readonly="true" path="name" htmlEscape="false" maxlength="20" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">卡主电话：</label>
			<div class="controls">
				<form:input readonly="true" path="phone" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">银行：</label>
			<div class="controls">
				<form:input readonly="true" path="bank" htmlEscape="false" maxlength="64" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">营业部：</label>
			<div class="controls">
				<form:input readonly="true" path="saleDepartment" htmlEscape="false" maxlength="100" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">销售经理：</label>
			<div class="controls">
				<form:input readonly="true" path="saleManager" htmlEscape="false" maxlength="64" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">销售主管：</label>
			<div class="controls">
				<form:input readonly="true" path="saleDirector" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收单专员：</label>
			<div class="controls">
				<form:input readonly="true" path="receiver" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">对接会计：</label>
			<div class="controls">
				<form:input readonly="true" path="accountant" htmlEscape="false" maxlength="64" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易密码：</label>
			<div class="controls">
				<form:input readonly="true" path="tradePwd" htmlEscape="false" maxlength="64" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">查询密码：</label>
			<div class="controls">
				<form:input readonly="true" path="queryPwd" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">贷款金额：</label>
			<div class="controls">
				<form:input readonly="true" path="loanAmount" htmlEscape="false" maxlength="64" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">账单日：</label>
			<div class="controls">
				<input readonly="readonly" name="billDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="${card.billDate}"
					onclick="WdatePicker({dateFmt:'dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">放款日：</label>
			<div class="controls">
				<input readonly="readonly" name="loanDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="${card.loanDate}"
					onclick="WdatePicker({dateFmt:'dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">实还天数：</label>
			<div class="controls">
				<form:input readonly="true" path="solidDay" htmlEscape="false" maxlength="20" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">还款日期：</label>
			<div class="controls">
				<form:input readonly="true" path="repaymentDay" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">修改日期：</label>
			<div class="controls">
				<input readonly="readonly" name="modifyDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${card.modifyDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开户行号：</label>
			<div class="controls">
				<form:input readonly="true" path="openNo" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">卡属性：</label>
			<div class="controls">
				<form:input readonly="true" path="cardAttr" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">贷款利率：</label>
			<div class="controls">
				<form:input readonly="true" path="lendingRates" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">风控等级：</label>
			<div class="controls">
				<form:input readonly="true" path="riskControl" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">卡来源：</label>
			<div class="controls">
				<form:input readonly="true" path="cardSource" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">有效日期：</label>
			<div class="controls">
				<input readonly="readonly" name="effectiveDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${card.effectiveDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">识别码：</label>
			<div class="controls">
				<form:input readonly="true" path="identifier" htmlEscape="false" maxlength="10" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收款日期：</label>
			<div class="controls">
				<form:input readonly="true" path="paymentTime" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">卡片额度：</label>
			<div class="controls">
				<form:input readonly="true" path="cardQuota" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">应收利息：</label>
			<div class="controls">
				<form:input readonly="true" path="receiveInterest" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">实收利息：</label>
			<div class="controls">
				<form:input readonly="true" path="paidInterest" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收款方式：</label>
			<div class="controls">
				<form:input readonly="true" path="paymentWay" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证号：</label>
			<div class="controls">
				<form:input readonly="true" path="idNumber" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收款明细：</label>
			<div class="controls">
				<form:input readonly="true" path="paymentDetail" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:input path="state" htmlEscape="false" maxlength="10" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea readonly="true" path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>