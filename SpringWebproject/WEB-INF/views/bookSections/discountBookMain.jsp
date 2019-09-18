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

<link rel="stylesheet" href="/webproject/resources/common/css/bnlBSList2.css" type="text/css">
<link rel="shortcut icon" href="http://image.bandinlunis.com/favicon.ico" type="image/x-icon">
<title>2조 반디앤루니스</title>

<script type="text/javascript" src="/webproject/resources/common/js/common.js"></script>
<script type="text/javascript" src="/webproject/resources/common/js/swfobject.js"></script>
<script type="text/javascript" src="/webproject/resources/common/js/flashcommon.js"></script>
<script type="text/javascript" src="/webproject/resources/common/js/AC_RunActiveContent.js"></script>


<script type="text/javascript" src="/webproject/resources/js/common.js" charset="utf-8"></script>
<script type="text/javascript" src="/webproject/resources/js/JUTIL/JUTIL.js" charset="utf-8"></script>
<script type="text/javascript" src="/webproject/resources/js/navi.js" charset="utf-8"></script>
<script type="text/javascript" src="/webproject/resources/js/partnerHeaderInfo.js"></script>

<script type="text/javascript" src="/webproject/resources/js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/webproject/resources/js/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="/webproject/resources/js/jquery/jquery.blockUI.js"></script>
<script type="text/javascript" src="/webproject/resources/js/jquery/idangerous.swiper.js"></script>



<style type="text/css">
	.m_tit{font:normal 20px '맑은 고딕','돋움';color:#000;height:24px;padding-left:5px;padding-bottom:10px}
	.m_tit_l{font:normal 20px '맑은 고딕','돋움';color:#000;height:24px;padding-left:5px;padding-bottom:10px;border-bottom:1px solid #e1e1e1}
	.m_tit_s{font:normal 18px '맑은 고딕','돋움';color:#000;height:24px;padding:18px 0 10px 24px}
	.tap_div_3 li{width:320px}
	.d_area_recomm {position:relative;margin-top:60px;clear:both; margin-top:60px}
	.d_area_recomm .swiper-container{clear:both;width:958px;padding-bottom:30px;hheight:360px;border:1px solid #e9e9e9}
	.d_area_recomm .d_area_list{margin:25px 0 0 38px;width:940px}
	.d_area_recomm .d_area_list li{float:left;width:168px;hheight:310px;margin:0 26px}
	.d_area_recomm .d_area_list .b_img{width:168px;text-align:center}.d_area_recomm .d_area_list .b_img img{width:166px;height:235px;border:1px solid #e9e9e9}
	.d_area_recomm .d_area_list dl {float:left;width:168px;margin-top:12px;font-family:돋움}
	.d_area_recomm .d_area_list dl dt{font-size:12px;letter-spacing:-0.02em;line-height:120%;font-weight:bolder}.d_area_recomm .d_area_list dl dt a{color:#333}
	.d_area_recomm .d_area_list dl .b_author{font-size:11px;margin-top:3px;line-height:130%}
	.d_area_recomm .d_area_list  .t_cate{text-align:center;margin-bottom:7px;width:168px;color:#1495cf}
	.d_area_recomm .btn_more_2014{position:absolute;right:5px;top:10px}
	.d_area_3div{width:655px;border:1px solid #e9e9e9;float:left}
	.d_area_3div .swiper-container{clear:both;width:655px;border:none}
	.d_area_3div .d_area_list li{float:left;width:132px;margin:0 30px}
	.d_area_3div .d_area_list .b_img{width:132px;text-align:center}.d_area_3div .d_area_list .b_img img{width:130px;height:185px;border:1px solid #e9e9e9}
	.d_area_3div .btn_more_2014{position:absolute;right:15px;top:20px}
	
	.d_md_recomm{overflow:hidden;margin-top:40px}
	.d_md_book{float:left;width:645px;margin:30px 0 0 0;position:relative}
	.d_md_book .swiper-container{clear:both;width:590px;height:270px;margin-left:30px}
	.d_md_book .b_img{float:left;width:180px}
	.d_md_book .b_img img{width:178px;border:1px solid #e1e1e1}
	.d_md_book dl{float:left;width:370px;margin:5px 0 0 20px}
	.d_md_book dt{font:bolder 16px 돋움; color:#000;margin-bottom:5px}
	.d_md_book dt a{color:#000}
	.d_md_book dd.t_txt{color:#888;margin-top:15px;line-height:150%}
	.d_md_book .aw_l, .d_md_book .aw_r{border:none;top:38%;z-index:10}
	.d_md_book .aw_l:hover{border-top:1px solid #666;border-bottom:1px solid #666;border-right:1px solid #666}
	.d_md_book .aw_r:hover{border-top:1px solid #666;border-bottom:1px solid #666;border-left:1px solid #666}
	.d_md_list{float:right;width:300px;height:250px;;margin:37px 15px 0 0 ;}
	.d_md_list li{float:left;width:81px;height:114px;margin:0 0 18px 18px}
	.d_md_list li img{float:left;width:75px;height:108px;border:3px solid #e1e1e1;cursor:pointer}
	.d_md_list li.active img{border:3px solid #58a7c8}
	
	.d_new_book{float:left;width:655px;height:310px;border:1px solid #e1e1e1;margin-top:60px;position:relative}
	
	.d_new_book .d_area_list {margin:0 0 0 20px}
	.d_new_book .d_area_list li{float:left;width:310px;margin:10px 3px}
	.d_new_book .d_area_list  .b_img{float:left;width:130px;text-align:center}.d_new_book .b_img img{width:128px;border:1px solid #e9e9e9}
	.d_new_book .d_area_list  dl {float:left;width:158px;margin:5px 0 0 12px;font-family:돋움}
	.d_new_book .d_area_list  dl dt{font-size:12px;letter-spacing:-0.02em;line-height:120%;font-weight:bolder}.d_new_book dl dt a{color:#333}
	.d_new_book .d_area_list  dl .b_author{font-size:11px;margin-top:3px;line-height:130%}
	.d_new_book .d_area_list  dl .t_cate{margin-bottom:7px;color:#1495cf}
	.d_new_book .btn_more_2014{position:absolute;right:15px;top:20px}
	.d_new_book .aw_type_num{position:absolute;right:15px;bottom:20px}
	
	.d_best{float:left;width:288px;height:310px;border:1px solid #e1e1e1;margin-left:13px;margin-top:60px}
	.d_best .ranking_list{width:250px;margin:10px 0 0 25px}
	.d_best .ranking_list li{margin-bottom:10px;height:14px}
	.d_best .ranking_list li .num{float:left;width:12px;height:11px;text-align:center;color:#FFF;font:normal 11px 돋움;padding-top:1px;border:1px solid #85755c;background:#a48b6d;letter-spacing:-0.05em}
	.d_best .ranking_list li:hover .num{border:1px solid #0f87bc;background:#1495ce}
	.d_best .ranking_list li .r_book{float:left;margin:0 0 0 7px;height:13px;padding:0;width:229px}
	.d_best .btn_more_2014{position:absolute;bottom:10px;left:140px}
	.d_best .best_ad{position:absolute;top:75px;right:14px;z-index:110}
	
	.d_tem_row{float:left;width:288px;height:380px;border:1px solid #e1e1e1;margin-left:13px;margin-top:60px;position:relative}
	.d_tem_row .d_area_list{margin:20px 0 0 20px}
	.d_tem_row .d_area_list li{width:250px;margin:10px 0 20px 0;overflow:hidden; }
	.d_tem_row  .b_img{float:left;width:82px;text-align:center}.d_tem_row .b_img img{width:80px;border:1px solid #e9e9e9}
	.d_tem_row  dl {float:left;width:158px;margin:5px 0 0 10px;font-family:돋움}
	.d_tem_row  dl dt{font-size:12px;letter-spacing:-0.02em;line-height:120%;font-weight:bolder}.d_new_book dl dt a{color:#333}
	.d_tem_row  dl .b_author{font-size:11px;margin-top:3px;line-height:130%}
	.d_tem_row  dl .t_cate{margin-bottom:7px;color:#1495cf}
	.d_tem_row .btn_more_2014{position:absolute;right:15px;top:20px}
	.d_tem_row .aw_type_num{position:absolute;right:15px;bottom:20px;z-index:110}
</style>

<!-- <link rel="stylesheet" href="/webproject/resources/common/css/dcBookMainSwiper.css" type="text/css"> -->

</head>
<body>
<jsp:include page="../common/header.jsp" flush="false"/>

<div id="contentBody">


		<div id="contentWrap">
			<h2 class="ml10 mt30  mb10 lh0"><img src="http://image.bandinlunis.com/images/specialBook/tit_h3_discount.gif" alt="정가인하도서" class="lh0"></h2>

			<div class="content">
				<ul class="tap_menu_d1 tap_div_3 mb20">
                	<li><a href="<%=cp %>/discountBookMain.action" class="on alt">추천</a></li>
                	<li><a href="<%=cp %>/discountBookList.action?theMonth=1">이달의 신규등록</a></li>
                	<li><a href="<%=cp %>/discountBookList.action?theMonth=">분야별 전체</a></li>
                </ul>
                
				<div class="d_md_recomm">
					<h3 class="m_tit_l"><span>정가인하 추천도서</span></h3>
					<div class="d_md_book" id="mdBookList">
						<div class="aw_type_box">
							<button class="aw_l" id="mdRecommAreaLt"><span class="ns">이전</span><span class="aw_count"><span class="start_index">2</span>/<span class="end_index">6</span></span></button>
							<button class="aw_r" id="mdRecommAreaRt"><span class="ns">다음</span><span class="aw_count"><span class="start_index">2</span>/<span class="end_index">6</span></span></button>
			 			</div>
						<div class="swiper-container">
							<div class="swiper-wrapper" style="width: 4720px; height: 270px; transform: translate3d(-1180px, 0px, 0px); transition-duration: 0.5s;">
							
							<c:forEach var="dto" items="${dcSixSlideLists }">
								<ul class="swiper-slide swiper-slide-duplicate" style="width: 590px; height: 270px;">
									<li>
										<div class="b_img">
											<a href="/front/product/detailProduct.do?prodId=3835347">
												<img src="<%=cp %>/resources/image/book/${dto.bookImage }" alt="">
											</a>
										</div>
										<dl>
											<dt><a href="/front/product/detailProduct.do?prodId=3835347">[정가인하] ${dto.bookTitle }</a></dt>
											<dd class="b_author">${dto.authorName } </dd>
											<dd class="mt15"><span class="rPrice">${dto.bookPrice }원</span> → ${dto.discountedPrice }원(<strong>${dto.discountRate }%↓</strong>)</dd>
											<dd class="price">판매가 : <strong><fmt:formatNumber value="${dto.discountedPrice*0.9 }" type="number"/>원</strong></dd>
											<dd class="t_txt">
												 ${dto.introduction }
											</dd>
										</dl> 
									</li>
								</ul>
							</c:forEach>
								
							</div>
						</div>
					</div>
					<div class="pagination">
						<span class="swiper-pagination-switch"></span>
						<span class="swiper-pagination-switch swiper-visible-switch swiper-active-switch"></span>
						<span class="swiper-pagination-switch"></span>
						<span class="swiper-pagination-switch"></span>
						<span class="swiper-pagination-switch"></span>
						<span class="swiper-pagination-switch"></span>
					</div>
					<ul class="d_md_list">
						<c:forEach var="dto" items="${dcSixSlideLists }">
						<li class="">
							<a href="/front/product/detailProduct.do?prodId=3796784">
								<img src="<%=cp %>/resources/image/book/${dto.bookImage }">
							</a>
						</li>
						</c:forEach>
						
					</ul>
				</div>
                
				<div class="d_area_recomm" id="discountAreaRecomm">
					<h3 class="m_tit"><span>분야 별 정가인하</span></h3>		
					<a href="<%=cp%>/discountBookList.action?theMonth=" class="btn_more_2014"><span>더보기</span></a>
					<div class="newBookArea">
						<div class="aw_type_box">
							<button class="aw_l" id="recommAreaLt"><span class="ns">이전</span><span class="aw_count"><span class="start_index">${start }</span>/<span class="end_index">${end }</span></span></button>
							<button class="aw_r" id="recommAreaRt"><span class="ns">다음</span><span class="aw_count"><span class="start_index">${start }</span>/<span class="end_index">${end }</span></span></button>
			 			</div>
						<div class="swiper-container">
							<ul class="swiper-wrapper" style="width: 4790px; transform: translate3d(-958px, 0px, 0px); transition-duration: 0s; height: 384px;">
							
							<c:set var="i" value="0"/>	
							<c:forEach var="dto" items="${dcRnumSlideLists}">
							<c:if test="${i eq 0 }">
								<li class="swiper-slide swiper-slide-duplicate swiper-slide-visible swiper-slide-active" style="width: 958px; height: 384px;">
									<ul class="d_area_list">
							</c:if>
									
										<li>
											<div class="t_cate">[${dto.genre }]</div>
											<div class="b_img">
												<a href="<%=cp %>/book_info.action?isbn=${dto.isbn}">
													<img src="<%=cp %>/resources/image/book/${dto.bookImage }" alt="">
												</a>
											</div>
											<dl>
												<dt><a href="<%=cp %>/book_info.action?isbn=${dto.isbn}">[정가인하] ${dto.bookTitle }</a></dt>
												<dd class="b_author">${dto.authorName }</dd>
												<dd class="mt10"><span class="rPrice">${dto.bookPrice }원</span> → ${dto.discountedPrice }원(<strong>${dto.discountRate }%↓</strong>)</dd>
												<dd class="price">판매가 : <strong><fmt:formatNumber value="${dto.discountedPrice*0.9 }" type="number"/>원</strong></dd>
											</dl>
										</li>
							<c:set var="i" value="${i+1 }"/>
							<c:if test="${i eq 4 }">
									</ul>
								</li>
							<c:set var="i" value="0"/>
							</c:if>

							</c:forEach>	
							
							</ul>
						</div>
						<div class="pagination">
							<span class="swiper-pagination-switch swiper-visible-switch swiper-active-switch"></span>
							<span class="swiper-pagination-switch"></span>
							<span class="swiper-pagination-switch"></span>
						</div>
					</div>
				</div>	
				

				
				<div class="overflow" style="margin-bottom: 20px;">
					<div class="d_new_book" id="discountTemType_3">
						<h3 class="m_tit_s"><span>이 달의 정가인하도서</span></h3>
						<a href="<%=cp %>/discountBookList.action" class="btn_more_2014"><span>더보기</span></a>
						<div class="swiper-container">
							<ul class="swiper-wrapper" style="width: 3930px; transform: translate3d(-655px, 0px, 0px); transition-duration: 0s; height: 219px;">
							
						<c:set var="i" value="0"/>	
							<c:forEach var="dto" items="${dcOfTheMonth }">
								<c:if test="${i eq 0 }">
								<li class="swiper-slide swiper-slide-duplicate" style="width: 655px; height: 219px;">	
								<ul class="d_area_list">
								</c:if>						
									
								
									<li>
										<div class="b_img">
											<a href="<%=cp %>/book_info.action?isbn=${dto.isbn}">
												<img src="<%=cp %>/resources/image/book/${dto.bookImage }" alt="">
											</a>
										</div>
										<dl>
											<dt><a href="<%=cp %>/book_info.action?isbn=${dto.isbn}">[정가인하] ${dto.bookTitle }</a></dt>
											<dd class="b_author">스티븐영</dd>
											<dd class="mt10"><span class="rPrice">${dto.bookPrice }원</span> → ${dto.discountedPrice }원(<strong>${dto.discountRate }%↓</strong>)</dd>
											<dd class="price mt5">판매가 : <strong><fmt:formatNumber value="${dto.discountedPrice*0.9 }" type="number"/></strong></dd>
										</dl>
									</li>
								<c:set var="i" value="${i+1 }"/>
								<c:if test="${i eq 2 }">
								</ul>
								</li>
								<c:set var="i" value="0"/>
								</c:if>

							</c:forEach>	
							
							</ul>
						</div>
						<div class="pagination">
							<span class="swiper-pagination-switch swiper-visible-switch swiper-active-switch"></span>
							<span class="swiper-pagination-switch"></span>
							<span class="swiper-pagination-switch"></span>
							<span class="swiper-pagination-switch"></span>
						</div>
						<div class="aw_type_num">
							
							<span class="on">1</span>
							
							<span>2</span>
							
							<span>3</span>
							
							<span>4</span>
							
						</div>
					</div>
					<div class="d_best">
						<h3 class="m_tit_s"><span>베스트셀러</span></h3>
						<ul class="ranking_list">
							
						<c:forEach var="dto" items="${bestSellerTop10 }">	
							<li><span class="num">${dto.rnum }</span> <a href="<%=cp %>/book_info.action?isbn=${dto.isbn}" class="r_book">${dto.bookTitle }</a></li>
						</c:forEach>
							
			      		</ul>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	


<!-- 동적으로 만들어주는 스크립트  -->
<script type="text/javascript">
$(document).ready(function(){
	templateRearrange();

});

	function templateRearrange() {
		
			$("#sortableArea").append($("#discountTemType_204"));
		
			$("#sortableArea").append($("#discountTemType_205"));
		
			$("#sortableArea").append($("#discountTemType_206"));
		
	}

	var mdBookTab = new Swiper('#mdBookList .swiper-container',{
	    onlyExternal : true,
	    pagination: '.d_md_recomm .pagination',
	    loop:true,
	/*     autoplay: 5000,
	    speed:500,
	    autoplayDisableOnInteraction: false, */
	    //autoplayStopOnLast: true,
	    paginationClickable: true,
	    onSlideChangeStart: function(){
	      $(".d_md_recomm .start_index").html(mdBookTab.activeLoopIndex + 1);	   
	      $(".d_md_recomm .d_md_list .active").removeClass('active');	   
	      var tabIndex = 0;
	      var kwLength = $(".d_md_recomm .d_md_list li").length;
	      if(kwLength == mdBookTab.activeIndex-1){
	    	  tabIndex = 0;
	      }else{
	    	  tabIndex = mdBookTab.activeIndex-1;
	      }
	      $(".d_md_recomm .d_md_list li").eq(tabIndex).addClass('active');
	    }
	  });	  
	  $(".d_md_recomm .end_index").html(mdBookTab.paginationButtons.length);	
	  $(".d_md_recomm .d_md_list li").mouseover('touchstart mousedown',function(e){
	    e.preventDefault();
	    $(".d_md_recomm .d_md_list .active").removeClass('active');
	    
	    $(this).addClass('active');
	    mdBookTab.swipeTo( $(this).index() );
	  });
	  $('#mdRecommAreaLt').on('click', function(e){
	    e.preventDefault();
	    mdBookTab.swipePrev();
	  });
	  $('#mdRecommAreaRt').on('click', function(e){
	    e.preventDefault();
	    mdBookTab.swipeNext();
	  });
	  $(".d_md_recomm").mouseover(function(){
		  mdBookTab.stopAutoplay();
		  })
	 $(".d_md_recomm").mouseout(function(){
		 mdBookTab.startAutoplay();
		  })
	  
	 var dRecommBook = new Swiper('#discountAreaRecomm .swiper-container',{
		    pagination: '#discountAreaRecomm .pagination',
		    /* slidesPerView: 4, */
		    loop:true,
		    simulateTouch: true,
		    paginationClickable: true,
			watchActiveIndex: true,
			calculateHeight:true,
			//paginationAsRange:true,
			//createPagination:false,
		    onSlideChangeEnd: function () { 
		       $("#discountAreaRecomm .start_index").html(dRecommBook.activeLoopIndex + 1);	   
		    }
		  });
		  $("#discountAreaRecomm .end_index").html(dRecommBook.paginationButtons.length);		  
		  $('#recommAreaLt').on('click', function(e){
		    e.preventDefault();
		    dRecommBook.swipePrev();
		  });
		  $('#recommAreaRt').on('click', function(e){
		    e.preventDefault();
		    dRecommBook.swipeNext();
		  });
		  
	  var dTemBook_3 = new Swiper('#discountTemType_3 .swiper-container',{
		    pagination: '#discountTemType_3 .pagination',
		    loop:true,
		    simulateTouch: true,
		    paginationClickable: true,
			watchActiveIndex: true,
			calculateHeight:true,
		    onSlideChangeStart: function(){
		      $("#discountTemType_3 .aw_type_num .on").removeClass('on');	   
		      var tabIndex = 0;
		      var kwLength = $("#discountTemType_3 .aw_type_num span").length;
		      if(kwLength == dTemBook_3.activeIndex-1){
		    	  tabIndex = 0;
		      }else{
		    	  tabIndex = dTemBook_3.activeIndex-1;
		      }
		      $("#discountTemType_3 .aw_type_num span").eq(tabIndex).addClass('on');
		    }
		  });
		  $("#discountTemType_3 .aw_type_num span").mouseover('touchstart mousedown',function(e){
		    e.preventDefault();
		    $("#discountTemType_3 .aw_type_num .on").removeClass('on');
		    
		    $(this).addClass('on');
		    dTemBook_3.swipeTo( $(this).index() );
		  });
		  
	  var dTemBook_4 = new Swiper('#discountTemType_4 .swiper-container',{
		    pagination: '#discountTemType_4 .pagination',
		    loop:true,
		    simulateTouch: true,
		    paginationClickable: true,
			watchActiveIndex: true,
			calculateHeight:true,
		    onSlideChangeEnd: function () { 
		       $("#discountTemType_4 .start_index").html(dTemBook_4.activeLoopIndex + 1);	   
		    }
		  });
		  $("#discountTemType_4 .end_index").html(dTemBook_4.paginationButtons.length);		  
		  $('#discountTemLt_4').on('click', function(e){
		    e.preventDefault();
		    dTemBook_4.swipePrev();
		  });
		  $('#discountTemRt_4').on('click', function(e){
		    e.preventDefault();
		    dTemBook_4.swipeNext();
		  });		
		  
	  var dTemBook_5 = new Swiper('#discountTemType_5 .swiper-container',{
		    pagination: '#discountTemType_5 .pagination',
		    loop:true,
		    simulateTouch: true,
		    paginationClickable: true,
			watchActiveIndex: true,
			calculateHeight:true,
		    onSlideChangeStart: function(){
		      $("#discountTemType_5 .aw_type_num .on").removeClass('on');	   
		      var tabIndex = 0;
		      var kwLength = $("#discountTemType_5 .aw_type_num span").length;
		      if(kwLength == dTemBook_5.activeIndex-1){
		    	  tabIndex = 0;
		      }else{
		    	  tabIndex = dTemBook_5.activeIndex-1;
		      }
		      $("#discountTemType_5 .aw_type_num span").eq(tabIndex).addClass('on');
		    }
		  });
	  
		  $("#discountTemType_5 .aw_type_num span").mouseover('touchstart mousedown', function(e){
		    e.preventDefault();
		    $("#discountTemType_5 .aw_type_num .on").removeClass('on');
		    
		    $(this).addClass('on');
		    dTemBook_5.swipeTo( $(this).index() );
		  });

	  
	  
	  var dTemBook_204 = new Swiper('#discountTemType_204 .swiper-container',{
		    pagination: '#discountTemType_204 .pagination',
		    loop:true,
		    simulateTouch: true,
		    paginationClickable: true,
			watchActiveIndex: true,
			calculateHeight:true,
		    onSlideChangeEnd: function () { 
		       $("#discountTemType_204 .start_index").html(dTemBook_204.activeLoopIndex + 1);	   
		    }
		  });
		  $("#discountTemType_204 .end_index").html(dTemBook_204.paginationButtons.length);		  
		  $('#discountTemLt_204').on('click', function(e){
		    e.preventDefault();
		    dTemBook_204.swipePrev();
		  });
		  $('#discountTemRt_204').on('click', function(e){
		    e.preventDefault();
		    dTemBook_204.swipeNext();
		  });
	  
	  
	  
	  var dTemBook_205 = new Swiper('#discountTemType_205 .swiper-container',{
		    pagination: '#discountTemType_205 .pagination',
		    loop:true,
		    simulateTouch: true,
		    paginationClickable: true,
			watchActiveIndex: true,
			calculateHeight:true,
		    onSlideChangeEnd: function () { 
		       $("#discountTemType_205 .start_index").html(dTemBook_205.activeLoopIndex + 1);	   
		    }
		  });
		  $("#discountTemType_205 .end_index").html(dTemBook_205.paginationButtons.length);		  
		  $('#discountTemLt_205').on('click', function(e){
		    e.preventDefault();
		    dTemBook_205.swipePrev();
		  });
		  $('#discountTemRt_205').on('click', function(e){
		    e.preventDefault();
		    dTemBook_205.swipeNext();
		  });
  	  
</script>
<!-- 동적으로 만들어주는 스크립트 끝  --> 


<jsp:include page="../common/footer.jsp" flush="false" />
</body>
</html>