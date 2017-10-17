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
		<li class="active"><a href="javascript:void(0)">${fns:getDictLabel(card.state, 'work_state', '未收录')}列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="card" action="${ctx}/work/card/bill" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="state" name="state" type="hidden" value="${state}"/>
		<input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}">
		<ul class="ul-form">
			<li><label>卡主姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>卡号</th>
				<th>月份</th>
				<th>卡状态</th>
				<th>卡主姓名</th>
				<th>卡主电话</th>
				<th>银行</th>
				<th class="order-col" data-order="card_quota+0">卡片额度
					&nbsp;
					<span class="arrow-icon">
						<span class="icon-arrow-up"></span><span class="icon-arrow-down"></span>
					</span>
				</th>
				<th class="order-col" data-order="loan_amount+0">贷款金额
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
				<th style="min-width:400px;">备注信息</th>
				<shiro:hasPermission name="work:card:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="card" varStatus="g">
			<tr class="contextMenu" data-row-id="${card.id}">
				<td>${g.count}</td>
				<td><a href="${ctx}/work/card/info?id=${card.id}">
					${card.no}
				</a></td>
				<td>${fns:getDate("yyyy-MM")}</td>
				<td>${fns:getDictLabel(card.state, 'work_state', '未收录')}</td>
				<td>
					${card.name}
				</td>
				<td>
					${card.phone}
				</td>
				<td>
					${card.bank}
				</td>
				<td>
					${card.cardQuota}
				</td>
				<td>
					${card.loanAmount}
				</td>
				<td>
					${card.billDate}
				</td>
				<td>${card.repaymentDay}</td>
				<td>
					<fmt:formatDate value="${card.effectiveDate}" pattern="yyyy-MM"/>
				</td>
				<td>
					${card.identifier}
				</td>
				<td>
					${card.saleManager}
				</td>
				<td>
					${card.saleDirector}
				</td>
				<td>
					${card.accountant}
				</td>
				<td>
					${card.tradePwd}
				</td>
				<td>
					${card.remarks}
				</td>
				<shiro:hasPermission name="work:card:edit">
					<td>
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" ria-expanded="false">
								转换&nbsp;<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li ${card.state == 1 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${card.state != 1}">onclick="changeState('${card.id}', 1, '${card.state}')"</c:if> >新录入</a></li>
								<li ${card.state == 2 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${card.state != 2}">onclick="changeState('${card.id}', 2, '${card.state}')"</c:if>>卡已收</a></li>
								<li ${card.state == 3 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${card.state != 3}">onclick="changeState('${card.id}', 3, '${card.state}')"</c:if>>今日退卡</a></li>
								<li ${card.state == 4 ? 'class="disabled"' : ''}><a href="javascript:void(0)" <c:if test="${card.state != 4}">onclick="changeState('${card.id}', 4, '${card.state}')"</c:if>>已退卡</a></li>
							</ul>
						</div>
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" ria-expanded="false">
								操作&nbsp;<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li><a href="javascript:void(0)" onclick="changeBillState('${card.id}', 1)">一次通知</a></li>
								<li><a href="javascript:void(0)" onclick="changeBillState('${card.id}', 2)">二次通知</a></li>
								<li><a href="javascript:void(0)" onclick="changeBillState('${card.id}', 3)">已收费</a></li>
								<li><a href="javascript:void(0)" onclick="changeBillState('${card.id}', 4)">不操作</a></li>
								<li><a href="javascript:void(0)" onclick="changeBillState('${card.id}', 5)">退卡</a></li>
								<%-- <li><a href="javascript:void(0)" onclick="changeBillState('${card.id}', 6)">已分账</a></li> --%>
								<li><a href="javascript:void(0)" onclick="changeBillState('${card.id}', 7)">手工操作</a></li>
							</ul>
						</div>
	    				<%-- <a href="${ctx}/work/card/form?id=${card.id}">修改</a>
						<a href="${ctx}/work/card/delete?id=${card.id}" onclick="return confirmx('确认要删除该信用卡吗？', this.href)">删除</a> --%>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
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
		
		function changeState(id, state, preState) {
			return confirmx('确定要转换该卡？','${ctx}/work/card/convert?id='+id+'&state='+state+'&preState='+preState);
		}
		function changeBillState(id, state) {
			return confirmx('确定进行该操作？','${ctx}/work/card/createBill?id='+id+'&billState='+state);
		}
	</script>
</body>
</html>