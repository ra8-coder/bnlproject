<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<form id="orderForm">
	<div class="col-lg-6 form-group">
		<div class="col-lg-6">
			<input type="date" class="form-control" name="fromDate">
		</div>

		<div class="col-lg-6">
			<input type="date" class="form-control" name="toDate">
		</div>
	</div>
	<div class="col-lg-6 form-group">
		<div class="col-lg-8">
			<input type="hidden" name="searchKey" value="userId"> <input
				type="text" class="form-control" placeholder="사용자 아이디"
				name="searchValue">
		</div>
		<div class="col-lg-4">
			<button type="button" class="btn btn-default"
				onclick="formSubmit('order');">검색</button>
		</div>
	</div>
</form>

<div class="table">
	
		<table class="table table-bordered">
			<thead>
				<tr>
					<th scope="col">no</th>
					<th scope="col">주문번호</th>
					<th scope="col">사용자아이디</th>
					<th scope="col">주문현황</th>
					<th scope="col">처리날짜</th>
					<th scope="col">주문금액</th>
					<th scope="col">주소</th>
					<th scope="col">상세내역</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach var="order" items="${orderList}" varStatus="status">
					<tr>
						<td>${(status.index + pageMaker.cri.numPerPage * (pageMaker.cri.page-1))+1 }</td>
						<td>${order.orderId }</td>
						<td>${order.userId }</td>
						<td>${order.status }</td>
						<td>${order.handlingDate }</td>
						<td>${order.orderPrice }</td>
						<td>${order.zipCode}${order.address1 }${order.address2 }</td>
						<td>
							<button type="button" class="btn" id="del_btn">상세내역</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	

</div>


<div style="display: table; margin: 0 auto;">
	<ul class="pagination">
		<c:if test="${pageMaker.pre }">
			<li><a style="cursor:pointer"
				onclick="orderPaging('<%=cp %>/admin_order_ok.action?page=${pageMaker.startPage-1}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}&toDate=${pageMaker.cri.toDate}&fromDate=${pageMaker.cri.fromDate}')">&lt;</a></li>
		</c:if>
		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }"
			var="idx">
			<li><a style="cursor:pointer"
				onclick="orderPaging('<%=cp %>/admin_order_ok.action?page=${idx}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}&toDate=${pageMaker.cri.toDate}&fromDate=${pageMaker.cri.fromDate}')">${idx }</a></li>
		</c:forEach>
		<c:if test="${pageMaker.nex }">
			<li><a style="cursor:pointer"
				onclick="orderPaging('<%=cp %>/admin_order_ok.action?page=${pageMaker.endPage+1}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}&toDate=${pageMaker.cri.toDate}&fromDate=${pageMaker.cri.fromDate}')">&gt;</a></li>
		</c:if>
	</ul>
</div>