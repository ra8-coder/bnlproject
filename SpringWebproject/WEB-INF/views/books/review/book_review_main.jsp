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
<title>Insert title here</title>

<link rel="stylesheet" href="/webproject/resources/book_css/base.css"
	type="text/css">
<link rel="stylesheet" href="/webproject/resources/book_css/global.css"
	type="text/css">
<style>
.ilike {
	display: inline-block
}

.ilike .btn_ilike {
	display: inline-block;
	width: 66px;
	height: 19px;
	background: url('/webproject/resources/book_image/ico_ilike_comm.gif')
		no-repeat 0 1px;
	padding: 0 0 0 14px;
	font: normal 11px 돋움;
	color: #777
}

.ilike .btn_ilike:hover {
	background:
		url('/webproject/resources/book_image/ico_ilike_comm_on.gif')
		no-repeat;
}

.ilike .on {
	background:
		url('/webproject/resources/book_image/ico_ilike_comm_on.gif')
		no-repeat;
}

.ilike .ilike_count {
	display: inline-block;
	font: normal 11px verdana, 돋움;
	color: #777;
	width: 20px;
	height: 19px;
	padding-top: 4px;
	text-align: center
}
</style>

<script type="text/javascript">
	function goReview(Val) {
		location.href = '<%=cp%>/book_review.action?isbn=' + Val;
	}
	
	function goReview2(Val) {
		location.href = '<%=cp%>/book_review_main.action?reviewId=' + Val + '&isbn=' + ${isbn};
	}
	
	function reviewVote(Val){
		location.href ='<%=cp%>/book_review_vote.action?reviewId=' + Val + '&isbn=' + ${isbn};
	}
</script>

</head>
<body>

	<div class="p_bookInfo">
		<div class="iframe_bookInfo_subCon">
			<div style="width: 99%; height: 25px; margin-top: 30px;">
				<h3
					style="padding-right: 22px; font-weight: bold; font-size: 15pt; font-family: '맑은 고딕', '돋움', sans-serif; letter-spacing: -0.1em">
					리뷰</h3>
			</div>
			<!-- 리뷰보기 -->
			<div class="reviewDetail" style="width: 99%">
				<div class="reviewDetailT" style="width: 99%">
					<div class="reviewDetailB" style="width: 99%">
						<ul>

							<li class="title overflow"><strong class="fl_left mr10"
								style="font: normal 16px 맑은 고딕">${dto.reviewTitle }</strong> <span
								class="fl_right mt3 mr10"> <span class=" t_11gr pb5 mr5">${dto.username }</span>
									<c:if test="${dto.rate >= 0 && dto.rate < 2}">

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
									</c:if>
							</span></li>
							<li class="contents" style="LINE-HEIGHT: 20px;">

								<p class="info mb15">
									<span class="t_11br3 ">조회: <strong>${dto.hitCount +1}</strong></span>
									| <span class="t_11br3 ">공감: <strong>${dto.thumbup }</strong></span>
									| <span class="t_11br3 ">작성일: ${dto.created }</span>
								</p>


								<p class="mt15"></p>
								<p>
									<font size="3"> </font>
								</p>
								<p style="margin: 0cm 0cm 10pt;">
									<font face="맑은 고딕"> ${dto.contents } </font>
								</p>
								<p>
									<font size="3"> </font><br>
								</p>
								<p></p>
							</li>
						</ul>

						<!-- btn area -->
						<div class="btnA">
							<span class="ilike"> <input type="hidden" value="${isbn }"
								name="isbn">
								<button onclick="reviewVote(${dto.reviewId})"
									class="btn_ilike 0">
									<span>공감하기</span>
								</button> <span class="ilike_count">${dto.thumbup }</span></span>

						</div>

					</div>
				</div>
			</div>
			<!-- //리뷰보기 -->

			<!-- btn area -->
			<div class="btnR">
				<a href="javascript:goReview(${dto.isbn })"><img
					src="http://blog.bandinlunis.com/bandi_blog/images/common/btnW_list.gif"
					alt="목록으로 돌아가기"></a>
			</div>

			<ul class="listRN mt20">
				<li><img
					src="http://blog.bandinlunis.com/bandi_blog/images/common/list_prev.gif"
					alt="이전글" class="al_middle"> <c:choose>
						<c:when test="${empty preDto }">
							게시물이 없습니다.
						</c:when>

						<c:otherwise>
							<a href="javascript:goReview2(${preDto.reviewId })">${preDto.reviewTitle }</a>
							<p class="t_gr">${preDto.username }</p>
						</c:otherwise>
					</c:choose></li>
				<li class="alt"><img
					src="http://blog.bandinlunis.com/bandi_blog/images/common/list_next.gif"
					alt="다음글" class="al_middle"> <c:choose>
						<c:when test="${empty nextDto }">
							게시물이 없습니다.
						</c:when>

						<c:otherwise>
							<a href="javascript:goReview2(${nextDto.reviewId })">${nextDto.reviewTitle }</a>
							<p class="t_gr">${nextDto.username }</p>

						</c:otherwise>

					</c:choose></li>
			</ul>
		</div>

	</div>

</body>
</html>