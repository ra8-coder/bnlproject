<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>반디앤루니스 인터넷서점</title>

<link rel="stylesheet" href="<%=cp%>/resources/css/main.css"
	type="text/css">
<link rel="stylesheet" href="<%=cp%>/resources/css/myShopping.css"
	type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="<%=cp%>/resources/js/myShopping.js"></script>

</head>
<body style="padding: 0; margin: 0;">

	<!-- header -->
	<jsp:include page="../common/header.jsp" flush="false" />

	<!-- 전체 div -->
	<div style="margin: 0 auto; width: 960px;">

		<div style="margin-top: 12px;">
			<a href="<%=cp%>/main.action">홈</a> > <a
				href="<%=cp%>/myShoppingMain.action">나의쇼핑</a> > <a
				href="<%=cp%>/myShopping/myOrderList.action">주문/배송조회</a> > <b>주문내역상세</b>
		</div>
		<!-- navigation -->
		<jsp:include page="./topNavi.jsp" flush="false" />
		<jsp:include page="./sideNavi.jsp" flush="false" />

		<div class="contents">
			<div
				style="font-size: 13pt; font-weight: bold; padding-bottom: 10px;">주문내역상세
			</div>

			<div class="order_detail_info_box">
				<span><b>주문번호:</b> ${orderInfo.orderId }</span> <span><b>주문일자:</b>
					${orderInfo.handlingDate }</span>
			</div>

			<div class="order_detail_book">
				<span style="font-size: 10pt;"><b>주문 상품 정보</b></span>
				<table>
					<tr>
						<th style="width: 360px;">상품명</th>
						<th style="width: 40px;">수량</th>
						<th>판매가</th>
						<th>적립금</th>
						<th>현황</th>
						<th>배송상황</th>
					</tr>
					<c:forEach var="dto" items="${lists }">
						<tr>
							<td style="text-align: left; padding-left: 15px;"><a
								href="<%=cp%>/book_info.action?isbn=${dto.isbn}">${dto.bookTitle }</a></td>
							<td>${dto.quantity }</td>
							<td><fmt:formatNumber value="${dto.price }"
									pattern="#,###" />원</td>
							<td><fmt:formatNumber value="${dto.point }" pattern="#,###" />원</td>
							<td>${orderInfo.status }</td>
							<td><c:if
									test="${orderInfo.status!='구매완료' && orderInfo.status!='반품완료' && orderInfo.status!='교환완료' && orderInfo.status!='주문취소'}">
							${orderInfo.shipmentsStatusCode }	
						</c:if></td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="7" style="text-align: right; padding-right: 10px;">
							<span style="margin-right: 20px;">
								합계 : 	<span style="font-weight: bold; color: #ea5759;">
								<fmt:formatNumber value="${orderInfo.booksPrice }" pattern="#,###" />
								<c:set var="val" value="${(orderInfo.booksPrice-orderInfo.orderPrice) }" />
								<c:if test="${val>=0 }">
								 - <fmt:formatNumber value="${(orderInfo.booksPrice-orderInfo.orderPrice) }" pattern="#,###" />(적립금) = 
								</c:if>
								<c:if test="${val<0 }">
								 + <fmt:formatNumber value="${(orderInfo.booksPrice-orderInfo.orderPrice)-(((orderInfo.booksPrice-orderInfo.orderPrice)*2)) }" pattern="#,###" />(배송비) = 
								</c:if>
								<fmt:formatNumber value="${orderInfo.orderPrice }" pattern="#,###" />원</span>
							</span>
							<span>적립금: <span style="font-weight: bold; color: #ea5759;">
								<fmt:formatNumber value="${orderInfo.point }" pattern="#,###" />원</span>
							</span>
						</td>
					</tr>
				</table>

				<div style="margin-top: 5px;">
					<c:if test="${orderInfo.shipmentsStatusCode == '입금대기중' }">
						<c:if test="${orderInfo.status !='구매완료' }">
							<input type="button" class="order_detail_book_btn2" value="주문취소"
								onclick="cancelOrder('${orderInfo.orderId}','${orderInfo.point }','${(orderInfo.booksPrice-orderInfo.orderPrice) }');">
						</c:if>
					</c:if>
					<c:if test="${orderInfo.shipmentsStatusCode == '상품준비중' }">
						<c:if
							test="${orderInfo.status !='구매완료' && orderInfo.status !='주문취소'}">
							<input type="button" class="order_detail_book_btn2" value="주문취소"
								onclick="cancelOrder('${orderInfo.orderId}','${orderInfo.point }','${(orderInfo.booksPrice-orderInfo.orderPrice) }');">
						</c:if>
					</c:if>
					<c:if test="${orderInfo.shipmentsStatusCode == '상품준비완료' }">
						<c:if test="${orderInfo.status !='구매완료' }">
							<input type="button" class="order_detail_book_btn2" value="주문취소"
								onclick="cancelOrder('${orderInfo.orderId}','${orderInfo.point }'.'${(orderInfo.booksPrice-orderInfo.orderPrice) }');">
						</c:if>
					</c:if>

					<c:if test="${orderInfo.shipmentsStatusCode == '출고작업중' }">
						<input type="button" class="order_detail_book_btn2" value="반품신청"
							onclick="returnOrder('${orderInfo.orderId}');">
					</c:if>
					<c:if test="${orderInfo.shipmentsStatusCode == '출고완료' }">
						<input type="button" class="order_detail_book_btn2" value="반품신청"
							onclick="returnOrder('${orderInfo.orderId}');">
						<input type="button" class="order_detail_book_btn3" value="구매완료"
							onclick="confirmOrder('${orderInfo.orderId}');">
					</c:if>
					<c:if test="${orderInfo.shipmentsStatusCode == '배송중' }">
						<c:if test="${orderInfo.status !='구매완료' }">
							<input type="button" class="order_detail_book_btn2" value="반품신청"
								onclick="returnOrder('${orderInfo.orderId}');">
							<input type="button" class="order_detail_book_btn2" value="교환신청"
								onclick="exchangeOrder('${orderInfo.orderId}');">
							<input type="button" class="order_detail_book_btn3" value="구매완료"
								onclick="confirmOrder('${orderInfo.orderId}');">
						</c:if>
					</c:if>
				</div>
			</div>

			<div class="order_detail_notice">
				<ul>
					<li>출고완료상태에서 '구매완료' 버튼을 누르시면 '구매완료'로 전환됩니다.</li>
					<li>주문상태가 '구매완료'가 되면 반품/교환/주문취소는 불가능하오니 반품 등을 고려하실 경우에는 '구매완료'
						버튼을 클릭하지 마시기 바랍니다.</li>
				</ul>
			</div>

			<div class="order_detail_user">
				<span style="font-size: 10pt;"><b>배송 정보</b></span>
				<table>
					<tr style="border-top: 1px solid #d5d5d5;">
						<th>주문자</th>
						<td>${orderInfo.recipientName }</td>
						<th>휴대폰</th>
						<td>${userInfo.phone }</td>
					</tr>
					<tr>
						<th>수령예상일</th>
						<td colspan="3">${orderInfo.expectedDate }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="4">(${orderInfo.zipCode }) ${orderInfo.address1 }
							${orderInfo.address2 }</td>
					</tr>

				</table>
			</div>

			<div style="margin-top: 20px; margin-left: 10px;">
				<img alt="배송단계"
					src="<%=cp%>/resources/img/myShopping/my_order_step.gif">
			</div>



		</div>




	</div>

	<!-- footer -->
		<jsp:include page="../common/footer.jsp" flush="false" />

</body>
</html>