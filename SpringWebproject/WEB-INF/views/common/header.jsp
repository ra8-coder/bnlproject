<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

	$(document).ready(function(){
	    $("#hide").click(function(){
	        $("p").hide();
	    });
	    $("#show").click(function(){
	        $("p").show();
	    });
	});

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
		scrollHeight = 540;
	}

	$(function() {
		//탑버튼 표시
		$(window).scroll(function() {
			if ($(this).scrollTop() > 450) {
				$('.top_btn').show();
			} else {
				$('.top_btn').hide();
			}
			//스크롤시 사이드 배너 고정
			if ($(this).scrollTop() > scrollHeight) {
				$('#side_service').addClass('ss_fixed');
			} else {
				$('#side_service').removeClass('ss_fixed');
			}
		});
		//탑버튼 클릭시 위로 이동
		$("#onTop").click(function() {
			$('html, body').animate({scrollTop : 0}, 350);
		});
		
		if(${empty sessionScope.userInfo.userId}){
	   			
   			//최근본 상품 사이드배너에 표시(비로그인)
   			var sck = cookieInfo(getCookie('rcbook'));
   			var sData = document.getElementById("side_today_view");
   			var sNoData = document.getElementById("side_today_nodata");
   			
   			todaySView(sck);

   	   		if(sck!=null){
   	   			sNoData.style.display = 'none';
   	   			sData.style.display = 'block';
   			}else if(sck==null){
   				sNoData.style.display = 'block';
   				sData.style.display = 'none';
   			}
   					
   		}else if(${!empty sessionScope.userInfo.userId}){
   			//로그인시
   			todaySViewL();
   		}
	});
	
	//로그인시 오늘 본 상품
	function todaySViewL() {
		
		var url = "<%=cp%>/sidebanner.action";
		
		$.post(url,function(args){
			$("#side_today_view").html(args);
		});	
	}
	
	//오늘 본 상품
	function todaySView(ck) {
		if(ck==null){
			return;
		}else{
			var shtml= '<h4>최근 본 상품</h4>';
			shtml+= '<div class="swiper-container side_swiper">';
			shtml+= '	<ul class="swiper-wrapper">';

			for(var i=0;i<ck.length;i++){
				if(i==0||i%2==0){
					shtml+= '<li class="swiper-slide">';
				}
				shtml+= '	<div class="tv_item">';
				shtml+= '		<a href="<%=cp%>/book_info.action?isbn='+ ck[i].isbn +'">';
				shtml+= '			<img src="<%=cp%>/resources/image/book/'+ck[i].bookImage+'">';
				shtml+= '		</a>';
				shtml+= '	</div>';
				if(i==1||i%2==1){
					shtml+= '</li>';
				}	
			}		
			shtml+= '</ul></div>';
			shtml+= '<div class="aw_box_tv">';
			shtml+= '	<button class="tv_aw left" id="tv_awl"></button>';
			shtml+= '	<span class="tv_aw_count"></span>';
			shtml+= '	<button class="tv_aw right" id="tv_awr"></button>';
			shtml+= '</div>';
			
			$("#side_today_view").html(shtml);	
		}
		
		var swiper = new Swiper('.side_swiper', {
			spaceBetween: 0,
			centeredSlides: true,
			simulateTouch : false,
			loop: true,
			pagination: {
				el: '.tv_aw_count',
				type: 'fraction',
			},
			navigation: {
				nextEl: '#tv_awr',
				prevEl: '#tv_awl',
			},
		});
	}		
	
	//쿠키 가져오기
	function getCookie(cookiename){
		var cookiestring  = document.cookie;
		var cookiearray = cookiestring.split(';');
		for(var i=0; i<cookiearray.length; ++i){ 
		    if(cookiearray[i].indexOf(cookiename)!=-1){
		        var nameVal = cookiearray[i].split("=");
		        nameVal = nameVal[1].trim();
		        
		        return unescape(nameVal);
		    }else{
		    	var cookie = null;
		    } 
		}
		return cookie;
	}
 	
	//쿠키 뿌리기
	function cookieInfo(cValue) {		
 		var cookie = cValue;
 		
 		if(cookie!=null){
 			cookie = cookie.split("/");
 	 		var ck = new Array();
 	 		
 	 		for(i=0;i<cookie.length;i++){
 	 			ck[i] = JSON.parse(cookie[i]);
 	 		} 		
 	 		return ck;
 		}else{
 			return null;
 		}
	}

</script>
<link rel="shortcut icon" href="http://bandinlunis.com/favicon.ico"	type="image/x-icon">
<link rel="stylesheet" href="http://bandinlunis.com/common/css/center.css" type="text/css">
<link rel="stylesheet" href="http://bandinlunis.com/common/css/common.css?v=20180705" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resources/css/swiper_min.css">
<link rel="stylesheet" href="<%=cp%>/resources/css/main.css" type="text/css"/>

<body>
	<div id="onTop" class="top_btn">
		<a href="javascript://"> <img
			src="<%=cp%>/resources/image/main/btn_top.png">
		</a>
	</div>
	<div class="side_banner" style="top: 200px;">
		<div>
			<a href="/webproject/book_info.action?isbn=9788965706830"> <img
				src="<%=cp%>/resources/image/main/side_banner01.jpg">
			</a>
		</div>
		<div>
			<a href="<%=cp%>/book_info.action?isbn=9788984373594"> <img
				src="<%=cp%>/resources/image/main/banner20181109141235.jpg">
			</a>
		</div>
	</div>
	<div id="side_service" style="top: 554px;">
		<div class="today_view main" id="side_today_nodata" style="display: none;">
			<h4>최근 본 상품</h4>
			<div style="width: 92px;margin: 0 auto;overflow: hidden;">
				<div class="nodata">
					최근 본 상품이<br>없습니다.
				</div>
			</div>
		</div>
		<div class="today_view" id="side_today_view" style="display: block;"></div>
		<div class="ss_myshop">
			<a href="<%=cp%>/myShoppingMain.action">
				나의 쇼핑
			</a>
		</div>
		<div class="ss_myshop">
			<a href="<%=cp%>/myShopping/myWishList.action">
				위시리스트
			</a>
		</div>
		<div class="ss_myshop">
			<a href="<%=cp%>/myShopping/myReviewList.action">
				나의 리뷰
			</a>
		</div>
	</div>
	<div id="head">

		<div class="head_top">
			<h1 class="logo">
				<a href="<%=cp%>/main.action"> <img alt=""
					src="<%=cp%>/resources/image/main/logo_2014_top.gif">
				</a>
			</h1>
			<div class="top_menu">
				<ul class="t_menu_list">
					<c:if test="${empty sessionScope.userInfo.userId }">
						<li class="t_menu login">
							<a href="<%=cp%>/login.action" class="t_menu_link btn_login">로그인</a>
						</li>
						<li class="t_menu join">
							<a href="<%=cp%>/login/mem_agree.action" class="t_menu_link">회원가입</a>
						</li>
						<li class="t_menu">
							<a href="<%=cp %>/shopCartList.action" class="t_menu_link">쇼핑카트</a>
						</li>
					</c:if>
					<c:if test="${!empty sessionScope.userInfo.userId }">
						<li class="t_menu logout">
							<a href="<%=cp%>/logout.action" class="t_menu_link btn_logout">로그아웃</a>
						</li>
						<li class="t_menu join">
							<a href="<%=cp %>/shopCartList.action" class="t_menu_link">쇼핑카트</a>
						</li>
					</c:if>
					<li class="t_menu myShopping">
						<a href="<%=cp%>/myShoppingMain.action" class="t_menu_link"	
						onmouseover="javascript:toggleDisplay2('01')"
						onmouseout="javascript:toggleDisplay2('01')">나의쇼핑</a>
						<div id="top_layer01" class="display_top"
							style="display: none; width: 90px;"
							onmouseover="javascript:toggleDisplay2('01')"
							onmouseout="javascript:toggleDisplay2('01')">
							<div style="margin-top: 5px;">
								<a href="<%=cp%>/myShoppingMain.action">나의쇼핑정보</a>
							</div>
							<div>
								<a href="<%=cp %>/myShopping/myOrderList.action">주문배송조회</a>
							</div>
							<div>
								<a href="<%=cp %>/myShopping/myPointHistory.action">적립내역</a>
							</div>
							<div>
                
								<a href="<%=cp %>/myShopping/myReviewList.action">나의 리뷰</a>
                
							</div>
							<div>
								<a href="<%=cp %>/myShopping/myWishList.action">위시리스트</a>
							</div>
							<div>
								<a href="<%=cp %>/myShopping/pre_updateMyInfo.action?mode=update">회원정보</a>
							</div>
						</div></li>
					<li class="t_menu"><a href="<%=cp %>/help/helpMain.action" class="t_menu_link">고객센터</a>
					</li>
					<li class="t_menu store"><a href="<%=cp %>/store.action"
						class="t_menu_link" onmouseover="javascript:toggleDisplay2('02')"
						onmouseout="javascript:toggleDisplay2('02')"> 영업점안내</a>
						<div id="top_layer02" class="display_top"
							style="display: none; width: 130px;"
							onmouseover="javascript:toggleDisplay2('02')"
							onmouseout="javascript:toggleDisplay2('02')">
							<div style="margin-top: 5px;">
								<a href="<%=cp%>/store.action?params=1">신세계강남점</a>
							</div>
							<div>
								<a href="<%=cp%>/store.action?params=2">신세계센텀시티점(부산)</a>
							</div>
							<div>
								<a href="<%=cp%>/store.action?params=3">롯데월드몰점</a>
							</div>
							<div>
								<a href="<%=cp%>/store.action?params=4">여의도신영증권점</a>
							</div>
							<div>
								<a href="<%=cp%>/store.action?params=5">대구신세계점</a>
							</div>
							<div>
								<a href="<%=cp%>/store.action?params=6">롯데몰수원점</a>
							</div>
							<div>
								<a href="<%=cp%>/store.action?params=7">신세계김해점</a>
							</div>
							<div>
								<a href="<%=cp%>/store.action?params=8">롯데스타시티점</a>
							</div>
							<div>
								<a href="<%=cp%>/store.action?params=9">신림역점</a>
							</div>
							<div>
								<a href="<%=cp%>/store.action?params=10">사당역점</a>
							</div>
							<div>
								<a href="<%=cp%>/store.action?params=11">목동점</a>
							</div>
							<div>
								<a href="<%=cp%>/store.action?params=12">롯데피트인산본점</a>
							</div>
							<div>
								<a href="<%=cp%>/store.action?params=13">롯데울산점</a>
							</div>
						</div>
					</li>
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
			</div>
			<!-- 검색 -->

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
										<li><a href="<%=cp%>/book_novel.action">
										<em>소설</em>
										</a></li>
										<li>
										<a href="<%=cp%>/genre_fiction.action">
										<em>장르소설</em>
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=115">
										시/에세이/기행
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=175">
										청소년교양
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=197">
										경제/경영
										</a>
										</li>
										<li><a href="<%=cp%>/book_self_improvement.action">
										<em>자기계발</em>
										</a></li>
									</ul>
									<ul class="cate_list">
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=667">
										유아
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=692">
										육아/자녀교육
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=704">
										어린이
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=767">
										어린이 영어
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=774">
										아동전집
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=794">
										정가제 Free
										</a>
										</li>
									</ul>
									<ul class="cate_list">
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1275">
										가정/생활/요리
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1317">
										건강/의학/미용
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1363">
										여행/취미/레저
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1420">
										잡지
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1440">
										만화
										</a>
										</li>
									</ul>
									<ul class="cate_list clear">
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=292">
										인문/교양/철학
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=381">
										역사/신화/문화
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=431">
										종교
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=474">
										사회/정치/법률
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=528">
										예술/대중문화
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=607">
										자연과학/공학
										</a>
										</li>
									</ul>
									<ul class="cate_list">
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=798">
										초등학습
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=840">
										중/고등참고서
										</a>
										</li>
										<li>&nbsp;</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=943">
										외국어/사전
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1013">
										대학교재
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1153">
										컴퓨터/IT
										</a>
										</li>
									</ul>
									<ul class="cate_list">
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1469">
										서양서
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1487">
										일본서
										</a>
										</li>
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
										<li><a href="<%=cp%>/bnlBSList.action">베스트셀러</a></li>
										<li><a href="<%=cp%>/bnlNewBookList.action">새로나온 책</a></li>
										<li><a href="<%=cp%>/discountBookMain.action">정가인하도서</a></li>
									</ul>
								</div>
								<div class="cate_list_wrap">
									<ul class="cate_list">
										<li><a href="<%=cp%>/book_novel.action">
										<em>소설</em>
										</a></li>
										<li>
										<a href="<%=cp%>/genre_fiction.action">
										<em>장르소설</em>
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=115">
										시/에세이/기행
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=175">
										청소년교양
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=197">
										경제/경영
										</a>
										</li>
										<li><a href="<%=cp%>/book_self_improvement.action">
										<em>자기계발</em>
										</a></li>
									</ul>
									<ul class="cate_list">
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=667">
										유아
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=692">
										육아/자녀교육
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=704">
										어린이
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=767">
										어린이 영어
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=774">
										아동전집
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=794">
										정가제 Free
										</a>
										</li>
									</ul>
									<ul class="cate_list">
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1275">
										가정/생활/요리
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1317">
										건강/의학/미용
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1363">
										여행/취미/레저
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1420">
										잡지
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1440">
										만화
										</a>
										</li>
									</ul>
									<ul class="cate_list clear">
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=292">
										인문/교양/철학
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=381">
										역사/신화/문화
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=431">
										종교
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=474">
										사회/정치/법률
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=528">
										예술/대중문화
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=607">
										자연과학/공학
										</a>
										</li>
									</ul>
									<ul class="cate_list">
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=798">
										초등학습
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=840">
										중/고등참고서
										</a>
										</li>
										<li>&nbsp;</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=943">
										외국어/사전
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1013">
										대학교재
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1153">
										컴퓨터/IT
										</a>
										</li>
									</ul>
									<ul class="cate_list">
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1469">
										서양서
										</a>
										</li>
										<li>
										<a href="<%=cp%>/book_cate.action?categoryId=1487">
										일본서
										</a>
										</li>
									</ul>
								</div>
							</div>
							<div class="cate_book02">
								<h3>
									<a href="<%=cp%>/main.action">수험서</a>
								</h3>
								<div class="cate_list_wrap cate_exam">
									<ul class="cate_list exam">
										<li>
										
										공무원
									
										</li>
										<li>
										
										국가고시
									
										</li>
										<li>
										
										임용시험
										
										</li>
										<li>
										
										대기업/공기업/면접
										
										</li>
										<li>
										
										대표저자수험서
										
										</li>
									</ul>
									<ul class="cate_list">
										<li>
										
										국가기술자격증
										
										</li>
										<li>
										
										국가전문자격증
										
										</li>
										<li>
										
										민간전문자격증
										
										</li>
										<li>
										
										외국자격증
										
										</li>
									</ul>
									<ul class="cate_list exam clear">
										<li>
										
										편입/진학/전문대학원
										
										</li>
										<li>
										
										공부법/안내서
									
										</li>
									</ul>
								</div>
							</div>
							<span></span>
						</div>
					</li>
					<li class="menu">
					<a href="<%=cp%>/bnlBSList.action" class="menu_link menu_best">
						<span></span>
					</a>
					</li>
					<li class="menu">
						<a href="<%=cp %>/bnlNewBookList.action" class="menu_link menu_new">
							<span></span>
						</a>
					</li>
					<li class="menu">
						<a href="<%=cp %>/discountBookMain.action" class="menu_link menu_sale">
							<span></span>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>


	
	

</body>


