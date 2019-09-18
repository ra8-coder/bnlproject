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
	padding: 0;
}
.content{
	HEIGHT: 458px;
    WIDTH: 808px;
    POSITION: absolute;
    LEFT: 76px;
    TOP: 537px;}
.bnl_mv{
    HEIGHT: 497px;
    WIDTH: 798px;
    POSITION: absolute;
    LEFT: 90px;
    TOP: 435px;
}
.f_margin{
	height: 26px !important;
}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" flush="false"/>

<div class="contentBody">
	<div class="contentWrap">
		<div style="width: 960px; margin: 0 auto;">
			<div style="position: relative;">
				<div class="content">
					<iframe height="458" src="https://www.youtube.com/embed/iwEhgjqCjJk" frameborder="0" width="808" allowfullscreen=""></iframe>
				</div>
				<img src="<%=cp%>/resources/image/main/vod_pc.jpg" border="0" usemap="#Map">
				<map name="Map" id="Map">
					<area shape="circle" coords="509,1084,26" href="https://twitter.com/intent/tweet?text=[반디앤루니스] 그 곳에 책이 있었다 &url=http://goo.gl/A8ZnRn" target="_blank">
  					<area shape="circle" coords="449,1086,26" href="http://www.facebook.com/sharer/sharer.php?u=http://goo.gl/A8ZnRn" target="_blank">
				</map>
			</div>
			
		</div>
	</div>
</div>

<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
</html>