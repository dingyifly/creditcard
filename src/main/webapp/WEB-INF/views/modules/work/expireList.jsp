<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>信用卡管理</title>
	<meta name="decorator" content="default"/>
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
		<li class="active"><a href="javascript:void(0);">到期卡列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="card" action="${ctx}/work/card/expire" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
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
				<th>卡状态</th>
				<th>卡主姓名</th>
				<th>卡主电话</th>
				<th>银行</th>
				<th>卡片额度</th>
				<th>贷款金额</th>
				<th>到期月份</th>
				<th class="order-col" data-order="convert(sale_manager using gbk)">卡编号
					&nbsp;
					<span class="arrow-icon">
						<span class="icon-arrow-up"></span><span class="icon-arrow-down"></span>
					</span>
				</th>
				<th>销售主管</th>
				<th>对接会计</th>
				<th>交易密码</th>
				<th>有效期</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="work:card:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="card" varStatus="g">
			<tr>
				<td>${g.count}</td>
				<td><a href="${ctx}/work/card/info?id=${card.id}">
					${card.no}
				</a></td>
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
					<fmt:formatDate value="${card.effectiveDate}" pattern="yyyy-MM"/>
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
					<fmt:formatDate value="${card.effectiveDate}" pattern="yyyy-MM"/>
				</td>
				<td>
					<fmt:formatDate value="${card.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${card.remarks}
				</td>
				<shiro:hasPermission name="work:card:edit"><td>
    				<a href="${ctx}/work/card/form?id=${card.id}">修改</a>
					<a href="${ctx}/work/card/delete?id=${card.id}" onclick="return confirmx('确认要删除该信用卡吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>