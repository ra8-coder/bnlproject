<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<!DOCTYPE html>
<html>
<head>
<title>반디앤루니스 인터넷서점</title>

	<link rel="stylesheet" href="<%=cp%>/resources/css/main.css" type="text/css">
	<link rel="stylesheet" href="<%=cp%>/resources/css/myShopping.css" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="<%=cp%>/resources/js/myShopping.js"></script>
	
</head>
<body style="padding: 0; margin: 0;">

<!-- header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<!-- 전체 div -->
<div style="margin: 0 auto; width: 960px;">

<div style="margin-top: 12px;">
	<a href="<%=cp %>/main.action">홈</a> > <a href="<%=cp %>/myShoppingMain.action">나의쇼핑</a> > 나의 상담 > <b>1:1 상담 내역</b>
</div>
<!-- navigation -->
<jsp:include page="./topNavi.jsp" flush="false"/>
<jsp:include page="./sideNavi.jsp" flush="false"/>

<!-- 본문 -->
<div class="contents">
	<div style="font-size: 13pt; font-weight: bold; padding-bottom: 10px; border-bottom: 2px solid #e1e1e1;">1:1 상담 내역</div>
	<div class="review_article_title" style="border-bottom: none;">
		<b>${dto.subject }</b>
		<span style="float: right;">
			${dto.consultationDate } | 
			<c:if test="${!empty dto.answerCheck }">답변완료</c:if>
			<c:if test="${empty dto.answerCheck }">답변대기</c:if>
		</span>
		<br/>
	</div>
	<div class="review_article_contents">
		${dto.contents }
	</div>
</div>

</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
</html>