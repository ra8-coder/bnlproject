<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<div class="navi_div">
	<div class="nameBar">
		<div class="left_div">
			<b>
			${userInfo.userId }<c:if test="${!empty userInfo.nickName }">(${userInfo.nickName })님의 쇼핑 정보</c:if>
			<c:if test="${empty userInfo.nickName }">(${userInfo.userId })님의 쇼핑 정보</c:if>
			</b>
		</div>
		<div class="right_div">
			<img alt="" src="<%=cp%>/resources/img/myShopping/btn_mem_modify.gif" onclick="location.href='<%=cp %>/myShopping/pre_updateMyInfo.action?mode=update';">
			<img alt="" src="<%=cp%>/resources/img/myShopping/btn_mem_wishlist.gif" onclick="location.href='<%=cp%>/myShopping/myWishList.action';">
		</div>
	</div>
	<div class="infoBar">
		<ul>
			<li style="border-left: none;">
				<span>회원등급</span>
				<span class="under">${userInfo.memberGrade }</span>
			</li>
			<li>
				<span>진행중 주문건</span>
				<span class="under">${orderCount }건</span>
			</li>
			<li>
				<span>적립금</span>
				<span class="under"><fmt:formatNumber value="${pointValue }" pattern="#,###"/>원</span>
			</li>
			<li>
				<span>최근 본 상품</span>
				<span class="under">${recentCount }건</span>
			</li>
			<li>
				<span>1:1 상담 내역</span>
				<span class="under">${counselCount }건</span>
			</li>
		</ul>
	</div>
</div>