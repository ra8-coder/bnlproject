<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${!empty lst }">
<ul class="rc_books_list">
	<c:forEach var="rc" items="${lst }">
	<li>
		<div class="rb_image">
			<a href="<%=cp%>/book_info.action?isbn=${rc.isbn}">
				<img src="<%=cp%>/resources/image/book/${rc.bookImage}">
			</a>
			<dl class="rb_title">
				<dt>${rc.bookTitle }</dt>
				<dd>${rc.authorName }</dd>
			</dl>
		</div>
	</li>
	</c:forEach>
</ul>
</c:if>
<c:if test="${empty lst }">
	<div class="rc_books_list recommend_no_data">
		유사 분야 서적이 없습니다
	</div>
</c:if>

