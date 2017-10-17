<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>不操作日管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
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
		<li class="active"><a href="${ctx}/work/cardInoperation/">不操作日列表</a></li>
		<shiro:hasPermission name="work:cardInoperation:edit"><li><a href="${ctx}/work/cardInoperation/form">不操作日添加</a></li></shiro:hasPermission>
	</ul>
	<%-- <form:form id="searchForm" modelAttribute="cardInoperation" action="${ctx}/work/cardInoperation/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form> --%>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>限制日期</th>
				<shiro:hasPermission name="work:cardInoperation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cardInoperation">
			<tr>
				<td><a href="${ctx}/work/cardInoperation/form?id=${cardInoperation.id}">
					${cardInoperation.limitDate}
				</a></td>
				<shiro:hasPermission name="work:cardInoperation:edit"><td>
    				<a href="${ctx}/work/cardInoperation/form?id=${cardInoperation.id}">修改</a>
					<a href="${ctx}/work/cardInoperation/delete?id=${cardInoperation.id}" onclick="return confirmx('确认要删除该不操作日吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>