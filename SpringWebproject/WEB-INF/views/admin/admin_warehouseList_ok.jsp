<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<form id="warehouseForm">
	<div class="col-lg-12 form-group">
		<div class="col-lg-8">
			<input type="hidden" name="searchKey" value="warehouseName">
			<input type="text" class="form-control" placeholder="지점을 입력하세요"
				name="searchValue">
		</div>
		<div class="col-lg-4">
			<button type="button" class="btn btn-default" onclick="formSubmit();">검색</button>
		</div>
	</div>
</form>
<div class="table">
	<table class="table table-bordered">
		<thead>
			<tr>
				<th scope="col">지점아이디</th>
				<th scope="col">지점이름</th>
				<th scope="col">지점주소</th>
				<th scope="col">전화번호</th>
			</tr>
		</thead>
		<c:forEach var="warehouse" items="${warehouseList}" varStatus="status">
			<tr>
				<td>${warehouse.warehouseId }</td>
				<td>${warehouse.warehouseName }</td>
				<td>${warehouse.addr }</td>
				<td>${warehouse.tel }</td>
			</tr>
		</c:forEach>
		<tbody>
		</tbody>
	</table>
</div>
<div style="display: table; margin: 0 auto;">
	<ul class="pagination">
		<c:if test="${pageMaker.pre }">
			<li><a style="cursor: pointer"
				onclick="paging('<%=cp %>/admin_warehouseList_ok.action?page=${pageMaker.startPage-1}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}')">&lt;</a></li>
		</c:if>
		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }"
			var="idx">
			<li><a style="cursor: pointer"
				onclick="paging('<%=cp %>/admin_warehouseList_ok.action?page=${idx}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}')">${idx }</a></li>
		</c:forEach>
		<c:if test="${pageMaker.nex }">
			<li><a style="cursor: pointer"
				onclick="paging('<%=cp %>/admin_warehouseList_ok.action?page=${pageMaker.endPage+1}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}')">&gt;</a></li>
		</c:if>
	</ul>
</div>

