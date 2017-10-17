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
		
		var oneInTotal = 0,twoInTotal = 0,inTotal = 0,oneOutTotal = 0,twoOutTotal = 0, outTotal = 0;
		$(".contextMenu").each(function(i,e){
			var oi = $(this).find(".oneIn").eq(0).text();
			var oo = $(this).find(".oneOut").eq(0).text();
			var ti = $(this).find(".twoIn").eq(0).text();
			var to = $(this).find(".twoOut").eq(0).text();
			oneInTotal = parseFloat(oneInTotal) + parseFloat(oi);
			twoInTotal = parseFloat(twoInTotal) + parseFloat(ti);
			oneOutTotal = parseFloat(oneOutTotal) + parseFloat(oo);
			twoOutTotal = parseFloat(twoOutTotal) + parseFloat(to);
			if ((i+1) == $(".contextMenu").length) {
				$("#oneInTotal").text(oneInTotal);
				$("#twoInTotal").text(twoInTotal);
				$("#oneOutTotal").text(oneOutTotal);
				$("#twoOutTotal").text(twoOutTotal);
				$("#inTotal").text(parseFloat(oneInTotal) + parseFloat(twoInTotal));
				$("#outTotal").text(parseFloat(oneOutTotal) + parseFloat(twoOutTotal));
			}
		});
		$("input:checkbox").change(function(){
			var oneInTotal_checked = 0,twoInTotal_checked = 0,inTotal_checked = 0,oneOutTotal_checked = 0,twoOutTotal_checked = 0, outTotal_checked = 0;
			$("#oneInTotal_checked").text(0);
			$("#twoInTotal_checked").text(0);
			$("#oneOutTotal_checked").text(0);
			$("#twoOutTotal_checked").text(0);
			$("#inTotal_checked").text(0);
			$("#outTotal_checked").text(0);
			$("input[name='transactionIds']:checked").each(function(i,e){
				var oi = $(this).parent().parent().find(".oneIn").eq(0).text();
				var oo = $(this).parent().parent().find(".oneOut").eq(0).text();
				var ti = $(this).parent().parent().find(".twoIn").eq(0).text();
				var to = $(this).parent().parent().find(".twoOut").eq(0).text();
				oneInTotal_checked = parseFloat(oneInTotal_checked) + parseFloat(oi);
				twoInTotal_checked = parseFloat(twoInTotal_checked) + parseFloat(ti);
				oneOutTotal_checked = parseFloat(oneOutTotal_checked) + parseFloat(oo);
				twoOutTotal_checked = parseFloat(twoOutTotal_checked) + parseFloat(to);
				if ((i+1) == $("input[name='transactionIds']:checked").length) {
					$("#oneInTotal_checked").text(oneInTotal_checked);
					$("#twoInTotal_checked").text(twoInTotal_checked);
					$("#oneOutTotal_checked").text(oneOutTotal_checked);
					$("#twoOutTotal_checked").text(twoOutTotal_checked);
					$("#inTotal_checked").text(parseFloat(oneInTotal_checked) + parseFloat(twoInTotal_checked));
					$("#outTotal_checked").text(parseFloat(oneOutTotal_checked) + parseFloat(twoOutTotal_checked));
				}
			});	
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
		<li class="active"><a href="javascript:void(0)">${fns:getDictLabel(cardTransaction.state, 'transaction_state', '未收录')}列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="cardTransaction" action="${ctx}/work/cardTransaction/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="state" name="state" type="hidden" value="${state}"/>
		<input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}">
		<ul class="ul-form">
			<li><label>卡主姓名：</label>
				<form:input path="card.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<c:if test="${state != null && state != '' && state != 0 && state != 7}">
				<c:forEach items="${fns:getDictList('transaction_state')}" var="s">
					<li class="btns">
						<c:if test="${s.value != 0 && s.value != 1 && s.value != 9}">
							<input id="xlrk" class="btn btn-primary ${state == s.value ? 'disabled' : ''}" type="button" value="${s.label}"
						  		<c:if test="${state != s.value}">onclick="changeStateBatch(${s.value})"</c:if>/>
						</c:if>
					</li>
				</c:forEach>
			</c:if>
			<c:if test="${state == 0}">
				<li class="btns">
					<input id="deleteBatch" type="button" class="btn btn-warning" value="删除"/>
				</li>
			</c:if>
			<li class="btns"><input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input class="checkAll" id="chkAll" type="checkbox"></th>
				<th>序号</th>
				<th>所属账号</th>
				<th>卡号</th>
				<th>银行</th>
				<th>交易密码</th>
				<th class="order-col" data-order="convert(sale_manager using gbk)">卡编号
					&nbsp;
					<span class="arrow-icon">
						<span class="icon-arrow-up"></span><span class="icon-arrow-down"></span>
					</span>
				</th>
				<c:if test="${state == null || state == ''}">
					<th>状态</th>
				</c:if>
				<th>月份</th>
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
				<th class="order-col" data-order="deal_date">处理日期
					&nbsp;
					<span class="arrow-icon">
						<span class="icon-arrow-up"></span><span class="icon-arrow-down"></span>
					</span>
				</th>
				<th>一进</th>
				<th>一出</th>
				<th>成本1</th>
				<th>二进</th>
				<th>二出</th>
				<th>成本2</th>
				<th style="min-width:400px;">备注</th>
				<shiro:hasPermission name="work:card:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<form id="chkForm" method="post" action="">
		<c:forEach items="${page.list}" var="transaction" varStatus="g">
			<tr class="contextMenu" data-row-id="${transaction.card.id}">
				<td><input class="checkSub" name="transactionIds" type="checkbox" value="${transaction.id}"></td>
				<td>${g.count}</td>
				<td>
					${transaction.card.name}
				</td>
				<td><a href="${ctx}/work/card/info?id=${transaction.card.id}">
					${transaction.card.no}
				</a></td>
				<td>${transaction.card.bank}</td>
				<td>${transaction.card.tradePwd}</td>
				<td>${transaction.card.saleManager}</td>
				<c:if test="${state == null || state == ''}">
					<td>${fns:getDictLabel(transaction.state, 'transaction_state', '无')}</td>
				</c:if>
				<td>${transaction.month}</td>
				<td>${transaction.bill.amount}</td>
				<td>${transaction.card.billDate}</td>
				<td>${transaction.card.repaymentDay}</td>
				<td>${transaction.dealDate}</td>
				<td class="oneIn">${transaction.oneIn}</td>
				<td class="oneOut">${transaction.oneOut}</td>
				<td>${transaction.costOne}</td>
				<td class="twoIn">${transaction.twoIn}</td>
				<td class="twoOut">${transaction.twoOut}</td>
				<td>${transaction.costTwo}</td>
				<td>
					${transaction.remarks}
				</td>
				<shiro:hasPermission name="work:card:edit">
					<td>
						<%-- <div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" ria-expanded="false">
								转换&nbsp;<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li ${transaction.card.state == 1 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${transaction.card.state != 1}">onclick="changeState('${transaction.card.id}', 1, '${card.state}')"</c:if>>新录入</a></li>
								<li ${transaction.card.state == 2 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${transaction.card.state != 2}">onclick="changeState('${transaction.card.id}', 2, '${card.state}')"</c:if>>卡已收</a></li>
								<li ${transaction.card.state == 3 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${transaction.card.state != 3}">onclick="changeState('${transaction.card.id}', 3, '${card.state}')"</c:if>>今日退卡</a></li>
								<li ${transaction.card.state == 4 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${transaction.card.state != 4}">onclick="changeState('${transaction.card.id}', 4, '${card.state}')"</c:if>>已退卡</a></li>
							</ul>
						</div> --%>
						<c:if test="${transaction.state != 0 && transaction.state != 7 && transaction.state != 8}">
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" ria-expanded="false">
								操作&nbsp;<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li ${transaction.state == 2 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${transaction.state != 2}">onclick="changeTransactionState('${transaction.id}', 2, '${transaction.state}')"</c:if>>手工操作</a></li>
								<li ${transaction.state == 3 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${transaction.state != 3}">onclick="changeTransactionState('${transaction.id}', 3, '${transaction.state}')"</c:if>>已完成手工操作</a></li>
								<li ${transaction.state == 4 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${transaction.state != 4}">onclick="changeTransactionState('${transaction.id}', 4, '${transaction.state}')"</c:if>>待定</a></li>
								<li ${transaction.state == 5 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${transaction.state != 5}">onclick="changeTransactionState('${transaction.id}', 5, '${transaction.state}')"</c:if>>确认待定</a></li>
								<li ${transaction.state == 7 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${transaction.state != 7}">onclick="changeTransactionState('${transaction.id}', 7, '${transaction.state}')"</c:if>>已完成</a></li>
								<li ${transaction.state == 8 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${transaction.state != 8}">onclick="changeTransactionState('${transaction.id}', 8, '${transaction.state}')"</c:if>>不操作</a></li>
							</ul>
						</div>
						</c:if>
	    				<%-- <a href="${ctx}/work/card/form?id=${card.id}">修改</a>
						<a href="${ctx}/work/card/delete?id=${card.id}" onclick="return confirmx('确认要删除该信用卡吗？', this.href)">删除</a> --%>
						<c:if test="${transaction.state == 0}">
							<a href="${ctx}/work/cardTransaction/deleteUnActive?id=${transaction.id}" onclick="return confirmx('确认要删除该条记录吗？', this.href)">删除</a>
						</c:if>
						<c:if test="${transaction.state == 4}">
							<a href="javascript:void(0)" onclick="addRemarks('${transaction.id}')">备注</a>
						</c:if>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</form>
		</tbody>
	</table>
	<div class="alert" style="background-color:#f5f5f5">
		<span><font color="black">全部合计：一进：</font><span id="oneInTotal">0</span>
		<font color="black">，二进：</font><span id="twoInTotal">0</span>
		<font color="black">，总金额：</font><span id="inTotal">0</span>
		<font color="black">；一出：</font><span id="oneOutTotal">0</span>
		<font color="black">，二出：</font><span id="twoOutTotal">0</span>
		<font color="black">，总金额：</font><span id="outTotal">0</span>
		&nbsp;&nbsp;<font color="black">|</font>&nbsp;&nbsp;
		<span><font color="black">选中合计：一进：</font><span id="oneInTotal_checked">0</span>
		<font color="black">，二进：</font><span id="twoInTotal_checked">0</span>
		<font color="black">，总金额：</font><span id="inTotal_checked">0</span>
		<font color="black">；一出：</font><span id="oneOutTotal_checked">0</span>
		<font color="black">，二出：</font><span id="twoOutTotal_checked">0</span>
		<font color="black">，总金额：</font><span id="outTotal_checked">0</span>
	</div>
	<div class="pagination">${page}</div>
	<form id="subForm" class="hide" action="${ctx}/work/cardTransaction/addRemarks" method="post" target="mainFrame">
		<input id="id" type="hidden" name="id" value=""/>
		<textarea id="remarks" rows="" cols="" name="remarks"></textarea>
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
	<script src="${ctxStatic}/common/main.js" type="text/javascript"></script>
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
		
		$(function(){
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出交易数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/work/cardTransaction/export");
						$("#searchForm").submit();
						$("#searchForm").attr("action","${ctx}/work/cardTransaction/list");
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			
			$("#deleteBatch").click(function(){
				layer.confirm("确认批量删除？", {icon:3, tilte:'提示'}, function(index){
					$("#chkForm").attr("action", "${ctx}/work/cardTransaction/deleteUnActiveBatch");
					$("#chkForm").submit();
					layer.close(index);
				});
			});
		});
		
		function changeStateBatch(state) {
			if($("input[name='transactionIds']:checked").length > 0) {
				layer.confirm("确认进行此批量操作？", {icon:3, tilte:'提示'}, function(index){
					$("#chkForm").attr("action", "${ctx}/work/cardTransaction/updateBatch?changeState="+state+"&transactionState=${state}");
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
		function changeTransactionState(id, state, preState) {
			return confirmx('确定进行该操作？','${ctx}/work/cardTransaction/convert?id='+id+'&state='+state+'&transactionState='+preState);
		}
		function subAccount(id) {
			return confirmx('确定分账？','${ctx}/work/cardBill/subAccount?id='+id);
		}
		
		function addRemarks(id) {
			layer.prompt({
				formType:2,
				title:'备注'
			},function(value, index, elem){
				$("#id").val(id);
				$("#remarks").val(value);
				$("#subForm").submit();
				layer.close(index);
			})
			//return confirmx('确定分账？','${ctx}/work/cardBill/subAccount?id='+id);
		}
	</script>
</body>
</html>