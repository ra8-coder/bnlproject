<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>




<form id="booksForm">
	<div class="col-lg-12 form-group">
		<div class="col-lg-2 form-group">
			<select class="form-control" name="searchKey">
				<option value=null>선택</option>
				<option value="isbn">isbn</option>
				<option value="bookTitle">책제목</option>
				<!-- <option value="author">작가</option> -->
			</select>
		</div>
		<div class="col-lg-6">
			<input type="text" class="form-control" placeholder="검색어를 입력하세요"
				name="searchValue" >
		</div>
		<div class="col-lg-4">
			<button type="button" class="btn btn-default" onclick="formSubmit();">검색</button>
		</div>
	</div>
</form>
<div class="table">
	<form name="userList" method="post" action="">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th scope="col">no</th>
					<th scope="col">책제목</th>
					<th scope="col">작가</th>
					<th scope="col">출판사</th>
					<th scope="col">isbn</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach var="book" items="${bookList}" varStatus="status">
					<tr>
						<td>${(status.index + pageMaker.cri.numPerPage * (pageMaker.cri.page-1))+1 }</td>
						<td>${book.bookTitle }</td>
						<td>${book.authorName }</td>
						<td>${book.publisher }</td>
						<td>${book.isbn }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>





</div>
<div style="display: table; margin: 0 auto;">
	<ul class="pagination">
		<c:if test="${pageMaker.pre }">
			<li><a style="cursor:pointer"
				onclick="bookPaging('<%=cp %>/admin_books_ok.action?page=${pageMaker.startPage-1}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}')">&lt;</a></li>
		</c:if>
		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }"
			var="idx">
			<li><a style="cursor:pointer"
				onclick="bookPaging('<%=cp %>/admin_books_ok.action?page=${idx}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}')">${idx }</a></li>
		</c:forEach>
		<c:if test="${pageMaker.nex }">
			<li><a style="cursor:pointer"
				onclick="bookPaging('<%=cp %>/admin_books_ok.action?page=${pageMaker.endPage+1}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}')">&gt;</a></li>
		</c:if>
	</ul>
</div>






















