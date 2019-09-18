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
						<img src="<%=cp %>/resources/image/main/h2_history.gif">
					</h2>
				</div>
				<div class="h_content01">
					
					서울문고는 1988년 코엑스(COEX)내에 2,314㎡규모의 서점을 시작으로 강남지역 주민들의 독서문화 증대와 <br>
					도서관보다 더 편리한 서점의 확립을 위해 노력해왔습니다. 그 결과 2000년 코엑스몰(COEX mall)내 11,900㎡의<br>
					임대면적(전시면적5,619㎡)의 반디앤루니스 서점을 오픈했으며 이후 종로타워점, 신세계강남점, 롯데월드몰점 등 <br> 
					수도권 포함 전국 규모로 지속 확장하고 있습니다. <br><br>					
					200만 권에 이르는 서적량과 방대한 DB, 고객과 함께 숨쉬는 독서공간, 어린이를 위한 전용공간 키즈월드, 편안한<br>
					휴식을 제공하는 북카페 등 외적 시설 확충은 물론 지속적인 온라인 서점 리뉴얼 및 모바일 서점 강화 등을 통해<br>
					온/오프라인을 아우르는 최고의 서점으로 도약하기 위해 임직원 모두 최선을 다하고 있습니다.<br>
				</div>
				<div class="h_box">
					<div class="h_text">
						<div class="h_textB">
							<h3>
								<img src="<%=cp %>/resources/image/main/h3_history_01.gif">
							</h3>
							<div class="h_img">
								<img src="<%=cp %>/resources/image/main/history01.PNG">
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		

<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>			