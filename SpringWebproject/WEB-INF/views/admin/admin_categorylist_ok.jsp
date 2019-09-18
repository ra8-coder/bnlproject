<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<form id="categoryForm">
	<div class="col-lg-12 form-group">
		<div class="col-lg-8">
			<input type="hidden" name="searchKey" value="categoryName"> <input
				type="text" class="form-control" placeholder="카테고리를 입력하세요"
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
				<th scope="col">no</th>
				<th scope="col">카테고리 아이디</th>
				<th scope="col">카테고리 이름</th>
				<th scope="col">상위 카테고리 아이디</th>
			</tr>
		</thead>
		<tbody>

				<c:forEach var="category" items="${categoryList}" varStatus="status">
					<tr>
						<td>${(status.index + pageMaker.cri.numPerPage * (pageMaker.cri.page-1))+1 }</td>
						<td>${category.categoryId }</td>
						<td>${category.categoryName }</td>
						<td>${category.parentsId }</td>
					</tr>
				</c:forEach>
			</tbody>
	</table>
</div>
<div style="display: table; margin: 0 auto;">
	<ul class="pagination">
		<c:if test="${pageMaker.pre }">
			<li><a style="cursor:pointer"
				onclick="categoryPaging('<%=cp %>/admin_categorylist_ok.action?page=${pageMaker.startPage-1}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}')">&lt;</a></li>
		</c:if>
		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }"
			var="idx">
			<li><a style="cursor:pointer"
				onclick="categoryPaging('<%=cp %>/admin_categorylist_ok.action?page=${idx}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}')">${idx }</a></li>
		</c:forEach>
		<c:if test="${pageMaker.nex }">
			<li><a style="cursor:pointer"
				onclick="categoryPaging('<%=cp %>/admin_categorylist_ok.action?page=${pageMaker.endPage+1}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}')">&gt;</a></li>
		</c:if>
	</ul>
</div>

