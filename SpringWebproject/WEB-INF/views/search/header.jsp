<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
    $("#hide").click(function(){
        $("p").hide();
    });
    $("#show").click(function(){
        $("p").show();
    });
});
</script>
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
		var con = document.getElementById("top_layer" + num);
		if (con.style.display == 'none') {
			con.style.display = 'block';
		} else {
			con.style.display = 'none';
		}
	}

	var newURL = window.location.pathname;
	if (newURL == '/webproject/main.action') {
		scrollHeight = 924;
	} else {
		scrollHeight = 500;
	}

	$(function() {
		$(window).scroll(function() {
			if ($(this).scrollTop() > 450) {
				$('.top_btn').show();
			} else {
				$('.top_btn').hide();
			}

			if ($(this).scrollTop() > scrollHeight) {
				$('#side_service').addClass('ss_fixed');
			} else {
				$('#side_service').removeClass('ss_fixed');
			}
		});

		$("#onTop").click(function() {
			$('html, body').animate({
				scrollTop : 0
			}, 350);
		});
	});
</script>




<link rel="stylesheet" href="<%=cp%>/resources/css/swiper_min.css">
<link rel="stylesheet" href="<%=cp%>/resources/css/main2.css"
	type="text/css">

<script src="<%=cp%>/resources/js/swiper_min.js"></script>

<body>
	<div id="onTop" class="top_btn">
		<a href="javascript://"> <img
			src="<%=cp%>/resources/image/main/btn_top.png">
		</a>
	</div>
	<div class="side_banner" style="top: 200px;">
		<div>
			<a href="javascript://"> <img
				src="<%=cp%>/resources/image/main/side_banner01.jpg">
			</a>
		</div>
		<div>
			<a href="javascript://"> <img
				src="<%=cp%>/resources/image/main/side_banner02.jpg">
			</a>
		</div>
	</div>
	<div id="side_service" style="top: 554px;">
		<div class="today_view">
			<h4>최근 본 상품</h4>
			<div class="swiper-container side_swiper">
				<div class="swiper-wrapper">
					<ul class="swiper-slide">
						<li class="tv_item"><a href="javascript://"> <img src="">
						</a></li>
						<li class="tv_item"><a href="javascript://"> <img src="">
						</a></li>
					</ul>
					<ul class="swiper-slide">
						<li class="tv_item"><a href="javascript://"> <img src="">
						</a></li>
						<li class="tv_item"><a href="javascript://"> <img src="">
						</a></li>
					</ul>
				</div>
			</div>
			<div class="aw_box_tv">
				<button class="tv_aw left" id="tv_awl"></button>
				<span class="tv_aw_count"></span>
				<button class="tv_aw right" id="tv_awr"></button>
			</div>
		</div>
		<div class="ss_myshop">
			<a href="javascript://"> 나의 쇼핑 </a>
		</div>
		<div class="ss_myshop">
			<a href="javascript://"> 위시리스트 </a>
		</div>
		<div class="ss_myshop">
			<a href="javascript://"> 구매히스토리 </a>
		</div>
	</div>
	<div id="head">
		<div id="top_wrap">
			<div class="head_top">
				<h1 class="logo">
					<a href="<%=cp%>/main.action"> <img alt=""
						src="<%=cp%>/resources/image/main/logo_2014_top.gif">
					</a>
				</h1>
				
				<div class="top_menu">
						<ul class="t_menu_list">
							<c:if test="${empty sessionScope.userInfo.userId }">
								<li class="t_menu login"><a href="<%=cp%>/login.action"
									class="t_menu_link btn_login">로그인</a></li>
								<li class="t_menu join"><a
									href="<%=cp%>/login/mem_agree.action" class="t_menu_link">회원가입</a>
								</li>
							</c:if>
							<c:if test="${!empty sessionScope.userInfo.userId }">
								<li class="t_menu logout"><a href="<%=cp%>/logout.action"
									class="t_menu_link btn_logout">로그아웃</a></li>
							</c:if>
							<li class="t_menu"><a href="javascript://"
								class="t_menu_link">쇼핑카트</a></li>
							<li class="t_menu myShopping"><a
								href="<%=cp%>/myShoppingMain.action" class="t_menu_link"
								onmouseover="javascript:toggleDisplay2('01')"
								onmouseout="javascript:toggleDisplay2('01')"> 나의쇼핑</a>
								<div id="top_layer01" class="display_top"
									style="display: none; width: 90px;"
									onmouseover="javascript:toggleDisplay2('01')"
									onmouseout="javascript:toggleDisplay2('01')">
									<div style="margin-top: 5px;">
										<a href="<%=cp%>/myShoppingMain.action">나의쇼핑정보</a>
									</div>
									<div>
										<a href="javascript://">주문배송조회</a>
									</div>
									<div>
										<a href="javascript://">적립내역</a>
									</div>
									<div>
										<a href="javascript://">구매히스토리</a>
									</div>
									<div>
										<a href="javascript://">위시리스트</a>
									</div>
									<div>
										<a href="javascript://">회원정보</a>
									</div>
								</div></li>
							<li class="t_menu"><a href="javascript://"
								class="t_menu_link">고객센터</a></li>
							<li class="t_menu store"><a href="javascript://"
								class="t_menu_link"
								onmouseover="javascript:toggleDisplay2('02')"
								onmouseout="javascript:toggleDisplay2('02')"> 영업점안내</a>
								<div id="top_layer02" class="display_top"
									style="display: none; width: 130px;"
									onmouseover="javascript:toggleDisplay2('02')"
									onmouseout="javascript:toggleDisplay2('02')">
									<div style="margin-top: 5px;">
										<a href="javascript://">신세계강남점</a>
									</div>
									<div>
										<a href="javascript://">신세계센텀시티점(부산)</a>
									</div>
									<div>
										<a href="javascript://">롯데월드몰점</a>
									</div>
									<div>
										<a href="javascript://">여의도신영증권점</a>
									</div>
									<div>
										<a href="javascript://">대구신세계점</a>
									</div>
									<div>
										<a href="javascript://">롯데몰수원점</a>
									</div>
									<div>
										<a href="javascript://">신세계김해점</a>
									</div>
									<div>
										<a href="javascript://">롯데스타시티점</a>
									</div>
									<div>
										<a href="javascript://">신림역점</a>
									</div>
									<div>
										<a href="javascript://">사당역점</a>
									</div>
									<div>
										<a href="javascript://">목동점</a>
									</div>
									<div>
										<a href="javascript://">롯데피트인산본점</a>
									</div>
									<div>
										<a href="javascript://">롯데울산점</a>
									</div>
								</div></li>
						</ul>
					</div>
				
				<!-- 검색 -->
				<div class="wrap_search">
					<form id="searchForm" action="/webproject/search/search.do"
						method="post">
						<fieldset>
							<legend>검색</legend>
							<div class="bbox">
								<div class="window_wrap">
									<input type="hidden" id="ad_url" value="http://www.bandinlunis.com/front/product/detailProduct.do?prodId=4202976">
									<input type="text" title="검색" id="sch_keyword" name="searchValue" maxlength="255" class="box_window"
										accesskey="s" autocomplete="off" value="" style="ime-mode: active;"> 
										<span class="auto_word">										
										<a href="javascript://;"><span>▼</span></a>
										</span>
								</div>
							</div>

							<button id="header_search_btn" type="submit" class="btn_search">
								<span class="ir_wa">검색</span>
							</button>

							<input type="hidden" name="v" id="frm_v" value=""> <input
								type="hidden" name="s" id="frm_s" value=""> <input
								type="hidden" name="l" id="frm_l" value="20"> <input
								type="hidden" name="o" id="frm_o" value="0"> <input
								type="hidden" name="ps" id="frm_ps" value=""> <input
								type="hidden" name="pt" id="frm_pt" value=""> <input
								type="hidden" name="ct" id="frm_ct" value=""> <input
								type="hidden" name="dt" id="frm_dt" value=""> <input
								type="hidden" name="pq" id="frm_pq" value=""> <input
								type="hidden" name="sp1" id="frm_sp1" value="0"> <input
								type="hidden" name="sp2" id="frm_sp2" value="12"> <input
								type="hidden" name="sp3" id="frm_sp3" value="-1"> <input
								type="hidden" name="sp4" id="frm_sp4" value="7">
						</fieldset>

					</form>
						
					
					
					
					<hr>
					<!-- 검색 -->

					
				</div>
			</div>

			<div class="wrap_header">
				<div class="header_menu">
					<ul class="menu_wrap">
						<li class="menu"><a href="javascript://"
							class="menu_link menu_total"
							onmouseover="javascript:toggleDisplay('01')"
							onmouseout="javascript:toggleDisplay('01')"> <%-- <img alt="" src="<%=cp%>/resources/image/sp_gnb_menu1.png"> --%>
								<span></span>
						</a>

							<div id="layer01" class="display_wrap display_total"
								style="display: none;"
								onmouseover="javascript:toggleDisplay('01')"
								onmouseout="javascript:toggleDisplay('01')">
								<div class="cate01">
									<h3>
										<a href="<%=cp%>/main.action">도서</a>
									</h3>
									<ul class="cate_list">
										<li><em>소설</em></li>
										<li><em>장르소설</em></li>
										<li>시/에세이/기행</li>
										<li>청소년교양</li>
										<li>경제/경영</li>
										<li><em>자기계발</em></li>
									</ul>

									<ul class="cate_list">
										<li>유아</li>
										<li>육아/자녀교육</li>
										<li>어린이</li>
										<li>어린이영어</li>
										<li>아동전집</li>
										<li>정가제 Free</li>
									</ul>

									<ul class="cate_list">
										<li>가정/생활/요리</li>
										<li>건강/의학/미용</li>
										<li>여행/취미/레저</li>
										<li>잡기</li>
										<li>만화</li>
									</ul>

									<ul class="cate_list clear">
										<li><em>인문/교양/철학</em></li>
										<li>역사/신화/문화</li>
										<li>종교</li>
										<li>사회/정치/법률</li>
										<li>예술/대중문화</li>
										<li>자연과학/공학</li>
									</ul>

									<ul class="cate_list">
										<li><em>초등참고서</em></li>
										<li><em>중/고등참고서</em></li>
										<li>&nbsp;</li>
										<li><em>외국어/사전</em></li>
										<li>대학교재</li>
										<li>컴퓨터/IT</li>
									</ul>

									<ul class="cate_list">
										<li>서양서</li>
										<li>일본서</li>
									</ul>
								</div>
								<div class="cate02">
									<h3>
										<a href="<%=cp%>/main.action">키즈샵</a>
									</h3>
									<ul class="cate_list">
										<li><em>유아</em></li>
										<li>어린이</li>
										<li>유아동전집</li>
									</ul>

									<ul class="cate_list">
										<li>유아/자녀교육</li>
										<li>임신/출산/태교</li>
										<li>교구완구</li>
									</ul>

									<ul class="cate_list">
										<li><em>초등참고서</em></li>
										<li>어린이 영어</li>
										<li>교구완구</li>
									</ul>
								</div>
								<div class="cate03">
									<h3>
										<a href="<%=cp%>/main.action">수험서</a>
									</h3>
									<ul class="cate_list">
										<li>공무원</li>
										<li>국가고시</li>
										<li>임용시험</li>
										<li>대기업/공기업/면접</li>
										<li>대표저자수험서</li>
									</ul>

									<ul class="cate_list">
										<li>국가기술자격증</li>
										<li>국가전문자격증</li>
										<li>민간전문자격증</li>
										<li>외국자격증</li>
									</ul>

									<ul class="cate_list">
										<li>편입/진학/전문대학원</li>
										<li>공부법/안내서</li>
									</ul>
								</div>
								<span></span>
							</div></li>

						<li class="menu"><a href="javascript://"
							class="menu_link menu_book"
							onmouseover="javascript:toggleDisplay('02')"
							onmouseout="javascript:toggleDisplay('02')"> <span></span>
						</a>

							<div id="layer02" class="display_wrap display_book"
								style="display: none;"
								onmouseover="javascript:toggleDisplay('02')"
								onmouseout="javascript:toggleDisplay('02')">
								<div class="cate_book01">
									<h3>
										<a href="<%=cp%>/main.action">도서</a>
									</h3>
									<div class="cate_menu">
										<ul>
											<li>베스트셀러</li>
											<li>새로나온 책</li>
											<li>주간 탑클릭</li>
											<li>정가인하도서</li>
											<li>오늘의 책</li>
											<li>이달의 추천책</li>
											<li>미디어 추천책</li>
											<li class="gap">작가 프로필</li>
											<li>이벤트</li>
											<li class="gap">북셀프안내</li>
											<li>대량주문 안내</li>
											<li>반디e캐쉬안내</li>
										</ul>
									</div>
									<div class="cate_list_wrap">
										<ul class="cate_list">
											<li><em>소설</em></li>
											<li><em>장르소설</em></li>
											<li><em>시/에세이/기행</em></li>
											<li>청소년교양</li>
											<li>경제/경영</li>
											<li><em>자기계발</em></li>
										</ul>
										<ul class="cate_list">
											<li>유아</li>
											<li>육아/자녀교육</li>
											<li><em>어린이</em></li>
											<li>어린이영어</li>
											<li>아동전집</li>
											<li>정가제 Free</li>
										</ul>
										<ul class="cate_list">
											<li>가정/생활/요리</li>
											<li>건강/의학/미용</li>
											<li>여행/취미/레저</li>
											<li>잡지</li>
											<li>만화</li>
										</ul>
										<ul class="cate_list clear">
											<li><em>인문/교양/철학</em></li>
											<li>역사/신화/문화</li>
											<li>종교</li>
											<li>사회/정치/법률</li>
											<li>예술/대중문화</li>
											<li>자연과학/공학</li>
										</ul>
										<ul class="cate_list">
											<li><em>초등참고서</em></li>
											<li><em>중/고등참고서</em></li>
											<li>&nbsp;</li>
											<li><em>외국어/사전</em></li>
											<li>대학교재</li>
											<li>컴퓨터/IT</li>
										</ul>
										<ul class="cate_list">
											<li>서양서</li>
											<li>일본서</li>
										</ul>
									</div>
								</div>
								<div class="cate_book02">
									<h3>
										<a href="<%=cp%>/main.action">수험서</a>
									</h3>
									<div class="cate_list_wrap cate_exam">
										<ul class="cate_list exam">
											<li><em>공무원</em></li>
											<li>국가고시</li>
											<li>임용시험</li>
											<li><em>대기업/공기업/면접</em></li>
											<li>대표저자수험서</li>
										</ul>
										<ul class="cate_list">
											<li>국가기술자격증</li>
											<li>국가전문자격증</li>
											<li>민간전문자격증</li>
											<li>외국자격증</li>
										</ul>
										<ul class="cate_list exam clear">
											<li>편입/진학/전문대학원</li>
											<li>공부법/안내서</li>
										</ul>
									</div>
								</div>
								<span></span>
							</div></li>
						<li class="menu"><a href="javascript://"
							class="menu_link menu_best"> <span></span>
						</a></li>
						<li class="menu"><a href="javascript://"
							class="menu_link menu_new"> <span></span>
						</a></li>
						<li class="menu"><a href="javascript://"
							class="menu_link menu_sale"> <span></span>
						</a></li>
					</ul>
				</div>
			</div>
		</div>
			
	</div>


	<script src="<%=cp%>/resources/js/swiper_min.js"></script>
	<script src="<%=cp%>/resources/js/main.js"></script>

</body>


