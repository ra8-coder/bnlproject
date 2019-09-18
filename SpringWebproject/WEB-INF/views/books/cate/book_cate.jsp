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
<title>도서 목록</title>

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

html, body {
	heigth: 100%;
	overflow: auto;
}

/* #iframe_list1 {
	display: block;
	border: none;
	height: 100vh;
	width: 100vw;
}

#iframe_list2 {
	display: block;
	border: none;
	height: 400vh;
} */
</style>
<!-- 베스트셀러 css -->
<link rel="stylesheet"
	href="/webproject/resources/common/css/bnlBSList2.css" type="text/css">

<link rel="stylesheet" href="/webproject/resources/book_css/class.css"
	type="text/css">

<link rel="stylesheet"
	href="/webproject/resources/book_css/detail_default.css"
	type="text/css">

<link rel="stylesheet" href="/webproject/resources/book_css/pStyle.css"
	type="text/css">

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript"
	src="/webproject/resources/book_js/jquery.iframeResizer.min.js"></script>


<script type="text/javascript">

 function calcHeight(){
	
	var the_height = document.getElementById('iframe_list2').contentWindow.document.body.scrollHeight;
	
	document.getElementById('iframe_list2').height = the_height;
	
	document.getElementById('iframe_list2').style.overflow = "hidden";
	
	
} 

/* function iframeAutoResize(h){
	if(h == null){
		return false;
		
	}
	(h).height = "0px";
	
	var iframeHeight = (h).contentWindow.document.body.scrollHeight;
	(h).height=iframeHeight + 15;

} */


/* $(function() {
	$("#iframe_list1").load(function(){
		
		var frame = $(this).get(0);
		var doc = (frame.contentDocument) ? frame.contentDocument : frame.contentWindow.document;
		$(this).height(doc.body.scrollHeight);
		$(this).width(doc.body.scrollWidth);
		
	});

	
});
$(function() {
	$("#iframe_list2").load(function(){
		
		var frame = $(this).get(0);
		var doc = (frame.contentDocument) ? frame.contentDocument : frame.contentWindow.document;
		$(this).height(doc.body.scrollHeight);
		$(this).width(doc.body.scrollWidth);
		
	});

	
}); */


jQuery(document).ready(function() {
        App.init();
        new WOW().init();
        App.initParallaxBg();
        StyleSwitcher.initStyleSwitcher();
        FancyBox.initFancybox();
        OwlCarousel.initOwlCarousel();
});
iFrameResize({
        log            : true,  // Enable console logging
        inPageLinks    : true,
});


</script>


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

<script type="text/javascript">

	
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
<!-- 스트립트2 끝  -->

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


	<jsp:include page="../../common/header.jsp" flush="false" />

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
			</div>

			<!-- left banner -->

			<!-- 브랜드 -->

			<!-- 추천인사이드:회원님이 주로 구입하시는 가격대의 인기 상품입니다 -->

		</div>

		<!-- 좌측 템플릿 끝 -->




		<!-- 가운데 레이아웃 -->

		<div class="con_t2" style="width: 850px;">

			<div class="container" style="width: 850px;">
				<ul class="nav nav-tabs">

					<li class="active"><a href="#menu_best">베스트셀러</a></li>

					<li><a href="#menu_new">새로나온 책</a></li>

					<li><a href="#menu_discount">정가인하</a></li>
				</ul>


				<!-- 줄 생성 -->

				<!-- 탭 메뉴 -->

				<div class="tab-content" style="width: 800px;">

					<!-- 베스트셀러 시작 -->

					<div id="menu_best" class="tab-pane in active">
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
										<li><input class="checkbox" type="checkbox"
											value="${dto.isbn }" name="isbn" id="cart_isbn${dto.isbn }">
											<div class="prod_thumb">
												<span class="ranking"> <span class="rank_num">${dto.rnum }</span>
													<span class="rank_change"> <img
														src="http://image.bandinlunis.com/images/common/2014/ico_best_same.gif"
														alt="-"> <!-- 0 -->
												</span>
												</span>
												<div class="prod_thumb_img">
													<a href="/webproject/book_info.action?isbn=${dto.isbn }"
														onfocus="this.blur();"> <img
														src="<%=cp %>/resources/image/book/${dto.bookImage }">

													</a> <a class="btn_popup" target="_blank"
														href="/webproject/book_info.action?isbn=${dto.isbn }"><span
														class="ico_new">새창열기</span></a>
												</div>
												<a class="btn_preview"
													href="javascript:popPreview('${dto.isbn }');">미리 보기</a>
											</div>

											<dl class="prod_info">
												<dt>
													<a href="/webproject/book_info.action?isbn=${dto.isbn }"
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
													<span>지금 주문하면 <strong class="t_red">내일</strong>받을 수
														있습니다.
													</span>
												</dd>
											</dl>

											<dl class="prod_btn">
												<dt>
													<span class="num_txt">수량</span> <input type="text"
														id="cntVal_${dto.isbn }" value="1" class="num" size="3"
														maxlength="2" onkeydown="onlyNumber();" onkeyup="">
													<span class="btn_updn_wrap"> <a
														href="javascript:cntUp('${dto.isbn }');"
														class="btn_num_up">▲</a> <a
														href="javascript:cntDown('${dto.isbn }');"
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
												<dd class="mt3">
													<a
														href="javascript:add_wish_array_common('${dto.isbn }', true);"><span
														class="btn_w_comm btype_f1">위시리스트</span></a>
												</dd>
											</dl></li>
									</ul>
								</div>
							</c:forEach>


						</div>
						<!-- con_t2 -->
					</div>
					<!-- 베스트셀러 끝 -->




					<!-- 새로나온 책 시작  -->
					<div id="menu_new" class="tab-pane fade" style="height: 100%">
						<iframe id="iframe_list1" height="100%" width="100%"
							src="<%=cp %>/book_New.action?categoryId=${categoryId}"
							style="margin-left: 0; overflow: auto; min-height: 1000px;"
							frameborder="0" scrolling="auto" onload="calcHeight();"
							name="WrittenPublic"></iframe>


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
	<jsp:include page="../../common/footer.jsp" flush="false" />
</body>

<script type="text/javascript">
	$(".nav-tabs a").click(function() {
		$(this).tab('show');
	});
	
<%-- 	$(document).ready(function(){
		
		$("<iframe scrolling='no' />").attr("src","<%=cp%>/book_Discount.action?categoryId=${categoryId}").attr("frameborder",0).attr("width","100%").attr("height","0px").appendTo("#iframe-container2");
		$('iframe').iframeAutoHeight({heightOffset: 10});
		
		
	}); --%>
	
	
</script>
</html>