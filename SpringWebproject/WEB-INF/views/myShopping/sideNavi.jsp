<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>

<div class="side_navi">
	<span class="side_navi_title">나의쇼핑</span>
	<ul>
		<li style="padding-top: 10px;">
			<span class="side_navi_span">주문관리</span>
			<div class="side_navi_line">
				<ul>
					<li><a href="<%=cp%>/myShopping/myOrderList.action">주문/배송 조회</a></li>
					<li style="padding-bottom: 10px;"><a href="<%=cp%>/myShopping/myOrderRetList.action">취소/반품/교환 내역</a></li>
				</ul>
			</div>
		</li>
		<li style="padding-top: 10px;">
			<span class="side_navi_span">포인트와 혜택</span>
			<div class="side_navi_line">
				<ul>
					<li style="padding-bottom: 10px;"><a href="<%=cp%>/myShopping/myPointHistory.action">적립금</a></li>
				</ul>
			</div>
		</li>
		<li style="padding-top: 10px;">
			<span class="side_navi_span">관심 리스트</span>
			<div class="side_navi_line">
				<ul>
					<li><a href="<%=cp%>/myShopping/myLatesBooksList.action">최근 본 상품</a></li>
					<li style="padding-bottom: 10px;"><a href="<%=cp%>/myShopping/myWishList.action">위시리스트</a></li>
				</ul>
			</div>
		</li>
		<li style="padding-top: 10px;">
			<span class="side_navi_span">나의 리뷰</span>
			<div class="side_navi_line">
				<ul>
					<li><a href="<%=cp%>/myShopping/myReviewList.action">리뷰가 있는 책</a></li>
					<li><a href="<%=cp%>/myShopping/readyReviewList.action">리뷰를 기다리는 책</a></li>
					<li style="padding-bottom: 10px;"><a href="<%=cp%>/myShopping/mySentenceList.action">간단평</a></li>
				</ul>
			</div>
		</li>
		<li style="padding-top: 10px;">
			<span class="side_navi_span">나의 상담</span>
			<div class="side_navi_line">
				<ul>
					<li><a href="<%=cp%>/myShopping/myCounselHistory.action">1:1 상담 내역</a></li>
					<li style="padding-bottom: 10px;"><a href="<%=cp%>/help/helpCounsel.action">1:1 상담하기</a></li>
				</ul>
			</div>
		</li>
		<li style="padding-top: 10px;">
			<span class="side_navi_span">회원정보</span>
			<div class="side_navi_line">
				<ul>
					<li><a href="<%=cp %>/myShopping/pre_updateMyInfo.action?mode=update">회원정보 수정</a></li>
					<li style="padding-bottom: 10px;"><a href="<%=cp %>/myShopping/pre_updateMyInfo.action?mode=out">회원 탈퇴</a></li>
				</ul>
			</div>
		</li>
	</ul>
</div>