<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="b_arrow_box">
	<button class="slide_aw left" id="ib_awL">
		<span class="aw_count_ib"></span>
	</button>	
	<button class="slide_aw right" id="ib_awR">
		<span class="aw_count_ib"></span>
	</button>
</div>
<div class="swiper-container swiper5">
	<div class="swiper-wrapper">
		<c:set var="i" value="0"/>
		<c:forEach var="ib" items="${lst }">
			<c:if test="${i==0||i%5==0 }">
			<div class="swiper-slide">
				<ul class="wrap_b_img">
			</c:if>
				<li class="wrap_b_li">
					<a href="<%=cp%>/book_info.action?isbn=${ib.isbn}">
						<img src="<%=cp%>/resources/image/book/${ib.bookImage }">
					</a>
					<dl class="rb_title">
						<dt>${ib.bookTitle }</dt>
						<dd>${ib.authorName }</dd>
					</dl>
				</li>
			<c:if test="${i==4||i%5==4}">
				</ul>
			</div>
			</c:if>
		<c:set var="i" value="${i+1 }"/>
		</c:forEach>
	</div>
</div>

<script>
var swiper = new Swiper('.swiper5', {
	spaceBetween: 0,
	centeredSlides: true,
	loop: true,
	pagination: {
		el: '.aw_count_ib',
		type: 'fraction',
	},
	navigation: {
		nextEl: '#ib_awR',
		prevEl: '#ib_awL',
	},
});
</script>
