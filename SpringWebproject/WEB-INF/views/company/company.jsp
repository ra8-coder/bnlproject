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
						<img src="<%=cp %>/resources/image/main/h2_overview.gif">
					</h2>
				</div>
			</div>
			<div class="bc_intro">
				<p class="margin">
					<img src="<%=cp%>/resources/image/main/txt_overview01.gif" style="border: 0; vertical-align: top;">
				</p>
				<p class="margin">
					<img src="<%=cp%>/resources/image/main/txt_overview02.gif">
				</p>
				<table class="bc_table">
					<tr>
						<th>
							<img src="<%=cp%>/resources/image/main/th02_nameCorp.gif">
						</th>
						<td>
							주식회사
							<strong>서울문고</strong>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="line">
					</tr>
					<tr>
						<th>
							<img src="<%=cp%>/resources/image/main/th02_nameBrand.gif">
						</th>
						<td>
							반디앤루니스
						</td>
					</tr>
					<tr>
						<td colspan="2" class="line">
					</tr>
					<tr>
						<th>
							<img src="<%=cp%>/resources/image/main/th02_representative.gif">
						</th>
						<td>
							김천식
						</td>
					</tr>
					<tr>
						<td colspan="2" class="line">
					</tr>
					<tr>
						<th>
							<img src="<%=cp%>/resources/image/main/th02_dateFoundation.gif">
						</th>
						<td>
							1988년 04월 29일
						</td>
					</tr>
					<tr>
						<td colspan="2" class="line">
					</tr>
					<tr>
						<th>
							<img src="<%=cp%>/resources/image/main/th02_address.gif">
						</th>
						<td>
							(06627) 서울특별시 서초구 강남대로 331 광일플라자빌딩 14층
						</td>
					</tr>
					<tr>
						<td colspan="2" class="line">
					</tr>
					<tr>
						<th>
							<img src="<%=cp%>/resources/image/main/th02_homepage.gif">
						</th>
						<td>
							www.bandinlunis.com
						</td>
					</tr>
				</table>	
			</div>
			<div class="bc_img">
				<p>
					<img src="<%=cp%>/resources/image/main/img_overview01.jpg">
				</p>
				<p>
					<img src="<%=cp%>/resources/image/main/img_overview02.jpg">
				</p>
			</div>
		</div>
	</div>
</div>


<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>