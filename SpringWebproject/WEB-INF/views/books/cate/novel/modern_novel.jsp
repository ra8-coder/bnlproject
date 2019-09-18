<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인_소설 도서부분</title>

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

<script>
	function openCity(evt, cityName) {
		var i, tabcontent, tablinks;
		tabcontent = document.getElementsByClassName("tabcontent");
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none";
		}
		tablinks = document.getElementsByClassName("tablinks");
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className
					.replace(" active", "");
		}
		document.getElementById(cityName).style.display = "block";
		evt.currentTarget.className += " active";
	}
</script>

<script>
	$(document).ready(function() {
		$(".nav-tabs a").click(function() {
			$(this).tab('show');
		});
	});
</script>

<!-- Dynamic Tabs 스크립트 -->

<script>
	$(document).ready(
			function() {
				var now = new Date();

				var year = now.getFullYear();
				var mon = (now.getMonth() + 1) > 9 ? '' + (now.getMonth() + 1)
						: '0' + (now.getMonth() + 1);
				var day = now.getDate();

				var day2 = day + 2; // 이틀 후 배송

				if (day > 30) {
					mon++;
					if (mon > 12) {
						year++;
					}
					day2 = 1;
				}

				var chan_val = year + ' 년 ' + mon + ' 월 ' + day2 + ' 일';
				dateTime.innerHTML = chan_val;
			});
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
		if (q < 1) {
			$("#" + id).val() = 1;
		}
		$("#" + id).val(q);

	};
</script>

<style>
* {
	box-sizing: border-box
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
	padding: 12px 12px;
	border: none;
	width: 100%;
	height: 350px;
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

<br/><br/><br/>
	<div id="contentBody" style="width: 1100px;">

		<!-- 좌측 템플릿 시작 -->

		<div class="side_t2 ml5">
			<div class="cate_comm">
				<h2 class="cate_tit">소설</h2>
				<ul class="cate_d1">
					<!-- 중분류 -->
					<li id="kidsCate_821" class="cate_d1_li "><a
						href="/front/product/bookCategoryMain.do?cateId=821"
						class="cate_d1_link" onmouseover="javascript:toggleDisplay3('01')"
						onmouseout="javascript:toggleDisplay3('01')">한국소설</a> <!-- 소분류 -->
						
						<div class="cate_d2" id="left2_layer01"
							onmouseover="javascript:toggleDisplay3('01')"
							onmouseout="javascript:toggleDisplay3('01')"
							style="display: none;">

							<div class="pos_rel">
								<div class="ico_arrow"></div>
								<ul>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=822">현대소설</a></li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=826">고전/명작소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=827">공포/무협소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=831">추리/범죄/스릴러소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">로맨스/인터넷소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">SF/판타지소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">동화/우화소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">가족/성장소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">드라마/영화소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">청소년소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">대하/역사/전쟁소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">문학상수상작품</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">라이트(NT)소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">문지사
											한국소설전</a></li>

								</ul>
							</div>
						</div></li>


					<li id="kidsCate_841" class="cate_d1_li "><a
						href="/front/product/bookCategoryMain.do?cateId=841"
						class="cate_d1_link" onmouseover="javascript:toggleDisplay3('02')"
						onmouseout="javascript:toggleDisplay3('02')">일본소설</a> <!-- 소분류 -->



						<div class="cate_d2" id="left2_layer02"
							onmouseover="javascript:toggleDisplay3('02')"
							onmouseout="javascript:toggleDisplay3('02')"
							style="display: none;">

							<div class="pos_rel">
								<div class="ico_arrow"></div>
								<ul>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=822">현대소설</a></li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=826">고전/명작소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=827">공포/무협소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=831">추리/범죄/스릴러소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">로맨스/인터넷소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">SF/판타지소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">동화/우화소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">가족/성장소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">드라마/영화소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">청소년소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">대하/역사/전쟁소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">문학상수상작품</a>
									</li>


								</ul>
							</div>
						</div></li>


					<!-- 중분류 -->


					<li id="kidsCate_853" class="cate_d1_li "><a
						href="/front/product/bookCategoryMain.do?cateId=853"
						class="cate_d1_link" onmouseover="javascript:toggleDisplay3('03')"
						onmouseout="javascript:toggleDisplay3('03')">영미소설</a> <!-- 소분류 -->

						<div class="cate_d2" id="left2_layer03"
							onmouseover="javascript:toggleDisplay3('03')"
							onmouseout="javascript:toggleDisplay3('03')"
							style="display: none;">

							<div class="pos_rel">
								<div class="ico_arrow"></div>
								<ul>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=822">현대소설</a></li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=826">고전/명작소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=827">공포/무협소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=831">추리/범죄/스릴러소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">로맨스/인터넷소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">SF/판타지소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">동화/우화소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">가족/성장소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">드라마/영화소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">청소년소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">대하/역사/전쟁소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=835">문학상수상작품</a>
									</li>

								</ul>
							</div>
						</div></li>


					<!-- 중분류 -->

					<li id="kidsCate_864" class="cate_d1_li "><a
						href="/front/product/bookCategoryMain.do?cateId=864"
						class="cate_d1_link" onmouseover="javascript:toggleDisplay3('04')"
						onmouseout="javascript:toggleDisplay3('04')">기타외국소설</a> <!-- 소분류 -->



						<div class="cate_d2" id="left2_layer04"
							onmouseover="javascript:toggleDisplay3('04')"
							onmouseout="javascript:toggleDisplay3('04')"
							style="display: none;">

							<div class="pos_rel">
								<div class="ico_arrow"></div>
								<ul>


									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=865">프랑스소설</a>
									</li>


									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=866">독일소설</a></li>


									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=867">중국소설</a></li>



									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=868">인도소설</a></li>



									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=869">동유럽소설</a></li>


									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=869">스페인/중남미소설</a></li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=869">기타국가소설</a></li>
								</ul>
							</div>
						</div></li>


					<!-- 중분류 -->


					<li id="kidsCate_873" class="cate_d1_li "><a
						href="/front/product/bookCategoryMain.do?cateId=873"
						class="cate_d1_link" onmouseover="javascript:toggleDisplay3('05')"
						onmouseout="javascript:toggleDisplay3('05')">고전/명작소설</a> <!-- 소분류 -->



						<div class="cate_d2" id="left2_layer05"
							onmouseover="javascript:toggleDisplay3('05')"
							onmouseout="javascript:toggleDisplay3('05')"
							style="display: none;">

							<div class="pos_rel">
								<div class="ico_arrow"></div>
								<ul>


									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=874">한국</a></li>



									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=875">일본</a></li>



									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=876">영미</a></li>



									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=877">중국</a></li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=877">기타외국</a></li>


								</ul>
							</div>
						</div></li>


					<!-- 중분류 -->

					<li id="kidsCate_878" class="cate_d1_li "><a
						href="/front/product/bookCategoryMain.do?cateId=878"
						class="cate_d1_link" onmouseover="javascript:toggleDisplay3('06')"
						onmouseout="javascript:toggleDisplay3('06')">장르소설</a> <!-- 소분류 -->


						<div class="cate_d2" id="left2_layer06"
							onmouseover="javascript:toggleDisplay3('06')"
							onmouseout="javascript:toggleDisplay3('06')"
							style="display: none;">

							<div class="pos_rel">
								<div class="ico_arrow"></div>
								<ul>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=879">공포/무협소설</a></li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=880">추리/범죄/스릴러소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=881">라이트(NT)소설</a></li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=882">로맨스/인터넷소설</a>
									</li>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=882">SF/판타지소설</a>
									</li>


								</ul>
							</div>
						</div></li>


					<!-- 중분류 -->


					<li id="kidsCate_883" class="cate_d1_li "><a
						href="/front/product/bookCategoryMain.do?cateId=883"
						class="cate_d1_link" onmouseover="javascript:toggleDisplay3('07')"
						onmouseout="javascript:toggleDisplay3('07')">테마소설</a> <!-- 소분류 -->



						<div class="cate_d2" id="left2_layer07"
							onmouseover="javascript:toggleDisplay3('07')"
							onmouseout="javascript:toggleDisplay3('07')"
							style="display: none;">

							<div class="pos_rel">
								<div class="ico_arrow"></div>
								<ul>

									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=884">동화/우화소설</a>
									</li>



									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=885">가족/성장소설</a>
									</li>



									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=886">드라마/영화소설</a>
									</li>



									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=887">청소년소설</a>
									</li>



									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=888">대하/역사/전쟁소설</a>
									</li>



									<li class="cate_d2_link "><a
										href="/front/product/bookCategoryMain.do?cateId=889">성인소설</a></li>




								</ul>
							</div>
						</div></li>

				</ul>
			</div>


			<!-- left banner -->

			<!-- 브랜드 -->

			<!-- 추천인사이드:회원님이 주로 구입하시는 가격대의 인기 상품입니다 -->
			<div id="CATE_2"></div>

			<!-- 좌측 템플릿 -->

			<div class="cate_left_box temClassE">

				<h4 class="cate_tem_tit ">이 분야의 시리즈/총서</h4>
				<ul>

					<li>
						<dl>
							<dt class="pImg60">
								<a href="/front/product/detailProduct.do?prodId=4026928"><img
									src="http://image.bandinlunis.com/upload/product/4026/4026928.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';"></a>
							</dt>
							<dd class="booktit">
								<a href="/front/product/detailProduct.do?prodId=4026928">영어책
									한 권 외워봤니?</a>
							</dd>
							<dd class="writer">김민식</dd>
							<dd class="price">12,600원</dd>
							<dd class="sPoint t_11">(10%↓+5%P)</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt class="pImg60">
								<a href="/front/product/detailProduct.do?prodId=4003399"><img
									src="http://image.bandinlunis.com/upload/product/4003/4003399.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';"></a>
							</dt>
							<dd class="booktit">
								<a href="/front/product/detailProduct.do?prodId=4003399">휘게
									라이프, 편안하게 함께...</a>
							</dd>
							<dd class="writer">마이크 비킹</dd>
							<dd class="price">12,600원</dd>
							<dd class="sPoint t_11">(10%↓+5%P)</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt class="pImg60">
								<a href="/front/product/detailProduct.do?prodId=3998575"><img
									src="http://image.bandinlunis.com/upload/product/3998/3998575.jpg"
									onerror="this.src='/images/common/noimg_type04.gif';"></a>
							</dt>
							<dd class="booktit">
								<a href="/front/product/detailProduct.do?prodId=3998575">그릿
									GRIT</a>
							</dd>
							<dd class="writer">앤절라 더크워스</dd>
							<dd class="price">14,400원</dd>
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
				<!-- 		<div class="tap_menu_d2 mb15"> -->
				<ul class="nav nav-tabs">
					<li class="active"><a href="#home">현대소설 전체</a></li>

					<li><a href="#menu_best">베스트셀러</a></li>

					<li><a href="#menu_new">새로나온 책</a></li>

					<li><a href="#menu_discount">정가인하</a></li>
				</ul>

				<!-- 줄 생성 -->

				<!-- 탭 메뉴 -->

				<div class="tab-content">

					<div id="home" class="tab-pane fade in active">

						<div class="con_t2">

							<div class="prod_sort">
								<div class="sorting">
									<input type="hidden" name="sorts" value="">
									<ul class="con01">
										<li><a id="sort1" style="cursor: pointer;" class="on">판매량순</a></li>
										<li><a id="sort2" style="cursor: pointer;">발행일순</a></li>
										<li><a id="sort12" style="cursor: pointer;">등록일순</a></li>
										<li><a id="sort6" style="cursor: pointer;">상품명순</a></li>
										<li><a id="sort11" style="cursor: pointer;">정가인하순</a></li>
										<li class="alt"><a id="sort10" style="cursor: pointer;">가격순</a></li>
									</ul>
									<div class="con02"></div>
								</div>

								<h4>

									<span><strong>현대소설에</strong>에 총 <strong>5,314</strong>
										권의 정가인하 도서가 등록되어 있습니다. </span>



								</h4>
								<p class="btn_cart"></p>
							</div>
							<div class="fl_clear ml5">
								<div class="prod_list_type  ">

									<ul>

										<!-- 리스트 1개 시작  -->
										<li>
											<div class="prod_thumb">
												<div class="prod_thumb_img">
													<a href="/front/product/detailProduct.do?prodId=3795041"
														onfocus="this.blur();"> <img
														src="http://image.bandinlunis.com/upload/product/3795/3795041.jpg"
														onerror="this.src='/images/common/noimg_type01.gif';">

													</a> <a class="btn_popup" target="_blank"
														href="/front/product/detailProduct.do?prodId=3795041"><span
														class="ico_new">새창열기</span></a>
												</div>

											</div>
											<dl class="prod_info">
												<dt>
													<a href="/front/product/detailProduct.do?prodId=3795041"
														onfocus="this.blur();"> [정가인하] 한국사를 바꿀 14가지 거짓과 진실 </a>
													<!-- <span class="tit_sub">- 덧셈구구</span> -->
													<span class="tag_area"> <span class="tag_best"><span>베스트</span></span>


													</span>
												</dt>
												<dd class="txt_block">
													<span>KBS역사추적팀, 윤영수</span> <span class="gap">|</span> <span>지식파수꾼</span>
													<span class="txt_date"><span class="gap">|</span> <span>2011.05.11</span></span>
												</dd>


												<dd class="mt5">
													<p>
														<span class="txt_junga">정가 <span class="txt_junga">13,000원</span></span><span
															class="txt_arrow">→</span> <span class="txt_reprice2">4,000원
															[<strong>69%</strong> 정가인하]
														</span>
													</p>
													<p class="mt5">
														<span class="txt_price"><strong><em>3,600</em>원</strong>
															(10%↓+5%P)</span>
													</p>
												</dd>
												<dd class="txt_desc">
													<div class="review_point">
														<span style="width: 80.50%"></span>
													</div>
													<span class="ratings_num"> <strong>8.05</strong> <a
														href="/front/product/detailProduct.do?prodId=3795041#sub10"
														target="_blank">리뷰<em>(19)</em></a>
													</span>
												</dd>
												<dd class="txt_bex">추적과 추리의 역사 장금이는 요리사였을까? 정말 계백장군은
													위대했고, 의자왕은 무기력했을까? KBS 역사추적은 ‘과연?’이라는 물음에서 시작된다. 전혀 관계없을 것
													같던 흉노와 신...</dd>
												<dd class="txt_ebook">
													<span>지금 주문하면<strong class="t_red"><span
															id=dateTime style="display: inline;"></span> 이내 </strong> 받을 수
														있습니다.
													</span>
												</dd>

											</dl>
											<dl class="prod_btn">
												<dt>
													<span class="txt_num">수량</span> <input name="quantity"
														id="quantity"
														style="vertical-align: middle; text-align: right" size="5"
														maxlength="4" value="1" /> <img
														style="vertical-align: middle;" alt="수량 증가 감소"
														src="/springwebview/resources/images/book/common/2014/btn_cnt.gif"
														usemap="#map_name_quantity" />
													<map id="map_name_quantity" name="map_name_quantity">
														<area
															href="javascript:modifyProductQuantity('quantity',1);"
															shape="rect" alt="수량 증가" coords="0,0,9,10" />
														<area
															href="javascript:modifyProductQuantity('quantity',-1);"
															shape="rect" alt="수량 감소" coords="0,10,9,20" />
													</map>
												</dt>



												<dd>
													<a href="javascript:addCart('3795041');"><span
														class="btn_b_comm btype_f1">쇼핑카트</span></a>
												</dd>
												<dd class="mt3">
													<a href="javascript:goOrder('3795041');"><span
														class="btn_w_comm btype_f1">바로구매</span></a>
												</dd>




												<dd class="mt3">
													<a
														href="javascript:add_wish_array_common('3795041', true);"><span
														class="btn_w_comm btype_f1">위시리스트</span></a>
												</dd>
											</dl>
										</li>
										<!-- 리스트 1개 끝  -->

									</ul>

								</div>

							</div>


							<!-- 페이징 -->
							<div class="pageTypeA">
								<span class="prev-btn"> <!-- <img src="/images/common/btn_pagePrevG.gif" align="absmiddle" border="0"> -->

									<!-- <img src="/images/common/btn_pagePrev.gif" align="absmiddle" hspace="2" border="0"> -->
								</span> <span class="pageNum"> <a class="on">1</a> <a
									href="/front/display/discountBookList.do?page=2#tabMenu">2</a>
									<a href="/front/display/discountBookList.do?page=3#tabMenu">3</a>
									<a href="/front/display/discountBookList.do?page=4#tabMenu">4</a>
									<a href="/front/display/discountBookList.do?page=5#tabMenu">5</a>
								</span>

							</div>


						</div>




					</div>
					<!-- 전체 목록 끝  -->

					<!-- 베스트셀러 시작 -->

					<div id="menu_best" class="tab-pane fade">

						<div class="con_t2">

							<div class="prod_sort">
								<div class="sorting">
									<input type="hidden" name="sorts" value="">
									<ul class="con01">
										<li><a id="sort1" style="cursor: pointer;" class="on">판매량순</a></li>
										<li><a id="sort2" style="cursor: pointer;">발행일순</a></li>
										<li><a id="sort12" style="cursor: pointer;">등록일순</a></li>
										<li><a id="sort6" style="cursor: pointer;">상품명순</a></li>
										<li><a id="sort11" style="cursor: pointer;">정가인하순</a></li>
										<li class="alt"><a id="sort10" style="cursor: pointer;">가격순</a></li>
									</ul>
									<div class="con02"></div>
								</div>

								<h4>

									<span><strong>전체</strong>에 총 <strong>5,314</strong> 권의
										정가인하 도서가 등록되어 있습니다. </span>



								</h4>
								<p class="btn_cart"></p>
							</div>
							<div class="fl_clear ml5">
								<div class="prod_list_type  ">

									<ul>

										<!-- 리스트 1개 시작  -->
										<li>
											<div class="prod_thumb">
												<div class="prod_thumb_img">
													<a href="/front/product/detailProduct.do?prodId=3795041"
														onfocus="this.blur();"> <img
														src="http://image.bandinlunis.com/upload/product/3795/3795041.jpg"
														onerror="this.src='/images/common/noimg_type01.gif';">

													</a> <a class="btn_popup" target="_blank"
														href="/front/product/detailProduct.do?prodId=3795041"><span
														class="ico_new">새창열기</span></a>
												</div>

											</div>
											<dl class="prod_info">
												<dt>
													<a href="/front/product/detailProduct.do?prodId=3795041"
														onfocus="this.blur();"> [정가인하] 한국사를 바꿀 14가지 거짓과 진실 </a>
													<!-- <span class="tit_sub">- 덧셈구구</span> -->
													<span class="tag_area"> <span class="tag_best"><span>베스트</span></span>


													</span>
												</dt>
												<dd class="txt_block">
													<span>KBS역사추적팀, 윤영수</span> <span class="gap">|</span> <span>지식파수꾼</span>
													<span class="txt_date"><span class="gap">|</span> <span>2011.05.11</span></span>
												</dd>


												<dd class="mt5">
													<p>
														<span class="txt_junga">정가 <span class="txt_junga">13,000원</span></span><span
															class="txt_arrow">→</span> <span class="txt_reprice2">4,000원
															[<strong>69%</strong> 정가인하]
														</span>
													</p>
													<p class="mt5">
														<span class="txt_price"><strong><em>3,600</em>원</strong>
															(10%↓+5%P)</span>
													</p>
												</dd>
												<dd class="txt_desc">
													<div class="review_point">
														<span style="width: 80.50%"></span>
													</div>
													<span class="ratings_num"> <strong>8.05</strong> <a
														href="/front/product/detailProduct.do?prodId=3795041#sub10"
														target="_blank">리뷰<em>(19)</em></a>
													</span>
												</dd>
												<dd class="txt_bex">추적과 추리의 역사 장금이는 요리사였을까? 정말 계백장군은
													위대했고, 의자왕은 무기력했을까? KBS 역사추적은 ‘과연?’이라는 물음에서 시작된다. 전혀 관계없을 것
													같던 흉노와 신...</dd>
												<dd class="txt_ebook">
													<span>지금 주문하면<strong class="t_red">2018년
															10월 20일(토) 이내</strong>받을 수 있습니다.
													</span>
												</dd>

											</dl>
											<dl class="prod_btn">
												<dt>
													<span class="txt_num">수량</span> <input name="quantity"
														id="quantity"
														style="vertical-align: middle; text-align: right" size="5"
														maxlength="4" value="1" /> <img
														style="vertical-align: middle;" alt="수량 증가 감소"
														src="/springwebview/resources/images/book/common/2014/btn_cnt.gif"
														usemap="#map_name_quantity" />
													<map id="map_name_quantity" name="map_name_quantity">
														<area
															href="javascript:modifyProductQuantity('quantity',1);"
															shape="rect" alt="수량 증가" coords="0,0,9,10" />
														<area
															href="javascript:modifyProductQuantity('quantity',-1);"
															shape="rect" alt="수량 감소" coords="0,10,9,20" />
													</map>
												</dt>



												<dd>
													<a href="javascript:addCart('3795041');"><span
														class="btn_b_comm btype_f1">쇼핑카트</span></a>
												</dd>
												<dd class="mt3">
													<a href="javascript:goOrder('3795041');"><span
														class="btn_w_comm btype_f1">바로구매</span></a>
												</dd>




												<dd class="mt3">
													<a
														href="javascript:add_wish_array_common('3795041', true);"><span
														class="btn_w_comm btype_f1">위시리스트</span></a>
												</dd>
											</dl>
										</li>
										<!-- 리스트 1개 끝  -->

									</ul>

								</div>

							</div>


							<!-- 페이징 -->
							<div class="pageTypeA">
								<span class="prev-btn"> <!-- <img src="/images/common/btn_pagePrevG.gif" align="absmiddle" border="0"> -->

									<!-- <img src="/images/common/btn_pagePrev.gif" align="absmiddle" hspace="2" border="0"> -->
								</span> <span class="pageNum"> <a class="on">1</a> <a
									href="/front/display/discountBookList.do?page=2#tabMenu">2</a>
									<a href="/front/display/discountBookList.do?page=3#tabMenu">3</a>
									<a href="/front/display/discountBookList.do?page=4#tabMenu">4</a>
									<a href="/front/display/discountBookList.do?page=5#tabMenu">5</a>
								</span>
							</div>

						</div>

					</div>
					<!-- 베스트셀러 끝 -->

					<!-- 새로나온 책 시작  -->
					<div id="menu_new" class="tab-pane fade">
						<div class="con_t2">

							<div class="prod_sort">
								<div class="sorting">
									<input type="hidden" name="sorts" value="">
									<ul class="con01">
										<li><a id="sort1" style="cursor: pointer;" class="on">판매량순</a></li>
										<li><a id="sort2" style="cursor: pointer;">발행일순</a></li>
										<li><a id="sort12" style="cursor: pointer;">등록일순</a></li>
										<li><a id="sort6" style="cursor: pointer;">상품명순</a></li>
										<li><a id="sort11" style="cursor: pointer;">정가인하순</a></li>
										<li class="alt"><a id="sort10" style="cursor: pointer;">가격순</a></li>
									</ul>
									<div class="con02">
										<p>
											<select class="changeListSize">
												<option value="20" selected="">20개씩</option>
												<option value="40">40개씩</option>
												<option value="60">60개씩</option>
											</select>
										</p>
										<p>
											<select class="changeListType">
												<option value="detail" selected="">자세히보기</option>
												<option value="simple">간단히보기</option>
											</select>
										</p>
										<p class="t_11gr">
											<input type="checkbox" name="prodStat" value="Y" class="chk"
												id="prodStat"> 품절/절판제외
										</p>
									</div>
								</div>

								<h4>

									<span><strong>전체</strong>에 총 <strong>5,314</strong> 권의
										정가인하 도서가 등록되어 있습니다. </span>



								</h4>
								<p class="btn_cart">
									<span><input type="checkbox" name="prodIds" class="chk"
										onclick="javascript:check_all(document.getElementsByName('prodId'), this.checked);">
										전체</span> <a href="javascript:addCarts();"><span
										class="btn_w_comm btype_a2">쇼핑카트</span></a> <a
										href="javascript:addWishes();"><span
										class="btn_w_comm btype_a2">위시리스트</span></a>
								</p>
							</div>
							<div class="fl_clear ml5">
								<div class="prod_list_type  ">

									<ul>

										<!-- 리스트 1개 시작  -->
										<li><input class="checkbox" type="checkbox"
											value="3795041" name="prodId">
											<div class="prod_thumb">
												<div class="prod_thumb_img">
													<a href="/front/product/detailProduct.do?prodId=3795041"
														onfocus="this.blur();"> <img
														src="http://image.bandinlunis.com/upload/product/3795/3795041.jpg"
														onerror="this.src='/images/common/noimg_type01.gif';">

													</a> <a class="btn_popup" target="_blank"
														href="/front/product/detailProduct.do?prodId=3795041"><span
														class="ico_new">새창열기</span></a>
												</div>

											</div>
											<dl class="prod_info">
												<dt>
													<a href="/front/product/detailProduct.do?prodId=3795041"
														onfocus="this.blur();"> [정가인하] 한국사를 바꿀 14가지 거짓과 진실 </a>
													<!-- <span class="tit_sub">- 덧셈구구</span> -->
													<span class="tag_area"> <span class="tag_best"><span>베스트</span></span>


													</span>
												</dt>
												<dd class="txt_block">
													<span>KBS역사추적팀, 윤영수</span> <span class="gap">|</span> <span>지식파수꾼</span>
													<span class="txt_date"><span class="gap">|</span> <span>2011.05.11</span></span>
												</dd>


												<dd class="mt5">
													<p>
														<span class="txt_junga">정가 <span class="txt_junga">13,000원</span></span><span
															class="txt_arrow">→</span> <span class="txt_reprice2">4,000원
															[<strong>69%</strong> 정가인하]
														</span>
													</p>
													<p class="mt5">
														<span class="txt_price"><strong><em>3,600</em>원</strong>
															(10%↓+5%P)</span>
													</p>
												</dd>
												<dd class="txt_desc">
													<div class="review_point">
														<span style="width: 80.50%"></span>
													</div>
													<span class="ratings_num"> <strong>8.05</strong> <a
														href="/front/product/detailProduct.do?prodId=3795041#sub10"
														target="_blank">리뷰<em>(19)</em></a>
													</span>
												</dd>
												<dd class="txt_bex">추적과 추리의 역사 장금이는 요리사였을까? 정말 계백장군은
													위대했고, 의자왕은 무기력했을까? KBS 역사추적은 ‘과연?’이라는 물음에서 시작된다. 전혀 관계없을 것
													같던 흉노와 신...</dd>
												<dd class="txt_ebook">
													<span>지금 주문하면<strong class="t_red">2018년
															10월 20일(토) 이내</strong>받을 수 있습니다.
													</span>
												</dd>

											</dl>
											<dl class="prod_btn">
												<dt>
													<span class="num_txt">수량</span> <input type="text"
														id="cntVal_3795041" value="1" class="num" size="3"
														maxlength="2" onkeydown="onlyNumber();" onkeyup="">
													<span class="btn_updn_wrap"><a
														href="javascript:cntUp('3795041','01');"
														class="btn_num_up">▲</a><a
														href="javascript:cntDown('3795041','01');"
														class="btn_num_dn">▼</a></span>
												</dt>



												<dd>
													<a href="javascript:addCart('3795041');"><span
														class="btn_b_comm btype_f1">쇼핑카트</span></a>
												</dd>
												<dd class="mt3">
													<a href="javascript:goOrder('3795041');"><span
														class="btn_w_comm btype_f1">바로구매</span></a>
												</dd>




												<dd class="mt3">
													<a
														href="javascript:add_wish_array_common('3795041', true);"><span
														class="btn_w_comm btype_f1">위시리스트</span></a>
												</dd>
											</dl></li>
										<!-- 리스트 1개 끝  -->


										<!-- 리스트 2번째 시작  -->
										<li><input class="checkbox" type="checkbox"
											value="3795041" name="prodId">
											<div class="prod_thumb">
												<div class="prod_thumb_img">
													<a href="/front/product/detailProduct.do?prodId=3795041"
														onfocus="this.blur();"> <img
														src="http://image.bandinlunis.com/upload/product/3795/3795041.jpg"
														onerror="this.src='/images/common/noimg_type01.gif';">

													</a> <a class="btn_popup" target="_blank"
														href="/front/product/detailProduct.do?prodId=3795041"><span
														class="ico_new">새창열기</span></a>
												</div>

											</div>
											<dl class="prod_info">
												<dt>
													<a href="/front/product/detailProduct.do?prodId=3795041"
														onfocus="this.blur();"> [정가인하] 한국사를 바꿀 14가지 거짓과 진실 </a>
													<!-- <span class="tit_sub">- 덧셈구구</span> -->
													<span class="tag_area"> <span class="tag_best"><span>베스트</span></span>


													</span>
												</dt>
												<dd class="txt_block">
													<span>KBS역사추적팀, 윤영수</span> <span class="gap">|</span> <span>지식파수꾼</span>
													<span class="txt_date"><span class="gap">|</span> <span>2011.05.11</span></span>
												</dd>


												<dd class="mt5">
													<p>
														<span class="txt_junga">정가 <span class="txt_junga">13,000원</span></span><span
															class="txt_arrow">→</span> <span class="txt_reprice2">4,000원
															[<strong>69%</strong> 정가인하]
														</span>
													</p>
													<p class="mt5">
														<span class="txt_price"><strong><em>3,600</em>원</strong>
															(10%↓+5%P)</span>
													</p>
												</dd>
												<dd class="txt_desc">
													<div class="review_point">
														<span style="width: 80.50%"></span>
													</div>
													<span class="ratings_num"> <strong>8.05</strong> <a
														href="/front/product/detailProduct.do?prodId=3795041#sub10"
														target="_blank">리뷰<em>(19)</em></a>
													</span>
												</dd>
												<dd class="txt_bex">추적과 추리의 역사 장금이는 요리사였을까? 정말 계백장군은
													위대했고, 의자왕은 무기력했을까? KBS 역사추적은 ‘과연?’이라는 물음에서 시작된다. 전혀 관계없을 것
													같던 흉노와 신...</dd>
												<dd class="txt_ebook">
													<span>지금 주문하면<strong class="t_red">2018년
															10월 20일(토) 이내</strong>받을 수 있습니다.
													</span>
												</dd>

											</dl>
											<dl class="prod_btn">
												<dt>
													<span class="num_txt">수량</span> <input type="text"
														id="cntVal_3795041" value="1" class="num" size="3"
														maxlength="2" onkeydown="onlyNumber();" onkeyup="">
													<span class="btn_updn_wrap"><a
														href="javascript:cntUp('3795041','01');"
														class="btn_num_up">▲</a><a
														href="javascript:cntDown('3795041','01');"
														class="btn_num_dn">▼</a></span>
												</dt>



												<dd>
													<a href="javascript:addCart('3795041');"><span
														class="btn_b_comm btype_f1">쇼핑카트</span></a>
												</dd>
												<dd class="mt3">
													<a href="javascript:goOrder('3795041');"><span
														class="btn_w_comm btype_f1">바로구매</span></a>
												</dd>




												<dd class="mt3">
													<a
														href="javascript:add_wish_array_common('3795041', true);"><span
														class="btn_w_comm btype_f1">위시리스트</span></a>
												</dd>
											</dl></li>
										<!-- 리스트 2번째 끝  -->


										<!-- 리스트 3번째 시작  -->
										<li><input class="checkbox" type="checkbox"
											value="3795041" name="prodId">
											<div class="prod_thumb">
												<div class="prod_thumb_img">
													<a href="/front/product/detailProduct.do?prodId=3795041"
														onfocus="this.blur();"> <img
														src="http://image.bandinlunis.com/upload/product/3795/3795041.jpg"
														onerror="this.src='/images/common/noimg_type01.gif';">

													</a> <a class="btn_popup" target="_blank"
														href="/front/product/detailProduct.do?prodId=3795041"><span
														class="ico_new">새창열기</span></a>
												</div>

											</div>
											<dl class="prod_info">
												<dt>
													<a href="/front/product/detailProduct.do?prodId=3795041"
														onfocus="this.blur();"> [정가인하] 한국사를 바꿀 14가지 거짓과 진실 </a>
													<!-- <span class="tit_sub">- 덧셈구구</span> -->
													<span class="tag_area"> <span class="tag_best"><span>베스트</span></span>


													</span>
												</dt>
												<dd class="txt_block">
													<span>KBS역사추적팀, 윤영수</span> <span class="gap">|</span> <span>지식파수꾼</span>
													<span class="txt_date"><span class="gap">|</span> <span>2011.05.11</span></span>
												</dd>


												<dd class="mt5">
													<p>
														<span class="txt_junga">정가 <span class="txt_junga">13,000원</span></span><span
															class="txt_arrow">→</span> <span class="txt_reprice2">4,000원
															[<strong>69%</strong> 정가인하]
														</span>
													</p>
													<p class="mt5">
														<span class="txt_price"><strong><em>3,600</em>원</strong>
															(10%↓+5%P)</span>
													</p>
												</dd>
												<dd class="txt_desc">
													<div class="review_point">
														<span style="width: 80.50%"></span>
													</div>
													<span class="ratings_num"> <strong>8.05</strong> <a
														href="/front/product/detailProduct.do?prodId=3795041#sub10"
														target="_blank">리뷰<em>(19)</em></a>
													</span>
												</dd>
												<dd class="txt_bex">추적과 추리의 역사 장금이는 요리사였을까? 정말 계백장군은
													위대했고, 의자왕은 무기력했을까? KBS 역사추적은 ‘과연?’이라는 물음에서 시작된다. 전혀 관계없을 것
													같던 흉노와 신...</dd>
												<dd class="txt_ebook">
													<span>지금 주문하면<strong class="t_red">2018년
															10월 20일(토) 이내</strong>받을 수 있습니다.
													</span>
												</dd>

											</dl>
											<dl class="prod_btn">
												<dt>
													<span class="num_txt">수량</span> <input type="text"
														id="cntVal_3795041" value="1" class="num" size="3"
														maxlength="2" onkeydown="onlyNumber();" onkeyup="">
													<span class="btn_updn_wrap"><a
														href="javascript:cntUp('3795041','01');"
														class="btn_num_up">▲</a><a
														href="javascript:cntDown('3795041','01');"
														class="btn_num_dn">▼</a></span>
												</dt>



												<dd>
													<a href="javascript:addCart('3795041');"><span
														class="btn_b_comm btype_f1">쇼핑카트</span></a>
												</dd>
												<dd class="mt3">
													<a href="javascript:goOrder('3795041');"><span
														class="btn_w_comm btype_f1">바로구매</span></a>
												</dd>




												<dd class="mt3">
													<a
														href="javascript:add_wish_array_common('3795041', true);"><span
														class="btn_w_comm btype_f1">위시리스트</span></a>
												</dd>
											</dl></li>
										<!-- 리스트 3번째 끝  -->


									</ul>

								</div>

							</div>
							<!-- 베스트셀러 끝 -->

							<!-- 페이징 -->
							<div class="pageTypeA">
								<span class="prev-btn"> <!-- <img src="/images/common/btn_pagePrevG.gif" align="absmiddle" border="0"> -->

									<!-- <img src="/images/common/btn_pagePrev.gif" align="absmiddle" hspace="2" border="0"> -->
								</span> <span class="pageNum"> <a class="on">1</a> <a
									href="/front/display/discountBookList.do?page=2#tabMenu">2</a>
									<a href="/front/display/discountBookList.do?page=3#tabMenu">3</a>
									<a href="/front/display/discountBookList.do?page=4#tabMenu">4</a>
									<a href="/front/display/discountBookList.do?page=5#tabMenu">5</a>
									<a href="/front/display/discountBookList.do?page=6#tabMenu">6</a>
									<a href="/front/display/discountBookList.do?page=7#tabMenu">7</a>
									<a href="/front/display/discountBookList.do?page=8#tabMenu">8</a>
									<a href="/front/display/discountBookList.do?page=9#tabMenu">9</a>
									<a href="/front/display/discountBookList.do?page=10#tabMenu">10</a>
								</span> <span class="next-btn"> <a
									href="/front/display/discountBookList.do?page=11#tabMenu"><img
										src="/images/common/btn_pageNext.gif" align="absmiddle"
										hspace="2" border="0"></a>

								</span>

							</div>

							<div class="prod_sort_b">
								<span><input type="checkbox" name="prodIds" class="chk"
									onclick="javascript:check_all(document.getElementsByName('prodId'), this.checked);">
									전체</span> <a href="javascript:addCarts();"><span
									class="btn_w_comm btype_a2">쇼핑카트</span></a> <a
									href="javascript:addWishes();"><span
									class="btn_w_comm btype_a2">위시리스트</span></a>
							</div>

						</div>

					</div>
					<!-- 새로나온 책 끝  -->


					<!-- 정가인하 시작 -->
					<div id="menu_discount" class="tab-pane fade">
						<div class="con_t2">

							<div class="prod_sort">
								<div class="sorting">
									<input type="hidden" name="sorts" value="">
									<ul class="con01">
										<li><a id="sort1" style="cursor: pointer;" class="on">판매량순</a></li>
										<li><a id="sort2" style="cursor: pointer;">발행일순</a></li>
										<li><a id="sort12" style="cursor: pointer;">등록일순</a></li>
										<li><a id="sort6" style="cursor: pointer;">상품명순</a></li>
										<li><a id="sort11" style="cursor: pointer;">정가인하순</a></li>
										<li class="alt"><a id="sort10" style="cursor: pointer;">가격순</a></li>
									</ul>
									<div class="con02">
										<p>
											<select class="changeListSize">
												<option value="20" selected="">20개씩</option>
												<option value="40">40개씩</option>
												<option value="60">60개씩</option>
											</select>
										</p>
										<p>
											<select class="changeListType">
												<option value="detail" selected="">자세히보기</option>
												<option value="simple">간단히보기</option>
											</select>
										</p>
										<p class="t_11gr">
											<input type="checkbox" name="prodStat" value="Y" class="chk"
												id="prodStat"> 품절/절판제외
										</p>
									</div>
								</div>

								<h4>

									<span><strong>전체</strong>에 총 <strong>5,314</strong> 권의
										정가인하 도서가 등록되어 있습니다. </span>



								</h4>
								<p class="btn_cart">
									<span><input type="checkbox" name="prodIds" class="chk"
										onclick="javascript:check_all(document.getElementsByName('prodId'), this.checked);">
										전체</span> <a href="javascript:addCarts();"><span
										class="btn_w_comm btype_a2">쇼핑카트</span></a> <a
										href="javascript:addWishes();"><span
										class="btn_w_comm btype_a2">위시리스트</span></a>
								</p>
							</div>
							<div class="fl_clear ml5">
								<div class="prod_list_type  ">

									<ul>

										<!-- 리스트 1개 시작  -->
										<li><input class="checkbox" type="checkbox"
											value="3795041" name="prodId">
											<div class="prod_thumb">
												<div class="prod_thumb_img">
													<a href="/front/product/detailProduct.do?prodId=3795041"
														onfocus="this.blur();"> <img
														src="http://image.bandinlunis.com/upload/product/3795/3795041.jpg"
														onerror="this.src='/images/common/noimg_type01.gif';">

													</a> <a class="btn_popup" target="_blank"
														href="/front/product/detailProduct.do?prodId=3795041"><span
														class="ico_new">새창열기</span></a>
												</div>

											</div>
											<dl class="prod_info">
												<dt>
													<a href="/front/product/detailProduct.do?prodId=3795041"
														onfocus="this.blur();"> [정가인하] 한국사를 바꿀 14가지 거짓과 진실 </a>
													<!-- <span class="tit_sub">- 덧셈구구</span> -->
													<span class="tag_area"> <span class="tag_best"><span>베스트</span></span>


													</span>
												</dt>
												<dd class="txt_block">
													<span>KBS역사추적팀, 윤영수</span> <span class="gap">|</span> <span>지식파수꾼</span>
													<span class="txt_date"><span class="gap">|</span> <span>2011.05.11</span></span>
												</dd>


												<dd class="mt5">
													<p>
														<span class="txt_junga">정가 <span class="txt_junga">13,000원</span></span><span
															class="txt_arrow">→</span> <span class="txt_reprice2">4,000원
															[<strong>69%</strong> 정가인하]
														</span>
													</p>
													<p class="mt5">
														<span class="txt_price"><strong><em>3,600</em>원</strong>
															(10%↓+5%P)</span>
													</p>
												</dd>
												<dd class="txt_desc">
													<div class="review_point">
														<span style="width: 80.50%"></span>
													</div>
													<span class="ratings_num"> <strong>8.05</strong> <a
														href="/front/product/detailProduct.do?prodId=3795041#sub10"
														target="_blank">리뷰<em>(19)</em></a>
													</span>
												</dd>
												<dd class="txt_bex">추적과 추리의 역사 장금이는 요리사였을까? 정말 계백장군은
													위대했고, 의자왕은 무기력했을까? KBS 역사추적은 ‘과연?’이라는 물음에서 시작된다. 전혀 관계없을 것
													같던 흉노와 신...</dd>
												<dd class="txt_ebook">
													<span>지금 주문하면<strong class="t_red">2018년
															10월 20일(토) 이내</strong>받을 수 있습니다.
													</span>
												</dd>

											</dl>
											<dl class="prod_btn">
												<dt>
													<span class="num_txt">수량</span> <input type="text"
														id="cntVal_3795041" value="1" class="num" size="3"
														maxlength="2" onkeydown="onlyNumber();" onkeyup="">
													<span class="btn_updn_wrap"><a
														href="javascript:cntUp('3795041','01');"
														class="btn_num_up">▲</a><a
														href="javascript:cntDown('3795041','01');"
														class="btn_num_dn">▼</a></span>
												</dt>



												<dd>
													<a href="javascript:addCart('3795041');"><span
														class="btn_b_comm btype_f1">쇼핑카트</span></a>
												</dd>
												<dd class="mt3">
													<a href="javascript:goOrder('3795041');"><span
														class="btn_w_comm btype_f1">바로구매</span></a>
												</dd>




												<dd class="mt3">
													<a
														href="javascript:add_wish_array_common('3795041', true);"><span
														class="btn_w_comm btype_f1">위시리스트</span></a>
												</dd>
											</dl></li>
										<!-- 리스트 1개 끝  -->

									</ul>

								</div>

							</div>
							<!-- 베스트셀러 끝 -->

							<!-- 페이징 -->
							<div class="pageTypeA">
								<span class="prev-btn"> <!-- <img src="/images/common/btn_pagePrevG.gif" align="absmiddle" border="0"> -->

									<!-- <img src="/images/common/btn_pagePrev.gif" align="absmiddle" hspace="2" border="0"> -->
								</span> <span class="pageNum"> <a class="on">1</a> <a
									href="/front/display/discountBookList.do?page=2#tabMenu">2</a>
									<a href="/front/display/discountBookList.do?page=3#tabMenu">3</a>
									<a href="/front/display/discountBookList.do?page=4#tabMenu">4</a>
									<a href="/front/display/discountBookList.do?page=5#tabMenu">5</a>
									<a href="/front/display/discountBookList.do?page=6#tabMenu">6</a>
									<a href="/front/display/discountBookList.do?page=7#tabMenu">7</a>
									<a href="/front/display/discountBookList.do?page=8#tabMenu">8</a>
									<a href="/front/display/discountBookList.do?page=9#tabMenu">9</a>
									<a href="/front/display/discountBookList.do?page=10#tabMenu">10</a>
								</span> <span class="next-btn"> <a
									href="/front/display/discountBookList.do?page=11#tabMenu"><img
										src="/images/common/btn_pageNext.gif" align="absmiddle"
										hspace="2" border="0"></a>

								</span>

							</div>

							<div class="prod_sort_b">
								<span><input type="checkbox" name="prodIds" class="chk"
									onclick="javascript:check_all(document.getElementsByName('prodId'), this.checked);">
									전체</span> <a href="javascript:addCarts();"><span
									class="btn_w_comm btype_a2">쇼핑카트</span></a> <a
									href="javascript:addWishes();"><span
									class="btn_w_comm btype_a2">위시리스트</span></a>
							</div>

						</div>

					</div>
					<!-- 정가인하 끝 -->



				</div>
				<!-- Dynamic Tabs Div -->

			</div>

		</div>
		<!-- 가운데 레이아웃 -->
	</div>

	<!-- footer -->
	<jsp:include page="../../../common/footer.jsp" flush="false" />
</body>
</html>