<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>交易管理</title>
	<meta name="decorator" content="default"/>
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
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/work/cardBill/">交易列表</a></li>
		<li class="active"><a href="${ctx}/work/cardBill/form?id=${cardBill.id}">交易<shiro:hasPermission name="work:cardBill:edit">${not empty cardBill.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="work:cardBill:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cardBill" action="${ctx}/work/cardBill/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">账单状态：</label>
			<div class="controls">
				<form:input path="state" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">信用卡id：</label>
			<div class="controls">
				<form:input path="card.id" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">交易表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>金额</th>
								<th>账单状态</th>
								<th>月份</th>
								<th>信用卡id</th>
								<th>备注信息</th>
								<shiro:hasPermission name="work:cardBill:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="cardTransactionList">
						</tbody>
						<shiro:hasPermission name="work:cardBill:edit"><tfoot>
							<tr><td colspan="7"><a href="javascript:" onclick="addRow('#cardTransactionList', cardTransactionRowIdx, cardTransactionTpl);cardTransactionRowIdx = cardTransactionRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="cardTransactionTpl">//<!--
						<tr id="cardTransactionList{{idx}}">
							<td class="hide">
								<input id="cardTransactionList{{idx}}_id" name="cardTransactionList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="cardTransactionList{{idx}}_delFlag" name="cardTransactionList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="cardTransactionList{{idx}}_account" name="cardTransactionList[{{idx}}].account" type="text" value="{{row.account}}" maxlength="20" class="input-small "/>
							</td>
							<td>
								<input id="cardTransactionList{{idx}}_state" name="cardTransactionList[{{idx}}].state" type="text" value="{{row.state}}" maxlength="2" class="input-small "/>
							</td>
							<td>
								<input id="cardTransactionList{{idx}}_month" name="cardTransactionList[{{idx}}].month" type="text" value="{{row.month}}" maxlength="10" class="input-small "/>
							</td>
							<td>
								<input id="cardTransactionList{{idx}}_card" name="cardTransactionList[{{idx}}].card.id" type="text" value="{{row.card.id}}" maxlength="64" class="input-small "/>
							</td>
							<td>
								<textarea id="cardTransactionList{{idx}}_remarks" name="cardTransactionList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="work:cardBill:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#cardTransactionList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var cardTransactionRowIdx = 0, cardTransactionTpl = $("#cardTransactionTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(cardBill.cardTransactionList)};
							for (var i=0; i<data.length; i++){
								addRow('#cardTransactionList', cardTransactionRowIdx, cardTransactionTpl, data[i]);
								cardTransactionRowIdx = cardTransactionRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="work:cardBill:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>