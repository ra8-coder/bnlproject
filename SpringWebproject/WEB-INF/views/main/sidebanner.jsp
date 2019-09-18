<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%> 
    
<c:if test="${!empty rcSideList}">
	<h4>최근 본 상품</h4>
	<div class="swiper-container side_swiper">
		<ul class="swiper-wrapper">
		<c:set var="i" value="0"/>
	    <c:forEach var="rcs" items="${rcSideList }">
	    	<c:if test="${i==0||i%2==0 }">
	    		<li class="swiper-slide">
	    	</c:if>
	    		<div class="tv_item">
	    			<a href="<%=cp%>/book_info.action?isbn=${rcs.isbn}">
	    				<img src="<%=cp%>/resources/image/book/${rcs.bookImage}">
	    			</a>
	    		</div>
	    	<c:if test="${i==1||i%2==1 }">
	    		</li>
	    	</c:if>
	    	<c:set var="i" value="${i+1 }" />
	    </c:forEach>
	   	</ul>
	</div>
	<div class="aw_box_tv">
		<button class="tv_aw left" id="tv_awl"></button>
			<span class="tv_aw_count"></span>
		<button class="tv_aw right" id="tv_awr"></button>
	</div>
	<script>
	var swiper = new Swiper('.side_swiper', {
				spaceBetween: 0,
				centeredSlides: true,
				simulateTouch : false,
				loop: true,
				pagination: {
					el: '.tv_aw_count',
					type: 'fraction',
				},
				navigation: {
					nextEl: '#tv_awr',
					prevEl: '#tv_awl',
				},
			});
	</script>
</c:if>
<c:if test="${empty rcSideList }">
	<h4>최근 본 상품</h4>
	<div style="width: 92px;margin: 0 auto;overflow: hidden;">
		<div class="nodata">
			최근 본 상품이<br>없습니다.
		</div>
	</div>
</c:if>