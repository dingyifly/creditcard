<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>信用卡管理</title>
	<meta name="decorator" content="default"/>
	<%-- <script src="${ctxStatic}/common/rightClick.js" type="text/javascript"></script> --%>
	<script src="${ctxStatic}/common/BootstrapMenu.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".order-col").each(function(){
				if($("#orderBy").val().startWith($(this).attr("data-order"))) {
					if ($("#orderBy").val().endWith("asc")){
						$(this).find(".arrow-icon").html('<span class="icon-arrow-up"></span>');
					} else if ($("#orderBy").val().endWith("desc")){
						$(this).find(".arrow-icon").html('<span class="icon-arrow-down"></span>');
					}
				}
			});
			$(".order-col").click(function(){
				if (!$("#orderBy").val().endWith("asc")){
					
					$("#orderBy").val($(this).attr("data-order") + " asc");
					$("#searchForm").submit();
				} else{
					$("#orderBy").val($(this).attr("data-order") + " desc");
					$("#searchForm").submit();
				}
			});
		});
		String.prototype.endWith=function(endStr){
	      var d=this.length-endStr.length;
	      return (d>=0&&this.lastIndexOf(endStr)==d)
	    }
		String.prototype.startWith = function(compareStr){
			return this.indexOf(compareStr) == 0;
		}
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">${fns:getDictLabel(cardBill.state, 'bill_state', '未收录')}列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="cardBill" action="${ctx}/work/cardBill/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="state" name="state" type="hidden" value="${state}"/>
		<input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}">
		<ul class="ul-form">
			<li><label>卡主姓名：</label>
				<form:input path="card.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<c:if test="${state != null && state != '' && state != 0 && state != 7}">
				<c:forEach items="${fns:getDictList('bill_state')}" var="s">
					<li class="btns">
						<c:if test="${s.value != 0 && s.value != 9}">
							<input id="xlrk" class="btn btn-primary ${state == s.value ? 'disabled' : ''}" type="button" value="${s.label}"
						  		<c:if test="${state != s.value}">onclick="changeStateBatch(${s.value})"</c:if>/>
						</c:if>
					</li>
				</c:forEach>
			</c:if>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input class="checkAll" id="chkAll" type="checkbox"></th>
				<th>序号</th>
				<th>卡号</th>
				<th>状态</th>
				<th>月份</th>
				<th>卡主姓名</th>
				<th>卡主电话</th>
				<th>银行</th>
				<th class="order-col" data-order="card_quota+0">卡片额度
					&nbsp;
					<span class="arrow-icon">
						<span class="icon-arrow-up"></span><span class="icon-arrow-down"></span>
					</span>
				</th>
				<th class="order-col" data-order="amount+0">贷款金额
					&nbsp;
					<span class="arrow-icon">
						<span class="icon-arrow-up"></span><span class="icon-arrow-down"></span>
					</span>
				</th>
				<th class="order-col" data-order="bill_date">账单日
					&nbsp;
					<span class="arrow-icon">
						<span class="icon-arrow-up"></span><span class="icon-arrow-down"></span>
					</span>
				</th>
				<th class="order-col" data-order="repayment_day">还款日期
					&nbsp;
					<span class="arrow-icon">
						<span class="icon-arrow-up"></span><span class="icon-arrow-down"></span>
					</span>
				</th>
				<th class="order-col" data-order="effective_date">有效期
					&nbsp;
					<span class="arrow-icon">
						<span class="icon-arrow-up"></span><span class="icon-arrow-down"></span>
					</span>
				</th>
				<th>识别码</th>
				<th class="order-col" data-order="convert(sale_manager using gbk)">卡编号
					&nbsp;
					<span class="arrow-icon">
						<span class="icon-arrow-up"></span><span class="icon-arrow-down"></span>
					</span>
				</th>
				<th>销售主管</th>
				<th>对接会计</th>
				<th>交易密码</th>
				<th style="min-width:400px;">备注</th>
				<shiro:hasPermission name="work:card:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<form id="chkForm" method="post" action="">
		<c:forEach items="${page.list}" var="bill" varStatus="g">
			<tr class="contextMenu" data-row-id="${bill.card.id}">
				<td><input class="checkSub" name="billIds" type="checkbox" value="${bill.id}"></td>
				<td>${g.count}</td>
				<td><a href="${ctx}/work/card/info?id=${bill.card.id}">
					${bill.card.no}
				</a></td>
				<td>${fns:getDictLabel(bill.state, 'bill_state', '无')}</td>
				<td>${bill.month}</td>
				<td>
					${bill.card.name}
				</td>
				<td>
					${bill.card.phone}
				</td>
				<td>
					${bill.card.bank}
				</td>
				<td>
					${bill.card.cardQuota}
				</td>
				<td>
					${bill.amount}
				</td>
				<td>${bill.card.billDate}</td>
				<td>${bill.card.repaymentDay}</td>
				<td>
					<fmt:formatDate value="${bill.card.effectiveDate}" pattern="yyyy-MM"/>
				</td>
				<td>
					${bill.card.identifier}
				</td>
				<td>
					${bill.card.saleManager}
				</td>
				<td>
					${bill.card.saleDirector}
				</td>
				<td>
					${bill.card.accountant}
				</td>
				<td>
					${bill.card.tradePwd}
				</td>
				<td>${bill.card.remarks}</td>
				<shiro:hasPermission name="work:card:edit">
					<td>
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" ria-expanded="false">
								转换&nbsp;<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li ${bill.card.state == 1 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${bill.card.state != 1}">onclick="changeState('${bill.card.id}', 1, '${card.state}')"</c:if>>新录入</a></li>
								<li ${bill.card.state == 2 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${bill.card.state != 2}">onclick="changeState('${bill.card.id}', 2, '${card.state}')"</c:if>>卡已收</a></li>
								<li ${bill.card.state == 3 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${bill.card.state != 3}">onclick="changeState('${bill.card.id}', 3, '${card.state}')"</c:if>>今日退卡</a></li>
								<li ${bill.card.state == 4 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${bill.card.state != 4}">onclick="changeState('${bill.card.id}', 4, '${card.state}')"</c:if>>已退卡</a></li>
							</ul>
						</div>
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" ria-expanded="false">
								操作&nbsp;<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li ${bill.state == 2 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${bill.state != 2}">onclick="changeBillState('${bill.id}', 2, '${bill.state}')"</c:if>>二次通知</a></li>
								<li ${bill.state == 3 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${bill.state != 3}">onclick="changeBillState('${bill.id}', 3, '${bill.state}')"</c:if>>已收费</a></li>
								<li ${bill.state == 4 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${bill.state != 4}">onclick="changeBillState('${bill.id}', 4, '${bill.state}')"</c:if>>不操作</a></li>
								<li ${bill.state == 5 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${bill.state != 5}">onclick="changeBillState('${bill.id}', 5, '${bill.state}')"</c:if>>退卡</a></li>
								<%-- <li><a href="javascript:void(0)" onclick="changeBillState('${bill.id}', 6)">已分账</a></li> --%>
								<li ${bill.state == 7 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${bill.state != 7}">onclick="changeBillState('${bill.id}', 7, '${bill.state}')"</c:if>>手工操作</a></li>
							</ul>
						</div>
						<c:if test="${bill.state == 3}"><a href="javascript:void(0)" onclick="subAccount('${bill.id}', '${bill.card.loanAmount}')">分账</a></c:if>
	    				<%-- <a href="${ctx}/work/card/form?id=${card.id}">修改</a>
						<a href="${ctx}/work/card/delete?id=${card.id}" onclick="return confirmx('确认要删除该信用卡吗？', this.href)">删除</a> --%>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</form>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<form id="subForm" action="${ctx}/work/cardBill/subAccount" method="post">
		<input type="hidden" name="id" id="id"/>
		<input type="hidden" name="billState" value="${state}">
		<div id="hideDiv" style="display:none;margin-top: 8px;margin-left: 15px;">
			<label>分账天数：</label><input type="number" name="days" id="days" maxlength="2" value="5"/><br/>
			<label>贷款金额：</label><input type="text" name="amount" id="amount" value=""/>
		</div>
	</form>
	<!-- <div id="bmenu" style="position:absolute;display:none;top:0px;left:0px;width:150px;margin:0px;padding:2px;border:1px solid #cccccc;background-color:#CEE2FF;">
	  <ul>
	  	<li id="del">删除</li>
	  </ul>
	 </div>
	 
	 <div id="bmenu2" style="position:absolute;display:none;top:0px;left:0px;width:150px;margin:0px;padding:2px;border:1px solid #cccccc;background-color:#CEE2FF;">
	  <ul>
	  	<li id="del">删除</li>
	  </ul>
	 </div>
	 <script type="text/javascript">
		var id;
		if(getOs()=='MSIE'){id="bmenu"}
		if(getOs()=='Safari'){id="bmenu2"} 
		if("${user.dept.dept_type == deptTypess}" == "true") {
			  var cmenu = new contextMenu(
				    {
				   menuID : id,
				   targetEle : "contextMenu"
				  },
				  {
				   bindings:{
				    'del' : function(o){deleteObj(o.id)}
				    }
				   }
				  );
			 cmenu.buildContextMenu();
		}
	</script> -->
	<script type="text/javascript">
		/*var tr = $(".contextMenu").eq(1);
		var menu = new BootstrapMenu('.contextMenu', {
			fetchElementData:function($rowElem) {
				var rowId = $rowElem.data('rowId');
				return rowId;
			},
			actions:[{
				name:'分账',
				onClick: function(rowId) {
					alert("分账成功" + rowId);
				}
			}]
		});*/
		function changeStateBatch(state) {
			if($("input[name='billIds']:checked").length > 0) {
				layer.confirm("确认进行此批量操作？", {icon:3, tilte:'提示'}, function(index){
					$("#chkForm").attr("action", "${ctx}/work/cardBill/updateBatch?changeState="+state+"&billState=${state}");
					$("#chkForm").submit();
					layer.close(index);
				});
			} else {
				layer.msg('请先选中一条记录');				
			}
		}
		
		function changeState(id, state, preState) {
			return confirmx('确定要转换该卡？','${ctx}/work/card/convert?id='+id+'&state='+state+'&preState='+preState);
		}
		function changeBillState(id, state, preState) {
			return confirmx('确定进行该操作？','${ctx}/work/cardBill/convert?id='+id+'&state='+state+'&billState='+preState);
		}
		function subAccount(id, amount) {
			$("#amount").val(amount);
			layer.open({
				type: 1,
				title:'设置天数及金额',
				skin:'layui-layer-rim',
				area:['320px', '190px'],
			  	content: $("#hideDiv"),
			  	btn: ['确认'],
			  	btnAlign: 'c',
			  	btn1:function(){
			  		$("#id").val(id);
			  		$("#amount").val(parseFloat($("#amount").val()));
			  		$("#subForm").submit();
			  	}
			});
			/*layer.prompt({
				value:5,
				maxlength:3,
				title:'设置分账天数'
			},function(value, index, elem){
				if (parseInt(value)) {
					location.href = '${ctx}/work/cardBill/subAccount?id='+id+'&days='+parseInt(value)+'&billState=${state}';
				}
				layer.close(index);
			})*/
			//return confirmx('确定分账？','${ctx}/work/cardBill/subAccount?id='+id);
		}
	</script>
</body>
</html>