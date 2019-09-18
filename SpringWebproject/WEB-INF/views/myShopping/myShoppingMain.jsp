<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<!DOCTYPE html>
<html>
<title>반디앤루니스 인터넷서점</title>
<head>
	<link rel="stylesheet" href="<%=cp%>/resources/css/main.css" type="text/css">
	<link rel="stylesheet" href="<%=cp%>/resources/css/myShopping.css" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="<%=cp%>/resources/js/myShopping.js"></script>
	
</head>
<body style="padding: 0; margin: 0;">

<!-- header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<!-- 전체 div -->
<div style="margin: 0 auto; width: 960px;">

<div style="margin-top: 12px;">
	<a href="<%=cp %>/main.action">홈</a> > <b>나의쇼핑</b>
</div>
<!-- navigation -->
<jsp:include page="./topNavi.jsp" flush="false"/>
<jsp:include page="./sideNavi.jsp" flush="false"/>

<div class="contents">
	<div class="main_RecentOrderList">
		<span class="contents_title">최근 주문/배송 내역</span> | 고객님의 최근 1개월 주문 내역입니다. 
		<span class="sapn_right"><a href="<%=cp%>/myShopping/myOrderList.action">더보기></a></span>
		
		<table>
			<tr>
				<th>주문번호</th>
				<th>주문일자</th>
				<th>수령예상일</th>
				<th style="width: 365px;">상품명</th>
				<th>주문금액</th>
			</tr>
			<!-- 주문내역 없을 시 -->
			<c:if test="${empty orderList }">
			<tr height="100px;">
				<td colspan="5">주문내역이 없습니다.</td>
			</tr>
			</c:if>
			<!-- 주문내역 있을 시 -->
			<c:forEach var="dto" items="${orderList }">
			<tr>
				<td>${dto.orderId }</td>
				<td>${dto.handlingDate }</td>
				<td>${dto.expectedDate }</td>
				<c:if test="${dto.quantity>1 }">
				<td style="text-align: left;"><a href="<%=cp%>/myShopping/myOrderDetail.action?orderId=${dto.orderId}">${dto.mainTitle } 외 ${dto.quantity-1 }개</a></td>
				</c:if>
				<c:if test="${dto.quantity==1 }">
				<td style="text-align: left;"><a href="<%=cp%>/myShopping/myOrderDetail.action?orderId=${dto.orderId}">${dto.mainTitle }</a></td>
				</c:if>	
				<td><fmt:formatNumber value="${dto.orderPrice }" pattern="#,###"/></td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<div class="main_wishList">
		<div style="border-bottom: 1px solid #c9c9c9; line-height: 30px;">
			<span class="contents_title">위시리스트</span><span class="count">[${wishCount }]</span>
			<span class="sapn_right"><a href="<%=cp%>/myShopping/myWishList.action">더보기></a></span>
		</div>
		<div class="wish_list_content" style="border-bottom: none;">
		<c:if test="${!empty wishList }">
		<c:forEach var="dto" items="${wishList }">
		<ul style="width: 180px;">
			<li style="width: 170px;">
				<!-- 상단 -->
				<div>
					<!-- 이미지 -->
					<div class="wish_book_up">
						<div class="wish_book_img" style="margin-left: 10px;">
							<a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"><img alt="" src="<%=cp%>/resources/image/book/${dto.bookImage}"></a>
							<a href="<%=cp%>/book_info.action?isbn=${dto.isbn}" target="_blank" class="wish_book_popup">
								<span>새창열기</span>
							</a>
						</div>
						<div style="margin-top: 5px; text-align: center; margin-left: 10px;">
							<a href="javascript:popPreview(${dto.isbn });"><img alt="미리보기" src="<%=cp%>/resources/img/myShopping/btn_comm_2.png"></a>
						</div>
					</div>
				</div>
				<!-- 하단 -->
				<div style="width: 160px;">
					<dl>
						<dt><a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"><b>${dto.bookTitle }</b></a></dt>
						<dd>${dto.authorName } | ${dto.publisher }</dd>
						<dd>
							<p>
								<span class="point_red"><b><fmt:formatNumber value="${dto.discountedPrice }" pattern="#,###"/>원</b> (${dto.discountRate }%↓+5%P)</span>
							</p>
						</dd>
					</dl>
				</div>
			</li>
		</ul>
		</c:forEach>
		</c:if>	
		<c:if test="${empty wishList }">
		<div style="text-align: center; font-size: 15pt; height: 250px; background-color: #d5d5d542; width: 730px; line-height: 12; margin-top: 10px;">위시리스트에 담긴 상품이 없습니다.</div>
		</c:if>
		</div>
	</div>
	<div class="main_latesbooksList">
		<div style="border-bottom: 1px solid #c9c9c9; line-height: 30px;">
			<span class="contents_title">최근 본 상품</span><span class="count">[${recentCount }]</span>
			<span class="sapn_right"><a href="<%=cp%>/myShopping/myLatesBooksList.action">더보기></a></span>
		</div>
		<div class="wish_list_content" style="border-bottom: none; padding: 0; margin: 0; padding-left: 20px;">
		<c:if test="${!empty recentList }">
		<c:forEach var="dto" items="${recentList }">
		<ul style="width: 180px;">
			<li style="width: 170px;">
				<!-- 상단 -->
				<div>
					<!-- 이미지 -->
					<div class="wish_book_up">
						<div class="wish_book_img" style="margin-left: 10px;">
							<a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"><img alt="" src="<%=cp%>/resources/image/book/${dto.bookImage}"></a>
							<a href="<%=cp%>/book_info.action?isbn=${dto.isbn}" target="_blank" class="wish_book_popup">
								<span>새창열기</span>
							</a>
						</div>
						<div style="margin-top: 5px; text-align: center; margin-left: 10px;">
							<a href="javascript:popPreview(${dto.isbn });"><img alt="미리보기" src="<%=cp%>/resources/img/myShopping/btn_comm_2.png"></a>
						</div>
					</div>
				</div>
				<!-- 하단 -->
				<div style="width: 160px;">
					<dl>
						<dt><a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"><b>${dto.bookTitle }</b></a></dt>
						<dd>${dto.authorName } | ${dto.publisher }</dd>
						<dd>
							<p>
								<span class="point_red"><b><fmt:formatNumber value="${dto.discountedPrice }" pattern="#,###"/>원</b> (${dto.discountRate }%↓+5%P)</span>
							</p>
						</dd>
					</dl>
				</div>
			</li>
		</ul>
		</c:forEach>
		</c:if>
		<c:if test="${empty recentList }">
		<div style="text-align: center; font-size: 15pt; height: 250px; background-color: #d5d5d542; width: 730px; line-height: 12; margin-top: 10px;">최근 본 상품이 없습니다.</div>
		</c:if>
		</div>
	</div>
	<div class="main_CounselList">
		<span class="contents_title">나의 상담 내역</span> | 1:1 상담 내역입니다.  <span class="sapn_right"><a href="<%=cp%>/myShopping/myCounselHistory.action">더보기></a></span>
		<table>
			<tr>
				<th>상담날짜</th>
				<th>구분</th>
				<th style="width: 500px;">제목</th>
				<th>답변여부</th>
			</tr>
			<c:if test="${!empty counselList }">
				<c:forEach var="dto" items="${counselList }">
				<tr>
					<td>${dto.consultationDate}</td>
					<td>${dto.typeId}</td>
					<td><a href="<%=cp%>/myShopping/counselArticle.action?consultId=${dto.consultId}">${dto.subject}</a></td>
					<td>
						<c:if test="${!empty dto.answerCheck }">답변완료</c:if>
						<c:if test="${empty dto.answerCheck }">답변대기</c:if>	
					</td>
				</tr>
				</c:forEach>	
			</c:if>
			<c:if test="${empty counselList }">
				<tr height="100px;">
				<td colspan="4">상담 내역이 없습니다.</td>
				</tr>
			</c:if>
			
		</table>
	</div>
</div>

<!-- 전체 div 끝 -->
</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>