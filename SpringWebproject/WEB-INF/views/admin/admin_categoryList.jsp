<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
	<option>선택</option>
<c:forEach var="category" items="${categoryList }">
	<option value="${category.categoryId }">${category.categoryName }</option>
</c:forEach>