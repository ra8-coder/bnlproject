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
<title>자기계발 도서부분</title>

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
	href="/webproject/resources/common/css/bnlBSList2.css" type="text/css">

<script type="text/javascript"
	src="/springwebview/resources/js/Main_01.js"></script>
<script type="text/javascript"
	src="/springwebview/resources/js/JUTIL/JUTIL.js"></script>
<script type="text/javascript"
	src="/springwebview/resources/js/jquery/jquery.min.js"></script>
<script type="text/javascript"
	src="/springwebview/resources/js/swfobject.js"></script>


<script type="text/javascript"
	src="/webproject/resources/common/js/common.js"></script>
<script type="text/javascript"
	src="/webproject/resources/common/js/jquery-3.3.1.js"></script>
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

<script type="text/javascript" src="https://wcs.naver.net/wcslog.js"></script>

<!-- ADSSOM 신규 버전 17-11-20 -->
<!-- ADSSOM 공통 SCRIPT -->
<script type="text/javascript" src="https://sc.11h11m.net/s/E799.js"></script>
<script type="text/javascript" charset="UTF-8" async=""
	src="http://s.n2s.co.kr/_n2s_ck_log.php"></script>

<!-- 스크립트2 시작 -->
<link rel="stylesheet"
	href="http://image.bandinlunis.com/common/css/pStyle.css"
	type="text/css">

<script type="text/javascript" src="/webproject/resources/js/dwr.js"
	charset="euc-kr"></script>
<script type="text/javascript"
	src="/webproject/resources/js/jquery/jquery.min.js"></script>
<!-- IE8 에서 오류로 인해 일부러 넣음(jQuery 보다 dwr.util.js 가 밑에 있음 오류 발생) -->
<script type="text/javascript"
	src="/webproject/resources/js/multiCart.js"></script>


<!-- Carousel BS -->
<!-- Tabs with Dropdown Menu-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
	border: none;
}

.tablinks {
	float: left;
	width: 25%;
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
	padding: 12px 12px;
	border-top: none;
	border-bottom: none;
	width: 100%;
	height: 200px;
	display: none;
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
		<!-- 좌측 템플릿 시작 -->

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

				<!-- 좌측 템플릿 -->

			</div>


			<!-- 좌측 템플릿 -->

			<div class="cate_left_box temClassE" style="width: 180px;">

				<h4 class="cate_tem_tit ">자기계발 스테디 셀러</h4>
				<ul>

					<li>
						<dl>
							<dt class="pImg60">
								<img
									src="http://image.bandinlunis.com/upload/product/4026/4026928.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';">
							</dt>
							<dd class="booktit">영어책 한 권 외워봤니?</dd>
							<dd class="writer">김민식</dd>
							<dd class="price">12,600원</dd>
							<dd class="sPoint t_11">(10%↓+5%P)</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt class="pImg60">
								<img
									src="http://image.bandinlunis.com/upload/product/4003/4003399.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';">
							</dt>
							<dd class="booktit">휘게 라이프, 편안하게 함께...</dd>
							<dd class="writer">마이크 비킹</dd>
							<dd class="price">12,600원</dd>
							<dd class="sPoint t_11">(10%↓+5%P)</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt class="pImg60">
								<img
									src="http://image.bandinlunis.com/upload/product/3998/3998575.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';">
							</dt>
							<dd class="booktit">그릿 GRIT</dd>
							<dd class="writer">앤절라 더크워스</dd>
							<dd class="price">14,400원</dd>
							<dd class="sPoint t_11">(10%↓+5%P)</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt class="pImg60">
								<img
									src="http://image.bandinlunis.com/upload/product/3990/3990452.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';">
							</dt>
							<dd class="booktit">프레임 [개정증보판]</dd>
							<dd class="writer">최인철</dd>
							<dd class="price">14,400원</dd>
							<dd class="sPoint t_11">(10%↓+5%P)</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt class="pImg60">
								<img
									src="http://image.bandinlunis.com/upload/product/3986/3986344.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';">
							</dt>
							<dd class="booktit">자존감 수업</dd>
							<dd class="writer">윤홍균</dd>
							<dd class="price">12,600원</dd>
							<dd class="sPoint t_11">(10%↓+5%P)</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt class="pImg60">
								<img
									src="http://image.bandinlunis.com/upload/product/3947/3947410.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';">
							</dt>
							<dd class="booktit">리딩으로 리드하라[개정증보판...</dd>
							<dd class="writer">이지성</dd>
							<dd class="price">15,300원</dd>
							<dd class="sPoint t_11">(10%↓+5%P)</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt class="pImg60">
								<img
									src="http://image.bandinlunis.com/upload/product/3928/3928166.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';">
							</dt>
							<dd class="booktit">미라클 모닝</dd>
							<dd class="writer">할 엘로드</dd>
							<dd class="price">10,800원</dd>
							<dd class="sPoint t_11">(10%↓+5%P)</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt class="pImg60">
								<img
									src="http://image.bandinlunis.com/upload/product/3853/3853562.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';">
							</dt>
							<dd class="booktit">혼자 있는 시간의 힘</dd>
							<dd class="writer">사이토 다카시</dd>
							<dd class="price">11,520원</dd>
							<dd class="sPoint t_11">(10%↓+5%P)</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt class="pImg60">
								<img
									src="http://image.bandinlunis.com/upload/product/3812/3812617.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';">
							</dt>
							<dd class="booktit">그림의 힘</dd>
							<dd class="writer">김선현</dd>
							<dd class="price">16,920원</dd>
							<dd class="sPoint t_11">(10%↓+5%P)</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt class="pImg60">
								<img
									src="http://image.bandinlunis.com/upload/product/3653/3653595.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';">
							</dt>
							<dd class="booktit">데일 카네기 인간관계론[개정...</dd>
							<dd class="writer">데일 카네기</dd>
							<dd class="price">12,420원</dd>
							<dd class="sPoint t_11">(10%↓+5%P)</dd>
						</dl>
					</li>

				</ul>
			</div>

		</div>


		<!-- 좌측 템플릿 끝 -->






		<!-- 가운데 레이아웃 -->

		<div class="con_t2">

			<div class="container" style="width: 850px;">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#home">전체목록</a></li>

					<li><a href="#menu_best">베스트셀러</a></li>

					<li><a href="#menu_new">새로나온 책</a></li>

					<li><a href="#menu_discount">정가인하</a></li>
				</ul>


				<!-- 줄 생성 -->

				<!-- 탭 메뉴 -->

				<div class="tab-content" style="width: 800px;">

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


									</div>
								</div>
							</div>
							<!-- 카테고리 메인배너 -->


							<br /> <br />

							<!-- 반디 추천책 -->
							<h4
								style="width: 532px; height: 35px; padding: 0 0 0 5px; border-bottom: 1px solid #e1e1e1; font: italic 11px; color: #000; letter-spacing: -0.05em">반디앤루니스
								추천책</h4>
							<hr>

							<div class="tab"
								style="border-bottom: 10px solid #ffffff; z-index: 99;">
								<div class="tablinks" onmouseover="openCity(event, 'book_1')"
									style="background-color: white;">
									<a href="/webproject/book_info.action?isbn=9788932473772">
										<img
										src="http://image.bandinlunis.com/upload/product/4168/4168234.jpg"
										style="cursor: pointer; width: 45%; height: 45%;">
									</a>
								</div>
								<div class="tablinks" onmouseover="openCity(event, 'book_2')"
									style="background-color: white;">
									<a href="/webproject/book_info.action?isbn=9791185811468">
										<img
										src="http://image.bandinlunis.com/upload/product/4161/4161879.jpg"
										style="cursor: pointer; width: 45%; height: 45%;">

									</a>
								</div>
								<div class="tablinks" onmouseover="openCity(event, 'book_3')"
									style="background-color: white;">
									<img
										src="http://image.bandinlunis.com/upload/product/4154/4154294.jpg"
										style="cursor: pointer; width: 45%; height: 45%;">

								</div>

								<div class="tablinks" onmouseover="openCity(event, 'book_4')"
									style="background-color: white;">
									<a href="/webproject/book_info.action?isbn=9791158462109">
										<img
										src="http://image.bandinlunis.com/upload/product/4149/4149818.jpg"
										style="cursor: pointer; width: 45%; height: 45%;">
									</a>
								</div>
							</div>

							<br /> <br />
							<div style="height: 60px;"></div>
							<div id="book_1" class="tabcontent" style="border: none;">
								<dl style="border: none;">
									<dt class="pImg145" style="float: left; margin-right: 20px;">
										<a href="/webproject/book_info.action?isbn=9788932473772">
											<img
											src="http://image.bandinlunis.com/upload/product/4168/4168234.jpg"
											style="float: left;">
										</a>
									</dt>
									<br />
									<dd class="booktit">
										<a href="/webproject/book_info.action?isbn=9788932473772">다동력</a>

									</dd>
									<dd class="writer">호리에 다카후미 | 을유문화사</dd>
									<br />
									<dd class="bex">일본에서 출간 후 1년 동안 30만 부 판매된 초특급 베스트셀러여러 가지
										다른 일을 동시에 진행하는 힘인 ‘다동력’으로 대체 불가능한 인재가 되고 업무 효율성을 높여 ‘나 자신의
										시간’을 찾는 방법을 제시한 책이 을유문화사에서 출간됐다. 세계 곳곳을 다니면서 수많은 사람을 만나며 수십 가지
										일을 처리해 내는 저자의 ‘다동력’을 전수받아 능...</dd>
								</dl>
							</div>

							<div id="book_2" class="tabcontent" style="border: none;">
								<dl style="border: none;">
									<dt class="pImg145" style="float: left; margin-right: 20px;">
										<a href="/webproject/book_info.action?isbn=9791185811468">
											<img
											src="http://image.bandinlunis.com/upload/product/4161/4161879.jpg"
											style="float: left;">

										</a>
									</dt>
									<br />
									<dd class="booktit">
										<a href="/webproject/book_info.action?isbn=9791185811468">인빅터스
											1 </a>
									</dd>
									<dd class="writer">이진 | 천년의상상</dd>
									<br />
									<dd class="bex">1. 당신에겐 어떤 ‘별’이 있나요? “비결은 그냥 노력이에요. 정말 잘하고
										싶다는 마음을 갈구하다 보니 여기까지 왔습니다.” 설상 종목 최초 금메달을 따낸 평창 금메달리스트 윤성빈은 금빛
										질주를 한 후 인터뷰에서 비인기 종목이었던 스켈레톤을 하면서 오로지 ‘노력’이 영광의 동력이었다고
										말했다.이상화와 아름다운 우정을 보여준 일본 빙속 5...</dd>
								</dl>

							</div>

							<div id="book_3" class="tabcontent" style="border: none;">
								<dl style="border: none;">
									<dt class="pImg145" style="float: left; margin-right: 20px;">

										<img
											src="http://image.bandinlunis.com/upload/product/4154/4154294.jpg"
											style="float: left;">

									</dt>
									<br />
									<dd class="booktit">만만하게 보이지 않는 대화법</dd>
									<dd class="writer">나이토 요시히토 | 홍익</dd>
									<br />
									<dd class="bex">“상처 받았다면 무심코라도 웃지 마라!” 필요한 말을 센스 있게 하는
										대화법으로일과 관계를 성공으로 이끄는 자존감up↑↑ 심리학일본 최고의 심리학 교수가 만만해 보이지 않기 위한
										대화기술을 알려주는 책이다. “그때 이렇게 말했어야 하는데…상처를 받았음에도 웃어주고 만 내가 싫습니다.”저자는
										상대가 무례한 말을 한 것은 당신이 ‘만만해 보여...</dd>
								</dl>
							</div>
							<div id="book_4" class="tabcontent" style="border: none;">
								<dl style="border: none;">
									<dt class="pImg145" style="float: left; margin-right: 20px;">
										<a href="/webproject/book_info.action?isbn=9791158462109">
											<img
											src="http://image.bandinlunis.com/upload/product/4149/4149818.jpg"
											style="float: left;">
										</a>
									</dt>
									<br />
									<dd class="booktit">
										<a href="/webproject/book_info.action?isbn=9791158462109">긍정의
											말습관 1</a>
									</dd>
									<dd class="writer">오수향 | 북클라우드</dd>
									<br />
									<dd class="bex">“나에게 하는 말을 바꾸자 인생이 달라지기 시작했다”잘되는 사람들이 매일
										실천하는 가장 작은 노력이 책의 저자인 오수향 SHO대화심리연구소 소장은 가정과 직장 등 모든 관계의 대화법을
										도와주는 한편, 말과 관련된 다방면의 강연을 통해 많은 사람이 말의 힘으로 성공하는 모습을 지켜봤다. 그녀는
										또한 인생 역전의 여왕이다. 고등학교 때 선생님...</dd>
								</dl>
							</div>

							<div class="clearfix"></div>

						</div>

						<div class="cateS"
							style="border: none; margin-left: 20px; margin-top: 8px;">

							<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
							<!-- 분야 주간 베스트 -->
							<div class="cateBest">
								<h4>분야 주간 베스트</h4>

								<ul>

									<li class="bestTop" style="border: none;">
										<dl>
											<dt>
												<span class="rank no1" style="height: 15px;">1</span>
											</dt>

											<dd class="pImg52 imgP">
												<img
													src="http://image.bandinlunis.com/upload/product/4134/4134086_s.jpg"
													onerror="this.src='/images/common/noimg_type04.gif';">



											</dd>
											<dd class="booktit">무례한 사람에게 웃으며 대처...</dd>
											<dd class="writer">정문정</dd>



										</dl>
									</li>

									<li>
										<dl>
											<dt>
												<span class="rank no2" style="height: 15px;">2</span>
											</dt>


											<dd class="booktit">자존감 수업</dd>
											<dd class="writer">윤홍균</dd>


										</dl>
									</li>

									<li>
										<dl>
											<dt>
												<span class="rank no3" style="height: 15px;">3</span>
											</dt>


											<dd class="booktit">첫째 딸로 태어나고 싶지는 ...</dd>
											<dd class="writer">리세터 스하위테마커르, 비스...</dd>


										</dl>
									</li>

									<li>
										<dl>
											<dt>
												<span class="rank no4" style="height: 15px;">4</span>
											</dt>


											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9788965706830">관점을
													디자인하라</a>
											</dd>
											<dd class="writer">박용후</dd>


										</dl>
									</li>

									<li>
										<dl>
											<dt>
												<span class="rank no5" style="height: 15px;">5</span>
											</dt>


											<dd class="booktit">말투 하나 바꿨을 뿐인데 [...</dd>
											<dd class="writer">나이토 요시히토</dd>


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
													<a href="/webproject/book_info.action?isbn=9791187400226"><img
														src="/webproject/resources/image/book/4154403_cover.jpg"
														onerror="this.src='/images/common/noimg_type01.gif';"></a>
												</dt>

												<dd class="booktit">
													<a href="/webproject/book_info.action?isbn=9791187400226">아침
														1시간 노트 [개정판] </a>
												</dd>
												<dd class="writer">
													야마모토 노리아키<span class="public"> | 책비</span>
												</dd>
												<dd class="price">13,000원</dd>
												<dd class="sPoint">(10%↓+5%P)</dd>


												<dd class="bex">출판사 리뷰 일본 아마존 베스트셀러 저자가 말하는 ‘아침 1시간’으로
													인생을 변화시키는 가장 손쉽고 현실적인 비결! ？ 회사원으로 일하면서 ‘세 ...</dd>
											</dl>
										</li>



										<li class="po1">
											<dl>
												<dt class="pImg90">
													<a href="/webproject/book_info.action?isbn=9788972773207"><img
														src="/webproject/resources/image/book/4156162_cover.jpg"
														onerror="this.src='/images/common/noimg_type01.gif';"></a>
												</dt>

												<dd class="booktit">
													<a href="/webproject/book_info.action?isbn=9788972773207">하버드
														첫 강의 시간관리 수업</a>
												</dd>
												<dd class="writer">
													쉬셴장<span class="public"> | 리드리드출판</span>
												</dd>
												<dd class="price">14,800원</dd>
												<dd class="sPoint">(10%↓+5%P)</dd>


												<dd class="bex">이 책은 ★★★★★ 최고의 대학 하버드 신입생의 첫 강의는 왜 시간관리
													수업인가? ‘글로벌 500’ 기업의 CEO를 가장 많이 배출한 곳! 졸업</dd>
											</dl>
										</li>

									</ul>

								</div>
							</div>


							<div class="temClassA temType2" id="dp_015">

								<h4>
									2018 습관의 힘<span></span>
								</h4>
								<ul>

									<li class="po1">
										<dl>
											<dt class="pImg90 imgP">




												<img
													src="http://image.bandinlunis.com/upload/product/4154/4154403.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


											</dt>


											<dd class="booktit">
												<a href="/webproject/book_info.action?isbn=9791187400226">아침
													1시간 노트 [개정판]</a>
											</dd>
											<dd class="writer">
												야마모토 노리아키<span class="public"> | 책비</span>
											</dd>


											<dd class="rPrice">13,000원</dd>
											<dd class="price">11,700원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="bex">일본 아마존 베스트셀러 저자가 말하는‘아침 1시간’으로 인생을 변화시키는
												가장 손쉽고 현실적인 비결! 회사원으로 일하면서 ‘세무사’ 시험에 합격...</dd>
										</dl>
									</li>

									<li class="po1">
										<dl>
											<dt class="pImg90 imgP">




												<img
													src="http://image.bandinlunis.com/upload/product/4152/4152988.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


											</dt>


											<dd class="booktit">6분 다이어리</dd>
											<dd class="writer">
												도미닉 스펜스트<span class="public"> | 행성B</span>
											</dd>


											<dd class="rPrice">15,700원</dd>
											<dd class="price">14,130원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="rStar s10">10.0</dd>

											<dd class="bex">★ 독일과 영국의 5만 명 넘는 독자들이 선택한 책★ 독일 아마존
												자기계발 분야 1위! ★ 깐깐한 독일 독자 평점 5점 만점!아침 3분, 저녁 ...</dd>
										</dl>
									</li>

									<li>
										<dl>
											<dt class="pImg90 imgP">




												<img
													src="http://image.bandinlunis.com/upload/product/4144/4144299.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


											</dt>



											<dd class="booktit">나우이스트 NOWIST</dd>
											<dd class="writer">맥스 맥케온</dd>

											<dd class="rPrice">14,500원</dd>
											<dd class="price">13,050원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="bex">★ 아마존 베스트셀러 작가 ★★ 포춘 선정 100대 기업 전략 코치 ★★
												MIT 미디어랩 소장 이토 조이치 강력 추천 ★지금을 놓치면 끝이다!망...</dd>
										</dl>
									</li>

									<li>
										<dl>
											<dt class="pImg90 imgP">




												<img
													src="http://image.bandinlunis.com/upload/product/4134/4134091.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">

											</dt>



											<dd class="booktit">AGAIN! 이기는 습관</dd>
											<dd class="writer">전옥표</dd>

											<dd class="rPrice">16,000원</dd>
											<dd class="price">14,400원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="bex">수많은 기업과 독자가 열광한 《이기는 습관》 본격 실천 편 밀리언셀러
												《이기는 습관》의 저자이자 우리나라 최고의 자기 혁신전문가인 전옥표 박사가...</dd>
										</dl>
									</li>

									<li>
										<dl>
											<dt class="pImg90 imgP">




												<img
													src="http://image.bandinlunis.com/upload/product/4131/4131687.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">



											</dt>



											<dd class="booktit">침대부터 정리하라</dd>
											<dd class="writer">윌리엄 H. 맥레이븐</dd>

											<dd class="rPrice">12,000원</dd>
											<dd class="price">10,800원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="rStar s9">8.67</dd>

											<dd class="bex">세상을 바꾸고 싶다면, 침대부터 정리하십시오!아마존닷컴, 뉴욕 타임스
												종합 베스트셀러 1위!2017년 4월 출간 이후 20여 주 연속 뉴욕 타임...</dd>
										</dl>
									</li>

									<li>
										<dl>
											<dt class="pImg90 imgP">



												<img
													src="http://image.bandinlunis.com/upload/product/4119/4119543.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


											</dt>



											<dd class="booktit">
												<a href="/front/product/detailProduct.do?prodId=4119543">습관책</a>
											</dd>
											<dd class="writer">마크 레클라우</dd>

											<dd class="rPrice">14,000원</dd>
											<dd class="price">12,600원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="bex">Change Your Habits, Change Your Life!
												새로운 인생을 만드는 30일 프로젝트에 도전하라!이 책을 읽으면 다시는 습관...</dd>
										</dl>
									</li>

									<li>
										<dl>
											<dt class="pImg90 imgP">




												<img
													src="http://image.bandinlunis.com/upload/product/4116/4116973.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">



											</dt>



											<dd class="booktit">하루 5분 아침 일기</dd>
											<dd class="writer">인텔리전트 체인지</dd>

											<dd class="rPrice">15,800원</dd>
											<dd class="price">14,220원</dd>
											<dd class="sPoint">(10%↓+5%P)</dd>



											<dd class="rStar s10">10.0</dd>

											<dd class="bex">“아는가? 성공하는 사람들은 아침에 일기를 쓴다는 사실을!” 글로벌
												CEO와 리더, 하이퍼포머들이 공개하는‘아침 일기 쓰기’의 놀라운 효과! “...</dd>
										</dl>
									</li>

								</ul>
							</div>

							<div class="cateInside" id="dp_029"></div>

							<script>
								$(document).ready(function() {
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

					</div>
					<!-- 베스트셀러 끝 -->


					<!-- 새로나온 책 시작  -->
					<div id="menu_new" class="tab-pane fade">
						<div class="row">
							<div class="col-md-12">
								<iframe id="iframe_list1" width="100%"
									src="<%=cp %>/book_New.action?categoryId=${categoryId}"
									style="overflow: auto; min-height: 1000px;" frameborder="0"
									scrolling="auto" onload="calcHeight();"></iframe>
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