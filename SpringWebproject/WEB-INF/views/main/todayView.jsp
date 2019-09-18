<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="rb_awbox">
	<button class="slide_aw left" id="rb_awL">
		<span class="aw_count_rb"></span>
	</button>	
	<button class="slide_aw right" id="rb_awR">
		<span class="aw_count_rb"></span>
	</button>
</div>
<h4>오늘본 상품</h4>
<div class="swiper-container swiper3">
	<ul class="swiper-wrapper list">
		<c:forEach var="ck" items="${lst }">
			<li class="swiper-slide">
				<input id="isbn" value="${ck.isbn }" type="hidden"/>
				<div class="rb_image">
					<a href="<%=cp%>/book_info.action?isbn=${ck.isbn}">
						<img src="<%=cp%>/resources/image/book/${ck.bookImage }">
					</a>
					<dl class="rb_title">
						<dt>${ck.bookTitle }</dt>
						<dd>${ck.authorName }</dd>
					</dl>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>

<script src="<%=cp%>/resources/js/swiper_min.js"></script>
<script type="text/javascript">

var swiper = new Swiper('.swiper3', {
	spaceBetween: 0,
	centeredSlides: true,
	loop: true,
	simulateTouch : false,
	pagination: {
		el: '.aw_count_rb',
		type: 'fraction',
	},
	navigation: {
		nextEl: '#rb_awR',
		prevEl: '#rb_awL',
	},
});






</script>
