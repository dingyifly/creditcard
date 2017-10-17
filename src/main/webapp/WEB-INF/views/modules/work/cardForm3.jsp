<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>信用卡管理</title>
	<!-- <meta name="decorator" content="default"/> -->
	<link href="${ctxStatic}/common/css.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/work/card/">信用卡列表</a></li>
		<li class="active"><a href="${ctx}/work/card/form?id=${card.id}">信用卡<shiro:hasPermission name="work:card:edit">${not empty card.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="work:card:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<div class="container-fluid">
		<form:form id="inputForm" modelAttribute="card" action="${ctx}/work/card/save" method="post" >
			<form:hidden path="id"/>
			<sys:message content="${message}"/>		
			<div class="form-group col-md-4 col-sm-4">
				<label class="control-label col-sm-2 text-right">卡号：</label>
				<div class="col-sm-10">
					<form:input path="no" htmlEscape="false" maxlength="64" class="form-control"/>
				</div>
			</div>
			<div class="form-group col-md-4 col-sm-4">
				<label class="control-label col-sm-2 text-right">卡号：</label>
				<div class="col-sm-10">
					<form:input path="no" htmlEscape="false" maxlength="64" class="form-control"/>
				</div>
			</div>
			<div class="form-group col-md-4 col-sm-4">
				<label class="control-label col-sm-2 text-right">卡号：</label>
				<div class="col-sm-10">
					<form:input path="no" htmlEscape="false" maxlength="64" class="form-control"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">卡号：</label>
				<div class="controls">
					<form:input path="no" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">卡主姓名：</label>
				<div class="controls">
					<form:input path="name" htmlEscape="false" maxlength="20" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">卡主电话：</label>
				<div class="controls">
					<form:input path="phone" htmlEscape="false" maxlength="20" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">银行：</label>
				<div class="controls">
					<form:input path="bank" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">营业部：</label>
				<div class="controls">
					<form:input path="saleDepartment" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">销售经理：</label>
				<div class="controls">
					<form:input path="saleManager" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">销售主管：</label>
				<div class="controls">
					<form:input path="saleDirector" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">收单专员：</label>
				<div class="controls">
					<form:input path="receiver" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">对接会计：</label>
				<div class="controls">
					<form:input path="accountant" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">交易密码：</label>
				<div class="controls">
					<form:input path="tradePwd" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">查询密码：</label>
				<div class="controls">
					<form:input path="queryPwd" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">贷款金额：</label>
				<div class="controls">
					<form:input path="loanAmount" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">账单日：</label>
				<div class="controls">
					<input name="billDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="<fmt:formatDate value="${card.billDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">放款日：</label>
				<div class="controls">
					<input name="loanDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="<fmt:formatDate value="${card.loanDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">实还天数：</label>
				<div class="controls">
					<form:input path="solidDay" htmlEscape="false" maxlength="20" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">还款日期：</label>
				<div class="controls">
					<form:input path="repaymentDay" htmlEscape="false" maxlength="20" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">修改日期：</label>
				<div class="controls">
					<input name="modifyDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="<fmt:formatDate value="${card.modifyDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">开户行号：</label>
				<div class="controls">
					<form:input path="openNo" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">卡属性：</label>
				<div class="controls">
					<form:input path="cardAttr" htmlEscape="false" maxlength="20" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">贷款利率：</label>
				<div class="controls">
					<form:input path="lendingRates" htmlEscape="false" maxlength="20" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">风控等级：</label>
				<div class="controls">
					<form:input path="riskControl" htmlEscape="false" maxlength="20" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">卡来源：</label>
				<div class="controls">
					<form:input path="cardSource" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">有效日期：</label>
				<div class="controls">
					<input name="effectiveDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="<fmt:formatDate value="${card.effectiveDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">识别码：</label>
				<div class="controls">
					<form:input path="identifier" htmlEscape="false" maxlength="10" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">收款日期：</label>
				<div class="controls">
					<form:input path="paymentTime" htmlEscape="false" maxlength="20" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">卡片额度：</label>
				<div class="controls">
					<form:input path="cardQuota" htmlEscape="false" maxlength="20" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">应收利息：</label>
				<div class="controls">
					<form:input path="receiveInterest" htmlEscape="false" maxlength="30" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">实收利息：</label>
				<div class="controls">
					<form:input path="paidInterest" htmlEscape="false" maxlength="30" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">收款方式：</label>
				<div class="controls">
					<form:input path="paymentWay" htmlEscape="false" maxlength="30" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">身份证号：</label>
				<div class="controls">
					<form:input path="idNumber" htmlEscape="false" maxlength="20" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">收款明细：</label>
				<div class="controls">
					<form:input path="paymentDetail" htmlEscape="false" maxlength="255" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">状态：</label>
				<div class="controls">
					<form:input path="state" htmlEscape="false" maxlength="10" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">备注信息：</label>
				<div class="controls">
					<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
				</div>
			</div>
			<div class="form-actions">
				<shiro:hasPermission name="work:card:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
		</form:form>
	</div>
</body>
</html>