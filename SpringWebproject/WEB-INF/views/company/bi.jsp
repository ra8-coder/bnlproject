<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="http://image.bandinlunis.com/favicon.ico" type="image/x-icon">
<title>반디앤루니스 인터넷서점</title>

<link rel="stylesheet" href="<%=cp%>/resources/css/store.css" type="text/css"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

</head>
<body style="margin: 0;">
<jsp:include page="../common/header.jsp" flush="false"/>

<div class="content_title">
	<div class="content_wrap">
		<div class="content_wrap2">
			<ul class="c_location">
				<li>
					<a href="<%=cp%>/main.action">홈</a>
				</li>
				<li>
					<a href="<%=cp%>/company.action">회사소개</a>
				</li>
				<li>
					반디앤루니스 소개
				</li>
			</ul>
		</div>
		<div class="smenu_wrap">
			<div class="menuL">
				<div class="menuImg">
					<div class="menuImg_b">
						<ul class="bnl_list">
							<li>
								반디앤루니스 소개
								<ul class="bnl_slist">
									<li>
										<a href="<%=cp%>/company.action">
										회사소개
										</a>										
									</li>
									<li>
										<a href="<%=cp%>/bi.action">
										BI소개
										</a>										
									</li>
									<li>
										<a href="<%=cp%>/history.action">
										연혁
										</a>										
									</li>
									<li>
										<a href="<%=cp%>/contrb.action">
										사회공헌
										</a>										
									</li>
									<li>
										<a href="<%=cp%>/store.action">
										매장소개
										</a>										
									</li>
								</ul>
							</li>
						</ul>
					</div>					
				</div>
			</div>
			<div class="body_content">
				<div class="b_title">
					<h2 class="line">
						<img src="<%=cp %>/resources/image/main/h2_ci.gif">
					</h2>
				</div>
				<div style="text-align: center;">
					<img src="<%=cp %>/resources/image/main/img_ci_2015.gif">
				</div>
				<div style="text-align: center; margin-top: 20px;">
					<img src="<%=cp %>/resources/image/main/img_ci_2014_02.gif">
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>			