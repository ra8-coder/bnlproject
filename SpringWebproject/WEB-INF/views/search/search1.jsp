<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/webproject/resources/css/searchN.css"	type="text/css">
<script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/js/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="/js/jquery/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/common.js" charset="euc-kr"></script>
<script type="text/javascript" src="/js/JUTIL/JUTIL.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/partnerHeaderInfo.js"></script>
<script type="text/javascript" src="https://wcs.naver.net/wcslog.js"></script>
</head>

<body><jsp:include page="../main/header.jsp" flush="false" /></body>
<div class="min_height">
	<!-- 컨텐츠 영역 -->
	<article id="bandiContainer" style=""> <!-- 상단 검색 키워드 영역 -->
	<!-- 검색 결과 값 영역 -->
	<div id="topResult">
		<div class="search_data">
			<p id="AREA_TOTAL">
				<em class="emph_on">'설거지'</em>(으)로 통합검색 <em class="emph_on">30</em>건
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
								<a href="javascript:goSearchCate('');" class="stit_more"><em>전체</em>
									<span>(22)</span></a>
							</div>
						</li>
						<li>
							<div class="btn_sub_area">
								<a href="javascript:showMoreCate('01');" class="btn_sub_more"
									id="book_category_sub_01" style="display: block;">더보기</a>
							</div>
							<ul class="book_category" id="book_category_01" style="">
								<li class=""><a href="javascript:goSearchCate('01_3139');">어린이<span>
											(13,274)</span></a></li>
								<li class=""><a href="javascript:goSearchCate('01_6706');">중/고등참고서<span>
											(11,787)</span></a></li>
								<li class=""><a href="javascript:goSearchCate('01_11');">외국어/사전<span>
											(10,096)</span></a></li>
								<li class=""><a href="javascript:goSearchCate('01_18');">예술/대중문화<span>
											(8,598)</span></a></li>
								<li class=""><a href="javascript:goSearchCate('01_24');">대학교재<span>
											(7,551)</span></a></li>
								
								
							</ul>
							<div class="stit " id="left_cate_grp_01">
								<a href="javascript:showCateGrp('01');" class="btn_more"
									style="display: none;"></a> <a
									href="javascript:goSearchCate('01');" class="stit_more"><em>국내도서</em>
									<span>(120,648)</span></a>
							</div>
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
											autocomplete="off" value="설거지"
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
						href="#AREA_G_2" id="PRODUCT_TOTAL">상품 [22]</a></span><span><a
						href="#AREA_G_3_1" id="TODAY_TOTAL">오늘의 책 [7]</a></span><span><a
						href="#AREA_G_3_2" id="THEME_TOTAL">테마북 [1]</a></span></span>
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
		<!--// 수상작 영역 --> <!-- 검색 리스트 시작 -->

		<div class="view_type" id="AREA_G_2">
			<c:forEach var="dto" items="${searchBook }">
				<ul>
					<li>
						<div class="thumb_area" onmouseover="onImage(4109026);"
							onmouseout="outImage(4109026);">
							<div class="thumb_left_big">
								<a href="/front/product/detailProduct.do?prodId=4109026"> <img
									src="<%=cp%>/resources/image/book/${dto.bookImage}"
									onerror="this.src='/images/common/noimg_type01.gif'">


								</a>
							</div>
							<div class="btn_popup">
								<a href="/front/product/detailProduct.do?prodId=4109026"
									class="btn_new" id="blank_link_4109026" target="_blank"
									style="display: none;"><span class="ico_new">새창열기</span></a>
							</div>
						</div>

						<dl class="book_contents">
							<dt>
								<a href="/front/product/detailProduct.do?prodId=4109026"><span
									class="tit_category"></span>${dto.bookTitle }</a> <span
									class="tit_sub">- ${dto.subTitle }</span>
								<div class="tag_area">
									<span class="tag_recom"><span>반디 추천</span></span><span
										class="tag_free"><span>무료 배송</span></span>
								</div>
							</dt>
							<dd class="txt_block">
								<span class="info"><span class="author first_child">
										<a href="#"
										onclick="javascript:changeKwd('${dto.authorName}');">${dto.authorName }</a>
										저
								</span><span class="publisher"><a href="#"
										onclick="javascript:changeKwd('${publisher }');">${publisher }</a></span><span
									class="pubdate">${dto.publishDate }</span></span>
							</dd>
							<dd class="txt_price">
								<p>
									<span>${dto.bookPrice }</span> → <strong><em>${dto.bookPrice *0.9 }</em>원</strong>
									(<em>10%</em>할인 + <em>5%</em>포인트)
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
			<a href="/search/search.do" onclick="pageMove(0); return false;"
				class="on">1</a><a href="/search/search.do"
				onclick="pageMove(1); return false;" class="">2</a><a
				href="/search/search.do" onclick="goNextPage(); return false;"
				class="next">next</a>
		</div>
		<!--// 페이징 영역 --> </section>
	</div>
	</article>
</div>

</body>
</html>