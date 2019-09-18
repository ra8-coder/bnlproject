<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반디 책 리뷰 화면</title>

<link rel="stylesheet"
	href="http://blog.bandinlunis.com/bandi_blog/css/base.css"
	type="text/css">
<link rel="stylesheet"
	href="http://blog.bandinlunis.com/bandi_blog/css/global.css"
	type="text/css">
<script src="http://blog.bandinlunis.com/bandi_blog/js/common.js"></script>




<style>
.commTable th {
	font-weight: normal;
	background: #f7f7f7;
	border-left: 1px solid #d8d8d8;
	padding: 10px 5px 10px 5px;
	text-align: center
}

.commTable th:first-child {
	border-left: none
}

.commTable td {
	padding: 10px 5px;
	border-bottom: 1px solid #d8d8d8;
	border-left: 1px solid #d8d8d8;
	text-align: center
}

.commTable td:first-child {
	border-left: none
}

.commTable td.noline {
	border-left: none
}

.commTable td.prod_name {
	border-left: none;
	text-align: left
}

.commTable td.total {
	font: bolder 16px verdana, 돋움;
	text-align: right;
	padding-right: 10px;
}

.commTable .book_img {
	width: 40px;
	hheight: 60px
}

.commTable .book_img img {
	width: 38px;
	border: 1px solid #d2d2d2
}

.commTable .book_name {
	display: block;
	float: left;
	margin-left: 10px
}

.commTable2 {
	font: normal 12px 굴림, Dotum, AppleGothic, sans-serif;
	border-top: 1px solid #d1d1d1;
}

.commTable2 th {
	color: #6e6e6e;
	background: #f7f7f7;
	border-bottom: 1px solid #ededed;
	padding: 12px 5px 12px 20px;
	font-weight: normal;
}

.commTable2 td {
	background: #fff;
	padding: 12px 5px 12px 20px;
	border-bottom: 1px solid #ededed;
	text-align: center
}

.commTable2 .messages {
	width: 90%;
	height: 60px;
	border: 1px solid #d1d1d1;
	font: normal 14px 돋움, Dotum, AppleGothic, sans-serif
}

.commTable2 .saleW {
	float: left;
	width: 250px
}

.orderTable2 .sale2W {
	float: left;
	margin-left: 10px
}

.commTable2 .bgcon {
	background: #e1e1e1;
}

.commTable2 .line_none {
	border-bottom: none
}

.commTable2 .pb0 {
	padding-bottom: 2px
}

.commTable2 .pl0 {
	padding-left: 0px
}

.commTable2 .s_con01 {
	display: inline-block;
	width: 130px;
}

.commTable2 .s_con02 {
	display: inline-block;
	width: 110px;
}

.commTable2 .s_con04 {
	display: inline-block;
	width: 200px
}
</style>


</head>




<body>

	<form name="mainform" id="mainform"
		action="/bandi_blog/extention/prodListTop.do">
		<input type="hidden" name="prod_id" value="${isbn }">

	</form>
	<div class="p_bookInfo">
		<div class="iframe_bookInfo_subCon">
			<div class="pos_rel"
				style="width: 100%; height: 25px; margin-top: 30px; *padding-top: 20px">
				<h3
					style="padding-right: 20px; font-weight: bold; font-size: 15pt; font-family: '맑은 고딕', '돋움', sans-serif; letter-spacing: -0.1em; margin-left: 0">
					리뷰 <span style="font-size: 14px; color: #666">[${reviewNum }]</span>
					<!-- 데이터개수 입력하기 -->
				</h3>
			</div>

			<div class="reviewList">
				<!-- boardList02 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="commTable2">
					<colgroup>
						<col width="12%">
						<col width="50%">
						<col width="12%">
						<col width="7%">
						<col width="7%">
						<col width="12%">
					</colgroup>
					<thead>
						<tr>
							<th class="thS">평점</th>
							<th>리뷰제목</th>
							<th>글쓴이</th>
							<th>조회</th>
							<th>공감</th>
							<th class="thE">작성일</th>
						</tr>
					</thead>
					<tbody>
						<!-- loop -->
						<c:forEach var="dto" items="${lists }">
							<tr>
								<td style="width: 15%"><c:if
										test="${dto.rate >= 0 && dto.rate < 2}">

										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->

									</c:if> <c:if test="${dto.rate >= 2 && dto.rate < 4  }">
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
									</c:if> <c:if test="${dto.rate >=4 && dto.rate < 6}">
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
									</c:if> <c:if test="${dto.rate >=6 && dto.rate <8}">
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
									</c:if> <c:if test="${dto.rate >=8 && dto.rate <10}">
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS0.gif"
											alt="">
										<!-- 나뭇잎0 -->
									</c:if> <c:if test="${dto.rate ==10}">
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
										<img
											src="http://blog.bandinlunis.com/bandi_blog/images/common/ico_gradeS2.gif"
											alt="">
										<!-- 나뭇잎1 -->
									</c:if></td>
								<td style="text-align: left;"><a
									href="javascript:goReviewMain(${dto.reviewId })">
										${dto.reviewTitle } </a></td>
								<td class="t_gr">${dto.username }</td>
								<td class="t_11gr">${dto.hitCount }</td>
								<td class="t_11gr">${dto.thumbup }</td>
								<td class="t_11gr">${dto.created }</td>

							</tr>

						</c:forEach>


						<!-- //loop -->
					</tbody>
				</table>
				<!-- //boardList02 -->
				<!-- page -->
				<div class="pageBG pageBGNone">
					<div class="page">
						<span class="pageNum">
							<div class="page" style="font-size: 12pt;">
								<c:if test="${reviewNum!=0 }">
					${pageIndexList }
				</c:if>
								<c:if test="${reviewNum==0 }">
					등록된게시물이 없습니다.
				</c:if>
							</div>
						</span>
					</div>

					<div class="pageConR">

						<script>
						
						function go_login2() {

							alert("로그인 하셔야 리뷰를 쓰실수 있습니다.");
							parent.location.href = '<%=cp%>/login2.action?isbn='+${isbn };
							return;

						}


						function goReview() {
							
							if(${check_review } == 1){
								alert("이미 리뷰를 한번 등록하셨습니다.");	
								return ;
							}									
							parent.location.href = '<%=cp%>/book_review_created.action?isbn='+ ${isbn};
							
						}
						
						function goReviewMain(Val){
							location.href = '<%=cp%>/book_review_main.action?reviewId='+ Val+ '&isbn=' + ${isbn };
							}

					
						</script>
						<form action="" name="reviewForm" method="post">
							<c:choose>

								<c:when test="${empty sessionScope.userInfo.userId }">
									<a href="javascript:go_login2();"> <img
										src="http://blog.bandinlunis.com/bandi_blog/images/common/btn_writeReview.gif"
										class="al_middle" alt="리뷰쓰기">
									</a>
								</c:when>



								<c:otherwise>
									<a href="javascript:goReview();"> <img
										src="http://blog.bandinlunis.com/bandi_blog/images/common/btn_writeReview.gif"
										class="al_middle" alt="리뷰쓰기">
									</a>
								</c:otherwise>

							</c:choose>
						</form>

					</div>
				</div>
				<!-- //page -->
			</div>
		</div>
	</div>





</body>
</html>