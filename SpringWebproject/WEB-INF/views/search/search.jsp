<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="euc-kr">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>반디앤루니스 인터넷서점</title>

<link rel="stylesheet" href="/webproject/resources/css/searchN.css"	type="text/css">
<!--[if IE]>
<script src="/js/jquery/html5shiv.min.js"></script>
<![endif]-->
<script type="text/javascript" src="/webproject/resources/js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/webproject/resources/js/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="/webproject/resources/js/jquery/jquery/jquery.blockUI.js"></script>
<script type="text/javascript" src="/webproject/resources/common/js/common.js" charset="euc-kr"></script>
<script type="text/javascript" src="/webproject/resources/js/JUTIL/JUTIL.js" charset="utf-8"></script>
<script type="text/javascript" src="/webproject/resources/js/partnerHeaderInfo.js"></script>
<script type="text/javascript" src="https://wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">

$(document).ready(function(){

	/* onLoad */
	
	/* onLoad */

	//자동완성
	$("#sch_keyword").keyup(function(){
		if(akcOn) {
			if(event.keyCode == 38 || event.keyCode == 40) {	//상,하 방향키 event
				timeB = new Date();	//한타입력 후 방향키 입력시 두번찍힘...
				if((timeB-timeA) > 100) {
					var len = $("#AREA_AKC_WORDS li").size();
					if(len > 0) {
						if(event.keyCode == 40) {	//down
							akcIdx++;
							if((len-1) < akcIdx) akcIdx = 0;
						}else if(event.keyCode == 38) {	//up
							akcIdx--;
							if(akcIdx < 0) akcIdx = len-1;
						}
						$("#AREA_AKC_WORDS li").attr("style","background-color:#fff").delay(1000);
						$("#AREA_AKC_WORDS li").eq(akcIdx).attr("style","background-color:#f5f5f5");
						$("#sch_keyword").val($(".akc_hidden_words").eq(akcIdx).val());
						viewAkcExact($("#AREA_AKC_WORDS li").eq(akcIdx).val());
					}
				}
				timeA=timeB;
			}else {
				SCH_API_akc($("#sch_keyword").val());
			}
		}
	});

	//자동완성끄기
	$(".inner_func").click(function(){
		akcOn = false;
		$("#AREA_AKC").addClass("blind");
	});

	//자동완성켜기
	$(".auto_word").click(function(){
		if($("#AREA_AKC").attr("class").indexOf("blind") > -1) {
			akcOn = true;
			SCH_API_akc($("#sch_keyword").val());
			$("#AREA_AKC").removeClass("blind");
		}else {
			akcOn = false;
			$("#AREA_AKC").addClass("blind");
		}
	});

	//본문영역 클릭시 자동완성 닫기
	$("#sch_keyword").focusout(function() {
		setTimeout("closeAkcArea()",200);
	});
	
	/* 통합검색 셀렉트 */
	$(".search_select").hover(function() {
		$("#sch_prodType").removeClass("blind");
		},function() {
		$("#sch_prodType").addClass("blind");
	});
	
	$("#sch_prodType").hover(function() {
		$("#sch_prodType").removeClass("blind");
		},function() {
		$("#sch_prodType").addClass("blind");
	});

	$("#sch_prodType ul li").click(function() {
		$("#frm_pt").val(this.id);
		$(".search_select").html($("#sch_prodType ul li").eq(this.value).html());
		$("#sch_prodType").addClass("blind");
	});
	/* 통합검색 셀렉트 */
	
	/* 나의쇼핑 */
	$(".myShopping").hover(function() {
		$("#myShopping").show();
		},function() {
		$("#myShopping").hide();
	});
	$("#myShopping").hover(function() {
		$("#myShopping").show();
		},function() {
		$("#myShopping").hide();
	});	
	/* 나의쇼핑 */

	/* 영업점안내 */
	$(".store").hover(function() {
		$("#storeInfo").show();
		},function() {
		$("#storeInfo").hide();
	});
	$("#storeInfo").hover(function() {
		$("#storeInfo").show();
		},function() {
		$("#storeInfo").hide();
	});	
	/* 영업점안내 */

	/* 쉽게찾기 */
	$(".btn_easy").hover(function() {
		$(".layer_link").show();
		},function() {
		$(".layer_link").hide();
	});
	
	$(".layer_link").hover(function() {
		$(".layer_link").show();
		},function() {
		$(".layer_link").hide();
	});
	/* 쉽게찾기 */

	//submit
	$("#searchForm").submit(function() {
		$("#sch_keyword").val($("#sch_keyword").val().trim());
		if($("#sch_keyword").val() == "") {
			alert("검색어를 입력하세요.");
			$("#sch_keyword").focus();
			return false;
		}
	});

});

	wcs.inflow("bandinlunis.com");
	var sMemSeq = "";
	
	var akcIdx = -1;
	var timeA = new Date();
	var timeB;
	var console = window.console || {error:function(){}};

	//전역변수
	var akcOn = true;				//자동완성 끄기여부
	var gKwd = "설거지";		//검색어
	var gKwd_F = "";				//필터검색어
	var gKwd_S = "";				//구간검색어
	var gProdType = "";	//상품타입
	var gCateId = "";	//카테고리
	var currentPage = 0;			//현재페이지
	var productTotal = 0;			//상품 검색 결과 수
	var todayBookTotal = 0;			//오늘의책 검색 결과 수
	var themeBookTotal = 0;			//테마북 검색 결과 수

	//loading..
	function processing(){
		$.blockUI({
			message:null,
			overlayCSS:{ backgroundColor:'#FFFFFF' }
		});
	}

	//자동완성 영역 닫기
	function closeAkcArea() {
		$("#AREA_AKC").addClass("blind");
	}
	
	//자동완성
	function SCH_API_akc(kwd) {
		
		var apiUrl = "http://222.122.120.242:7571/ksf/api/suggest";
		
		//parameters
		var target = "complete";
		var domain_no = "0";	//0-전체
		var term = kwd;	//검색어
		var mode = "sc";
		var max_count = "10";	//요청건수
		
		var parameters = { target:target, domain_no:domain_no, term:term, mode:mode, max_count:max_count };
		var HTML = "";

		akcIdx = -1;	//초기화

		if(kwd.trim().length > 0) {
			
			$.ajax({
				
				url: apiUrl,
				type: "get",
				data: parameters,
				dataType: "jsonp",
				jsonp: "callback",
				success: function(data)	{

					try {

						$.each(data.suggestions[0], function(i,item) {
							HTML += '<li value="'+item[1]+'" onmouseover="onMouseAkcWord(\''+item[1]+'\');" onmouseout="outMouseAkcWord(\''+item[1]+'\');"><a href="javascript:akcChangeKwd('+i+')"><span class="txt_keywords">['+DispProdType(item[2])+'] '+item[0].replace(term.trim(),"<strong>"+term+"</strong>")+'</span></a><input type="hidden" class="akc_hidden_words" value="'+item[0]+'"/></li>';
						});
		
						if(data.suggestions[0].length > 0) {
							$("#AREA_AKC").removeClass("blind");
							viewAkcExact(data.suggestions[0][0][1]);
						}else {
							$("#AREA_AKC").addClass("blind");
						}
						
					}catch(e) {
						HTML = "";
					}
				},
				complete: function(){
					$("#AREA_AKC_WORDS").html(HTML);
				},
				error: function(){
					$("#AREA_AKC").addClass("blind");
				}
			});
		}else{
			if($("#AREA_AKC").attr("class").indexOf("blind") == -1) {
				$("#AREA_AKC").addClass("blind");
			}
		}
	}

	var timer;
	//자동완성 마우스 over
	function onMouseAkcWord(prodId) {
		timer = setTimeout("viewAkcExact('"+prodId+"')",300);
	}
	
	//자동완성 마우스 out
	function outMouseAkcWord(prodId) {
		clearTimeout(timer);
	}

	//자동완성 오른쪽 영역 그리기
	function viewAkcExact(prodId) {

		var apiUrl = "http://222.122.120.242:7570/ksf/api/search";

		//parameters
		var sn = "product";	//검색 볼륨
		var q = "pid^"+prodId;	//검색어

		var parameters = { sn:sn, q:q };
		var HTML = "";

		$.ajax({
			
			url: apiUrl,
			type: "get",
			data: parameters,
			dataType: "jsonp",
			jsonp: "callback",
			success: function(data)	{

				try {
					if(data.result[0].prod_type != "10"){ 
					HTML +='<span class="txt_category">['+data.result[0].catename1+']</span>\n';
					HTML +='<a href="http://www.bandinlunis.com/front/product/detailProduct.do?prodId='+data.result[0].prod_id+'" target="_blank"><span class="txt_title">'+data.result[0].prod_name+'</span></a>\n';
					HTML +='<div class="thumb_left_big">\n';
					HTML +='	<a href="/front/product/detailProduct.do?prodId='+data.result[0].prod_id+'" target="_blank">\n';
					HTML +='	<img src="http://image.bandinlunis.com/upload'+data.result[0].prod_img+'" onerror="this.src=\'/images/common/noimg_type01.gif\'" >\n';
					HTML +='	</a>\n';
					HTML +='</div>\n';
					HTML +='<dl class="select_product">\n';
					HTML +='<dd><span class="info"><span class="first_child">'+data.result[0].author+'</span><span>'+data.result[0].maker+'</span></span></dd>\n';
					HTML +='<dd>'+data.result[0].pdate.substring(0,4)+'년 '+data.result[0].pdate.substring(4,6)+'월</dd>\n';
					HTML +='<dd><div class="review_point"><span style="width:'+(data.result[0].review_avg*10)+'%"></span></div></dd>\n';
					HTML +='<dd><span class="txt_price"><span class="txt_sale">'+FormatNumber(data.result[0].price1)+'원</span> → <strong>'+FormatNumber(data.result[0].price2)+'</strong>원</span></dd>\n';
					HTML +='<dd><span class="txt_price">(<em>'+data.result[0].discount_rate+'%</em>↓ + <em>'+data.result[0].save_rate+'%</em>P)</span></dd>\n';
					HTML +='</dl>\n';
					HTML +='<div class="btn_select_area">\n';
					if(data.result[0].prod_type == "01") {
						HTML +='	<span class="btn_type brown"><a href="javascript:addCart('+data.result[0].prod_id+');">쇼핑카트</a></span>\n';
					}else if(data.result[0].prod_type == "06") {
						HTML +='	<span class="btn_type brown"><a href="javascript:add_basket_ebook('+data.result[0].prod_id+',1);">쇼핑카트</a></span>\n';
					}
					
					HTML +='</div>\n';
					}
	
				}catch(e) {
					HTML = "";
				}
			},
			complete: function(){
				$("#AREA_AKC_EXACT").html(HTML);
			},
			error: function(){
			}
		});
	}

	//타입별 텍스트 return
	function DispProdType(val){

		var str = "";
		
		if(val === "01")		str = "도서";
		else if(val === "02")	str = "도서";
		else if(val === "03")	str = "음반";
		else if(val === "04")	str = "GIFT";
		else if(val === "05")	str = "중고샵";
		else if(val === "06")	str = "eBook";
		else if(val === "07")	str = "DVD";
		else if(val === "08")	str = "해외주문도서";
		else if(val === "09")	str = "중고샵";
		else if(val === "11")	str = "뷰티";
		else if(val === "12")	str = "오피스문구";
		else 					str = "통합검색";

		return str;
	}

	//자동완성 키워드 선택시
	function akcChangeKwd(idx) {
		$("#sch_keyword").val($(".akc_hidden_words").eq(idx).val());
		$("#searchForm").submit();		
	}

	//하이라이팅 태그 삭제
	function EraseHighlightingTag(val) {
		var str = val.replace("<em class= 'emph_on'>","").replace("</em>","").replace("<em class= 'emph_on'>","").replace("</em>","").replace("<em class= 'emph_on'>","").replace("</em>","").replace("<em class= 'emph_on'>","").replace("</em>","").replace("<em class= 'emph_on'>","").replace("</em>","");
		return str;
	}

	//이미지 마우스오버시 새창열기 노출
	function onImage(val) {
		$("#blank_link_"+val).show();
	}

	//이미지 마우스아웃시 새창열기 제거
	function outImage(val) {
		$("#blank_link_"+val).hide();
	}

	//예약 태그
	function DispPreSaleYn(val){
		var str = "";
		if(val === "Y") {
			str = '<span class="tag_reser"><span>예약</span></span>';
		}
		return str;
	}

	//베스트 태그
	function DispBestYn(val){
		var str = "";
		if(val === "Y") {
			str = '<span class="tag_best"><span>베스트</span></span>';
		}
		return str;
	}

	//반디추천 태그
	function DispBandiYn(val){
		var str = "";
		if(val === "Y") {
			str = '<span class="tag_recom"><span>반디 추천</span></span>';
		}
		return str;
	}

	//해외구매 태그
	function DispOverseaYn(val, prodType){
		var str = "";
		if(val === "Y" && prodType === "03") {
			str = '<span class="tag_global"><span>해외 구매</span></span>';
		}
		return str;
	}

	//추가적립 태그
	function DispAddPointYn(val, prodType){
		var str = "";
		if(val === "Y" && (prodType === "04" || prodType === "11")) {
			str = '<span class="tag_bonus"><span>추가 적립</span></span>';
		}
		return str;
	}

	//무료배송 태그
	function DispFreeDeliYn(val, prodType){
		var str = "";
		if(val === "Y" && (prodType === "01" || prodType === "03" || prodType === "04" || prodType === "11")) {
			str = '<span class="tag_free"><span>무료 배송</span></span>';
		}
		return str;
	}

	//쿠폰 태그
	function DispCouponiYn(val, prodType){
		var str = "";
		if(val === "Y" && (prodType === "04" || prodType === "11")) {
			str = '<span class="tag_coupon"><span>쿠폰</span></span>';
		}
		return str;
	}
	
	//정가제 Free 태그
	function DispPriceFree(val, prodType){
		var pVal = "";
		var str = "";
		if(val.length > 0)
			pVal = val.trim().substr(0,5);
		
		if(pVal.length > 0 && pVal != "97889" && pVal != "97911" && prodType == "01") {
			str = '<span class="tag_price_free"><span>정가제 Free</span></span>';
		}
		return str;
	}

	//카운트 증가
	function cntUp(prodId, prodSaleStd) {
		if(prodSaleStd == "03") {
			alert("이 상품은 재고가 한정되어 있는 상품입니다. 쇼핑카트에 담으신 후 수량을 조절 해주시기 바랍니다.");
			return;
		}else {
			var ordCnt = parseInt($("#cntVal_"+prodId).val(),10);
			if(isNaN(ordCnt)) {
				ordCnt = 1;
			}else {
				ordCnt++;
			}
			if(ordCnt > 99) {
				alert("최대 수량입니다.");
				ordCnt = 99;
			}
			$("#cntVal_"+prodId).val(ordCnt);
		}
	}

	//카운트 감소
	function cntDown(prodId, prodSaleStd) {
		if(prodSaleStd == "03") {
			alert("이 상품은 재고가 한정되어 있는 상품입니다. 쇼핑카트에 담으신 후 수량을 조절 해주시기 바랍니다.");
			return;
		}else {
			var ordCnt = parseInt($("#cntVal_"+prodId).val(),10);
			if(isNaN(ordCnt)) {
				ordCnt = 1;
			}else {
				ordCnt--;
			}
			if(ordCnt < 1) {
				alert("최소 수량입니다.");
				ordCnt = 1;
			}
			$("#cntVal_"+prodId).val(ordCnt);
		}
	}

	//쇼핑카트
	function addCart(prodId) {
		var ordCnt = $("#cntVal_"+prodId).val();
		if(isNaN(ordCnt)) {
			ordCnt = 1;
		}
		add_basket(prodId, ordCnt);
	}
	
	//바로구매
	function goOrder(prodId) {
		var ordCnt = $("#cntVal_"+prodId).val();
		if(isNaN(ordCnt)) {
			ordCnt = 1;
		}
		goBuyOpt(prodId, ordCnt, 0);
	}
	
	

</script>
</head>
<body class="vsc-initialized" style="">
	<jsp:include page="../main/header.jsp" flush="false"/>
	<article id="bandiWrap"> 
	<script type="text/javascript">
	if(window.location.protocol == 'https:'){
		window.location.href = window.location.href.replace('https:','http:');

	}
</script>
	<div class="min_height">
		<!-- 컨텐츠 영역 -->
		<article id="bandiContainer" style=""> <!-- 상단 검색 키워드 영역 -->
		<!-- 검색 결과 값 영역 -->
		<div id="topResult">
			<div class="search_data">
				<p id="AREA_TOTAL">
					<em class="emph_on">'${searchValue }'</em>(으)로 통합검색 <em class="emph_on">${dataCount}</em>건
					검색
				</p>
			</div>
			<div class="search_wrap" style="display: none;">
				<div class="search_keyword" style="display: none;">
					<h3 class="search_tit">추천 검색어</h3>
					<ul class="search_lst" id="AREA_E_1"></ul>
				</div>
				<div class="search_keyword" style="display: none;">
					<h3 class="search_tit">연관 키워드</h3>
					<ul class="search_lst" id="AREA_E_2"></ul>
				</div>
			</div>
		</div>
		<!-- 검색 결과 값 영역 -->
		
		<div id="resultWrap">
		<!-- 좌측 사이드 영역 -->
		<aside id="asideWrap">
		<div class="side_box">
			<ul class="depth1">
				<li class="opened">
					<ul class="total_category" id="AREA_C_1">
						<li class="first_child">
							<div class="stit on" id="left_cate_grp_">
								<a href="/webproject/search/search.do?&searchValue=${searchValue}" class="stit_more"><em>전체</em>
									<span>(${dataCount})</span></a>
							</div>
						</li>
						<li>
							<div class="btn_sub_area">
								<a href="javascript:showMoreCate('01');" class="btn_sub_more"
									id="book_category_sub_01" style="display: block;">더보기</a>
							</div>						
							
							<ul class="book_category" id="book_category_01" style="">								
								
								<c:forEach var="dto" items="${categoryList }">
								<li class=""><a href="/webproject/search/search.do?categoryId=${dto.categoryId }&searchValue=${searchValue}">${dto.categoryName }<span>
											(${dto.categortCount })</span></a></li>
								</c:forEach>						
								
							</ul>
							
						</li>
						
						<li>
							<div class="btn_sub_area">
								<a href="javascript:showMoreCate('06');" class="btn_sub_more"
									id="book_category_sub_06" style="display: block;">더보기</a>
							</div>						
						</li>
					</ul>
				</li>
				<li class="opened">
					<dl class="list_style" id="filterSet">
						<dt>더 자세히</dt>
						<dd>
							<fieldset>
								<legend>필터 검색</legend>
								<div class="bbox2">
									<div class="window_wrap2">
										<input type="text" title="검색" id="sch_keyword_filter"
											maxlength="255" class="box_window2" accesskey="s"
											autocomplete="off" value="${searchValue }"
											onkeypress="if(event.keyCode==13){goSearchFilterSub();}">
										<button type="submit" id="btn_search_filter"
											class="btn_search2">
											<span class="ir_wa">검색</span>
										</button>
									</div>
								</div>
							</fieldset>
						</dd>
						<dd id="filter_pnm">
							<input id="pnm" type="checkbox" value="pnm" title="제목/ISBN"><label
								for="pnm">제목/ISBN</label>
						</dd>
						<dd id="filter_atr">
							<input id="atr" type="checkbox" value="atr" title="저자/역자"><label
								for="atr">저자/역자</label>
						</dd>
						<dd id="filter_mkr">
							<input id="mkr" type="checkbox" value="mkr" title="출판사"><label
								for="mkr">출판사</label>
						</dd>
						<dd id="filter_cdn">
							<input id="cdn" type="checkbox" value="cdn" title="서평 내용"><label
								for="cdn">서평 내용</label>
						</dd>
						<dd id="filter_tgl">
							<input id="tgl" type="checkbox" value="tgl" title="태그"><label
								for="tgl">태그</label>
						</dd>
					</dl>
				</li>
				<li class="opened" id="filterSet_music" style="display: none;">
					<dl class="list_style">
						<dt>음반 카탈로그 NO.</dt>
						<dd>
							<fieldset>
								<legend>필터 검색</legend>
								<div class="bbox2">
									<div class="window_wrap2">
										<input type="text" title="검색" id="sch_keyword_music"
											maxlength="255" class="box_window2" accesskey="s"
											autocomplete="off" value="설거지"
											onkeypress="if(event.keyCode==13){goSearchFilterSub();}">
										<button type="submit" id="btn_search_music"
											class="btn_search2">
											<span class="ir_wa">검색</span>
										</button>
									</div>
								</div>
							</fieldset>
						</dd>
					</dl>
				</li>
				<li class="opened">
					<dl class="list_style">
						<dt class="tit_slider">출간일</dt>
						<dd class="date">
							<div id="slider-range-pdate"
								class="ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all">
								<div class="ui-slider-range ui-widget-header ui-corner-all"
									style="left: 0%; width: 100%;"></div>
								<span class="ui-slider-handle ui-state-default ui-corner-all"
									tabindex="0" style="left: 0%;"></span><span
									class="ui-slider-handle ui-state-default ui-corner-all"
									tabindex="0" style="left: 100%;"></span>
							</div>
							<span class="icon_slider gage1">최근</span> <span
								class="icon_slider gage2">3개월</span> <span
								class="icon_slider gage3">6개월</span> <span
								class="icon_slider gage4">9개월</span> <span
								class="icon_slider gage5">전체</span> <input type="hidden"
								id="slider-range-pdate1" value="0"> <input type="hidden"
								id="slider-range-pdate2" value="12">
						</dd>
						<dd class="dash"></dd>
						<dt class="tit_slider">가격대</dt>
						<dd class="price">
							<div id="slider-range-price"
								class="ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all">
								<div class="ui-slider-range ui-widget-header ui-corner-all"
									style="left: 0%; width: 100%;"></div>
								<span class="ui-slider-handle ui-state-default ui-corner-all"
									tabindex="0" style="left: 0%;"></span><span
									class="ui-slider-handle ui-state-default ui-corner-all"
									tabindex="0" style="left: 100%;"></span>
							</div>
							<span class="icon_slider gage1">0</span> <span
								class="icon_slider gage2">1만</span> <span
								class="icon_slider gage3">3만</span> <span
								class="icon_slider gage4">5만</span> <span
								class="icon_slider gage5">최대</span>
							<div class="item">
								<input type="text" id="slider-range-price1" value="0" name=""
									title="최저가격" class="i_text" readonly="readonly"> - <input
									type="text" id="slider-range-price2" value="999000" name=""
									title="최고가격" class="i_text" readonly="readonly">
							</div>
						</dd>
					</dl>
				</li>
			</ul>
		</div>
		</aside>

		<!-- 메인 섹션 영역 -->
		<section id="mainSection"> <!-- 검색 옵션 영역 -->
		<div class="search_option">
			<div class="select_left">
				<span class="info"><span class="first_child"><a
						href="#AREA_G_2" id="PRODUCT_TOTAL">상품 [${dataCount }]</a></span>
			</div>
			<!-- 우측 셀렉트 영역 -->
			<div id="AREA_D">
				<select id="sch_sort" class="inp_opt">
					<option value="" selected="">정확도 높은 순</option>
					<option value="pt">발행일 최신 순</option>
					<option value="st">판매량 많은 순</option>
					<option value="ra">평점 높은 순</option>
					<option value="rt">리뷰 많은 순</option>
					<option value="drt">할인율 순</option>
					<option value="scta">가격 순</option>
				</select> <select id="sch_listSize" class="inp_opt">
					<option value="20" selected="">20개씩</option>
					<option value="50">50개씩</option>
					<option value="100">100개씩</option>
				</select> <select id="sch_viewType" class="inp_opt">
					<option value="view_type" selected="">자세히</option>
					<option value="view_type_simple">간단히</option>
				</select> <span class="soldout"> <input id="pb1" type="checkbox"
					value="Y" title="품절 제외"><label for="pb1">품절 제외</label>
				</span>
			</div>
			<!--// 우측 셀렉트 영역 -->
		</div>
		<!--// 검색 옵션 영역 --> <!-- 작가 소개 영역 -->
		<div class="info_writer" id="AREA_G_1" style="display: none;"></div>
		<!--// 작가 소개 영역 --> <!-- 시리즈 영역 -->
		<div class="info_serise" id="AREA_C_3_A" style="display: none;">
			<dl class="list_style2" id="AREA_C_3_1"></dl>
		</div>
		<!--// 시리즈 영역 --> <!-- 수상작 영역 -->
		<div class="info_serise" id="AREA_C_3_B" style="display: none;">
			<dl class="list_style2" id="AREA_C_3_2"></dl>
		</div>
		<!--// 수상작 영역 --> 
			
			<!-- 검색 리스트 시작 -->

			<div class="view_type" id="AREA_G_2">
				<c:forEach var="dto" items="${searchBook }">
				<ul>
					<li> 
						<div class="thumb_area" onmouseover="onImage(4109026);"
							onmouseout="outImage(4109026);">
							<div class="thumb_left_big">
								<a href="/front/product/detailProduct.do?prodId=4109026"> 
								<img src="<%=cp%>/resources/image/book/${dto.bookImage}"	onerror="this.src='/images/common/noimg_type01.gif'">
								
								
								</a>
							</div>
							<div class="btn_popup">
								<a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"
									class="btn_new" id="blank_link_4109026" target="_blank"
									style="display: none;"><span class="ico_new">새창열기</span></a>
							</div>
						</div>
						
						<dl class="book_contents">
							<dt>
								<a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"><span
									class="tit_category"></span>${dto.bookTitle }</a> <span class="tit_sub">-
									${dto.subTitle }</span>
								<div class="tag_area">
									<span class="tag_recom"><span>반디 추천</span></span><span
										class="tag_free"><span>무료 배송</span></span>
								</div>
							</dt>
							<dd class="txt_block">
								<span class="info"><span class="author first_child">
										<a href="#" onclick="javascript:changeKwd('${dto.authorName}');">${dto.authorName }</a> 저
								</span><span class="publisher"><a href="#"
										onclick="javascript:changeKwd('${publisher }');">${publisher }</a></span><span
									class="pubdate">${dto.publishDate }</span></span>
							</dd>
							<dd class="txt_price">
								<p>
									<span>${dto.bookPrice }</span> → <strong><em>${dto.bookPrice *0.9 }</em>원</strong> (<em>10%</em>할인
									+ <em>5%</em>포인트)
								</p>
							</dd>
							<dd class="txt_desc">
								<div class="review_point">
									<span style="width: 0%"></span>
								</div>
							</dd>
						</dl>
						<dl class="btn_area">
							<dt>
								<input id="" type="checkbox" class="checkbox" value="4109026"
									title="선택"><span class="num_txt">수량</span><input
									type="text" id="cntVal_4109026" value="1" class="num" size="3"
									maxlength="2" onkeydown="onlyNumber();" onkeyup=""><span
									class="btn_updn_wrap"><a
									href="javascript:cntUp('4109026','01');" class="btn_num_up">▲</a><a
									href="javascript:cntDown('4109026','01');" class="btn_num_dn">▼</a></span>
							</dt>
							<dd>
								<span class="btn_type brown"><a
									href="javascript:addCart(4109026);">쇼핑카트</a></span>
							</dd>
							<dd>
								<span class="btn_type white"><a
									href="javascript:goOrder(4109026);">바로구매</a></span>
							</dd>
							<dd>
								<span class="btn_type white"><a
									href="javascript:add_wish_array_common(4109026, true);">위시리스트</a></span>
							</dd>
						</dl>
					</li>					
				</ul>
				</c:forEach>
			</div>



			<!-- //검색 리스트 --> <!-- 하단 버튼 영역-->
			<div class="btn_under" style="">
				<a href="javascript:addWishes();" class="wishlist">위시리스트 담기</a> <a
					href="javascript:addCarts();" class="bookcart">선택 쇼핑카트 담기</a> <span
					class="check_all"> <input id="pb2" type="checkbox" value=""
					title="전체"><label for="pb2">전체</label>
				</span>
			</div>
			<!--// 하단 버튼 영역--> <!-- 페이징 영역 -->
			<div class="paging" id="AREA_G_2_PAGE">
			<c:if test="${dataCount!=0 }">
					${pageIndexList }
				</c:if>
											<c:if test="${dataCount==0 }">
					등록된게시물이 없습니다.
				</c:if>
				<%-- <a href="/webproject/search/search.do?searchValue=${searchValue}&pageNum=1" onclick="pageMove(0); return false;"
					class="on">1</a>
					<a href="/webproject/search/search.do?searchValue=${searchValue}&pageNum=2"	onclick="pageMove(1); return false;" class="">2</a>
					<a href="/search/search.do" onclick="goNextPage(); return false;" class="next">next</a> --%>
			</div>
			<!--// 페이징 영역 --> 
			 </section>
		</div>
		</article>
	</div>
	<!-- 에스크로확인 --> 

	
</body>
</html>