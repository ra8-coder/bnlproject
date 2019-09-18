<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인_소설 도서부분</title>
<style type="text/css">
.prod_info .txt_desc .review_point {
	display: block;
	overflow: hidden;
	float: left;
	width: 79px;
	height: 14px;
	margin-right: 7px;
	background:
		url(/webproject/resources/images/searchN/sp_review_point.gif) 0 0
		no-repeat
}

.prod_info .txt_desc .review_point span {
	float: left;
	height: 14px;
	background:
		url(/webproject/resources/images/searchN/sp_review_point.gif) 0 -18px
		no-repeat
}
</style>
<!-- 베스트셀러 css -->

<link rel="stylesheet"
	href="/webproject/resources/common/css/bnlBSList2.css" type="text/css">

<link rel="stylesheet" href="/webproject/resources/book_css/class.css"
	type="text/css">

<link rel="stylesheet" href="/webproject/resources/book_css/common.css"
	type="text/css">

<link rel="stylesheet"
	href="/webproject/resources/book_css/detail_default.css"
	type="text/css">

<link rel="stylesheet" href="/webproject/resources/book_css/pStyle.css"
	type="text/css">

<link rel="stylesheet"
	href="/webproject/resources/book_css/review_class.css" type="text/css">

<script type="text/javascript"
	src="/springwebview/resources/js/Main_01.js"></script>

<link rel="stylesheet"
	href="/webproject/resources/book_css/detail_default.css"
	type="text/css">

<link rel="stylesheet" href="/webproject/resources/book_css/pStyle.css"
	type="text/css">

<script type="text/javascript"
	src="/webproject/resources/common/js/common.js"></script>

<script type="text/javascript"
	src="/webproject/resources/common/js/swfobject.js"></script>
<script type="text/javascript"
	src="/webproject/resources/common/js/flashcommon.js"></script>
<script type="text/javascript"
	src="/webproject/resources/common/js/AC_RunActiveContent.js"></script>

<script type="text/javascript" src="/webproject/resources/js/common.js"
	charset="euc-kr"></script>
<script type="text/javascript"
	src="/webproject/resources/js/JUTIL/JUTIL.js" charset="utf-8"></script>
<script type="text/javascript" src="/webproject/resources/js/navi.js"
	charset="euc-kr"></script>
<script type="text/javascript"
	src="/webproject/resources/js/partnerHeaderInfo.js"></script>

<script type="text/javascript"
	src="/webproject/resources/js/jquery/jquery.min.js"></script>
<script type="text/javascript"
	src="/webproject/resources/js/jquery/jquery-ui.js"></script>
<script type="text/javascript"
	src="/webproject/resources/js/jquery/jquery.blockUI.js"></script>
<script type="text/javascript"
	src="/webproject/resources/js/jquery/idangerous.swiper.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://wcs.naver.net/wcslog.js"></script>

<!-- ADSSOM 신규 버전 17-11-20 -->
<!-- ADSSOM 공통 SCRIPT -->
<script type="text/javascript" src="https://sc.11h11m.net/s/E799.js"></script>
<script type="text/javascript" charset="UTF-8" async=""
	src="http://s.n2s.co.kr/_n2s_ck_log.php"></script>

<script type="text/javascript" src="/webproject/resources/js/dwr.js"
	charset="euc-kr"></script>
<script type="text/javascript"
	src="/webproject/resources/js/jquery/jquery.min.js"></script>
<!-- IE8 에서 오류로 인해 일부러 넣음(jQuery 보다 dwr.util.js 가 밑에 있음 오류 발생) -->
<script type="text/javascript"
	src="/webproject/resources/js/multiCart.js"></script>

<script type="text/javascript"
	src="/springwebview/resources/js/Main_01.js"></script>
<script type="text/javascript"
	src="/springwebview/resources/js/JUTIL/JUTIL.js"></script>
<script type="text/javascript"
	src="/springwebview/resources/js/jquery/jquery.min.js"></script>
<script type="text/javascript"
	src="/springwebview/resources/js/swfobject.js"></script>
<script type="text/javascript">
	function toggleDisplay(num) {
		var con = document.getElementById("layer" + num);
		if (con.style.display == 'none') {
			con.style.display = 'block';
		} else {
			con.style.display = 'none';
		}
	}

	function toggleDisplay2(num) {
		var con = document.getElementById("left_layer" + num);
		if (con.style.display == 'none') {
			con.style.display = 'block';
		} else {
			con.style.display = 'none';
		}
	}

	function toggleDisplay3(num) {
		var con = document.getElementById("left2_layer" + num);
		if (con.style.display == 'none') {
			con.style.display = 'block';
		} else {
			con.style.display = 'none';
		}
	}
</script>
<!-- Carousel BS -->
<!-- Tabs with Dropdown Menu-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script type="text/javascript">
	function popPreview(isbn) {

		if (typeof (isbn) == "undefined" || isbn == "") {
			return;
		}

		window.open("/webproject/book_preview.action?isbn=" + isbn, "preview",
				"width=" + screen.availWidth + ",height=" + screen.availHeight
						+ ",resizable=yes,scrollbars=yes");
	}
</script>

<!-- 메뉴 드롭 다운 -->
<script>
	/* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
	var dropdown = document.getElementsByClassName("dropdown-btn");
	var i;

	for (i = 0; i < dropdown.length; i++) {
		dropdown[i].addEventListener("click", function() {
			this.classList.toggle("active");
			var dropdownContent = this.nextElementSibling;
			if (dropdownContent.style.display === "block") {
				dropdownContent.style.display = "none";
			} else {
				dropdownContent.style.display = "block";
			}
		});
	}
</script>

<!-- 수량 jQuery -->
<script type="text/javascript">
	function modifyProductQuantity(id, quantity) {

		if (isNaN($("#" + id).val())) {
			alert('숫자만 입력가능 합니다.');
			$("#" + id).focus();
			$("#" + id).val(0);
			return;
		}

		//var v = parseFloat($("#"+id).val())+parseFloat(quantity);    
		//$("#"+id).val(Math.round(v*10)/10);

		var q = parseInt($("#" + id).val()) + parseInt(quantity);
		if (q < 0) {
			$("#" + id).val() = 0;
		}
		$("#" + id).val(q);

	};
</script>

<style>
* {
	box-sizing: inherit;
}

/* Style the tab */
.tab {
	float: left;
	border: none;
	width: 100%;
	height: 100px;
	justify-content: space-around;
}

.tablinks {
	float: left;
	width: 25%;
	border: none;
}

/* Style the buttons inside the tab */
.tab button {
	display: block;
	background-color: inherit;
	color: black;
	padding: 22px 10px;
	width: 100%;
	border: none;
	outline: none;
	text-align: left;
	cursor: pointer;
	font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
	
}

/* Create an active/current "tab button" class */
.tab button.active {
	
}

/* Style the tab content */
.tabcontent {
	float: none;
	padding: 10px 10px;
	border: none;
	width: 100%;
	height: 200px;
	display: none;
	border-top: none;
}

/* Clear floats after the tab */
.clearfix::after {
	content: "";
	clear: both;
	display: table;
}
</style>



</head>
<body>


	<jsp:include page="../../../common/header.jsp" flush="false" />

	<div id="contentBody" style="width: 1100px;">


		<div class="side_t2 ml5">

			<div class="cate_comm">


				<h2 class="cate_tit">${dto_Main.categoryName }</h2>

				<ul class="cate_d1">

					<!-- 중분류 -->

					<c:set var="i" value="0" />

					<c:forEach var="list" items="${lists }">


						<li id="kidsCate_821" class="cate_d1_li "><a
							href="/webproject/book_cate.action?categoryId=${list.categoryId }"
							class="cate_d1_link"
							onmouseover="javascript:toggleDisplay3(${i})"
							onmouseout="javascript:toggleDisplay3(${i })">

								${list.categoryName }</a> <!-- 소분류 --> <c:choose>

								<c:when test="${empty list.lastNode }">


								</c:when>

								<c:otherwise>

									<div class="cate_d2" id="left2_layer${i }"
										onmouseover="javascript:toggleDisplay3(${i })"
										onmouseout="javascript:toggleDisplay3(${i })"
										style="display: none;">


										<div class="pos_rel">

											<div class="ico_arrow"></div>

											<ul>


												<c:forEach var="list2" items="${list.lastNode }">

													<li class="cate_d2_link "><a
														href="/webproject/book_cate.action?categoryId=${list2.categoryId }">${list2.categoryName}

													</a></li>

												</c:forEach>


											</ul>

										</div>


									</div>

								</c:otherwise>

							</c:choose></li>

						<c:set var="i" value="${i+1 }" />

					</c:forEach>


				</ul>


				<div class="cate_left_banner mt7">
					<a href="/webproject/genre_fiction.action"><img
						src="http://image.bandinlunis.com/upload/banner/20150731/banner20150731162405.jpg"></a>
				</div>


			</div>


			<!-- left banner -->


			<!-- 브랜드 -->


			<!-- 추천인사이드:회원님이 주로 구입하시는 가격대의 인기 상품입니다 -->


		</div>






		<!-- 가운데 레이아웃 -->

		<div class="con_t2" style="width: 850px;">

			<div class="container" style="width: 850px;">
				<!-- 		<div class="tap_menu_d2 mb15"> -->
				<ul class="nav nav-tabs">
					<li><a href="#home">전체목록</a></li>

					<li><a href="#menu_best">베스트셀러</a></li>

					<li><a href="#menu_new">새로나온 책</a></li>

					<li><a href="#menu_discount">정가인하</a></li>
				</ul>


				<!-- 줄 생성 -->

				<!-- 탭 메뉴 -->

				<div class="tab-content" style="width: 800px;">

					<!-- 					<div id="home" class="tab-pane fade in active"> -->
					<div id="home" class="tab-pane fade in active">
						<div class="cateM pos_rel">
							<div class="cate_main_bn">

								<div class="container" style="width: 100%">

									<div id="myCarousel" class="carousel slide"
										data-ride="carousel">
										<!-- Indicators -->
										<ol class="carousel-indicators">
											<li data-target="#myCarousel" data-slide-to="0"
												class="active"></li>
											<li data-target="#myCarousel" data-slide-to="1"></li>
											<li data-target="#myCarousel" data-slide-to="2"></li>
											<li data-target="#myCarousel" data-slide-to="3"></li>
										</ol>

										<!-- Wrapper for slides -->
										<div class="carousel-inner">
											<div class="item active">
												<img
													src="http://image.bandinlunis.com/upload/banner/20180928/banner20180928182256.jpg"
													alt="Image1" style="width: 100%;">
											</div>

											<div class="item">
												<img
													src="http://image.bandinlunis.com/upload/banner/20180827/banner20180827153634.jpg"
													alt="Image2" style="width: 100%;">
											</div>

											<div class="item">
												<img
													src="http://image.bandinlunis.com/upload/banner/20180903/banner20180903180323.jpg"
													alt="Image3" style="width: 100%;">
											</div>

											<div class="item">
												<img
													src="http://image.bandinlunis.com/upload/banner/20180906/banner20180906182627.jpg"
													alt="Image4" style="width: 100%;">
											</div>

										</div>

										<!-- Left and right controls -->

									</div>
								</div>
							</div>
							<!-- 카테고리 메인배너 -->


							<br /> <br />

							<!-- 반디 추천책 -->
							<h4
								style="width: 532px; height: 35px; padding: 0 0 0 5px; border-bottom: 1px solid #e1e1e1; font: '돋움' 16px; color: #000; letter-spacing: -0.05em">반디앤루니스
								추천책</h4>
							<hr>

							<div class="tab" style="border-bottom: 5px solid white;">
								<div class="tablinks" onmouseover="openCity(event, 'book_1')"
									style="background-color: white;">
									<a href="/webproject/book_info.action?isbn=9791188047475">
										<img
										src="http://image.bandinlunis.com/upload/product/4189/4189934.jpg"
										style="cursor: pointer; width: 45%; height: 45%;">
									</a>
								</div>
								<div class="tablinks" onmouseover="openCity(event, 'book_2')"
									style="background-color: white;">
									<a href="/webproject/book_info.action?isbn=9791157746088">
										<img
										src="http://image.bandinlunis.com/upload/product/4188/4188573.jpg"
										style="cursor: pointer; width: 45%; height: 45%;">


									</a>
								</div>
								<div class="tablinks" onmouseover="openCity(event, 'book_3')"
									style="background-color: white;">
									<a href="/webproject/book_info.action?isbn=9791186686348">
										<img
										src="http://image.bandinlunis.com/upload/product/4189/4189269.jpg"
										style="cursor: pointer; width: 45%; height: 45%;">
									</a>
								</div>

								<div class="tablinks" onmouseover="openCity(event, 'book_4')"
									style="background-color: white;">
									<a href="/webproject/book_info.action?isbn=9788965746614">
										<img
										src="http://image.bandinlunis.com/upload/product/4187/4187725.jpg"
										style="cursor: pointer; width: 45%; height: 45%;">
									</a>
								</div>
							</div>
							<br /> <br />
							<div style="height: 60px;"></div>

							<div id="book_1" class="tabcontent">
								<dl style="padding-top: 10px">
									<dt class="pImg145" style="float: left; margin-right: 20px;">
										<a href="/webproject/book_info.action?isbn=9791188047475">
											<img
											src="http://image.bandinlunis.com/upload/product/4189/4189934.jpg"
											style="float: left;">
										</a>
									</dt>
									<br />
									<dd class="booktit">
										<a href="/webproject/book_info.action?isbn=9791188047475">숨은
											골짜기의 단풍나무 한 그루 </a>

									</dd>
									<dd class="writer">윤영수 | 열림원</dd>
									<br />
									<dd class="bex">한국일보문학상, 남촌문학상, 만해문학상 수상작가 윤영수가 펼쳐 보이는
										독자적인 한국 판타지『단풍나무』는 우리 문학계에 기록될 하나의 사건이다!범상치 않은 작가의식과 성실성으로 문학의
										본령을 지켜온 작가 윤영수, 불혹의 나이에 등단한 윤영수는 도시의 사람살이를 폭넓게 탐사하며 소통이 단절된
										인간소외의 풍경과 자본주의라는 연옥에 던져진 우리네...</dd>
								</dl>
							</div>

							<div id="book_2" class="tabcontent">
								<dl>
									<dt class="pImg145" style="float: left; margin-right: 20px;">
										<a href="/webproject/book_info.action?isbn=9791157746088">
											<img
											src="http://image.bandinlunis.com/upload/product/4188/4188573.jpg"
											style="float: left;">

										</a>
									</dt>
									<br />
									<dd class="booktit">
										<a href="/webproject/book_info.action?isbn=9791157746088">네버무어
											1 </a>
									</dd>
									<dd class="writer">제시카 타운센드 | 디오네</dd>
									<br />
									<dd class="bex">이 책은출간 직후 세계 39개국과 계약을 맺은 화제작!호주 인디북 어워드
										2관왕, 시카고 트리뷴 올해 최우수 도서, 북셀러 올해의 책, 타임지 올해 최우수 도서, 뉴욕타임스 베스트셀러,
										아마존 올해 최우수 도서, 호주 출판 산업상 3관왕, 인디바운드 베스트셀러, 호주 닐슨북스캔
										베스트셀러…『네버무어』는 등장하자마자 세계 출판계의 비상한 관...</dd>
								</dl>

							</div>

							<div id="book_3" class="tabcontent">
								<dl>
									<dt class="pImg145" style="float: left; margin-right: 20px;">
										<a href="/webproject/book_info.action?isbn=9791186686348">
											<img
											src="http://image.bandinlunis.com/upload/product/4189/4189269.jpg"
											style="float: left;">

										</a>
									</dt>
									<br />
									<dd class="booktit">
										<a href="/webproject/book_info.action?isbn=9791186686348">인생
											우화</a>
									</dd>
									<dd class="writer">류시화 | 연금술사</dd>
									<br />
									<dd class="bex">천사의 실수로세상의 바보들이 한 마을에 모여 살게 되었다 우화는 두 천사
										이야기로 시작된다. 인간 세상을 내려다보며 지혜로운 자는 줄고 어리석은 자가 나날이 늘어나는 것이 걱정된 신은
										두 천사를 불렀다. 그중 한 천사에게 지상에 내려가 지혜로운 영혼들을 모두 모아 마을과 도시들에 고루
										떨어뜨리라고 말했다. 두 번째 천사에게는 지상에 있는 ...</dd>
								</dl>
							</div>
							<div id="book_4" class="tabcontent">
								<dl>
									<dt class="pImg145" style="float: left; margin-right: 20px;">
										<a href="/webproject/book_info.action?isbn=9788965746614">
											<img
											src="http://image.bandinlunis.com/upload/product/4187/4187725.jpg"
											style="float: left;">
										</a>
									</dt>
									<br />
									<dd class="booktit">
										<a href="/webproject/book_info.action?isbn=9788965746614">해리
											1</a>
									</dd>
									<dd class="writer">공지영 | 해냄</dd>
									<br />
									<dd class="bex">단 한 사람도 동의하지 않았지만그 누구도 부정하지 않았다작가 공지영, 5년
										만의 신작 장편소설 야만의 현장을 날것으로 보는 것처럼 그 순간 숨이 막혀왔다안개의 도시 무진, 그곳이거나
										그곳이 아닌 곳에서지금도 여전히 유효한 욕망과 부정의 거미줄끈질긴 취재와 집필로 일궈낸 1천만 독자의 감동!등단
										30년, 공지영 작가의 열두 번째 장편소설 『...</dd>
								</dl>
							</div>

							<div class="clearfix"></div>

						</div>

						<div class="cateS" style="margin-left: 20px; margin-top: 8px;">

							<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
							<!-- 분야 주간 베스트 -->
							<div class="cateBest">
								<h4>분야 주간 베스트</h4>

								<ul>

									<li class="bestTop">
										<dl>
											<dt>
												<span class="rank no1" style="height: 15px;">1</span>

											</dt>

											<dd class="pImg52 imgP">
												<a href="/webproject/book_info.action?isbn=9788998274795">

													<img
													src="http://image.bandinlunis.com/upload/product/4034/4034224_s.jpg"
													onerror="this.src='/images/common/noimg_type04.gif';">
												</a>
											</dd>
											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9788998274795">돌이킬
													수 없는 약속</a>
											</dd>
											<dd class="writer">야쿠마루 가쿠</dd>



										</dl>
									</li>

									<li>
										<dl>
											<dt>
												<span class="rank no2" style="height: 15px;">2</span>
											</dt>


											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9791186686348">인생
													우화</a>
											</dd>
											<dd class="writer">류시화</dd>


										</dl>
									</li>

									<li>
										<dl>
											<dt>
												<span class="rank no3" style="height: 15px;">3</span>
											</dt>


											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9791162207550">곁에
													남아 있는 사람</a>
											</dd>
											<dd class="writer">임경선</dd>


										</dl>
									</li>

									<li>
										<dl>
											<dt>
												<span class="rank no4" style="height: 15px;">4</span>
											</dt>


											<dd class="booktit">82년생 김지영</dd>
											<dd class="writer">조남주</dd>


										</dl>
									</li>

									<li>
										<dl>
											<dt>
												<span class="rank no5" style="height: 15px;">5</span>
											</dt>


											<dd class="booktit">고양이 2</dd>
											<dd class="writer">베르나르 베르베르</dd>


										</dl>
									</li>

								</ul>



							</div>
						</div>


						<script>
							function openCity(evt, cityName) {
								var i, tabcontent, tablinks;
								tabcontent = document
										.getElementsByClassName("tabcontent");
								for (i = 0; i < tabcontent.length; i++) {
									tabcontent[i].style.display = "none";
								}
								tablinks = document
										.getElementsByClassName("tablinks");
								for (i = 0; i < tablinks.length; i++) {
									tablinks[i].className = tablinks[i].className
											.replace(" active", "");
								}
								document.getElementById(cityName).style.display = "block";
								evt.currentTarget.className += " active";
							}
						</script>




						<!-- 추천인사이드 -->


						<!-- 주목할만한 새로나온 책 -->

						<div id="sortableArea" class="fl_clear ml5"
							style="overflow: hidden">

							<!-- 주목할만한 새로나온책 -->
							<div class="temClassA temType2" id="dp_050">

								<h4>주목할만한 새로나온 책</h4>
								<div id="cateNewArea">


									<ul>

										<li class="po1">
											<dl>
												<dt class="pImg90">
													<img
														src="http://image.bandinlunis.com/upload/product/4200/4200746.jpg"
														onerror="this.src='/images/common/noimg_type01.gif';">
												</dt>

												<dd class="booktit">반짝반짝 공화국</dd>
												<dd class="writer">
													오가와 이토<span class="public"> | 위즈덤하우스</span>
												</dd>
												<dd class="price">12,600원</dd>
												<dd class="sPoint">(10%↓+5%P)</dd>


												<dd class="bex">전하고 싶었던 마음, 듣고 싶었던 말…‘츠바키 문구점’이 다시 한 번
													당신의 마음을 배달합니다. 아름다운 손편지로 누군가의 간절한 마음을 대신 전해주는 가슴 뭉클한 기적으로
													많은 ...</dd>
											</dl>
										</li>



										<li class="po1">
											<dl>
												<dt class="pImg90">
													<img
														src="http://image.bandinlunis.com/upload/product/4201/4201643.jpg"
														onerror="this.src='/images/common/noimg_type01.gif';">
												</dt>

												<dd class="booktit">불안</dd>
												<dd class="writer">
													O. Z. 리반엘리<span class="public"> | 가쎄</span>
												</dd>
												<dd class="price">12,420원</dd>
												<dd class="sPoint">(10%↓+5%P)</dd>


												<dd class="bex">2017년 출간돼 단기간 40만 부가 읽힌 베스트셀러40개국에 소개된
													터키 유명 작가 리반엘리의 신작리반엘리의 소설 『불안(Huzursuzluk)』은 단기간에 40만 부가
													팔려나가...</dd>
											</dl>
										</li>

									</ul>

								</div>
							</div>


							<div class="temClassA temType2" id="dp_006">

								<h4>
									MD추천 도서 - GOOD BOOK! <span></span>
								</h4>

								<ul>
									<li class="po1">
										<dl>
											<dt class="pImg90 imgP">
												<a href="/webproject/book_info.action?isbn=9791189015213">
													<img
													src="http://image.bandinlunis.com/upload/product/4190/4190269.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


												</a>
											</dt>

											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9791189015213">여자에게
													어울리지 않는 직업</a>
											</dd>
											<dd class="writer">
												P. D. 제임스<span class="public"> | 아작</span>
											</dd>
											<dd class="rPrice">14,800원</dd>
											<dd class="price">13,320원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="bex">“겁먹을 게 뭐가 있어요? 그저 남자들이나 상대하게 될 텐데.”추리소설의
												여왕이 창조한 여자 탐정의 이상적 모델,미국 추리작가협회 최고 작품상 수상작!케임브리지 대학교를 중퇴한
												잘...</dd>
										</dl>
									</li>



									<li class="po1">
										<dl>
											<dt class="pImg90 imgP">
												<a href="/webproject/book_info.action?isbn=9791162206379">
													<img
													src="http://image.bandinlunis.com/upload/product/4189/4189241.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


												</a>
											</dt>

											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9791162206379">오만과
													편견</a>
											</dd>
											<dd class="writer">
												제인 오스틴<span class="public"> | 위즈덤하우스</span>
											</dd>
											<dd class="rPrice">13,000원</dd>
											<dd class="price">11,700원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="rStar s9">9.31</dd>

											<dd class="bex">섬세하고 감각적인 일러스트로 재탄생한 사실주의 로맨스 고전소설의
												걸작19세기 여성의 사랑과 결혼에 대한 이야기를 담은 『오만과 편견』은 결혼에 얽힌 인간의 세속적인 욕망과
												현실적인...</dd>
										</dl>
									</li>
								</ul>

								<ul>
									<li class="po1">
										<dl>
											<dt class="pImg90 imgP">
												<a href="/webproject/book_info.action?isbn=9791188502103">
													<img
													src="http://image.bandinlunis.com/upload/product/4189/4189222.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


												</a>
											</dt>

											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9791188502103">왕이
													나셨네</a>
											</dd>
											<dd class="writer">
												구광본<span class="public"> | 열림과울림</span>
											</dd>
											<dd class="rPrice">13,000원</dd>
											<dd class="price">11,700원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="bex">│‘다시 만나는 옛이야기’ 시리즈 소개│다 지나간 시대의 이야기를 단지
												다시 한다면 때늦은 이야기이다.그 이야기에 누구도 생각지 못한 새로움을 담아내었다면?한참이나 앞서가는
												놀라운...</dd>
										</dl>
									</li>



									<li class="po1">
										<dl>
											<dt class="pImg90 imgP">
												<a href="/webproject/book_info.action?isbn=9788998480936">
													<img
													src="http://image.bandinlunis.com/upload/product/4189/4189055.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


												</a>
											</dt>

											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9788998480936">빨주노초파람보</a>
											</dd>
											<dd class="writer">
												노엘라<span class="public"> | 시루</span>
											</dd>
											<dd class="rPrice">13,000원</dd>
											<dd class="price">11,700원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="rStar s9">9.0</dd>

											<dd class="bex">베스트셀러 《그림이 들리고 음악이 보이는 순간》 저자의 첫 소설. 소설
												출간과 동시에 영화화 확정 화제작!우리는 사랑 없이 살 수 있을까? 아니, 우리는 사랑만으로 살 수
												있을까?...</dd>
										</dl>
									</li>
								</ul>

								<ul>
									<li class="po1">
										<dl>
											<dt class="pImg90 imgP">
												<a href="/webproject/book_info.action?isbn=9791160271447">
													<img
													src="http://image.bandinlunis.com/upload/product/4188/4188892.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


												</a>
											</dt>

											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9791160271447">나비
													정원</a>
											</dd>
											<dd class="writer">
												닷 허치슨<span class="public"> | 소담</span>
											</dd>
											<dd class="rPrice">14,800원</dd>
											<dd class="price">13,320원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="rStar s9">9.44</dd>

											<dd class="bex">양들의 침묵, 키스 더 걸을 잇는 사이코패스 범죄 스릴러★ 아마존
												스릴러, 서스펜스 소설 베스트셀러 1위★ 2016년 굿리즈 초이스 어워드 베스트 호러 소설 부문 후보작★
												아마존 ...</dd>
										</dl>
									</li>



									<li class="po1">
										<dl>
											<dt class="pImg90 imgP">
												<a href="/webproject/book_info.action?isbn=9791159312472">
													<img
													src="http://image.bandinlunis.com/upload/product/4187/4187982.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


												</a>
											</dt>

											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9791159312472">타자기가
													들려주는 이야기</a>
											</dd>
											<dd class="writer">
												톰 행크스<span class="public"> | 책세상</span>
											</dd>
											<dd class="rPrice">16,000원</dd>
											<dd class="price">14,400원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="rStar s9">8.71</dd>

											<dd class="bex">톰 행크스 생애 첫 소설집오스카상을 수상한 세계적 배우, 작가로 다시
												태어나다‘타자기’에 영감을 받아 써 내려간 17편의 이야기향수 어린 아날로그적 감성, 유쾌하고 따뜻한
												시선으로...</dd>
										</dl>
									</li>
								</ul>

								<ul>
									<li class="po1">
										<dl>
											<dt class="pImg90 imgP">
												<a href="/webproject/book_info.action?isbn=9791187886297">
													<img
													src="http://image.bandinlunis.com/upload/product/4187/4187719.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


												</a>
											</dt>

											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9791187886297">수영하는
													여자들</a>
											</dd>
											<dd class="writer">
												리비 페이지<span class="public"> | 구픽</span>
											</dd>
											<dd class="rPrice">14,000원</dd>
											<dd class="price">12,600원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="rStar s10">10.0</dd>

											<dd class="bex">런던 도서전 화제작(전 세계 24개국 판권 계약), 영국 아마존·선데이
												타임스 베스트셀러 TOP 10, 영화화 예정작 2018 가디언 선정 주목할 만한 신인작가 리비 페이지의
												유쾌...</dd>
										</dl>
									</li>



									<li class="po1">
										<dl>
											<dt class="pImg90 imgP">
												<a href="/webproject/book_info.action?isbn=9791162336076">
													<img
													src="http://image.bandinlunis.com/upload/product/4187/4187616.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


												</a>
											</dt>

											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9791162336076">우리가
													살 뻔한 세상</a>
											</dd>
											<dd class="writer">
												엘란 마스타이<span class="public"> | 북폴리오</span>
											</dd>
											<dd class="rPrice">15,000원</dd>
											<dd class="price">13,500원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="rStar s9">8.7</dd>

											<dd class="bex">- 전 세계 26개국 번역 출간 - 파라마운트사 영화화 결정 우리가
												살았어야 할 그곳은 바로 상상 이상의 세상이었다 2016년, 지금과는 전혀 다른 새로운 유토피아 사회.
												1965...</dd>
										</dl>
									</li>
								</ul>

								<ul>
									<li class="po1">
										<dl>
											<dt class="pImg90 imgP">
												<a href="/webproject/book_info.action?isbn=9788954652087">
													<img
													src="http://image.bandinlunis.com/upload/product/4187/4187453.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


												</a>
											</dt>

											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9788954652087">솔라</a>
											</dd>
											<dd class="writer">
												이언 매큐언<span class="public"> | 문학동네</span>
											</dd>
											<dd class="rPrice">15,000원</dd>
											<dd class="price">13,500원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="rStar s8">8.0</dd>

											<dd class="bex">예술적으로 대담하고 무지막지하게 재미있다.이언 매큐언은 무서운 진실을
												우아하게 파헤친다.월스트리트 저널『솔라』는 작품마다 평단과 대중의 일관된 지지를 받으며 베스트셀러에 오르는
												현...</dd>
										</dl>
									</li>



									<li class="po1">
										<dl>
											<dt class="pImg90 imgP">
												<img
													src="http://image.bandinlunis.com/upload/product/4186/4186154.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


											</dt>

											<dd class="booktit">임파서블 포트리스</dd>
											<dd class="writer">
												제이슨 르쿨락<span class="public"> | 박하</span>
											</dd>
											<dd class="rPrice">14,500원</dd>
											<dd class="price">13,050원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="rStar s9">9.3</dd>

											<dd class="bex">“1980년대라는 풋풋하고 우스꽝스럽고, 무엇보다 근사했던 시대를 향한
												러브레터!”2017년 아마존에서 선정한 올해의 책이자 엔터테이먼트 위클리, 버슬, 인스타일닷컴 등 수많은
												매...</dd>
										</dl>
									</li>
								</ul>

							</div>

							<div class="cateInside" id="dp_029"></div>

							<script>
								$(function() {
									$(".nav-tabs a").click(function() {
										$(this).tab('show');
									});
								});
							</script>

							<!-- Dynamic Tabs 스크립트 -->


						</div>



					</div>
					<!-- 전체 목록 끝  -->

					<!-- 베스트셀러 시작 -->

					<div id="menu_best" class="tab-pane fade">
						<div class="prod_sort">

							<h4>
								<strong>${dto_Main.categoryName }</strong> 베스트셀러 목록입니다.
							</h4>

						</div>
						<div class="con_t2">

							<!-- EL / JSTL / Foreach  -->
							<c:forEach var="dto" items="${lists_Best }">

								<div class="prod_list_type prod_best_type">
									<ul>
										<li><input type="hidden" name="maxQuantity"
											id="maxQuantity" value="${dto.maxQuantity }" />
											<div class="prod_thumb">
												<span class="ranking"> <span class="rank_num">${dto.rnum }</span>
													<span class="rank_change"> <img
														src="http://image.bandinlunis.com/images/common/2014/ico_best_same.gif"
														alt="-"> <!-- 0 -->
												</span>
												</span>
												<div class="prod_thumb_img">
													<a href="<%=cp %>/book_info.action?isbn=${dto.isbn}"
														onfocus="this.blur();"> <img
														src="<%=cp %>/resources/image/book/${dto.bookImage }">
													</a> <a class="btn_popup" target="_blank"
														href="<%=cp %>/book_info.action?isbn=${dto.isbn}"><span
														class="ico_new">새창열기</span></a>
												</div>
												<a class="btn_preview" target="_blank"
													href="<%=cp %>/book_preview.action?isbn=${dto.isbn }">미리
													보기</a>
											</div>

											<dl class="prod_info">
												<dt>
													<a href="<%=cp %>/book_info.action?isbn=${dto.isbn}"
														onfocus="this.blur();"> ${dto.bookTitle } </a> <span
														class="tag_area"> <span class="tag_best"><span>베스트</span></span>
														<span class="tag_recom"><span>반디추천</span></span> <span
														class="tag_free"><span>무료배송</span></span>
													</span>
												</dt>
												<dd class="txt_block">
													<span>${dto.authorName }</span> <span class="gap">|</span>
													<span>${dto.publisher }</span> <span class="txt_date"><span
														class="gap">|</span> <span>${dto.publishDate }</span></span>
												</dd>
												<dd class="mt5">
													<p>
														<span class="txt_reprice">${dto.bookPrice }</span> <span
															class="txt_arrow">→</span> <span class="txt_price"><strong><em>${dto.discountedPrice }</em>원</strong>
															(${dto.discountRate }%↓+5%P)</span>
													</p>
												</dd>
												<dd class="txt_desc">
													<div class="review_point">
														<span style="width: ${dto.rate*10 }%;"></span>
													</div>
													<strong>${dto.rate }</strong> <a
														href="/front/product/detailProduct.do?isbn=4181047#sub10"
														target="_blank">리뷰<em>(${dto.reviewCnt })</em></a>
												</dd>
												<dd class="txt_bex">${dto.introduction }...</dd>
												<dd class="txt_ebook">
													<span>지금 주문하면 <strong class="t_red">3일</strong> 뒤에
														받을 수 있습니다.
													</span>
												</dd>
											</dl> <c:choose>
												<c:when test="${dto.maxQuantity ne 0}">
													<dl class="prod_btn">
														<dt style="width: 130px;">
															<input type="hidden" id="cart_isbn${dto.isbn }"
																value="${dto.isbn }"> <input type="hidden"
																name="isbn" id="isbn" value="" /> <input type="hidden"
																name="orderCount" id="orderCount" value="" /> 구입 가능 권수
															- <strong class="t_red">${dto.maxQuantity }</strong>권<span
																class="num_txt">수량</span> <input type="text"
																id="cntVal_${dto.isbn }" value="1" class="num" size="3"
																maxlength="2" onkeydown="onlyNumber();" onkeyup="">
															<span class="btn_updn_wrap"> <a
																href="javascript:cntUp('${dto.isbn }','${dto.maxQuantity }');"
																class="btn_num_up">▲</a> <a
																href="javascript:cntDown('${dto.isbn }','${dto.maxQuantity }');"
																class="btn_num_dn">▼</a>
															</span>
														</dt>

														<dd>
															<a href="javascript:addCart('${dto.isbn }');"><span
																class="btn_b_comm btype_f1">쇼핑카트</span></a>
														</dd>
														<dd class="mt3">
															<a href="javascript:goOrder('${dto.isbn }');"><span
																class="btn_w_comm btype_f1">바로구매</span></a>
														</dd>
													</dl>
												</c:when>

												<c:otherwise>
													<dl class="prod_btn">
														<dt>
															구입 가능 권수 - <strong class="t_red">${dto.maxQuantity }</strong>권<span
																class="num_txt">수량</span> <input type="text"
																id="cntVal_${dto.isbn }" value="0" class="num" size="3"
																maxlength="2" onkeydown="onlyNumber();" onkeyup=""
																readonly="readonly"> <span class="btn_updn_wrap">
																<a
																href="javascript:cntUp('${dto.isbn }','${dto.maxQuantity }');"
																class="btn_num_up">▲</a> <a
																href="javascript:cntDown('${dto.isbn }','${dto.maxQuantity }');"
																class="btn_num_dn">▼</a>
															</span>
														</dt>

														<dd>
															<a href=""><span class="btn_gy_comm btype_f1">상품문의하기</span></a>
														</dd>
														<%-- <dd class="mt3"><a href="javascript:goOrder('${dto.isbn }');"><span class="btn_w_comm btype_f1">바로구매</span></a></dd> --%>
													</dl>
												</c:otherwise>
											</c:choose></li>
									</ul>
								</div>
							</c:forEach>

						</div>
						<!-- con_t2 -->
					</div>
					<!-- 베스트셀러 끝 -->

					<!-- 새로나온 책 시작  -->
					<div id="menu_new" class="tab-pane fade">
						<div class="row">
							<div class="col-md-12">
								<iframe id="iframe_list1" height="100%" width="100%"
									src="<%=cp %>/book_New.action?categoryId=${categoryId}"
									style="overflow: auto; min-height: 1000px;" frameborder="0"
									scrolling="auto" onload="calcHeight();" name="WrittenPublic"></iframe>
							</div>
						</div>

					</div>


					<!-- 새로나온 책 끝  -->



					<!-- 정가인하 시작 -->
					<div id="menu_discount" class="tab-pane fade">

						<div class="row">
							<div class="col-md-12">
								<iframe id="iframe_list2" width="100%"
									style="min-height: 1000px; overflow: auto;" scrolling="auto"
									src="<%=cp %>/book_Discount.action?categoryId=${categoryId}"
									frameborder="0"> </iframe>
							</div>
						</div>


					</div>
					<!-- 정가인하 끝 -->

				</div>
				<!-- tabContent -->

			</div>
			<!-- Dynamic Tabs Div -->

		</div>

		<!-- 가운데 레이아웃 -->
	</div>

	<!-- footer -->
	<jsp:include page="../../../common/footer.jsp" flush="false" />
</body>

</html>