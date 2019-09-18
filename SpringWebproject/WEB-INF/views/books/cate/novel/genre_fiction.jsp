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

<title>메인_장르소설 도서부분</title>


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


<script type="text/javascript"
	src="/webproject/resources/js/multiCart.js">

	

</script>

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


				<div class="mt15 cate_left_box series" style="width: 180px;">

					<h4 class="cate_tem_tit">이 분야의 시리즈/총서</h4>

					<ul class="stop">


						<li>

							<dl>

								<dt>

									<img
										src="http://image.bandinlunis.com/upload/product/3854/3854692_s.jpg"
										onerror="this.src='/images/common/noimg_type04.gif';">

								</dt>

								<dd>

									애거서 크리스티 에디터스 초이스 <span>(10)</span>


								</dd>

							</dl>

						</li>


						<li>

							<dl>

								<dt>

									<img
										src="http://image.bandinlunis.com/upload/product/3854/3854832_s.jpg"
										onerror="this.src='/images/common/noimg_type04.gif';">

								</dt>

								<dd>

									인디아나 텔러 <span>(2)</span>


								</dd>

							</dl>

						</li>


						<li>

							<dl>

								<dt>
									<img
										src="http://image.bandinlunis.com/upload/product/3854/3854688_s.jpg"
										onerror="this.src='/images/common/noimg_type04.gif';">
								</dt>

								<dd>

									애거서 크리스티 푸아로 셀렉션 <span>(11)</span>


								</dd>

							</dl>

						</li>


						<li>

							<dl>

								<dt>

									<img
										src="http://image.bandinlunis.com/upload/product/3852/3852311_s.jpg"
										onerror="this.src='/images/common/noimg_type04.gif';">

								</dt>

								<dd>

									13월의 첫사랑 <span>(2)</span>


								</dd>

							</dl>

						</li>


						<li>

							<dl>

								<dt>
									<img
										src="http://image.bandinlunis.com/upload/product/3802/3802235_s.jpg"
										onerror="this.src='/images/common/noimg_type04.gif';">
								</dt>

								<dd>

									미야모토 무사시 <span>(11)</span>


								</dd>

							</dl>

						</li>


					</ul>


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


										<!-- Left and right controls -->


									</div>

								</div>

							</div>

							<!-- 카테고리 메인배너 -->



							<br /> <br />


							<!-- 반디 추천책 -->

							<h4
								style="width: 532px; height: 35px; padding: 0 0 0 5px; border-bottom: 1px solid #e1e1e1; font: 돋움 16px; color: #000; letter-spacing: -0.05em">반디앤루니스

								추천책</h4>

							<hr>


							<div class="tab">

								<div class="tablinks" onmouseover="openCity(event, 'book_1')"
									style="background-color: white;">

									<a href="/webproject/book_info.action?isbn=9791158790943">

										<img
										src="http://image.bandinlunis.com/upload/product/4189/4189162.jpg"
										style="cursor: pointer; width: 45%; height: 45%;">

									</a>

								</div>

								<div class="tablinks" onmouseover="openCity(event, 'book_2')"
									style="background-color: white;">

									<a href="/webproject/book_info.action?isbn=9788983927118">
										<img
										src="http://image.bandinlunis.com/upload/product/4189/4189565.jpg"
										style="cursor: pointer; width: 45%; height: 45%;">



									</a>

								</div>

								<div class="tablinks" onmouseover="openCity(event, 'book_3')"
									style="background-color: white;">

									<a href="/webproject/book_info.action?isbn=9788950976262">
										<img
										src="http://image.bandinlunis.com/upload/product/4186/4186552.jpg"
										style="cursor: pointer; width: 45%; height: 45%;">

									</a>

								</div>


								<div class="tablinks" onmouseover="openCity(event, 'book_4')"
									style="background-color: white;">

									<a href="/webproject/book_info.action?isbn=9788928090938">
										<img
										src="http://image.bandinlunis.com/upload/product/4186/4186534.jpg"
										style="cursor: pointer; width: 45%; height: 45%;">

									</a>

								</div>

							</div>

							<br /> <br />

							<div style="height: 60px;"></div>

							<div id="book_1" class="tabcontent">

								<dl>

									<dt class="pImg145" style="float: left; margin-right: 20px;">

										<a href="/webproject/book_info.action?isbn=9791158790943">

											<img
											src="http://image.bandinlunis.com/upload/product/4189/4189162.jpg"
											style="float: left;">


										</a>

									</dt>

									<br />

									<dd class="booktit">

										<a href="/webproject/book_info.action?isbn=9791158790943">죽음을

											선택한 남자</a>

									</dd>

									<dd class="writer">데이비드 발다치 | 북로드</dd>

									<br />

									<dd class="bex">아마존 베스트셀러 TOP 10, 뉴욕타임스 베스트셀러 1위!전 세계 80개국

										1억 3천만 독자가 열광하는 영미문학의 거장 데이비드 발다치의 신작 스릴러!‘모든 것을 기억하는 남자’ 에이머스

										데커가 펼치는 또 한 번의 영리하고 숨 막히는 두뇌 게임전 세계 80개국 45개 언어로 출간되어 1억 3천만

										부라는 경이로운 판매고를 올린, 명실 공히...</dd>

								</dl>


							</div>


							<div id="book_2" class="tabcontent">

								<dl>

									<dt class="pImg145" style="float: left; margin-right: 20px;">

										<a href="/webproject/book_info.action?isbn=9788983927118">
											<img
											src="http://image.bandinlunis.com/upload/product/4189/4189565.jpg"
											style="float: left;">


										</a>

									</dt>

									<br />

									<dd class="booktit">

										<a href="/webproject/book_info.action?isbn=9788983927118">비밀의
											비밀</a>

									</dd>

									<dd class="writer">할런 코벤 | 문학수첩</dd>

									<br />

									<dd class="bex">줄리아 로버츠 주연 영화화 예정!세계 3대 미스터리 문학상 최초 석권

										스릴러의 제왕 할런 코벤 신작★USA투데이 베스트셀러 1위(종합 부문) ★뉴욕 타임스 베스트셀러 1위(하드커버

										픽션)★커커스리뷰 2016 최고의 책(미스터리·스릴러) ★라이브러리저널 2016 최고의 책(스릴러)★아마존

										2016 최고의 책 · 독자가 가장 사랑한 도서 ★전...</dd>

								</dl>

							</div>

							<div id="book_3" class="tabcontent">

								<dl>

									<dt class="pImg145" style="float: left; margin-right: 20px;">

										<a href="/webproject/book_info.action?isbn=9788950976262">
											<img
											src="http://image.bandinlunis.com/upload/product/4186/4186552.jpg"
											style="float: left;">

										</a>

									</dt>

									<br />

									<dd class="booktit">

										<a href="/webproject/book_info.action?isbn=9788950976262">열화여가

											1</a>

									</dd>

									<dd class="writer">명효계 | 아르테</dd>

									<br />

									<dd class="bex">★2018년 중국 드라마 최고 화제작 열화여가 원작소설★삼생삼세 십리도화

										제작진이 선택한 새로운 이야기드라마 70억 뷰 돌파, 5주 연속 조회 수 1위여주인공 ‘열여가’와 그녀를 둘러싼

										인물들이 무림 최고 문파 ‘열화산장’을 배경으로 펼치는 사랑과 야망, 복수에 얽힌 무협사극 『열화여가』가

										아르테에서 출간되었다. 『열화여가』는 중국 국민 ...</dd>

								</dl>

							</div>

							<div id="book_4" class="tabcontent">

								<dl>

									<dt class="pImg145" style="float: left; margin-right: 20px;">

										<a href="/webproject/book_info.action?isbn=9788928090938">
											<img
											src="http://image.bandinlunis.com/upload/product/4186/4186534.jpg"
											style="float: left;">

										</a>

									</dt>

									<br />

									<dd class="booktit">

										<a href="/webproject/book_info.action?isbn=9788928090938">강박의
											연애 </a>


									</dd>

									<dd class="writer">류재현 | 마야마루</dd>

									<br />

									<dd class="bex">5년 전, 그녀는 왜 이별을 말했을까.함께했던 대학 시절이 인생에서 가장

										행복한 때였다.마음을 송두리째 빼앗아 놓고 떠나간 첫사랑.갑작스러운 이별처럼 갑자기 재회한 그녀,

										박지운.정리했다 여겼던 단하의 마음이 그때와 똑같이 두근거린다.우리가 무슨 사이도 아닌데 왜 이렇게 신경 쓰이게

										만들지.5년을 잊으려고 애썼지만 결국 지우지 못한 첫사랑...</dd>

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

												<span class="rank no1">1</span>

											</dt>


											<dd class="pImg52 imgP">




												<img
													src="http://image.bandinlunis.com/upload/product/3558/3558781_s.jpg"
													onerror="this.src='/images/common/noimg_type04.gif';">



											</dd>

											<dd class="booktit">나미야 잡화점의 기적</dd>

											<dd class="writer">히가시노 게이고</dd>




										</dl>

									</li>


									<li>

										<dl>

											<dt>

												<span class="rank no2">2</span>

											</dt>



											<dd class="booktit">나와 호랑이님 19 [한정판...</dd>

											<dd class="writer">카넬</dd>



										</dl>

									</li>


									<li>

										<dl>

											<dt>

												<span class="rank no3">3</span>

											</dt>



											<dd class="booktit">살인의 문 2</dd>

											<dd class="writer">히가시노 게이고</dd>



										</dl>

									</li>


									<li>

										<dl>

											<dt>

												<span class="rank no4">4</span>

											</dt>



											<dd class="booktit">Re:제로부터 시작하는 이세...</dd>

											<dd class="writer">나가츠키 탓페이</dd>



										</dl>

									</li>


									<li>

										<dl>

											<dt>

												<span class="rank no5">5</span>

											</dt>



											<dd class="booktit">사랑하는 기생충</dd>

											<dd class="writer">미아키 스가루</dd>



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

													<a href="/webproject/book_info.action?isbn=9788963713496"><img
														src="http://image.bandinlunis.com/upload/product/3997/3997224.jpg"
														onerror="this.src='/images/common/noimg_type01.gif';"></a>

												</dt>


												<dd class="booktit">

													<a href="/webproject/book_info.action?isbn=9788963713496">꽃길,
														꿈길</a>

												</dd>

												<dd class="writer">

													진양<span class="public"> | 파란</span>

												</dd>

												<dd class="price">11,700원</dd>

												<dd class="sPoint">(10%↓+5%P)</dd>



												<dd class="bex">◎ 이 책은당신의 꿈속에서라도 함께 걸을 수만 있다면…….진양 작가의

													장편소설 《꽃길, 꿈길》. 핏빛으로 물든 과거의 역모 사건과 맞물려 현재까지 이어지는 복수와 음모. 치밀한

													사...</dd>

											</dl>

										</li>




										<li class="po1">

											<dl>

												<dt class="pImg90">

													<a href=""><img
														src="http://image.bandinlunis.com/upload/product/3993/3993371.jpg"
														onerror="this.src='/images/common/noimg_type01.gif';"></a>

												</dt>


												<dd class="booktit">

													<a href="9788963713397">탑스타의 탑 시크릿</a>

												</dd>

												<dd class="writer">

													김지혜<span class="public"> | 파란</span>

												</dd>

												<dd class="price">9,000원</dd>

												<dd class="sPoint">(10%↓+5%P)</dd>



												<dd class="bex">그로부터 평행선이 되려는 여자와 그녀와 하나의 선이 되고 싶은

													남자.서로에게 유일한 선이 되기 위해 등을 맞대다 김지혜 작가의 장편소설 《탑스타의 탑 시크릿》.작가는

													최고의 인기 ...</dd>

											</dl>

										</li>

									</ul>


								</div>

							</div>



							<div class="temClassA temType2" id="dp_006">


								<h4>

									MD추천도서 : NICE BOOK!<span></span>

								</h4>


								<ul>

									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">

												<a href="/webproject/book_info.action?isbn=9791125864097">
													<img
													src="http://image.bandinlunis.com/upload/product/4190/4190319.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">



												</a>

											</dt>


											<dd class="booktit">

												<a href="/webproject/book_info.action?isbn=9791125864097">혼효
													昏曉 전 3권세트</a>

											</dd>

											<dd class="writer">

												문은숙<span class="public"> | 로망띠끄</span>

											</dd>

											<dd class="rPrice">30,000원</dd>

											<dd class="price">27,000원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="bex">1권.“소녀는 은파루의 황금조라 하지요.”때는 치평 4년의 겨울, 세밑이

												다가올 무렵의 요주.기분전환삼아 저잣거리에 나갔던 기녀 황리는 우연찮게 소매치기 소동에 휘말린다. 어린

												소...</dd>

										</dl>

									</li>




									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">

												<img
													src="http://image.bandinlunis.com/upload/product/4189/4189678.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">




											</dt>


											<dd class="booktit">월드 오브 워크래프트 : 폭풍전야</dd>

											<dd class="writer">

												크리스티 골드<span class="public"> | 제우미디어</span>

											</dd>

											<dd class="rPrice">15,800원</dd>

											<dd class="price">14,220원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="bex">"와우 확장팩 사이, 무슨 일이 일어난 걸까?"질문에 답해줄 소설

												『폭풍전야』 소설 『폭풍전야』는 블리자드 사의 대표 게임, 월드 오브 워크래프트의 신규 확장팩 '격전의

												아제로스'...</dd>

										</dl>

									</li>

								</ul>


								<ul>

									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">





												<img
													src="http://image.bandinlunis.com/upload/product/4188/4188614.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">





											</dt>


											<dd class="booktit">뱅쇼를 당신에게</dd>

											<dd class="writer">

												곤도 후미에<span class="public"> | 노블엔진팝</span>

											</dd>

											<dd class="rPrice">9,800원</dd>

											<dd class="price">8,820원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="bex">『얼어붙은 섬』으로 제4회 아유카와 데쓰야 상을 수상하고『새크리파이스』로

												제10회 오야부 하루히코 상을 수상한 작가곤도 후미에의 미스터리 시리즈 그 두 번째 작품! 작품 소개일본

												...</dd>

										</dl>

									</li>




									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">






												<img
													src="http://image.bandinlunis.com/upload/product/4188/4188602.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">





											</dt>


											<dd class="booktit">더 뉴 게이트 04 푸른색의 옛 성지</dd>

											<dd class="writer">

												카자나미 시노기<span class="public"> | 라의눈</span>

											</dd>

											<dd class="rPrice">9,500원</dd>

											<dd class="price">8,550원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="bex">일본 집계 10만 부 판매고를 기록한 경이적 인기의 웹소설!신과 공주가

												강제 전송된 곳은 ‘성지’ㅡ한때 「THE NEW GATE」의 세계에서 번성했던 그 도시는 천재지변의

												영향으로...</dd>

										</dl>

									</li>

								</ul>


								<ul>

									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">

												<a href="/webproject/book_info.action?isbn=9791126443734">
													<img
													src="http://image.bandinlunis.com/upload/product/4187/4187940.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">



												</a>

											</dt>


											<dd class="booktit">

												<a href="/webproject/book_info.action?isbn=9791126443734">영원한
													조연은 없다 1 </a>

											</dd>

											<dd class="writer">

												김로아<span class="public"> | 디앤씨미디어</span>

											</dd>

											<dd class="rPrice">13,000원</dd>

											<dd class="price">11,700원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="bex">“주인공이 됐으면 좀 좋아?! 왜 나는 신관 1이냐고!”현대의 강단아,

												애독하던 소설의 엑스트라 신관이 되다.그것도 하필이면 한순간의 실수로 노역형을 받은 직후에.신관 엘레나가

												이...</dd>

										</dl>

									</li>




									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">


												<img
													src="http://image.bandinlunis.com/upload/product/4186/4186251.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">

											</dt>


											<dd class="booktit">방패 용사 성공담 19</dd>

											<dd class="writer">

												아네코 유사기<span class="public"> | 영상출판미디어</span>

											</dd>

											<dd class="rPrice">10,000원</dd>

											<dd class="price">9,000원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="bex">나오후미에게 호의를 보이는 마룡의 안내를 받아, 과거에 마룡이 지배했던

												대륙의 성으로 향하는 방패 용사 일행. 그 성에서, 일행은 보물을 찾는 모험자로 위장한 파도의 첨병들을

												격퇴...</dd>

										</dl>

									</li>

								</ul>


							</div>



							<!-- 템플릿 : 2-5단 복합형 -->



							<!-- 템플릿 : 1-3단 수평형 -->



							<!-- 템플릿 TypeA 묶음상품 템플릿 -->





							<!-- 템플릿  : 5단 기본형 -->



							<!-- 템플릿 : 5단 할인형 -->



							<!-- 템플릿 : 5단 별점형 -->



							<!-- 템플릿 : 2단 기본형 -->


							<div class="temClassA temType2" id="dp_008">


								<h4>

									과학 (SF) 소설<span></span>

								</h4>


								<ul>

									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">






												<img
													src="http://image.bandinlunis.com/upload/product/4056/4056692.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">



											</dt>


											<dd class="booktit">칼리반의 전쟁 1</dd>

											<dd class="writer">

												제임스 S. A. 코리<span class="public"> | 아작</span>

											</dd>

											<dd class="rPrice">14,800원</dd>

											<dd class="price">13,320원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="bex">인기리 방영 중인 미드 익스팬스 시리즈 원작소설“SF판 얼음과 불의

												노래” 더 빨라졌다, 더 강렬해졌다!뉴욕타임스 베스트셀러이자 로커스상을 수상하고, 휴고상에 최종

												노미네이트되며 ...</dd>

										</dl>

									</li>




									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">

												<a href="/webproject/book_info.action?isbn=9791187886068">




													<img
													src="http://image.bandinlunis.com/upload/product/4051/4051913.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">



												</a>

											</dt>


											<dd class="booktit">

												<a href="/webproject/book_info.action?isbn=9791187886068">대우주시대</a>

											</dd>

											<dd class="writer">

												네이선 로웰<span class="public"> | 구픽</span>

											</dd>

											<dd class="rPrice">14,000원</dd>

											<dd class="price">12,600원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="bex">■ 작품 소개 24세기 우주를 누비는 것은 전쟁을 위한 전투선이 아닌 온

												우주와 거래할 무역선. 우주 무역의 황금기가 도래했다! 은하계를 누비는 가장 현실적이고 평범한 사람들의

												비...</dd>

										</dl>

									</li>

								</ul>


								<ul>

									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">

												<a href="/webproject/book_info.action?isbn=9791187206446">




													<img
													src="http://image.bandinlunis.com/upload/product/4050/4050158.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">



												</a>

											</dt>


											<dd class="booktit">

												<a href="/webproject/book_info.action?isbn=9791187206446">라마와의

													랑데부</a>

											</dd>

											<dd class="writer">

												아서 C. 클라크 <span class="public"> | 아작</span>

											</dd>

											<dd class="rPrice">14,800원</dd>

											<dd class="price">13,320원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="rStar s9">9.0</dd>


											<dd class="bex">지금까지 쓰인 SF에서 단 한 권을 꼽으라면 바로 이 책!고전이란 바로

												이런 것이다.서기 2130년, 길이 50킬로미터의 거대한 소행성이 지구를 향해 맹렬한 속도로 다가온다.

												‘라...</dd>

										</dl>

									</li>




									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">

												<a href="/webproject/book_info.action?isbn=9791187206422">




													<img
													src="http://image.bandinlunis.com/upload/product/4047/4047391.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">



												</a>

											</dt>


											<dd class="booktit">

												<a href="/webproject/book_info.action?isbn=9791187206422">저주토끼</a>

											</dd>

											<dd class="writer">

												정보라<span class="public"> | 아작</span>

											</dd>

											<dd class="rPrice">14,800원</dd>

											<dd class="price">13,320원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="bex">세상 몹쓸 것들을 제대로 응징하는, 어여쁜 저주 이야기한국 호러

												SF/판타지 대표작가 정보라의 4년 만의 신작 소설집할아버지는 늘 말씀하셨다. “저주에 쓰이는 물건일수록

												예쁘게 만...</dd>

										</dl>

									</li>

								</ul>


								<ul>

									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">

												<a href="/webproject/book_info.action?isbn=9791187206408">




													<img
													src="http://image.bandinlunis.com/upload/product/4041/4041440.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">



												</a>

											</dt>


											<dd class="booktit">

												<a href="/webproject/book_info.action?isbn=9791187206408">안드로메다

													성운</a>

											</dd>

											<dd class="writer">

												이반 예프레모프<span class="public"> | 아작</span>

											</dd>

											<dd class="rPrice">14,800원</dd>

											<dd class="price">13,320원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="bex">러시아 혁명 100주년, 최초의 인공위성 스푸트니크 발사 60주년을

												맞이하여20세기 소련을 대표하는 전설적인 SF 드디어 한국판 출간!인본주의적 공산주의자 작가가 그리는 미래

												인류...</dd>

										</dl>

									</li>




									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">



												<img
													src="http://image.bandinlunis.com/upload/product/4038/4038208.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">



											</dt>


											<dd class="booktit">다크 사이드</dd>

											<dd class="writer">

												앤서니 오닐<span class="public"> | 한스미디어</span>

											</dd>

											<dd class="rPrice">15,000원</dd>

											<dd class="price">13,500원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="rStar s8">7.67</dd>


											<dd class="bex">인터스텔라, 마션, 이번엔 다크 사이드다!★★★ 20세기 폭스사 영화

												제작 중 ★★★월스트리트저널, 퍼블리셔스 위클리, 북리스트, 커커스 리뷰 극찬!거칠고 어둡고 폭력적인 미래를

												...</dd>

										</dl>

									</li>

								</ul>


								<ul>

									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">


												<img
													src="http://image.bandinlunis.com/upload/product/4016/4016903.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">

											</dt>


											<dd class="booktit">제5도살장</dd>

											<dd class="writer">

												커트 보니것<span class="public"> | 문학동네</span>

											</dd>

											<dd class="rPrice">12,500원</dd>

											<dd class="price">11,250원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="rStar s9">8.86</dd>


											<dd class="bex"></dd>

										</dl>

									</li>




									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">


												<img
													src="http://image.bandinlunis.com/upload/product/4013/4013726.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">


											</dt>


											<dd class="booktit">중력의 임무</dd>

											<dd class="writer">

												할 클레민트<span class="public"> | 아작</span>

											</dd>

											<dd class="rPrice">14,800원</dd>

											<dd class="price">13,320원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="rStar s8">8.0</dd>


											<dd class="bex">최고 중력 700G의 행성에서 펼쳐지는 정통 하드 SF의 대명사 과학적

												엄밀함에 못지않은 소설적 재미까지적도 지름 7만7천 킬로미터, 극 지름 3만 킬로미터의 극단적으로 찌그러진

												...</dd>

										</dl>

									</li>

								</ul>


								<ul>

									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">

												<img
													src="http://image.bandinlunis.com/upload/product/4000/4000119.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">
											</dt>


											<dd class="booktit">당신 인생의 이야기</dd>

											<dd class="writer">

												테드 창<span class="public"> | 엘리</span>

											</dd>

											<dd class="rPrice">14,500원</dd>

											<dd class="price">13,050원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="rStar s9">8.78</dd>


											<dd class="bex">최고의 과학소설 작가, 테드 창 작품 영화화!시카리오 드니 빌뇌브 감독,

												11월 개봉작 SF 컨택트 원작! “이 소설집은 진정 경이롭다… 나는 사람의 정신이 제대로 기능하려면 일

												...</dd>

										</dl>

									</li>




									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">






												<img
													src="http://image.bandinlunis.com/upload/product/3978/3978912.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">




											</dt>


											<dd class="booktit">별의 계승자</dd>

											<dd class="writer">

												제임스 P. 호건<span class="public"> | 아작</span>

											</dd>

											<dd class="rPrice">14,800원</dd>

											<dd class="price">13,320원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="rStar s9">9.11</dd>


											<dd class="bex">SF 마니아들이 가장 사랑하며 복간을 기다려온 작품,세계적 SF 작가

												제임스 P. 호건의 대표작 드디어 복간! 달에서 5만 년 전 우주비행사의 시체가 발견되었다우주복 안의 유골은

												...</dd>

										</dl>

									</li>

								</ul>


								<ul>

									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">



												<img
													src="http://image.bandinlunis.com/upload/product/3791/3791159.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">



											</dt>


											<dd class="booktit">바람의 열두 방향</dd>

											<dd class="writer">

												어슐러 K. 르 귄<span class="public"> | 시공사</span>

											</dd>

											<dd class="rPrice">14,000원</dd>

											<dd class="price">12,600원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="rStar s8">8.0</dd>


											<dd class="bex">미국 문학의 거장 어슐러 K. 르 귄의 초기 걸작 단편집고독에 관한

												낭만적인 데뷔작 파리의 4월부터 휴고상, 네뷸러상, 로커스상에 빛나는 오멜라스를 떠나는 사람들과 혁명

												전날까지르...</dd>

										</dl>

									</li>




									<li class="po1">

										<dl>

											<dt class="pImg90 imgP">






												<img
													src="http://image.bandinlunis.com/upload/product/3601/3601121.jpg"
													onerror="this.src='/images/common/noimg_type01.gif';">





											</dt>


											<dd class="booktit">멋진 신세계</dd>

											<dd class="writer">

												올더스 헉슬리<span class="public"> | 문예출판사</span>

											</dd>

											<dd class="rPrice">10,000원</dd>

											<dd class="price">9,000원</dd>

											<dd class="sPoint">(10%↓+5%P)</dd>




											<dd class="rStar s9">9.14</dd>


											<dd class="bex">영국 소설가 올더스 헉슬리의 1932년 작으로 과학문명의 과도한 발전

												결과 인간성의 상실을 결과하고 만 미래사회의 모습을 그렸다. 미래의 인간은 출생시부터 인공수정에 의해

												대량생산...</dd>

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

								<iframe id="iframe_list1" height="100%" width="100%"
									src="<%=cp %>/book_New.action?categoryId=${categoryId}"
									style="margin-left: 0; overflow: auto; min-height: 1000px;"
									frameborder="0" scrolling="auto" onload="calcHeight();"
									name="WrittenPublic"></iframe>

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