<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="<%=cp%>/resources/css/main.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/resources/css/swiper_min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="shortcut icon" href="http://image.bandinlunis.com/favicon.ico" type="image/x-icon">
<title>반디앤루니스 인터넷서점</title>
<style type="text/css">

.contentBody{
	width: 970px;
    margin: 0 auto;
    margin-top: 5px;
    z-index: 30;
}
.contentWrap{
	width: 970px;
	z-index: 0;
}
.bnl_mv{
    HEIGHT: 497px;
    WIDTH: 798px;
    POSITION: absolute;
    LEFT: 90px;
    TOP: 435px;
}
.f_margin{
	height: 0 !important;
}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" flush="false"/>

<div class="contentBody">
	<div style="width: 960px; margin-left: 5px;">
		<div class="contentWrap">
			<div style="position: relative; height: 951px;">
				<div class="bnl_mv">
					<iframe src="//player.vimeo.com/video/110337639?color=e3cd9d" width="780" height="478" frameborder="0" autoplay="1" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
				</div>
				<img src="<%=cp%>/resources/image/main/event1016136_01.jpg">
			</div>
			<div style="margin: 0; padding: 0;">
				<img src="<%=cp%>/resources/image/main/event1016136_02.jpg" border="0" usemap="#Map">
				<map name="Map">
					<area shape="rect" coords="427,4,470,44" href="http://www.facebook.com/sharer/sharer.php?u=https://youtu.be/PQfpgCV51qY" alt="페이스북" target="_blank">
					<area shape="rect" coords="487,4,531,45" href="https://twitter.com/intent/tweet?text=[반디앤루니스] 그 곳에 책이 있었다 &url=https://youtu.be/PQfpgCV51qY;" alt="트위터" target="_blank">
				</map>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
</html>