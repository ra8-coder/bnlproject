<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<form id="shipmentsForm">
	<div class="col-lg-6 form-group">
		<div class="col-lg-8">
			<input type="hidden" name="searchKey" value="userId"> <input
				type="text" class="form-control" placeholder="사용자 아이디"
				name="searchValue">
		</div>
		<div class="col-lg-4">
			<button type="button" class="btn btn-default"
				onclick="formSubmit('shipments');">검색</button>
		</div>
	</div>
</form>
<div class="table">
	<form name="shipmentsList" method="post" action="">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th scope="col">no</th>
					<th scope="col">주문번호</th>
					<th scope="col">배송번호</th>
					<th scope="col">사용자아이디</th>
					<th scope="col">배송현황</th>
					<th scope="col">수령예상일</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach var="shipments" items="${shipmentsList}"
					varStatus="status">
					<tr>
						<td>${(status.index + pageMaker.cri.numPerPage * (pageMaker.cri.page-1))+1 }</td>
						<td>${shipments.orderId }</td>
						<td>${shipments.shipmentsId }</td>
						<td>${shipments.userId }</td>
						<td>${shipments.status }</td>
						<td>${shipments.expectedDate }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>

</div>


<div style="display: table; margin: 0 auto;">
	<ul class="pagination">
		<c:if test="${pageMaker.pre }">
			<li><a style="cursor: pointer"
				onclick="shipmentsPaging('<%=cp %>/admin_shipments_ok.action?page=${pageMaker.startPage-1}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}')">&lt;</a></li>
		</c:if>
		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }"
			var="idx">
			<li><a style="cursor: pointer"
				onclick="shipmentsPaging('<%=cp %>/admin_shipments_ok.action?page=${idx}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}')">${idx }</a></li>
		</c:forEach>
		<c:if test="${pageMaker.nex }">
			<li><a style="cursor: pointer"
				onclick="shipmentsPaging('<%=cp %>/admin_shipments_ok.action?page=${pageMaker.endPage+1}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}')">&gt;</a></li>
		</c:if>
	</ul>
</div>