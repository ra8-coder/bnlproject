<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		$(".warehouseId").click(function(){
			window.opener.$("#warehouseId").val($(this).val());
			window.opener.$("input[name=warehouseId]").val($(this).val());
			window.close();
		})
		
	});
	
</script>

</head>
<body>
	<form action="<%=cp %>/admin_search_warehouse.action" method="get">
		<div class="search_container" style="margin: 20px auto;">
			<div class="row">
				<div class="col-xs-8 col-xs-offset-2">
					<div class="input-group">
						<input type="text" class="form-control" name="searchValue"
							placeholder="번역가 이름을 검색하세요"> <span class="input-group-btn">
							<button class="btn btn-default" type="submit">
								<span class="glyphicon glyphicon-search"></span>
							</button>
						</span>
					</div>
				</div>
			</div>
		</div>
	</form>
	
	<div class="author_table">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>no</th>
					<th>아이디</th>
					<th>이름</th>
					<th>선택</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="warehouse" items="${warehouseList }" varStatus="status">
					<tr>
						<td>${(status.index + pageMaker.cri.numPerPage * (pageMaker.cri.page-1))+1 }</td>
						<td>${warehouse.warehouseId }</td>
						<td>${warehouse.warehouseName }</td>
						<td><button class="warehouseId" value="${warehouse.warehouseId }">선택</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>	
	</div>
	
	<div style="display: table; margin: 0 auto;">
		<ul class="pagination">
			<c:if test="${pageMaker.pre }">
				<li><a onclick="paging('<%=cp %>/admin_search_warehouse.action?page=${pageMaker.startPage-1}')">&lt;</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }" var="idx">
				<li><a
					href="<%=cp %>/admin_search_warehouse.action?page=${idx}&searchValue=${pageMaker.cri.searchValue}">${idx }</a></li>
			</c:forEach>
			<c:if test="${pageMaker.nex }">
				<li><a
					href="<%=cp %>/admin_search_warehouse.action?page=${pageMaker.endPage+1}&searchValue=${pageMaker.cri.searchValue}">&gt;</a></li>
			</c:if>
		</ul>
	</div>

</body>
</html>