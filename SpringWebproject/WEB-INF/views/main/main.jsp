<%@page import="java.util.List"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="http://bandinlunis.com/common/css/center.css" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="shortcut icon" href="http://image.bandinlunis.com/favicon.ico" type="image/x-icon">
<title>반디앤루니스 인터넷서점</title>
<script type="text/javascript">
	
	//베스트셀러 hover시 이미지 띄우기
	function hoverImg(num) {
		
		var img = document.getElementById("link_img"+num).src;
 		var link = document.getElementById("img_link"+num).href;
		
		document.getElementById("bs_link").href = link;
		document.getElementById("bs_img").src = img;
	}	
	
	
	//메인화면 로드시 기본값
	$(function() {
		
		var data = document.getElementById("data");
		var noData = document.getElementById("no_data");	
		
		var ck = cookieInfo(getCookie('rcbook'));
		todayView(ck);		

   		if($('.swiper-slide-active #isbn').val()!=null){
			noData.style.display = 'none';
			data.style.display = 'block';
			listRecomm($('.swiper-slide-active #isbn').val());
		}else if($('.swiper-slide-active #isbn').val()==null){
			noData.style.display = 'block';
			data.style.display = 'none';
		}
 		
		document.getElementById("bs_link").href = document.getElementById("img_link1").href;
		document.getElementById("bs_img").src = document.getElementById("link_img1").src; 
		
		newBookAll();
		issueBook();	
		
	});	
	
	//추천도서 새로고침 버튼
	$(document).ready(function() {
		$('#recommend_btn,#rb_awL,#rb_awR').click(function() {
		
			var params = $('.swiper-slide-active #isbn').val();
			$.ajax({
				type:"POST",
				url:"<%=cp%>/recomm.action",
				data: {isbn:params},
				success:function(args){
					$('#recommend_books').html(args);
				},
				error:function(e){
					alert(e.responseText);
				}
			});
		});
	});
	
	//기대 신간 카테고리 글자색
	$(function() {
		$(".nb_tab_menu li").click(function() {
			$(".nb_tab_menu .active").removeClass('active');
			$(this).addClass('active');
		});
	});

	//추천도서 불러오기
	function listRecomm(isbn) {
		var params = "isbn=" + isbn;
		var url = "<%=cp%>/recomm.action";
		
		$.post(url,params,function(args){
			$("#recommend_books").html(args);
		});
	}
	
		
	//기대신간 전체
	function newBookAll() {
		$("#first_born").addClass('active');
		var url = "<%=cp%>/newbookall.action";
		
		$.post(url,function(args){
			$("#new_book").html(args);
		});	
	}
	
	//기대신간 카테고리별
	function newBook(nb) {

		var url = "<%=cp%>/newbook.action";
		
		$.post(url,{nb:nb},function(args){
			$("#new_book").html(args);
		});
	}
	
	//이슈북
	function issueBook() {

		var url = "<%=cp%>/issuebook.action";
		
		$.post(url,function(args){
			$("#issue_book").html(args);
		});
	}
	
	
	//오늘 본 상품
	function todayView(ck) {
	
		if(ck==null){
			return;
		}else{
			var html= '<div class="rb_awbox">';
			html+= '	<button class="slide_aw left" id="rb_awL">';
			html+= '		<span class="aw_count_rb"></span>';
			html+= '	</button>';
			html+= '	<button class="slide_aw right" id="rb_awR">';
			html+= '		<span class="aw_count_rb"></span>';
			html+= '	</button>';
			html+= '</div>';
			html+= '<h4>오늘본 상품</h4>';
			html+= '<div class="swiper-container swiper3">';
			html+= '	<div class="swiper-wrapper list">';

			for(var i=0;i<ck.length;i++){
				
				html+= '<div class="swiper-slide">';
				html+= '	<input id="isbn" value="'+ ck[i].isbn +'" type="hidden"/>';
				html+= '	<div class="rb_image">';
				html+= '		<a href="<%=cp%>/book_info.action?isbn='+ ck[i].isbn +'">';
				html+= '			<img src="<%=cp%>/resources/image/book/'+ck[i].bookImage+'">';
				html+= '		</a>';
				html+= '		<dl class="rb_title">';
				html+= '		<dt>'+ck[i].bookTitle+'</dt>';
				html+= '		<dd>'+ck[i].authorName+'</dd>';
				html+= '	</dl>';
				html+= '	</div>';
				html+= '</div>';
			}
			
			html+= '</div></div>';
		
			$("#today_view").html(html);	
		}
		
		var swiper = new Swiper('.swiper3', {
			spaceBetween: 0,
			centeredSlides: true,
			loop: true,
			simulateTouch : false,
			pagination: {
				el: '.aw_count_rb',
				type: 'fraction',
			},
			navigation: {
				nextEl: '#rb_awR',
				prevEl: '#rb_awL',
			},
		});
	}	
	
	//로그인 오늘본 상품
	function todayViewL() {
		
		
	}
	

</script>
</head>
<body style="margin: 0;">
<jsp:include page="./header.jsp" flush="false"/>

<div id="body">
	<div class="swiper-container swiper1"><!-- 첫번째 슬라이드 -->
   		<div class="swiper-wrapper">
     		<div class="swiper-slide">
     			<a href="<%=cp%>/book_info.action?isbn=9788965962823"><img src="<%=cp%>/resources/image/main/box1_2.jpg"></a>
     		</div>
     		<div class="swiper-slide">
     			<ul>
     				<li class="s_box03">
     					<a href="<%=cp%>/book_info.action?isbn=9788932919287"><img src="<%=cp%>/resources/image/main/box3_1.jpg"></a>
     				</li>
     				<li class="s_box03">
     					<a href="<%=cp%>/book_info.action?isbn=9788984373594"><img src="<%=cp%>/resources/image/main/1541135742840.jpg"></a>
     				</li>
     				<li class="s_box03 alt">
     					<a href="<%=cp%>/book_info.action?isbn=9788959895526"><img src="<%=cp%>/resources/image/main/1541135801853.jpg"></a>
     				</li>
     			</ul>
     		</div>
     	</div>
     	
     	<div class="swiper-pagination"></div>

	    <div class="swiper-button-next"></div>
	    <div class="swiper-button-prev"></div>
	</div>
</div>

<div class="body_section">
	<div id="body" style="width: 1100px;height: 145px;margin: 0 auto;position: relative;clear: both; background-color: #fff">
		<ul class="mini_banner"><!-- 미니배너1 -->
			<li id="mini_bn01">
				<div class="swiper-container bn_swiper1">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<a href="<%=cp%>/book_info.action?isbn=9791162207550"><img src="<%=cp%>/resources/image/main/banner02.jpg"></a>
						</div>
						<div class="swiper-slide">
							<a href="<%=cp%>/book_info.action?isbn=9791195389889"><img src="<%=cp%>/resources/image/main/banner20181102141927.jpg"></a>
						</div>
					</div>
					
					<div class="arrow_box">
						<span class="arrow_count"></span>
						<button class="ban_awN"></button>
						<button class="ban_awP"></button>
					</div>
					
				</div>
			</li>
			<li id="mini_bn01"><!-- 미니배너2 -->
				<div class="swiper-container bn_swiper2">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<a href="<%=cp%>/book_info.action?isbn=9791189015299"><img src="<%=cp%>/resources/image/main/banner2_02.jpg"></a>
						</div>
						<div class="swiper-slide">
							<a href="<%=cp%>/book_info.action?isbn=9788965483755"><img src="<%=cp%>/resources/image/main/banner2_03.jpg"></a>
						</div>
						<div class="swiper-slide">
							<a href="<%=cp%>/book_info.action?isbn=9788984373594"><img src="<%=cp%>/resources/image/main/banner20181102142927.jpg"></a>
						</div>
					</div>
					
					<div class="arrow_box">
						<span class="arrow_count"></span>
						<button class="ban_awN"></button>
						<button class="ban_awP"></button>
					</div>
				</div>
			</li>
			<li id="mini_bn01"><!-- 미니배너3 -->
				<div class="swiper-container bn_swiper3">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<a href="<%=cp%>/book_info.action?isbn=9788993635027"><img src="<%=cp%>/resources/image/main/banner3_03.jpg"></a>
						</div>
					</div>
					
					<div class="arrow_box">
						<span class="arrow_count"></span>
						<button class="ban_awN"></button>
						<button class="ban_awP"></button>
					</div>
				</div>
			</li>
		</ul>
	</div>
		
	<div class="b_content_wrap1" style="overflow: hidden;">
		<div class="today_book"><!-- 오늘의 책 -->
			<div class="b_tit tit_book"></div>
			<div class="b_arrow_box">
				<button class="slide_aw left" id="slide_awL">
					<span class="aw_count_sl"></span>
				</button>	
				<button class="slide_aw right" id="slide_awR">
					<span class="aw_count_sl"></span>
				</button>
			</div>
			<div class="swiper-container swiper2">
				<div class="swiper-wrapper" 
				style="width: 3345px; height: 358px; transform: translate3d(-2676px, 0px, 0px); transition-duration: 0.3s;">
					<div class="swiper-slide one_b">
						<div class="tb_wrap">
							<div class="tb_img">
								<a href="<%=cp%>/book_info.action?isbn=9788950976514">
								<!-- db구축 후에 db에서 데이터 꺼내와야함 -->
									<img src="/webproject/resources/image/main/today_book1.jpg">
								</a>
							</div>
							<dl>
								<dt>
									<a href="<%=cp%>/book_info.action?isbn=9788950976514">
										오늘처럼 내가 싫었던 날은 없다
									</a>
								</dt>
								<dd class="author">글배우</dd>
								<dd class="b_intro">베스트셀러 ≪아무것도 아닌 지금은 없다≫ 저자 글배우가 들려주는 마음 수업. 오늘날 현대인의 고민에 그 누구보다 깊이 공감하는 카운슬러인 글배우는 3년 간 5천 명이 넘는 사람들을 만나 그들의 고민을 듣고 이야기를 나눴다. 이 책은 저자의 다년간의 고민 상담 경험을 바탕으로 일, 연애, 사랑, 인간관계, 꿈 등 누구나 마음속에 가지고 있는 고민과 걱정들을 어루만지는 공감 어린 글과 ‘내가 원하는 나’를 만들어나갈 수 있는 56개의 구체적인 방법을 알려준다. 자존감이 낮은 사람에게 ‘나를…</dd>
<%-- 									<c:choose>
										<c:when test="${fn:length(dto.movie_name)>10 }">
											<c:out value="${fn:substring(dto.movie_name,0,8) }"/>…
										</c:when>
										<c:otherwise>
											<c:out value="${dto.movie_name }"></c:out>
										</c:otherwise>
									</c:choose> --%>
							</dl>
						</div>							
					</div>
					<div class="swiper-slide">
						<ul class="b_wrap2">
							<li>
								<div class="b_img">
									<a href="<%=cp%>/book_info.action?isbn=9788965707080">
										<img src="/webproject/resources/image/book/4206375_cover.jpg">
									</a>
								</div>
								<dl>
									<dt>
										<a href="<%=cp%>/book_info.action?isbn=9788965707080">아임 낫 파인</a>
									</dt>
									<dd>이 책은 괜찮다고 말하지만, 괜찮지 않은 사람들의 이야기 국내 최고 정신의학 전문가들과 화제의 채널 ‘#해시온’이 함께한 우울증 프로젝트, ‘아임 낫 파인’을 책으로 만난다! “나는…</dd>
								</dl>
							</li>
							<li>
								<div class="b_img">
									<a href="<%=cp%>/book_info.action?isbn=9791189015299">
										<img src="/webproject/resources/image/book/4201326_cover.jpg">
									</a>
								</div>
								<dl>
									<dt>
										<a href="<%=cp%>/book_info.action?isbn=9791189015299">구미베어 살인사건</a>
									</dt>
									<dd>한국 SF의 한 미래를 엿볼 수 있는 달콤하고 쓸쓸한 8편의 곰인형 이야기! “무엇이 가장 그리운가요?” “포옹이요.” 제2회 SF 어워드 장편 소설 부문 대상 수상 작가 dcdc의 장르를 넘나드는…</dd>
								</dl>
							</li>
						</ul>	
					</div>
					<div class="swiper-slide">
						<ul class="b_wrap2">
							<li>
								<div class="b_img">
									<a href="<%=cp%>/book_info.action?isbn=9791162207550">
										<img src="/webproject/resources/image/book/4195328_cover.jpg">
									</a>
								</div>
								<dl>
									<dt>
										<a href="<%=cp%>/book_info.action?isbn=9791162207550">곁에 남아 있는 사람</a>
									</dt>
									<dd>복잡한 마음을 품고 살아가는 이들을 기록하고 싶었다는 그는 일곱 편의 단편소설에 등장하는 인물들을 통해 “자신의 인생에서 진정으로 소중한 것이 무엇인가를 성찰하고…</dd>
								</dl>
							</li>
							<li>
								<div class="b_img">
									<a href="<%=cp%>/book_info.action?isbn=9791186877838">
										<img src="/webproject/resources/image/book/4185860_cover.jpg">
									</a>
								</div>
								<dl>
									<dt>
										<a href="<%=cp%>/book_info.action?isbn=9791186877838">게을러도 괜찮아</a>
									</dt>
									<dd>세 여자는 치열하고 성실하게 살아본 결과, 역시 게으른 것이 최고라는 결론에 도달하게 되었다. 그래서 이제부터라도 가장 편한 속도로, 자신만의 방식으로 살기로 했다. 같은…</dd>
								</dl>
							</li>
						</ul>	
					</div>
				</div>
			</div>
		</div>
		<div class="best_seller"><!-- 베스트 셀러 -->
			<div class="b_tit">
				<span>베스트셀러</span>
			</div>
			<div class="bs_area">
				<div class="rank_wrap">
					<ul class="rank_list">
						<c:forEach var="bs" items="${lst }">
						<li>
							<a id="img_link${bs.listNum }" class="list_title" href="<%=cp %>/book_info.action?isbn=${bs.isbn}" 
							onmouseover="hoverImg('${bs.listNum}')">
								<span class="list_n">${bs.listNum }</span>
								<c:choose>
									<c:when test="${fn:length(bs.bookTitle)>16 }">
										<c:out value="${fn:substring(bs.bookTitle,0,13) }"/>…
									</c:when>
									<c:otherwise>
										<c:out value="${bs.bookTitle }"></c:out>
									</c:otherwise>
								</c:choose>
							</a>
							<a href="<%=cp %>/book_info.action?isbn=${bs.isbn}">
								<img id="link_img${bs.listNum }" src="<%=cp%>/resources/image/book/${bs.bookImage}" style="display: none;">
							</a>	
						</li>
						</c:forEach>
					</ul>
					<a class="more_link" href="<%=cp%>/bnlBSList.action"></a>
				</div>
				<div class="bs_image">
					<a id="bs_link" href="javascript://">
						<img id="bs_img" src="javascript://">
					</a>
				</div>
			</div>	
		</div>
		<div class="recommend_book"><!-- 추천도서 -->
			<div class="rc_title">
				<h4>
					<span>추천도서</span>
					&nbsp;&nbsp;오늘 조회 하신 상품과 유사한 속성을 지닌 상품을 추천합니다.
				</h4>
				<div class="rc_title_aw"></div>
			</div>
			<div class="rc_body" id="no_data" style="display: none;">
				<div class="rc_no_data">
					오늘 본 상품이 없습니다.
				</div>
			</div>
			<div class="rc_body" id="data" style="display: block;">

					<c:if test="${empty sessionScope.userInfo.userId }">
						<div class="recent_book" id="today_view"></div>
					</c:if>
					<c:if test="${!empty sessionScope.userInfo.userId }">
						<div class="recent_book">
							<div class="rb_awbox">
								<button class="slide_aw left" id="rb_awL">
									<span class="aw_count_rb"></span>
								</button>
								<button class="slide_aw right" id="rb_awR">
									<span class="aw_count_rb"></span>
								</button>
							</div>
							<h4>오늘본 상품</h4>
							<div class="swiper-container swiper3">
								<div class="swiper-wrapper list">
								<c:forEach var="rc" items="${rcList }">
									<div class="swiper-slide">
										<input id="isbn" value="${rc.isbn }" type="hidden"/>
										<div class="rb_image">
											<a href="<%=cp%>/book_info.action?isbn=${rc.isbn }">
												<img src="<%=cp%>/resources/image/book/${rc.bookImage }">
											</a>
											<dl class="rb_title">
												<dt>${rc.bookTitle }</dt>
												<dd>${rc.authorName }</dd>
											</dl>
										</div>
									</div>
								</c:forEach>					
								</div>
							</div>
						</div>	
					</c:if>
					
					<button class="rc_btn" id="recommend_btn"></button>
					<div class="rc_books">
						<h4>최근 본 도서와 유사한 분야 또는 주제를 다룬 도서</h4>
						<div id="recommend_books"></div>
					</div>

			</div>
		</div>
		<div class="new_book">
			<h3 class="nb_title"></h3>
			<ul class="nb_tab_menu">
				<li id="first_born">
					<a href="#" onclick="newBookAll();return false;">전체</a>
				</li>
				<li>
					<a href="#" onclick="newBook(1);return false;">소설</a>
				</li>
				<li>
					<a href="#" onclick="newBook(292);return false;">인문/교양/철학</a>
				</li>
				<li>
					<a href="#" onclick="newBook(115);return false;">시/에세이/기행</a>
				</li>
				<li>
					<a href="#" onclick="newBook(474);return false;">사회/정치/법률</a>
				</li>
				<li>
					<a href="#" onclick="newBook(197);return false;">경제/경영</a>
				</li>
				<li>
					<a href="#" onclick="newBook(255);return false;">자기계발</a>
				</li>
				<li>
					<a href="#" onclick="newBook(1275);return false;">가정/생활/요리</a>
				</li>
				<li>
					<a href="#" onclick="newBook(1363);return false;">여행/취미/레저</a>
				</li>
			</ul>
			<div class="nb_list1" id="new_book">
			</div>
		</div>
		<div class="issue_book">
			<h3 class="ib_title"></h3>
			<h4 class="ib_subtitle">우리가 사는 신비한 우주</h4>
			<div class="ib_list" id="issue_book">
			</div>
		</div>
	</div>
	<div class="theme_book">
		<div class="b_arrow_box">
			<button class="slide_aw left" id="tb_awL">
				<span class="aw_count_tb"></span>
			</button>	
			<button class="slide_aw right" id="tb_awR">
				<span class="aw_count_tb"></span>
			</button>
		</div>
		<div class="swiper-container swiper6">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<h3 class="tb_title"><반려견> 행복한 우리가족</h3>
					<ul class="tb_list">
						<li>
							<div class="tb_img">
								<a href="<%=cp%>/book_info.action?isbn=9791196219321">
									<img src="<%=cp%>/resources/image/book/4174166_cover.jpg">
								</a>
							</div>
							<dl class="rb_title">
								<dt>카밍 시그널</dt>
								<dd>투리드 루가스</dd>
							</dl>
						</li>
						<li>
							<div class="tb_img">
								<a href="<%=cp%>/book_info.action?isbn=9791155427484">
									<img src="<%=cp%>/resources/image/book/4109092_cover.jpg">
								</a>
							</div>
							<dl class="rb_title">
								<dt>닥터독의 강아지 수제간식 레시피</dt>
								<dd>닥터독</dd>
							</dl>
						</li>
						<li>
							<div class="tb_img">
								<a href="<%=cp%>/book_info.action?isbn=9788996952701">
									<img src="<%=cp%>/resources/image/book/3539093_cover.jpg">
								</a>
							</div>
							<dl class="rb_title">
								<dt>동고동락</dt>
								<dd>이웅종</dd>
							</dl>
						</li>
					</ul>
				</div>
				<div class="swiper-slide">
					<h3 class="tb_title"><연애> 책으로 공부하자</h3>
					<ul class="tb_list">
						<li>
							<div class="tb_img">
								<a href="<%=cp%>/book_info.action?isbn=9791196440336">
									<img src="<%=cp%>/resources/image/book/4205948_cover.jpg">
								</a>
							</div>
							<dl class="rb_title">
								<dt>언제부터 사랑이었는지</dt>
								<dd>김종선</dd>
							</dl>
						</li>
						<li>
							<div class="tb_img">
								<a href="<%=cp%>/book_info.action?isbn=9791187400219">
									<img src="<%=cp%>/resources/image/book/4143978_cover.jpg">
								</a>
							</div>
							<dl class="rb_title">
								<dt>서른의 연애</dt>
								<dd>좋은비</dd>
							</dl>
						</li>
						<li>
							<div class="tb_img">
								<a href="<%=cp%>/book_info.action?isbn=9791188331482">
									<img src="<%=cp%>/resources/image/book/4206391_cover.jpg">
								</a>
							</div>
							<dl class="rb_title">
								<dt>사랑; 짓</dt>
								<dd>이정</dd>
							</dl>
						</li>
					</ul>
				</div>
				<div class="swiper-slide">
					<h3 class="tb_title"><집밥> 오늘은 머먹지?</h3>
					<ul class="tb_list">
						<li>
							<div class="tb_img">
								<a href="<%=cp%>/book_info.action?isbn=9788968331930">
									<img src="<%=cp%>/resources/image/book/4204247_cover.jpg">
								</a>
							</div>
							<dl class="rb_title">
								<dt>퇴근 후 후다닥 집밥 한 끼</dt>
								<dd>램블부부</dd>
							</dl>
						</li>
						<li>
							<div class="tb_img">
								<a href="<%=cp%>/book_info.action?isbn=9788965181408">
									<img src="<%=cp%>/resources/image/book/3864342_cover.jpg">
								</a>
							</div>
							<dl class="rb_title">
								<dt>행복한 집밥 삼시세끼</dt>
								<dd>요안나 (이혜영)</dd>
							</dl>
						</li>
						<li>
							<div class="tb_img">
								<a href="<%=cp%>/book_info.action?isbn=9788926396858">
									<img src="<%=cp%>/resources/image/book/3915600_cover.jpg">
								</a>
							</div>
							<dl class="rb_title">
								<dt>백종원이 추천하는 집밥 메뉴 54</dt>
								<dd>백종원</dd>
							</dl>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<div class="sale_book">
		<h3 class="sb_title"></h3>
		<a class="more_link" href="<%=cp %>/discountBookMain.action"></a>
		<ul class="sb_list">
			<c:forEach var="dc" items="${dcB }">
			<li>
				<div class="sb_img">
					<a href="<%=cp %>/book_info.action?isbn=${dc.isbn}">
						<img src="<%=cp%>/resources/image/book/${dc.bookImage}">
					</a>						
				</div>
				<dl>
					<dt>
						<a href="<%=cp %>/book_info.action?isbn=${dc.isbn}">
						<c:choose>
							<c:when test="${fn:length(dc.bookTitle)>20 }">
								<c:out value="${fn:substring(dc.bookTitle,0,18) }"/>…
							</c:when>
							<c:otherwise>
								<c:out value="${dc.bookTitle }"></c:out>
							</c:otherwise>
						</c:choose>
						</a>
					</dt>
					<dd class="sb_author">${dc.authorName }</dd>
					<dd class="sb_price">재정가 : <fmt:formatNumber value="${dc.bookPrice }" pattern="#,###"/>원</dd>
					<dd class="sb_reprice">판매가 : <fmt:formatNumber value="${dc.discountedPrice }" pattern="#,###"/>원</dd>
				</dl>
			</li>
			</c:forEach>
		</ul>
	</div>
</div>
<div class="body_section_tale">
	<div class="bandi_n_lunis">
		<h3 class="bnl_title"></h3>
		<div class="bnl_info">
			<div class="info_box">
				<div class="swiper-container bnl_swiper1">
					<div class="swiper-wrapper">
						<div class="swiper-slide">	
							<dl>
								<dt>
									<a href="<%=cp%>/readbnl.action">
										<img src="<%=cp%>/resources/image/main/bnl_info01.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/readbnl.action">반디앤루니스를 읽다</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/readbnl.action">한 손으로 쉽고 빠르게 모든 혜택을 누려보세요!</a></dd>
							</dl>
						</div>
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/imbook.action">
										<img src="<%=cp%>/resources/image/main/bnl_info02.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/imbook.action">나는 책 입니다</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/imbook.action">일상에 묻혀 잠시 잊고 있었던 책을 떠올려 보세요.</a></dd>
							</dl>
						</div>
					</div>
					<div class="arrow_box ">
						<span class="arrow_count"></span>
						<button class="ban_awN"></button>
						<button class="ban_awP"></button>
					</div>
				</div>
			</div>
			<div class="info_box">
				<div class="swiper-container bnl_swiper2">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/store.action?params=12">
										<img src="<%=cp%>/resources/image/main/banner_lottepit.jpg">
									</a>
								</dt>
									<dd class="ifb_title"><a href="<%=cp%>/store.action?params=12">반디앤루니스 롯데피트인산본점</a></dd>
									<dd class="ifb_txt"><a href="<%=cp%>/store.action?params=12">책나라 군포의 문화 힐링 스팟</a></dd>
							</dl>
						</div>
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/store.action?params=5">
										<img src="<%=cp%>/resources/image/main/banner_daegu.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/store.action?params=5">반디앤루니스 대구신세계점</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/store.action?params=5">대구 서점의 새로운 랜드마크</a></dd>
							</dl>
						</div>
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/store.action?params=2">
										<img src="<%=cp%>/resources/image/main/banner_ccity.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/store.action?params=2">반디앤루니스 신세계센텀시티점</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/store.action?params=2">배움과 체험이 가득한 멀티컬쳐스토어</a></dd>
							</dl>
						</div>
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/store.action?params=3">
										<img src="<%=cp%>/resources/image/main/banner_lotteworld.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/store.action?params=3">반디앤루니스 롯데월드몰점</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/store.action?params=3">오감의 풍요로움을 느낄 수 있는 서점</a></dd>
							</dl>
						</div>
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/store.action?params=7">
										<img src="<%=cp%>/resources/image/main/banner_kimhae.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/store.action?params=7">반디앤루니스 신세계김해점</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/store.action?params=7">문화의 도시, 김해가 선택한 문화생활공간</a></dd>
							</dl>
						</div>
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/store.action?params=6">
										<img src="<%=cp%>/resources/image/main/banner_suwon.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/store.action?params=6">반디앤루니스 롯데몰수원점</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/store.action?params=6">역사와 전통의 수원, 새로운 문화소통공간</a></dd>
							</dl>
						</div>
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/store.action?params=1">
										<img src="<%=cp%>/resources/image/main/banner_gangnam.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/store.action?params=1">반디앤루니스 신세계강남점</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/store.action?params=1">강남지역 대표 문화의 관문</a></dd>
							</dl>
						</div>
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/store.action?params=10">
										<img src="<%=cp%>/resources/image/main/banner_sadang.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/store.action?params=10">반디앤루니스 사당역점</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/store.action?params=10">쾌적하고 깔끔한, 사당 지역 최대 서점</a></dd>
							</dl>
						</div>
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/store.action?params=9">
										<img src="<%=cp%>/resources/image/main/banner_sinrim.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/store.action?params=9">반디앤루니스 신림역점</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/store.action?params=9">포도몰 7층, 신림의 대표 만남의 장소</a></dd>
							</dl>
						</div>
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/store.action?params=13">
										<img src="<%=cp%>/resources/image/main/banner_lottewool.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/store.action?params=13">반디앤루니스 롯데울산점</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/store.action?params=13">울산의 북마크, 지역 최대 규모 서점</a></dd>
							</dl>
						</div>
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/store.action?params=8">
										<img src="<%=cp%>/resources/image/main/banner_lottestar.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/store.action?params=8">반디앤루니스 롯데스타시티점</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/store.action?params=8">핫플레이스 건대입구의 랜드마크</a></dd>
							</dl>
						</div>
						<div class="swiper-slide">
							<dl>
								<dt>
									<a href="<%=cp%>/store.action?params=11">
										<img src="<%=cp%>/resources/image/main/banner_mokdong.jpg">
									</a>
								</dt>
								<dd class="ifb_title"><a href="<%=cp%>/store.action?params=11">반디앤루니스 목동점</a></dd>
								<dd class="ifb_txt"><a href="<%=cp%>/store.action?params=11">Again & Renew</a></dd>
							</dl>
						</div>
					</div>
					<div class="arrow_box">
						<span class="arrow_count"></span>
						<button class="ban_awN"></button>
						<button class="ban_awP"></button>
					</div>
				</div>
			</div>
		</div>
		<div class="bnl_custom">
			<h4 class="bnlc_title">자주묻는 질문</h4>
			<a href="<%=cp%>/help/helpMain.action" class="more_link"></a>
			<ul class="q_list">
			<c:set var="i" value="1" />
			<c:forEach var="qlst" items="${qLst }">
				<li>
					<div class="no">
						<img src="http://image.bandinlunis.com/images/common/ico_no${i }.gif" alt="${i }">
					</div>
					<div>
						<a href="/webproject/help/helpIndex.action?parentsTypeId=${qlst.parentsTypeId }&questionId=${qlst.questionId }&typeId=${qlst.typeId}">
						<c:choose>
							<c:when test="${fn:length(qlst.subject)>30 }">
								<c:out value="${fn:substring(qlst.subject,0,28) }"/>…
							</c:when>
							<c:otherwise>
								<c:out value="${qlst.subject }"></c:out>
							</c:otherwise>
						</c:choose>
						</a>
					</div>
				</li>
				<c:set var="i" value="${i+1 }" />
			</c:forEach>
			</ul>
			<div class="bnl_banner">
			<a href="<%=cp%>/book_info.action?isbn=9791188810666">
				<img src="<%=cp%>/resources/image/main/banner20181102143615.jpg">
			</a>
		</div>
		</div>
	</div>
</div>

<%-- 	<script src="<%=cp%>/resources/js/swiper_min.js"></script>
	<script src="<%=cp%>/resources/js/swiper.js"></script> --%>
	
<jsp:include page="./footer.jsp" flush="false"/>

</body>
</html>