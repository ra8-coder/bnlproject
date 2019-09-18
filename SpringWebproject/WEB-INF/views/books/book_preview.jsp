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
<title>미리보기</title>

<link rel="stylesheet" href="/webproject/resources/book_css/class.css"
	type="text/css">

<link rel="stylesheet" href="/webproject/resources/book_css/common.css"
	type="text/css">

<style>
body {
	font-family: "Lato", sans-serif;
}

.sidebar {
	height: 100%;
	width: 0;
	position: fixed;
	z-index: 1;
	top: 0;
	left: 0;
	background-color: #545765;
	overflow-x: hidden;
	transition: 0.5s;
	padding-top: 60px;
}

.sidebar a {
	padding: 8px 8px 8px 32px;
	text-decoration: none;
	font-size: 10px;
	color: #black;
	display: block;
	transition: 0.3s;
}

.sidebar a:hover {
	color: #CCA63D;
}

.sidebar .closebtn {
	position: absolute;
	top: 0;
	right: 25px;
	font-size: 36px;
	margin-left: 50px;
	color: white;
}

.openbtn {
	font-size: 20px;
	cursor: pointer;
	background-color: #545765;
	color: white;
	padding: 10px 15px;
	border: none;
}

.openbtn:hover {
	background-color: #CCA63D;
}

.Zoom {
	height: 150px;
	width: 200px;
	margin-top: 20px;
	margin-bottom: 20px;
	justify-content: center;
}

.zoomIn {
	float: left;
}

.zoomOut {
	float: left;
}

#main {
	transition: margin-left .5s;
	padding: 16px;
	margin-top: 400px;
}

/* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
@media screen and (max-height: 450px) {
	.sidebar {
		padding-top: 15px;
	}
	.sidebar a {
		font-size: 18px;
	}
}
</style>

<style>
* {
	box-sizing: border-box
}

body {
	font-family: Verdana, sans-serif;
	margin: 0
}

.mySlides {
	display: none;
}

img {
	vertical-align: middle;
}

/* Slideshow container */
.slideshow-container {
	max-width: 60%;
	position: relative;
	margin: auto;
	position: relative;
}

/* Next & previous buttons */
.prev, .next {
	cursor: pointer;
	position: absolute;
	top: 50%;
	width: auto;
	padding: 16px;
	margin-top: -22px;
	color: #CCA63D;
	font-weight: bold;
	font-size: 18px;
	transition: 0.6s ease;
	border-radius: 0 3px 3px 0;
}

/* Position the "next button" to the right */
.next {
	right: 0;
	border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

/* Caption text */
.text {
	color: #f2f2f2;
	font-size: 15px;
	padding: 8px 12px;
	position: absolute;
	bottom: 8px;
	width: 100%;
	text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
	color: #CCA63D;
	font-size: 12px;
	padding: 8px 12px;
	position: absolute;
	top: 0;
}

/* The dots/bullets/indicators */
.dot {
	cursor: pointer;
	height: 15px;
	width: 15px;
	margin: 0 2px;
	background-color: #bbb;
	border-radius: 50%;
	display: inline-block;
	transition: background-color 0.6s ease;
}

.active, .dot:hover {
	background-color: #717171;
}

/* Fading animation */
.fade {
	-webkit-animation-name: fade;
	-webkit-animation-duration: 1.5s;
	animation-name: fade;
	animation-duration: 1.5s;
}

@
-webkit-keyframes fade {
	from {opacity: .4
}

to {
	opacity: 1
}

}
@
keyframes fade {
	from {opacity: .4
}

to {
	opacity: 1
}

}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
	.prev, .next, .text {
		font-size: 11px
	}
}
</style>
<style type="text/css">
bbbody {
	margin: 0;
	height: 100%;
	overflow-y: auto
}

.preView {
	height: 100%
}

.pageArea {
	margin: 0 auto;
	padding-right: 180px;
	position: relative;
}

.clickArea img {
	vertical-align: middle;
}

.pageHead {
	background:
		url("http://image.bandinlunis.com/images/detail/preView_topBg1.gif")
		center bottom no-repeat;
	height: 20px;
	padding-top: 15px;
}

.pageHead .headText {
	float: left;
	padding-left: 5px;
}

.pageView {
	padding-bottom: 18px;
	position: relative;
	background:
		url("http://image.bandinlunis.com/images/detail/preView_bottomBg1.gif")
		center bottom no-repeat;
}

.btn_prevPage {
	position: absolute;
	cursor: pointer;
	top: 45%;
	left: -6px;
	width: 30px;
	z-index: 1;
}

.btn_nextPage {
	position: absolute;
	cursor: pointer;
	top: 45%;
	right: -6px;
	width: 30px;
	z-index: 1;
}

.pageWrap {
	margin: auto;
	overflow: auto;
	z-index: 17;
}

.pageWrap img {
	
}

.pageImage {
	border: 1px solid #c4c4c4;
	overflow: hidden;
	background: url(/images/common/logo.gif) no-repeat 17% 42%;
}

.pageView .pageA {
	float: left;
	margin: 0;
	overflow: hidden;
	padding: 10px;
}

.pageView .pageB {
	border-left: 1px solid #c4c4c4;
	float: right;
	margin: 0;
	overflow: hidden;
	padding: 10px;
}

.preView .size1 {
	width: 845px
}

.preView .size1 .bsize {
	width: 400px;
	_height: 600px
}

.preView .size1 .bsize img {
	width: 400px;
}

.preView .size2 {
	width: 1045px
}

.preView .size2 .bsize {
	width: 500px;
	_height: 700px;
}

.preView .size2 .bsize img {
	width: 500px;
}

.preView .size3 {
	width: 1245px
}

.preView .size3 .bsize {
	width: 600px;
	_height: 800px;
}

.preView .size3 .bsize img {
	width: 600px;
}

.preView .size4 {
	width: 1445px
}

.preView .size4 .bsize {
	width: 700px;
	_height: 900px;
}

.preView .size4 .bsize img {
	width: 700px;
}

.naviOn {
	background:
		url("http://image.bandinlunis.com/images/detail/preView_rightBg1.gif")
		repeat-y scroll right top transparent;
	position: fixed;
	height: 100%;
	right: 0;
	top: 0;
	width: 219px;
	z-index: 100
}

* html .naviOn {
	position: absolute
}

.naviOnBottom {
	position: fixed;
	height: 100%;
	right: 0;
	top: 93%;
	width: 185px;
	z-index: 100
}

* html .naviOnBottom {
	position: absolute
}

.naviTitle {
	background:
		url("http://image.bandinlunis.com/images/detail/preview_rightTopBg1.gif")
		repeat-y scroll right top transparent;
	padding-left: 15px;
	height: 46px;
	width: 204px;
	float: left;
}

.previewTit {
	padding-top: 13px;
	padding-left: 20px;
}

.btnGo {
	s float: left;
	padding: 1px 0 0 10px;
}

.btnGo a {
	display: block;
	width: 27px;
	height: 19px;
	background:
		url("http://image.bandinlunis.com/images/detail/btn_preGo1.gif")
		no-repeat;
}

.btnGo a span {
	display: none
}

.naviOff {
	float: right;
	padding: 0;
	height: 100%;
	right: 0;
	top: 0;
	width: 19px;
	position: absolute;
}

.naviOff .btn_Open {
	cursor: pointer;
	background:
		url("http://image.bandinlunis.com/images/detail/btn_preOpen1.png")
		no-repeat;
	display: block;
	float: left;
	margin: 0;
	width: 19px;
	height: 48px;
}

.btn_Close {
	display: block;
	float: left;
	margin: -46px 0px 0 0;
	width: 21px;
	z-index: 1;
}

.btn_Close img {
	cursor: pointer;
}

.conTit {
	position: relative;
	float: left;
	text-decoration: none;
	color: #fff;
	font-family: 굴림;
}

.conTit .title {
	font-size: 16px;
	font-weight: bold;
	line-height: 120%;
}

.conTit .titleS {
	font-size: 12px;
	line-height: 120%;
}

.conTit .titleS2 {
	padding-top: 15px;
	font-size: 11px;
	line-height: 100%;
}

.naviCon {
	float: left;
	position: relative;
	margin: 11px 0 0 11px;
	width: 100px;
}

.pageCon {
	float: left;
	position: relative;
}

.pageCon .inputNum {
	float: left;
	padding-bottom: 0px;
}

.pageCon .inputNum .Num1 {
	float: left;
}

.pageCon .inputNum .Num1 input {
	width: 20px;
	height: 12px;
	padding: 3px 0 0 4px;
}

.pageCon .inputNum .Num1 span {
	color: #fff;
	padding-top: 1px
}

.pageNum {
	clear: both;
	font-size: 11px;
	width: 177px;
	padding-top: 5px;
	position: relative;
}

.pageNum a {
	display: block;
	float: left;
	margin: 2px 2px 0 0;
	width: 35px;
	height: 14px;
	background: #fff;
	border: 1px solid #000;
	text-align: center;
	text-decoration: none;
	color: #666
}

.pageNum a:hover {
	color: #22232b;
	border: 1px solid #22232b;
	font-weight: bolder;
}

.pageNum .on {
	border: 1px solid #1f2026;
	display: block;
	color: #ff6600;
	font-weight: bold;
}

.pageNum a span {
	float: left;
	width: 17px;
	display: block;
	text-align: center
}

.pageNum a span.alt {
	border-right: 1px solid #666
}

.pageZoom {
	clear: both;
	margin: 0;
	display: block;
	padding: 15px 0 15px 0;
	overflow: hidden;
	height: 100px;
}

.pageZoom img {
	cursor: pointer;
}

.pageZoom li {
	list-style-type: none;
	float: left;
	height: 37px;
}
/* .toolLine1 {clear: both; border-bottom:1px solid #6d707c; width:171px; border-top:1px solid #282930; width:171px;  margin:0 0 14px 0;}*/
.toolLine1 {
	background:
		url("http://image.bandinlunis.com/images/detail/preview_preLine1.gif")
		no-repeat;
	clear: both;
	width: 171px;
	height: 2px;
	margin: 0 0 14px 0;
}

.titBox {
	position: relative;
	float: left;
	padding: 0 0 30px 0;
}

.btnA a {
	display: block;
	float: left;
	width: 86px;
	height: 36px;
}

.btnA a span {
	display: none
}

.btnA a.bookCart {
	background:
		url("http://image.bandinlunis.com/images/detail/btn_preBookCart1.gif")
		no-repeat;
}

.btnA a:hover.bookCart {
	background:
		url("http://image.bandinlunis.com/images/detail/btn_preBookCart1_off.gif")
		no-repeat;
}

.btnA a.wishList {
	background:
		url("http://image.bandinlunis.com/images/detail/btn_preWishList1.gif")
		no-repeat;
}

.btnA a:hover.wishList {
	background:
		url("http://image.bandinlunis.com/images/detail/btn_preWishList1_off.gif")
		no-repeat;
}

.btnA a.myLibrary {
	background:
		url("http://image.bandinlunis.com/images/detail/btn_premyLibrary1.gif")
		no-repeat;
}

.btnA a:hover.myLibrary {
	background:
		url("http://image.bandinlunis.com/images/detail/btn_premyLibrary1_off.gif")
		no-repeat;
}

.btnA a.bookInfo {
	background:
		url("http://image.bandinlunis.com/images/detail/btn_preInfo1.gif")
		no-repeat;
	margin-top: 0
}

.btnA a:hover.bookInfo {
	background:
		url("http://image.bandinlunis.com/images/detail/btn_preInfo1_off.gif")
		no-repeat;
}
</style>
<script type="text/javascript">
	//북카트
	function addCart(isbn) {

		var ordCnt = 1;

		$(function() {

			var cookieValue = JSON.stringify({
				"isbn" : isbn,
				"orderCount" : ordCnt
			});
			var ck = $("#cart_isbn" + isbn).val();

			if (document.cookie.indexOf('shop') == -1) {
				setCookie('shop', cookieValue, 1);
			} else if (document.cookie.indexOf('shop') != -1) {
				addCookie(cookieValue, ck);
			}
		});

		//기존 쿠키에 추가
		function addCookie(cValue, cVal) {
			var items = getCookie('shop');
			//var maxItemNum = 10;
			var flag = true;

			if (items) {
				var itemArray = items.split('/');
				var ck = new Array();

				for (i = 0; i < itemArray.length; i++) {
					ck[i] = JSON.parse(itemArray[i]);
				}
				for (i = 0; i < ck.length; i++) {

					if (ck[i].isbn == cVal) {

						alert("이미 있는 상품입니다.");
						return;

					} else {
						flag = false;
					}
				}
				if (flag == false) {
					itemArray.unshift(cValue);
					/*						if(itemArray.length>maxItemNum){
					 itemArray.length=10;}*/
					items = itemArray.join('/');
					setCookie('shop', items, 1);

					if (confirm("쇼핑카트에 등록되었습니다. 지금 바로 확인 하시겠습니까?")) {
						location.href = 'shopCartList.action';
					} else {
						return;
					}
				}
			}
		}

		//쿠키 생성
		function setCookie(cName, cValue, cDay) {
			var expire = new Date();
			expire.setDate(expire.getDate() + cDay);
			cookies = cName + '=' + escape(cValue) + '; path=/ ';
			if (typeof cDay != 'undefined')
				cookies += ';expires=' + expire.toGMTString() + ';';
			document.cookie = cookies;
		}

		function getCookie(cookiename) {
			var cookiestring = document.cookie;
			var cookiearray = cookiestring.split(';');
			for (var i = 0; i < cookiearray.length; ++i) {
				if (cookiearray[i].indexOf(cookiename) != -1) {
					var ck = [];
					var nameVal = cookiearray[i].split("=");
					var value = nameVal[1].trim();
					ck += value;
				}
			}
			return unescape(ck);
		}

	}
</script>
<!-- ZoomIn ZoomOut 시작-->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src='/springwebview/resources/js/ex01/jquery.zoom.js'></script>
<script src='/springwebview/resources/js/ex01/jquery.Wheelzoom.js'></script>

<script type="text/javascript">
	$(document).ready(function() {

		$('#ex1').zoom({
			on : 'click'
		});
		$('#ex2').zoom({
			on : 'click'
		});
		$('#ex3').zoom({
			on : 'click'
		});
		$('#ex4').zoom({
			on : 'click'
		});
		$('#ex5').zoom({
			on : 'click'
		});
		$('#ex6').zoom({
			on : 'click'
		});
		$('#ex7').zoom({
			on : 'click'
		});
		$('#ex8').zoom({
			on : 'click'
		});
		$('#ex9').zoom({
			on : 'click'
		});
		$('#ex10').zoom({
			on : 'click'
		});
		$('#ex11').zoom({
			on : 'click'
		});
		$('#ex12').zoom({
			on : 'click'
		});
		$('#ex13').zoom({
			on : 'click'
		});
		$('#ex15').zoom({
			on : 'click'
		});
		$('#ex16').zoom({
			on : 'click'
		});
		$('#ex17').zoom({
			on : 'click'
		});
		$('#ex18').zoom({
			on : 'click'
		});
		$('#ex19').zoom({
			on : 'click'
		});
		$('#ex20').zoom({
			on : 'click'
		});

	});
</script>



<!-- Zoomin Zoomout 끝 -->


</head>
<body>






	<div class="slideshow-container">
		<c:forEach var="dto" items="${lists }">
			<div class="mySlides fade" id="ex${dto.rnum }" align="center">
				<img alt="${dto.bookImage }" style="height: 700px;"
					src="<%=cp %>/resources/book_image/sample/${dto.bookImage}">
			</div>



		</c:forEach>



		<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a class="next"
			onclick="plusSlides(1)">&#10095;</a>
		<c:forEach var="dto3" items="lists">

		</c:forEach>
	</div>
	<br>



	<script>
		var slideIndex = 1;
		showSlides(slideIndex);

		function plusSlides(n) {
			showSlides(slideIndex += n);
		}

		function currentSlide(n) {
			showSlides(slideIndex = n);
		}

		function showSlides(n) {
			var i;
			var slides = document.getElementsByClassName("mySlides");
			var dots = document.getElementsByClassName("dot");
			if (n > slides.length) {
				slideIndex = 1
			}
			if (n < 1) {
				slideIndex = slides.length
			}
			for (i = 0; i < slides.length; i++) {
				slides[i].style.display = "none";
			}
			for (i = 0; i < dots.length; i++) {
				dots[i].className = dots[i].className.replace(" active", "");
			}
			slides[slideIndex - 1].style.display = "block";
			dots[slideIndex - 1].className += " active";
		}
	</script>





	<!-- 왼쪽 템플릿 -->
	<div id="mySidebar" class="sidebar">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
		<div class="naviCon">
			<div class="pageCon">
				<div class="pageSetting">
					<div class="inputNum"></div>
					<div class="pageNum"></div>
				</div>

				<p class="toolLine1"></p>
				<div class="titBox">
					<div class="conTit">
						<div class="title">${dto2.bookTitle }</div>
						<div class="titleS2 t_11">${dto2.authorName }저<br /> <br />
							${dto2.publisher } <br /> <br /> ${dto2.publishDate }
						</div>
					</div>
				</div>
				<div class="btnA">

					<a class="bookCart" href="javascript:addCart('${dto2.isbn }');">
						<span>쇼핑카트</span>
					</a>

					<!-- 판매중지, 품절, 절판 -->

					<a class="bookInfo" target="_blank"
						href="<%=cp %>/book_info.action?isbn=${dto2.isbn }"> <span>상세정보</span>
					</a>
				</div>

			</div>
		</div>
	</div>


	<div id="main">
		<button class="openbtn" onclick="openNav()">☰ 네비게이션</button>

	</div>

	<script>
		function openNav() {
			document.getElementById("mySidebar").style.width = "230px";
			document.getElementById("main").style.marginLeft = "230px";
		}

		function closeNav() {
			document.getElementById("mySidebar").style.width = "0";
			document.getElementById("main").style.marginLeft = "0";
		}
	</script>

</body>
</html>