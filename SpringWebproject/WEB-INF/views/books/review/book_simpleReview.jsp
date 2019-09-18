<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

	String isbn = request.getParameter("isbn");
	String check_simpleReview = request.getParameter("check_simpleReview");
// 	int check = Integer.parseInt(check_simpleReview);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>반디앤루니스 인터넷서점</title>
<style>
* {
	margin: 0;
	padding: 0
}

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

body, ul, li {
	margin: 0;
	padding: 0
}

body {
	padding-bottom: 10px;
	font-size: 12px;
	color: #555555;
	line-height: 16px;
	font-family: 굴림;
}

img {
	border: 0;
	vertical-align: top;
}

ul {
	list-style: none;
	vertical-align: top;
}

li {
	vertical-align: top;
}

li img {
	vertical-align: top;
}

a:link {
	text-decoration: none;
	color: #555555;
}

a:visited {
	text-decoration: none;
	color: #555555;
}

a:hover {
	text-decoration: underline;
	color: #8F6A24;
}

a:active {
	text-decoration: underline;
	color: #555555;
}

.pos_rel {
	position: relative
}

form {
	margin: 0;
	padding: 0;
}

input {
	height: 13px;
	border: 1px solid #D0C3A9;
	padding: 3px 12px 0 4px;
	vertical-align: middle;
}

input.chk {
	width: 12px;
	height: 12px;
	border: 0;
	background: transparent;
	padding: 0;
}

textarea {
	border: 1px solid #d1d1d1;
}

.bookInfo_subCon {
	clear: both
}

.bookInfo_subCon.alt {
	background: none;
	padding-top: 25px;
}

.bookInfo_more {
	width: 100%;
	margin-bottom: 35px;
	padding: 0 5px 0 0;
	clear: both;
	overflow: hidden
}

.fl_left {
	float: left
}

.mt10 {
	margin-top: 10px
}

.ml10 {
	margin-left: 10px;
}

.mr10 {
	margin-right: 10px;
}

.t_11br3 {
	font-size: 11px;
	color: #9E8964;
	font-family: 돋움
}

.t_11br3	a:link {
	text-decoration: none;
	color: #9E8964;
}

.t_11br3	a:visited {
	text-decoration: none;
	color: #9E8964;
}

.t_11br3	a:hover {
	text-decoration: underline;
	color: #9E8964;
}

.t_11br3	a:active {
	text-decoration: underline;
	color: #9E8964;
}

table	td.td_Left {
	text-align: left
}

table	td.td_L10 {
	text-align: left;
	padding-left: 10px;
}

table	td.td_L15 {
	text-align: left;
	padding-left: 15px;
}

table	td.td_L20 {
	text-align: left;
	padding-left: 20px;
}

table	td.td_L30 {
	text-align: left;
	padding-left: 30px;
}

table	td.td_L35 {
	text-align: left;
	padding-left: 35px;
}

table	td.td_R5 {
	text-align: right;
	padding-right: 5px;
}

table	td.td_R10 {
	text-align: right;
	padding-right: 10px;
}

table	td.td_R15 {
	text-align: right;
	padding-right: 15px;
}

table	td.td_input {
	padding-top: 10px;
	padding-bottom: 10px
}

table	th.td_Left {
	text-align: left
}

.boardList02 {
	
}

.boardList02	th.thS {
	height: 31px;
	background: url('/images/common/boardTH02_S.gif') no-repeat left 0
}

.boardList02	th.thE {
	height: 31px;
	background: url('/images/common/boardTH02_E.gif') no-repeat right 0
}

.boardList02	th {
	height: 31px;
	font: normal 11px 돋움;
	color: #fff;
	background: url('/images/common/boardTH02_M.gif') repeat-x;
}

.boardList02	th	a:link, .boardList02	th	a:visited, .boardList02	th	a:hover
	{
	color: #fff;
}

.boardList02	th	a.on {
	text-decoration: underline
}

.boardList02	td {
	text-align: center;
	padding: 5px 0 3px
}

.boardList02	td.line {
	background: #ececec;
	height: 1px;
	padding: 0;
}

.bookInfo_subCon    li {
	line-height: 1.5em
}

.bookInfo_subCon    dl {
	width: 692px;
	overflow: auto;
	overflow: hidden;
	margin-top: 20px;
}

.bookInfo_subCon    dt {
	clear: both;
	float: left;
	width: 72px;
	margin-bottom: 8px;
}

.bookInfo_subCon    dd {
	float: left;
	width: 620px;
	margin-bottom: 8px;
	padding-top: 2px;
}

.bookInfo_subCon    h4 {
	margin-bottom: 10px;
	font: normal 11px 돋움
}

.bookInfo_subCon    .bookTitleBox {
	border: 1px solid #E1D6C3;
	background: #E9E2D6;
	padding: 3px 4px 2px;
	font: normal 12px 돋움;
	color: #6C5636;
}

.bookInfo_subCon    p {
	line-height: 1.6em;
}

.bookInfo_subCon    p.pen {
	line-height: 2.1em
}

.bookInfo_subCon    p.pen   span {
	background: #FFF4E2;
	padding: 5px 5px;
	color: #000;
	background: url('/images/common/bg_pen.gif') 0 0
}

.bookInfo_subCon    .conList {
	
}

.bookInfo_subCon    .conList    li {
	margin-bottom: 25px;
	line-height: 1.6em
}

.bookInfo_subCon    .conList    li  ul  li {
	margin-bottom: 0
}

.bookInfo_subCon    p.tag {
	color: #aaa
}

.bookInfo_subCon    .tagFormA {
	position: relative;
	text-align: right;
	margin: 10px 8px 0 0;
	z-index: 0;
}

.bookInfo_subCon    .pageBG {
	background: none;
	margin-left: -12px;
}

.bookInfo_subCon    .pageBG .pageConR {
	right: 8px;
}

.bookInfo_subCon    .subtab {
	width: 719px;
	margin-left: -12px;
}

.bookInfo_subCon    .reviewList .boardList02    td {
	padding: 2px 0 1px
}

.bookInfo_subCon    .reviewList .boardList02    td.line {
	background: #E9E4DC;
	height: 1px;
	padding: 0;
}

.bookInfo_subCon    .reviewList .btnR {
	text-align: right;
	padding-right: 5px;
	margin: 8px 0 25px;
}

.bookInfo_subCon    .reviewWrite {
	margin-left: -12px;
	padding: 11px 31px 13px;
}

.bookInfo_subCon    .reviewWrite    .titA {
	position: relative;
	width: 655px;
}

.bookInfo_subCon    .reviewWrite    .titA   .btnA {
	position: absolute;
	right: 0px;
	top: -10px;
}

.bookInfo_subCon    .reviewDetail {
	margin-left: -14px
}

.bookInfo_subCon    .listRN {
	margin: 0 0 30px -13px;
	width: 719px;
}

.bookInfo_subCon	.eventList {
	width: 700px;
}

.bookInfo_subCon	.eventList li {
	margin-bottom: 10px;
	overflow: hidden;
	clear: both;
}

.bookInfo_subCon	.eventList	.eventImg {
	float: left;
	width: 200px;
}

.bookInfo_subCon	.eventList	dl {
	float: right;
	width: 480px;
	margin-top: 5px;
}

.bookInfo_subCon	.eventList	dl dt {
	font-weight: bold;
	float: none;
	width: 480px;
	margin-bottom: 3px;
}

.bookInfo_subCon	.eventList	dl dd {
	margin-bottom: 0;
	padding-top: 0;
	width: 480px;
}

.shotReview {
	position: relative;
	padding-right: 120px;
	padding-bottom: 10px
}

.shotReview textarea {
	width: 837px;
	height: 40px;
	padding: 5px;
	overflow-x: hidden;
	overflow-y: auto;
	margin: 10px 0 0 10px
}

.shotReview .check {
	position: absolute;
	font: normal 10px Tahoma, verdana, 돋움;
	color: #888888;
	margin: 4px 0 0 15px;
	bottom: -3px;
	right: 102px
}

.shotReview .btn_show_register {
	position: absolute;
	top: 10px;
	right: 10px
}

.box_tag {
	float: left;
	width: 80px;
	height: 31px;
	padding-top: 20px;
	border: 1px solid #ccc;
	font-weight: bold;
	font-size: 9pt;
	line-height: 1.0;
	color: #656d73;
	text-align: center;
	text-decoration: none !important
}
/* page */
.pageBG {
	position: relative;
	height: 35px;
	background: url('/images/common/bg_pageA.gif') repeat-x 0 0;
	z-index: 1
}

.pageBG	.page {
	padding-top: 10px;
}

.pageBG	.pageConL {
	position: absolute;
	top: 10px;
	left: 20px;
}

.pageBG	.pageConR {
	position: absolute;
	top: 8px;
	right: 14px;
}

.pageBGNone {
	background: 0 none
}

.pageBGNone02 {
	margin-top: -1px;
	padding-top: 10px;
	border-top: 1px solid #E2D7C7;
	background: 0 none
}

.page {
	text-align: center
}

.page	img {
	vertical-align: top;
	margin: 3px 4px 0
}

.page	.pageNum {
	margin: 0 5px 0 7px;
	font: normal 10px verdana;
	color: #7D705A;
	letter-spacing: 2px;
}

.page	.pageNum	a, .page	.pageNum	a:visited {
	color: #7D705A;
}

.page	.pageNum	a:hover {
	color: #8F6A24;
	text-decoration: none
}

.page	.pageNum	.on {
	color: #8F6A24;
	font-weight: bold
}

.boardList02 td {
	padding: 7px 0;
	0
}
</style>
<link rel="stylesheet" href="/webproject/resources/book_css/common.css"
	type="text/css">

<script type="text/javascript"
	src="/webproject/resources/book_js/httpRequest.js"></script>
<script type="text/javascript"
	src="/webproject/resources/book_js/common.js"></script>
<script type="text/javascript"
	src="/webproject/resources/book_js/common.js" charset="euc-kr"></script>
<script type="text/javascript"
	src="/webproject/resources/book_js/JUTIL.js" charset="utf-8"></script>



<script type="text/javascript">
function go_login2() {

	alert("로그인 하셔야 간단평을 쓰실수 있습니다.");
	parent.location.href = '<%=cp%>/login2.action?isbn='+<%=isbn%>;

}

function enroll_SimpleReview(Val){
	
	if(${check_simpleReview } == 1){
		alert("이미 간단평을 등록하셨습니다.");	
		return ;
	}
	
	f = document.mainForm;
	
	str = f.sentence.value;
	if(str.length <0){
	alert("내용을 입력해주세요.");
	return ;
	}
	alert("간단평이 등록되었습니다.");
	
	
	location.href = '<%=cp%>/enroll_simpleReview.action?isbn=' + Val
				+ '&sentence=' + str;
		return;
}

function reviewVote2(Val){
	alert("한줄평에 공감하셨습니다. + " + Val);
	
	var url = '<%=cp%>/book_simpleReviewVote.action';
		url += '?isbn=' + ${isbn};
		url += '&reviewId=' + Val;

		var xmlHttp = new XMLHttpRequest();
		xmlHttp.open("GET", url, false); // false for synchronous request
		xmlHttp.send(null);
		return xmlHttp.responseText;

	}
</script>

<link rel="stylesheet"
	href="/webproject/resources/book_css/detail_default.css"
	type="text/css">

</head>

<body>
	<div class="wrap_contents">
		<div class="inner_info">
			<div class="row_item">
				<div class="title_zone" style="margin-bottom: 15px">
					<h3 class="txt_title">


						간단평<span class="t_12"
							style="letter-spacing: 0; font-weight: normal; margin-left: 5px;">1,000원이상
							상품 구매 후 100자 이상 간단평 작성 시 반딧불 100개(100자 미만 20개)를 드립니다. </span>


					</h3>
					<a href="javascript:popLayer('shotReviewInfo')"
						class="btn_w_comm btype_a2 hand mt3"
						style="position: absolute; right: 10px; top: 0">간단평 혜택 및 이용안내</a>
					<div class="bookViewPop" id="shotReviewInfo"
						style="visibility: hidden; right: 10px; top: 0; width: 450px">
						<h3 class="mLine">간단평 혜택 및 이용안내</h3>
						<div class="laypopCon mt15">
							<h4>구매완료 후 간단평 작성 시 혜택</h4>
							<table cellpadding="0" cellspacing="0" class="storeNum card_info">
								<colgroup>
									<col width="140">
									<col width="300">
								</colgroup>
								<tbody>
									<tr>
										<th>100자 이상 작성</th>
										<td>반딧불 100개 지급</td>
									</tr>
									<tr>
										<th>100자 미만 작성</th>
										<td>반딧불 20개 지급</td>
									</tr>
								</tbody>
							</table>
							<ul class="t_11gr mt5 overflow">
								<li class="dot_comm_11" style="padding-bottom: 0">반디앤루니스
									온라인에서 구매한 상품(1,000원 이상)에 한하여 적립됩니다.</li>
								<li class="dot_comm_11">상품 1종당 1회 적립가능합니다.</li>
							</ul>
							<h4 class="mt20">간단평 작성 유의사항</h4>
							<div class="t_11gr mt5" style="line-height: 140%">
								<span class="point_b">욕설, 단어 반복, 배송평가 등 상품과 관련이 없는 내용 작성
									시</span>, 지급된 반딧불은 회수처리 되며 작성된 간단평은 등록 취소 됩니다.
							</div>

							<h4 class="mt20">반딧불이란?</h4>
							<div class="t_11gr mt5" style="line-height: 140%">반디앤루니스에서
								메일 구독, 간단평/서평 작성, 공감하기 등 책과 관련된 컨텐츠 활동을 하는 모든 회원님께 드리는 특별 포인트
								입니다. 반딧불은 10개부터 적립금으로 환전하여 현금처럼 사용할 수 있습니다.</div>

						</div>
						<p class="btnClose">
							<img
								src="http://image.bandinlunis.com/images/common/btn_close02.gif"
								alt="close" style="cursor: pointer;"
								onclick="javascript:popHidden('shotReviewInfo')">
						</p>
					</div>
				</div>

				<div class="bookInfo_subCon">

					<!-- boardList02 -->
					<form name="mainForm" method="post">

						<input type="hidden" name="isbn" value=${isbn }>
						<div style="width: 100%;">
							<div class="shotReview">
								<textarea name="sentence"></textarea>
								<p class="btn_show_register">
									<c:choose>
										<c:when test="${empty sessionScope.userInfo.userId }">
											<a class="box_tag" href="javascript:go_login2();">등록</a>
										</c:when>
										<c:otherwise>
											<a class="box_tag"
												href="javascript:enroll_SimpleReview(${isbn });">등록</a>
										</c:otherwise>
									</c:choose>

								</p>
								<p class="check" id="title_stat">0/200</p>
							</div>
						</div>



						<div id="simpleReviewTitle"></div>



					</form>




				</div>
			</div>
		</div>
	</div>


</body>
<script>
	function simpleReviewTitle() {
		sendRequest(
				"/webproject/book_simpleReview_ok.action?isbn=" +
<%=isbn%>
	,
				null, displaySimpleReviewTitle, "GET");

	}

	function displaySimpleReviewTitle() {

		if (httpRequest.readyState == 4) {
			if (httpRequest.status == 200) {

				var doc = httpRequest.responseXML;
				var titleNL = doc.getElementsByTagName("sentence");
				var userName = doc.getElementsByTagName("userName");
				var thumbup = doc.getElementsByTagName("thumbUp");
				var reviewId = doc.getElementsByTagName("reviewId");
				var htmlData = "<table width='100%' border='0' cellpadding='0' cellspacing='0' class='boardList02 mt10'>";
				htmlData += "<colgroup>	<col width='135'><col width=''>	<col width='135'> </colgroup>";
				htmlData += "<tbody> <tr> <td colspan='6' class='line'> </td> </tr>";

				for (var i = 0; i < titleNL.length; i++) {
					htmlData += "<tr>";
					htmlData += "<td class='td_L15' style='width:15%'>"
							+ userName.item(i).firstChild.nodeValue;
					htmlData += "</td>";
					htmlData += "<td class='td_L15' style='width:70%'> ";
					htmlData += titleNL.item(i).firstChild.nodeValue;
					htmlData += "</td>";
					htmlData += "<td class='td_R10'style='width:15%'> ";
					htmlData += "<span class='ilike'><button id = 'btn1' onclick='reviewVote2(";
					htmlData += reviewId.item(i).firstChild.nodeValue;
					htmlData += ")'";
					htmlData += "class='btn_ilike'><span>공감하기</span></button>";
					htmlData += "<span class='ilike_count'>";
					htmlData += thumbup.item(i).firstChild.nodeValue;
					htmlData += "</span></span></td>";
					htmlData += "</tr>";

				}

				htmlData += "</tbody>  </table>";

				var simpleReviewDiv = document
						.getElementById("simpleReviewTitle");
				simpleReviewDiv.innerHTML = htmlData;

			} else {
				alert(httpRequest.status + " : " + httpRequest.statusText);
			}

		}

	}

	window.onload = function() {
		simpleReviewTitle();
	}
</script>
</html>