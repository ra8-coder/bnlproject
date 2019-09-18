<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="<%=cp%>/resources/css/admin.css" type="text/css"/>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet"/>

<link rel="shortcut icon" href="http://image.bandinlunis.com/favicon.ico" type="image/x-icon">
<title>2조 반디앤루니스</title>

</head>
<body>
<div id="head">
	<div id="top_wrap">
		<div class="head_top" style="width: 1100px;">
			<h1 class="logo">
				<a href="<%=cp%>/main.action">
					<img alt="" src="<%=cp%>/resources/image/main/logo_2014_top.gif">
				</a>
			</h1>
		</div>
	</div>
	
	<div class="wrap_header">
		<div class="header_menu" style="width: 1100px;">
			<ul class="menu_wrap">
				<li class="menu">
					<a href="<%=cp %>/admin_goods.action" >
						<font>도서관리</font>
					</a>
				</li>
				
				<li class="menu">
					<a href="<%=cp %>/admin_category.action" >
						<font>카테고리관리</font>
					</a>
				</li>
				<li class="menu">
					<a href="<%=cp %>/admin_author.action" >
						<font>작가관리</font>
					</a>
				</li>
				<li class="menu">
					<a href="<%=cp %>/admin_warehouse.action" >
						<font>지점관리</font>
					</a>
				</li>
				
				<li class="menu">
					<a href="<%=cp %>/admin_quantity.action" >
						<font>재고현황</font>
					</a>
				</li>
				
				<li class="menu">
					<a href="<%=cp %>/admin_consultation.action" >
						<font>고객상담</font>
					</a>
				</li>
				<li class="menu">
					<a href="<%=cp %>/admin_order.action" >
						<font>주문현황</font>
					</a>
				</li>
				<li class="menu">
					<a href="<%=cp %>/admin_users.action" >
						<font>회원관리</font>
					</a>
				</li>
			</ul>	
		</div>
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</div>
</body>
</html>



































