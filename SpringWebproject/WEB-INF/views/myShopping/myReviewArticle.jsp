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
	<a href="<%=cp %>/main.action">홈</a> > <a href="<%=cp %>/myShoppingMain.action">나의쇼핑</a> > 나의 리뷰 > <b>리뷰가 있는 책</b>
</div>
<!-- navigation -->
<jsp:include page="./topNavi.jsp" flush="false"/>
<jsp:include page="./sideNavi.jsp" flush="false"/>

<!-- 본문 -->
<div class="contents">
	<div style="font-size: 13pt; font-weight: bold; padding-bottom: 10px; border-bottom: 2px solid #e1e1e1;">리뷰가 있는 책</div>
	<div class="review_article_title">
		<b>${dto.reviewTitle }</b>
		<span>조회 ${dto.hitCount } | 공감 ${dto.thumbUp } (${dto.created })</span>
	</div>
	<div class="review_article_box">
		<ul>
			<li>
				<div class="sentence_head">
					<a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"><img alt="" src="<%=cp%>/resources/image/book/${dto.bookImage}" height="100px;" width="70px;"></a>
				</div>
				<div class="sentence_body">
					<b><a href="<%=cp%>/book_info.action?isbn=${dto.isbn}">${dto.bookTitle }</a></b>
					<br/>
					${dto.authorName } | ${dto.publisher } | ${dto.publishDate }
				</div>
			</li>
		</ul>
	</div>
	<div class="review_article_contents">
		${dto.contents }
	</div>
	<div style="float: right;">
		<b><a href="<%=cp%>/myShopping/reviewUpdate.action?reviewId=${dto.reviewId}&back=article">수정</a> | <a href="javascript:deleteReview('${dto.reviewId }');">삭제</a></b>
	</div>
</div>

</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
</html>