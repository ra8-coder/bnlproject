<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">


<!-- <link rel="stylesheet" href="/webproject/resources/css/main.css" type="text/css"> -->
<link rel="stylesheet" href="/webproject/resources/common/css/bnlBSList2.css" type="text/css">
<link rel="shortcut icon" href="http://image.bandinlunis.com/favicon.ico" type="image/x-icon">
<title>2조 반디앤루니스</title>

<!-- <script type="text/javascript" src="/webproject/resources/common/js/jquery-3.3.1.js"></script> -->
<script type="text/javascript" src="/webproject/resources/common/js/common.js"></script>

<script type="text/javascript" src="/webproject/resources/common/js/swfobject.js"></script>
<script type="text/javascript" src="/webproject/resources/common/js/flashcommon.js"></script>
<script type="text/javascript" src="/webproject/resources/common/js/AC_RunActiveContent.js"></script>

<script type="text/javascript" src="/webproject/resources/js/common.js" charset="euc-kr"></script>
<script type="text/javascript" src="/webproject/resources/js/JUTIL/JUTIL.js" charset="utf-8"></script>
<script type="text/javascript" src="/webproject/resources/js/navi.js" charset="euc-kr"></script>
<script type="text/javascript" src="/webproject/resources/js/partnerHeaderInfo.js"></script>

<script type="text/javascript" src="/webproject/resources/js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/webproject/resources/js/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="/webproject/resources/js/jquery/jquery.blockUI.js"></script>
<script type="text/javascript" src="/webproject/resources/js/jquery/idangerous.swiper.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 스크립트2 시작 -->
<link rel="stylesheet" href="http://image.bandinlunis.com/common/css/pStyle.css" type="text/css">


<script type="text/javascript" src="/webproject/resources/js/jquery/jquery.min.js"></script><!-- IE8 에서 오류로 인해 일부러 넣음(jQuery 보다 dwr.util.js 가 밑에 있음 오류 발생) -->
<script type="text/javascript" src="/webproject/resources/js/multiCart.js"></script>


</head>

<body>
<jsp:include page="../common/header.jsp" flush="false"/>

<div id="wrap">
	
	<!-- body -->
	<div id="contentBody">
		<div id="contentWrap">
			<div class="conWrap">
				 				
				<div class="side_t2 ml5">
					<div class="cate_comm">
						<h2 class="cate_tit"> 
						베스트셀러		
						</h2>
						
						<ul class="cate_d1">
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1" class="cate_d1_link">종합</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=1&sort2nd=90" class="cate_d1_link">소설</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=91&sort2nd=114" class="cate_d1_link" class="cate_d1_link">장르소설</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=115&sort2nd=174" class="cate_d1_link">시/에세이/기행</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=292&sort2nd=380" class="cate_d1_link" class="cate_d1_link">인문/교양/철학</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=381&sort2nd=430" class="cate_d1_link" class="cate_d1_link">역사/신화/문화</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=431&sort2nd=473" class="cate_d1_link" class="cate_d1_link">종교</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=474&sort2nd=527" class="cate_d1_link" class="cate_d1_link">사회/정치/법률</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=197&sort2nd=254" class="cate_d1_link" class="cate_d1_link">경제/경영</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=255&sort2nd=291" class="cate_d1_link">자기계발</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=943&sort2nd=1012" class="cate_d1_link" class="cate_d1_link">외국어/사전</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=1275&sort2nd=1316" class="cate_d1_link" class="cate_d1_link">가정/생활/요리</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=1317&sort2nd=1362" class="cate_d1_link" class="cate_d1_link">건강/의학/미용</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=667&sort2nd=703" class="cate_d1_link" class="cate_d1_link">유아</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=704&sort2nd=773" class="cate_d1_link" class="cate_d1_link">어린이</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=175&sort2nd=196" class="cate_d1_link" class="cate_d1_link">청소년교양</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=528&sort2nd=666" class="cate_d1_link" class="cate_d1_link">예술/대중문화</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=1363&sort2nd=1419" class="cate_d1_link" class="cate_d1_link">여행/취미/레저</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=1420&sort2nd=1439" class="cate_d1_link" class="cate_d1_link">잡지</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=1440&sort2nd=1468" class="cate_d1_link" class="cate_d1_link">만화</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=1153&sort2nd=1274" class="cate_d1_link" class="cate_d1_link">컴퓨터/IT</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=607&sort2nd=609" class="cate_d1_link" class="cate_d1_link">자연과학/공학</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=1013&sort2nd=1152" class="cate_d1_link" class="cate_d1_link">대학교재</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=774&sort2nd=796" class="cate_d1_link" class="cate_d1_link">아동전집</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=1469&sort2nd=1518" class="cate_d1_link" class="cate_d1_link">서양서</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=798&sort2nd=839" class="cate_d1_link" class="cate_d1_link">초등참고서</a></li>
							<li class="cate_d1_li "><a href="<%=cp%>/bnlBSList.action?pageNum=1&sort1st=840&sort2nd=942" class="cate_d1_link" class="cate_d1_link">중/고등참고서</a></li>
						</ul>
					</div>
				</div>
				
				<!-- left contents -->
				<div class="con_t2">
				<form name="bestForm" action="" method="post" onsubmit="javascript:return false;">
					<input type="hidden" name="prodStat">
					<input type="hidden" name="sort">
					<input type="hidden" name="pageNum" value="1">
					
				
				<h3 class="cateTit p10"><span>종합 
				<span class="t_11gr t_normal ml5">총 판매량과 주문수를 기준으로 업데이트 됩니다.</span></span></h3>

					<!-- 정렬 -->
					<div class="prod_sort sort_ver02">								
						<div class="sorting">
							<ul class="con01">
								<li><a style="cursor:pointer;" href="<%=cp%>/bnlBSList.action?pageNum=1&sort=&sort1st=${sort1st}&sort2nd=${sort2nd}" >순위 높은 순</a></li>
								<li><a style="cursor:pointer;" href="<%=cp%>/bnlBSList.action?pageNum=1&sort=sort1&sort1st=${sort1st}&sort2nd=${sort2nd}">발행일순</a></li>
								<li><a style="cursor:pointer;" href="<%=cp%>/bnlBSList.action?pageNum=1&sort=sort2&sort1st=${sort1st}&sort2nd=${sort2nd}">상품명순</a></li>
								<li><a style="cursor:pointer;" href="<%=cp%>/bnlBSList.action?pageNum=1&sort=sort3&sort1st=${sort1st}&sort2nd=${sort2nd}">평점순</a></li>
								<li class="alt"><a style="cursor:pointer;" href="<%=cp%>/bnlBSList.action?pageNum=1&sort=sort4&sort1st=${sort1st}&sort2nd=${sort2nd}">리뷰순</a></li> 
							</ul> 
						</div>
					</div>

						<!-- page -->
						<div class="pageTypeA pageTypeB">
							
							<!-- jQuery로 class on 하는 거 나중에 하기  -->
							<a href="<%=cp%>/bnlBSList.action?pageNum=1&sort=${sort }&sort1st=${sort1st}&sort2nd=${sort2nd}">1~10위</a>
							<a href="<%=cp%>/bnlBSList.action?pageNum=2&sort=${sort }&sort1st=${sort1st}&sort2nd=${sort2nd}">21~40위</a>
							<a href="<%=cp%>/bnlBSList.action?pageNum=3&sort=${sort }&sort1st=${sort1st}&sort2nd=${sort2nd}">41~60위</a>
							<a href="<%=cp%>/bnlBSList.action?pageNum=4&sort=${sort }&sort1st=${sort1st}&sort2nd=${sort2nd}">61~80위</a>
							<a href="<%=cp%>/bnlBSList.action?pageNum=5&sort=${sort }&sort1st=${sort1st}&sort2nd=${sort2nd}">81~100위</a>

						</div>
					<!-- //page --> 
					
<!-- EL / JSTL / Foreach  -->
					<c:forEach var="dto" items="${lists }">
					
					<div class="prod_list_type prod_best_type">
						<ul>	        	
			         	<li>
			         		
			         		<input type="hidden" name="maxQuantity" id="maxQuantity" value="${dto.maxQuantity }"/>
							<div class="prod_thumb">
								<span class="ranking">
									<span class="rank_num">${dto.rnum }</span>
									<span class="rank_change">
											<img src="http://image.bandinlunis.com/images/common/2014/ico_best_same.gif" alt="-">
										<!-- 0 -->		
									</span>
								</span>
								<div class="prod_thumb_img">
									<a href="<%=cp %>/book_info.action?isbn=${dto.isbn}" onfocus="this.blur();">
										<img src="<%=cp %>/resources/image/book/${dto.bookImage }">
									</a>
									<a class="btn_popup" target="_blank" href="<%=cp %>/book_info.action?isbn=${dto.isbn}"><span class="ico_new">새창열기</span></a>
								</div>
									<a class="btn_preview" target="_blank" href="<%=cp %>/book_preview.action?isbn=${dto.isbn }">미리 보기</a>			
							</div>
							
							<dl class="prod_info">
								<dt>
									<a href="<%=cp %>/book_info.action?isbn=${dto.isbn}" onfocus="this.blur();">
										  ${dto.bookTitle }
									</a> 												
									<span class="tag_area">
										<span class="tag_best"><span>베스트</span></span>
										<span class="tag_recom"><span>반디추천</span></span>
										<span class="tag_free"><span>무료배송</span></span>
									</span>
								</dt>
								<dd class="txt_block">
									<span>${dto.authorName }</span> <span class="gap">|</span> <span>${dto.publisher }</span>
									<span class="txt_date"><span class="gap">|</span> <span>${dto.publishDate }</span></span>
								</dd>
								<dd class="mt5"><p><span class="txt_reprice">${dto.bookPrice }</span> <span class="txt_arrow">→</span> 
													<span class="txt_price"><strong><em>${dto.discountedPrice }</em>원</strong>
													 (${dto.discountRate }%↓+5%P)</span></p></dd>
								<dd class="txt_desc">
									<div class="review_point"><span style="width: ${dto.rate*10 }%;"></span></div>
									<strong>${dto.rate }</strong>
									<a href="/front/product/detailProduct.do?isbn=4181047#sub10" target="_blank">리뷰<em>(${dto.reviewCnt })</em></a>
								</dd>
								<dd class="txt_bex">
									${dto.introduction }...
								</dd>
									<dd class="txt_ebook">
									<span>지금 주문하면 <strong class="t_red">3일</strong> 뒤에 받을 수 있습니다.</span>
									</dd>
							</dl>
							
							<c:choose>
								<c:when test="${dto.maxQuantity ne 0}">
									<dl class="prod_btn">
										<dt>
											<input type="hidden" id="cart_isbn${dto.isbn }" value="${dto.isbn }">
											<input type="hidden" name="isbn" id="isbn" value=""/>
											<input type="hidden" name="orderCount" id="orderCount" value=""/>
											구입 가능 권수 - <strong class="t_red">${dto.maxQuantity }</strong>권<span class="num_txt">수량</span>
											<input type="text" id="cntVal_${dto.isbn }" value="1" class="num" size="3" maxlength="2" onkeydown="onlyNumber();" onkeyup="">
											<span class="btn_updn_wrap">
												<a href="javascript:cntUp('${dto.isbn }','${dto.maxQuantity }');" class="btn_num_up">▲</a>
												<a href="javascript:cntDown('${dto.isbn }','${dto.maxQuantity }');" class="btn_num_dn">▼</a>
											</span>
										</dt>
										
										<dd><a href="javascript:addCart('${dto.isbn }');"><span class="btn_b_comm btype_f1">쇼핑카트</span></a></dd>
										<dd class="mt3"><a href="javascript:goOrder('${dto.isbn }');"><span class="btn_w_comm btype_f1">바로구매</span></a></dd>
									</dl>
								</c:when>
								
								<c:otherwise>
									<dl class="prod_btn">
										<dt>
											구입 가능 권수 - <strong class="t_red">${dto.maxQuantity }</strong>권<span class="num_txt">수량</span>
											<input type="text" id="cntVal_${dto.isbn }" value="0" class="num" size="3" maxlength="2" onkeydown="onlyNumber();" onkeyup="" readonly="readonly">
											<span class="btn_updn_wrap">
												<a href="javascript:cntUp('${dto.isbn }','${dto.maxQuantity }');" class="btn_num_up">▲</a>
												<a href="javascript:cntDown('${dto.isbn }','${dto.maxQuantity }');" class="btn_num_dn">▼</a>
											</span>
										</dt>
										
										<dd><a href=""><span class="btn_gy_comm btype_f1">상품문의하기</span></a></dd>
										<%-- <dd class="mt3"><a href="javascript:goOrder('${dto.isbn }');"><span class="btn_w_comm btype_f1">바로구매</span></a></dd> --%>
									</dl>
								</c:otherwise>
							</c:choose>
							
						</li>						
						</ul>							
					</div>
					</c:forEach>
					<!-- page -->
					<div class="pageTypeA pageTypeB">

						<a href="<%=cp%>/bnlBSList.action?pageNum=1&sort=${sort }&sort1st=${sort1st}&sort2nd=${sort2nd}">1~10위</a>
						<a href="<%=cp%>/bnlBSList.action?pageNum=2&sort=${sort }&sort1st=${sort1st}&sort2nd=${sort2nd}">11~20위</a>
						<a href="<%=cp%>/bnlBSList.action?pageNum=3&sort=${sort }&sort1st=${sort1st}&sort2nd=${sort2nd}">21~30위</a>
						<a href="<%=cp%>/bnlBSList.action?pageNum=4&sort=${sort }&sort1st=${sort1st}&sort2nd=${sort2nd}">31~40위</a>
						<a href="<%=cp%>/bnlBSList.action?pageNum=5&sort=${sort }&sort1st=${sort1st}&sort2nd=${sort2nd}">41~50위</a>

					</div>

					<!-- //page --> 
				</form>
				</div>
				<!-- //left contents --> 
				
			</div>
		</div>
	</div>
	<!-- //body -->

</div>
<jsp:include page="../common/footer.jsp" flush="false" />
</body>
</html>