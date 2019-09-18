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
<title>도서 상세페이지</title>
<link rel="stylesheet"
	href="/webproject/resources/common/css/bnlBSList2.css" type="text/css">
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
<script type="text/javascript" charset="UTF-8"
	src="http://s.n2s.co.kr/_n2s_ck_log.php"></script>

<script type="text/javascript" src="/webproject/resources/js/dwr.js"
	charset="euc-kr"></script>
<script type="text/javascript"
	src="/webproject/resources/js/jquery/jquery.min.js"></script>
<!-- IE8 에서 오류로 인해 일부러 넣음(jQuery 보다 dwr.util.js 가 밑에 있음 오류 발생) -->
<script type="text/javascript"
	src="/webproject/resources/js/multiCart.js"></script>

<script type="text/javascript"
	src="/springwebview/resources/js/JUTIL/JUTIL.js"></script>
<script type="text/javascript"
	src="/springwebview/resources/js/jquery/jquery.min.js"></script>
<script type="text/javascript"
	src="/springwebview/resources/js/swfobject.js"></script>
<link rel="stylesheet" href="/webproject/resources/book_css/class.css"
	type="text/css">


<link rel="stylesheet"
	href="/webproject/resources/book_css/detail_default.css"
	type="text/css">

<link rel="stylesheet" href="/webproject/resources/book_css/pStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>






<style>
* {
	box-sizing: inherit;
}

.container22 {
	justify-content: space-between;
}

i {
	border: solid black;
	border-width: 0 3px 3px 0;
	display: inline-block;
	padding: 3px;
}

.up {
	transform: rotate(-135deg);
	-webkit-transform: rotate(-135deg);
}

#more {
	display: none;
}

#more2 {
	display: none;
}
</style>

<style>
.tooltip {
	position: relative;
	display: inline-block;
	border-bottom: 1px dotted black;
	width: 149px;
}

.tooltip .tooltiptext {
	visibility: hidden;
	width: 100%;
	background-color: #F15F5F;
	color: #fff;
	text-align: center;
	border-radius: 6px;
	padding: 5px 0;
	position: absolute;
	z-index: 1;
	bottom: 125%;
	left: 50%;
	margin-left: -60px;
	opacity: 0;
	transition: opacity 0.3s;
}

.tooltip .tooltiptext::after {
	content: "";
	position: absolute;
	top: 100%;
	left: 50%;
	margin-left: -5px;
	border-width: 5px;
	border-style: solid;
	border-color: #555 transparent transparent transparent;
}

.tooltip:hover .tooltiptext {
	visibility: visible;
	opacity: 1;
}

.btn_num_up, .btn_num_dn {
	display: block;
	width: 12px;
	height: 11px;
	background:
		url('/webproject/resources/images/searchN/btn_comm_140630.gif');
		no-repeat;
	text-indent: -99999em
}

.btn_num_up {
	background-position: -81px -20px
}

.btn_num_dn {
	background-position: -81px -33px
}
</style>
<script type="text/javascript"
	src="/webproject/resources/js/multiCart.js">
	
</script>

<script src="/webproject/resources/book_js/bookInfo.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

<!-- TOP 버튼 CSS -->
<style type="text/css">
#myBtn {
	display: none;
	position: fixed;
	/* 	float: right;  */
	bottom: 20px;
	right: 30px;
	z-index: 99;
	font-size: 18px;
	border: none;
	outline: none;
	background-color: #EAEAEA;
	color: black;
	cursor: pointer;
	padding: 15px;
	border-radius: 4px;
	bottom: 20px;
}

#myBtn:hover {
	background-color: #555;
	color: white;
}

#myBtn1 {
	background-color: #957556;
	color: white;
}

#myBtn2 {
	background-color: #957556;
	color: white;
}
</style>

<!-- Read and More Script -->
<script>
	function myFunction() {
		var dots = document.getElementById("dots");
		var moreText = document.getElementById("more");
		var btnText = document.getElementById("myBtn1");

		if (dots.style.display == "none") {
			dots.style.display = "inline";
			btnText.innerHTML = "펼쳐보기";
			moreText.style.display = "none";
		} else {
			dots.style.display = "none";
			btnText.innerHTML = "닫기";
			moreText.style.display = "inline";
		}
	}

	function myFunction2() {
		var dots2 = document.getElementById("dots2");
		var moreText2 = document.getElementById("more2");
		var btnText2 = document.getElementById("myBtn2");

		if (dots2.style.display == "none") {
			dots2.style.display = "inline";
			btnText2.innerHTML = "펼쳐보기";
			moreText2.style.display = "none";
		} else {
			dots2.style.display = "none";
			btnText2.innerHTML = "닫기";
			moreText2.style.display = "inline";
		}
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
			$("#" + id).val() = 1;
		}
		$("#" + id).val(q);

	};
</script>

<!-- 쿠키 생성 -->
<script type="text/javascript">
	$(function() {

		var cookieValue = JSON.stringify({
			"isbn" : "${isbn}",
			"bookImage" : "${book_image}",
			"bookTitle" : "${dto.bookTitle}",
			"authorName" : "${dto2.authorname}"
		});

		if (document.cookie.indexOf('rcbook') == -1) {
			setCookie('rcbook', cookieValue, 1);
		} else if (document.cookie.indexOf('rcbook') != -1) {
			addCookie(cookieValue);
		}
	});

	//쿠키 생성
	function setCookie(cName, cValue, cDay) {
		var expire = new Date();
		expire.setDate(expire.getDate() + cDay);
		cookies = cName + '=' + escape(cValue) + '; path=/ ';
		if (typeof cDay != 'undefined')
			cookies += ';expires=' + expire.toGMTString() + ';';
		document.cookie = cookies;
	}

	//기존 쿠키에 추가
	function addCookie(cValue) {
		var items = getCookie('rcbook');
		var maxItemNum = 10;

		if (items) {
			var itemArray = items.split('/');

			if (itemArray.indexOf(cValue) != -1) {//중복시 기존 제거 후 맨앞으로 가져옴
				var idx = itemArray.findIndex(function(item) {
					return item === cValue;
				});
				// 				alert(idx);
				itemArray.splice(idx, 1);

				itemArray.unshift(cValue);
				if (itemArray.length > maxItemNum) {
					itemArray.length = 10;
				}
				items = itemArray.join('/');
				setCookie('rcbook', items, 1);

			} else {
				itemArray.unshift(cValue);
				if (itemArray.length > maxItemNum) {
					itemArray.length = 10;
				}
				items = itemArray.join('/');
				setCookie('rcbook', items, 1);
			}
		}
	}

	function getCookie(cookiename) {
		var cookiestring = document.cookie;
		var cookiearray = cookiestring.split(';');
		for (var i = 0; i < cookiearray.length; ++i) {
			if (cookiearray[i].indexOf(cookiename) != -1) {
				var ck = [];
				var nameVal = cookiearray[i].split("=");
				var value = nameVal[1].trim();
				ck += value;
			}
		}
		return unescape(ck);
	}
</script>


</head>

<body>
	<!-- header -->
	<jsp:include page="../common/header.jsp" flush="false" />





	<div id="wrapDetail" style="width: 1000px;">

		<div class="wrap_contents">
			<!-- 왼쪽 영역 -->
			<div class="inner_left">

				<div class="thumb_bookCover">
					<img src="/webproject/resources/image/book/${book_image}">
				</div>


				<p class="btn_txt">

					<a href="javascript:popPreview(${dto.isbn });"
						class="btn_gy_comm btype_a4" style="height: 25px;">미리보기</a>

				</p>





				<div class="mt30 pos_rel">
					<div>
						<strong>매장 재고현황 <a href="javascript:popLayer('prodNum')"><span
								class="sp_btn help">?</span></a></strong>
					</div>
					<div class="mt3">
						<!-- 일서,잡시 매장 재고 표시 안함. -->
						<table cellpadding="0" cellspacing="0" class="commTable_s">
							<colgroup>
								<col width="65">
								<col width="65">
								<col width="71">
							</colgroup>
							<tbody>


								<tr>
									<th>롯데<br>스타시티점
									</th>
									<th>롯데<br>월드몰점
									</th>
									<th>신림역점</th>
								</tr>
								<tr>



									<td>${dto4.g }</td>


									<td>${dto4.c }</td>


									<td>${dto4.h }</td>



								</tr>
								<tr>
									<th>사당역점</th>
									<th>목동점</th>
									<th>롯데몰<br>수원점
									</th>
								</tr>
								<tr>



									<td>${dto4.i }</td>

									<td>${dto4.j }</td>

									<td>${dto4.f }</td>


								</tr>
								<tr>
									<th>대구<br>신세계점
									</th>
									<th>롯데<br>울산점
									</th>
									<th>신세계<br>김해점
									</th>
								</tr>
								<tr>


									<td>${dto4.e }</td>

									<td>${dto4.l }</td>

									<td>${dto4.m }</td>


								</tr>
								<tr>
									<th>롯데피트인<br>산본점
									</th>
									<th>여의도<br>신영증권점
									</th>
									<th></th>
								</tr>
								<tr>


									<td>${dto4.k }</td>


									<td>${dto4.d }</td>


									<td></td>
								</tr>
								<tr>

									<th>신세계<br>강남점
									</th>
									<th>부산 신세계<br>센텀시티점
									</th>
									<th></th>
								</tr>
								<tr>


									<td>${dto4.a }</td>

									<td>${dto4.b }</td>


									<td></td>
								</tr>
							</tbody>
						</table>
						<div class="t_11gr mt5"></div>


					</div>

					<!-- 재고현황 안내 LAYER -->
					<div class="bookViewPop" id="prodNum"
						style="visibility: hidden; width: 300px; top: 0; left: 0">
						<h3 class="mLine">재고현황 안내</h3>
						<div class="laypopCon">
							<ul class="t_11gr pt10 overflow">
								<li class="dot_comm_11">비교적 정확한 수치이오나 매장별 재고수는 현장 구매 등 여러
									변수에 의해 실제 재고와 다를 수 있습니다.</li>
								<li class="dot_comm_11 mt5">정확한 재고를 확인하시려면 매장으로 직접 문의하시기
									바랍니다.</li>
								<li class="dot_comm_11 mt5">각 매장의 연락처 및 위치를 확인하시려면 재고숫자를
									클릭하십시오.</li>
								<li class="dot_comm_11 mt5">센트럴시티점의 매장명이 신세계강남점으로 변경되었습니다.</li>
							</ul>
						</div>
						<p class="btnClose">
							<img
								src="http://image.bandinlunis.com/images/common/btn_close02.gif"
								alt="close" style="cursor: pointer;"
								onclick="javascript:popHidden('prodNum')">
						</p>
					</div>
				</div>

			</div>
			<!--// 왼쪽 영역 -->



			<!-- 오른쪽 영역 -->
			<div class="inner_right" style="width: 760px;">
				<!--// 상품 구매영역 -->
				<div class="row_item" style="width: 760px; height: 120px;">
					<div class="group_tag">

						<span class="sp_tag benefit">배송 품질 보상</span>


					</div>
					<div class="group_title">
						<h1>
							<span class="txt_main">${dto.bookTitle } </span>
						</h1>
					</div>

					<div class="group_inside"
						style="height: 40px; padding: 0px; margin-bottom: 10px; padding-bottom: 10px;">
						<ul style="height: 40px;">
							<li style="height: 40px;">${dto2.authorname }&nbsp;저&nbsp;&nbsp;|</li>


							<li style="height: 40px;">${dto.publisher }&nbsp;&nbsp;|</li>


							<li style="height: 40px;">${dto.publishDate }</li>


						</ul>
					</div>
				</div>
				<div class="row_item" style="width: 760px;">
					<div class="group_info">
						<ul class="txt_price">

							<li>
								<div class="tbl_left">
									<span>정가</span>
								</div>
								<div class="tbl_right">
									<span class="list_price"><fmt:formatNumber
											value="${dto.bookPrice }" type="number"></fmt:formatNumber> 원</span>
								</div>
							</li>


							<li>
								<div class="tbl_left mt12">
									<span>판매가</span>
								</div>
								<div class="tbl_right" style="">
									<span class="sale_price"> <fmt:formatNumber
											value="${dto.bookPrice * 0.9 }" type="number"></fmt:formatNumber>
										<span>원</span></span> <span class="point_red">[10% 할인]</span>

								</div>
							</li>




							<li>
								<div class="tbl_left mt3">
									<span>제휴할인</span>
								</div>
								<div class="tbl_right">
									<a href="javascript:popLayer('cardSaleInfo')"><span>카드할인/포인트결제
											안내 </span></a>
									<!-- 제휴할인 -->
									<div class="bookViewPop" id="cardSaleInfo"
										style="visibility: hidden; right: 212px; top: 0; width: 450px; height: 425px">
										<h3 class="mLine">카드할인/포인트결제 안내</h3>
										<div class="laypop_scroll mt15" style="height: 300px">
											<h4>제휴카드</h4>
											<table cellpadding="0" cellspacing="0"
												class="storeNum card_info">
												<colgroup>
													<col width="150">
													<col>
												</colgroup>
												<tbody>
													<tr>
														<th>반디앤루니스 롯데카드</th>
														<td>결제금액 최대 25% 청구할인 (1만원 이상 결제건에 한해 월 2회, 건당 최대 1만원
															할인)</td>
													</tr>
													<!-- <tr><th>썸타는 우리체크카드</th><td>결제금액 최대 20% 할인(CASH-BACK)<br>※ 이벤트기간 발급분에 한함 <a href="http://www.bandinlunis.com/front/event/viewPromotionEvent.do?evtSeq=26829" class="btn_w_comm btype_a4" style="text-decoration:none">자세히보기</a></td></tr> -->
													<tr>
														<th>반디앤루니스 우리V카드</th>
														<td>결제금액 10% 청구할인</td>
													</tr>
												</tbody>
											</table>
											<h4 class="mt20">포인트결제</h4>
											<table cellpadding="0" cellspacing="0"
												class="storeNum card_info">
												<colgroup>
													<col width="150">
													<col>
												</colgroup>
												<tbody>
													<tr>
														<th>OK캐쉬백 포인트</th>
														<td>최소 10원부터 전액 사용 or 1% 적립</td>
													</tr>
													<tr>
														<th>현대카드 M포인트</th>
														<td>결제금액의 최대 10% 사용 가능</td>
													</tr>
													<tr>
														<th>신한카드 포인트</th>
														<td>결제금액의 최대 10% 사용 가능(일부카드)</td>
													</tr>
													<tr>
														<th>하나(구.외환) 포인트</th>
														<td>보유 한도 내에서 100% 사용 가능</td>
													</tr>
													<tr>
														<th>씨티카드 포인트</th>
														<td>결제금액의 최대 50% 사용 가능</td>
													</tr>
												</tbody>
											</table>
											<h4 class="mt20">할인카드</h4>
											<table cellpadding="0" cellspacing="0"
												class="storeNum card_info">
												<colgroup>
													<col width="150">
													<col>
												</colgroup>
												<tbody>
													<tr>
														<th>NH농협 TAKE5카드</th>
														<td>20% 청구할인(Edu Pack)</td>
													</tr>
													<tr>
														<th>채움 플래티늄 멀티카드</th>
														<td>20% 청구할인</td>
													</tr>
													<tr>
														<th>모바일 Tmoney 신한카드</th>
														<td>10% 청구할인</td>
													</tr>
													<tr>
														<th>신한카드 Shopping</th>
														<td>10% 청구할인</td>
													</tr>
													<tr>
														<th>NH농협 체크카드</th>
														<td>10% 청구할인</td>
													</tr>
													<tr>
														<th>NH20 해봄 신용카드</th>
														<td>10% 청구할인</td>
													</tr>
													<tr>
														<th>씨티 클리어 카드</th>
														<td>7% 청구할인</td>
													</tr>
													<tr>
														<th>NH20 해봄 체크카드</th>
														<td>5% 청구할인</td>
													</tr>
													<tr>
														<th>NH농협 LADY다솜카드</th>
														<td>5% 청구할인</td>
													</tr>
													<tr>
														<th>신한카드 큐브</th>
														<td>5% 청구할인</td>
													</tr>
													<tr>
														<th>신한카드 큐브 PLATINUM#</th>
														<td>5% 청구할인</td>
													</tr>
												</tbody>
											</table>
										</div>
										<div class="al_right mt10 mr10">
											<a href="/pages/front/service/serviceCard.jsp#st01"
												target="_blank"><button class="btn_more_2014">
													<span>더보기</span>
												</button></a>
										</div>
										<p class="btnClose">
											<img
												src="http://image.bandinlunis.com/images/common/btn_close02.gif"
												alt="close" style="cursor: pointer;"
												onclick="javascript:popHidden('cardSaleInfo')">
										</p>
									</div>


								</div>
							</li>

							<li>
								<div class="tbl_left mt3">
									<span>적립금</span>
								</div>
								<div class="tbl_right">
									<span class="save_price"><fmt:formatNumber
											value="${dto.bookPrice * 0.05 }" type="number"></fmt:formatNumber>
										<span>원 적립</span></span> <span class="sub_info">[5%P]</span> <span
										class="ml5 lspM">- 5만원이상 구매시 2천원 / 멤버십 최대3% <strong>추가적립</strong>
										<a href="javascript:popLayer('addPoint')"><span
											class="sp_btn help">?</span></a>
									</span>
									<div style="margin: 7px 0 0 122px">
										<span class="txt_ad">바로ON 접속하면 2% <strong>추가
												적립</strong></span> <a href="/favorite.do#st01" target="_blank"><span
											class="sp_btn move">?</span></a>
									</div>
									<!-- 추가 적립금 안내 -->
									<div class="bookViewPop" id="addPoint"
										style="visibility: hidden; right: 212px; top: 18px; width: 320px">
										<h3 class="mLine">추가 적립금 안내</h3>
										<div class="laypopCon">
											<p class="mt15">
												<strong>[2천원 추가 적립]</strong>
											</p>
											<p class="mt5">총 주문금액 5만원 이상 구매 시 2,000원 추가 적립</p>
											<p class="mt5"></p>
											<div class="dot_comm">도서(eBook포함)만 구매 시 적립 대상에서 제외</div>
											<div class="dot_comm mt5">해외구매 음반/DVD 적립 대상에서 제외</div>
											<div class="dot_comm mt5">
												<strong>업체배송상품</strong>은 적립 대상에서 제외 <br>(상품상세 및 카트에서
												업체배송 여부 확인 가능)
											</div>
											<p></p>
											<div class="btnR mt5 t_11br4">
												<a href="/pages/front/service/serviceAddPoint.jsp#st01"><strong>자세히
														보기 &gt; </strong></a>
											</div>
											<p class="mt20">
												<strong>[멤버십 추가 적립]</strong>
											</p>
											<div class="mt10">
												<p class="dot_comm">
													슈퍼루니 : <strong>3%</strong> 추가 적립
												</p>
												<p class="dot_comm">
													골드루니 : <strong>2%</strong> 추가 적립
												</p>
												<p class="dot_comm">
													실버루니 : <strong>1%</strong> 추가 적립
												</p>
											</div>
											<p class="t_11gr mt5">단, 국내도서, eBook만 구매 시 적립 불가</p>
											<div class="btnR mt5 t_11br4">
												<a href="/pages/front/service/serviceMembership.jsp#st01"><strong>서비스
														안내 및 유의사항 보기 &gt; </strong></a>
											</div>
										</div>
										<p class="btnClose">
											<img
												src="http://image.bandinlunis.com/images/common/btn_close02.gif"
												alt="close" style="cursor: pointer;"
												onclick="javascript:popHidden('addPoint')">
										</p>
									</div>
								</div>
							</li>

						</ul>
					</div>





				</div>


				<div class="row_item">
					<div class="group_info">
						<ul class="txt_shipping">
							<li style="display: none;">
								<div class="tbl_left">
									<span>배송구분</span>
								</div>
								<div class="tbl_right">업체배송(반디북)</div>
							</li>
							<li>
								<div class="tbl_left">
									<span>배송료</span>
								</div>
								<div class="tbl_right">
									<strong>무료배송</strong>

								</div>
							</li>










							<li style="overflow: visible;">
								<div class="tbl_left">
									<span>당일배송 </span> <a
										href="/pages/front/service/serviceTodayDeli.jsp#st01"
										target="_blank"><span class="sp_btn help ml3">?</span></a>
								</div>

								<div class="tbl_right">

									<div class="mt5">
										<strong>서울/수도권</strong> 오전 12시 주문까지 <span
											class="btn_w_comm btype_a4 al_top mt3m hand"
											style="height: 18pt;"
											onmouseover="javascript:popLayer('oneDay1')"
											onmouseout="javascript:popHidden('oneDay1')">가능지역</span> <span
											class="btn_w_comm btype_a4 al_top mt3m hand"
											style="height: 18pt;"
											onmouseover="javascript:popLayer('todayDeliveryInfo')"
											onmouseout="javascript:popHidden('todayDeliveryInfo')">당일배송
											유의사항</span>
									</div>

									<!-- 당일배송 가능지역 LAYER -->
									<div class="bookViewPop" id="oneDay1"
										style="visibility: hidden; top: 40px; left: 80px; width: 480px; text-align: left">
										<h3 class="mLine">서울/수도권 당일배송 가능지역</h3>
										<div class="laypopCon">
											<table cellapdding="0" cellspacing="0"
												class="commTable_d mt10">
												<colgroup>
													<col width="80">
													<col width="360">
												</colgroup>
												<tbody>
													<tr>
														<th>서울시</th>
														<td class="al_left">전 지역(일부 동 제외)</td>
													</tr>
													<tr>
														<th>인천시</th>
														<td class="al_left">서구, 계양구, 남동구, 남구, 연수구, 부평구</td>
													</tr>
													<tr>
														<th>경기</th>
														<td class="al_left">수원시, 안산시, 안양시, 용인시, 의왕시, 의정부시,
															고양시, 광명시, 구리시, 군포시, 성남시, 화성시, 부천시</td>
													</tr>
												</tbody>
											</table>
											<div class="mt10">※ 단, 가능지역 중 일부 외곽지역은 서비스가 제한될 수도
												있습니다.</div>
										</div>
									</div>



									<!-- 당일배송 유의사항 LAYER -->
									<div class="bookViewPop" id="todayDeliveryInfo"
										style="visibility: hidden; top: 40px; left: 80px; width: 480px; text-align: left">
										<h3 class="mLine">당일배송 유의사항</h3>
										<div class="laypopCon">
											<div class="pt10 overflow">
												<div class="dot_comm_11">'당일배송 상품'외 상품 또는 예약상품을 같이
													주문하면 타 상품 수령예상일에 맞춰 배송됩니다.</div>
												<div class="dot_comm_11 mt5">선물포장 주문건은 제외됩니다.</div>
												<div class="dot_comm_11 mt5">가능지역 중 일부 외곽지역은 서비스가 일부
													제한될 수 있으니 지역변경으로 가능지역을 검색하세요.</div>
												<div class="dot_comm_11 mt5">당일배송 지역 내 일부 도서 산간 및 특수
													지역은 서비스가 제한 될 수 있습니다.</div>
												<div class="dot_comm_11 mt5">18시 이후에 배송될 수도 있으므로 직장주소는
													피해주시기 바랍니다.</div>
											</div>
										</div>
									</div>
								</div>
							</li>



						</ul>

						<!-- 지역변경 레이어 -->
						<div class="bookViewPop zip_code" id="zipCode"
							style="visibility: hidden; top: 40px; left: 80px;">
							<h3 class="mLine">당일배송 가능지역 검색</h3>
							<p class="btnClose">
								<img
									src="http://image.bandinlunis.com/images/common/btn_close02.gif"
									alt="close" style="cursor: pointer;"
									onclick="javascript:popHidden('zipCode')">
							</p>
							<div class="zip_tap">
								<ul class="tap_menu">
									<!-- 								<li id="jibun" class="on" ><a style="cursor:pointer;">지번 주소 찾기</a></li><li id="doro" class="alt"><a style="cursor:pointer;">도로명주소 찾기</a></li> -->
								</ul>
							</div>
							<div class="zip_contents">
								<div name="search_doro" id="search_doro">
									<p class="box_notice">
										<strong>“도로명주소”를 쉽게 찾아보세요</strong><br> 1. 도로명으로 검색하기 (예,
										“직지길” or “직지길+322”)<br> 2. 건물명으로 검색하기 (예, “반디앤루니스빌딩”)<br>
										3. 동(읍/면/리) 으로 검색 (예, “인사동” or “인사동+43”)<br> 4. 도로명주소를
										모르실 경우 도로명주소 안내시스템(<a href="http://www.juso.go.kr"
											target="_blank">http://www.juso.go.kr</a>)에서 확인해주세요.
									</p>
									<div class="item">
										<input name="searchType" type="radio" value="doro" id="c1"
											class="i_radio" checked=""><label for="c1"
											class="i_label">도로명+건물번호</label> <input name="searchType"
											type="radio" value="bldName" id="c2" class="i_radio"><label
											for="c2" class="i_label">건물명</label> <input name="searchType"
											type="radio" value="dong" id="c3" class="i_radio"><label
											for="c3" class="i_label">동명+지번</label>
									</div>
									<div class="item">
										<span class="txt_basic">시/도</span> <select name="sido"
											onchange="javascript:changeDist(this.value);"
											class="slt_zipcode">
											<option value="" selected="">전체</option>
											<option value="01">서울특별시</option>
											<option value="02">부산광역시</option>
											<option value="03">대구광역시</option>
											<option value="04">인천광역시</option>
											<option value="05">광주광역시</option>
											<option value="06">대전광역시</option>
											<option value="07">울산광역시</option>
											<option value="08">세종특별자치시</option>
											<option value="09">강원도</option>
											<option value="10">경기도</option>
											<option value="11">경상남도</option>
											<option value="12">경상북도</option>
											<option value="13">전라남도</option>
											<option value="14">전라북도</option>
											<option value="15">제주특별자치도</option>
											<option value="16">충청남도</option>
											<option value="17">충청북도</option>
										</select> <span class="txt_basic">시/군/구</span> <select name="sigungu"
											class="slt_zipcode">
											<option value="">전체</option>
										</select>
									</div>
									<div class="item " id="doroArea">
										<label for="temp_input" class="i_screen_hide"
											style="position: absolute; display: block;">도로명,
											ex)직지길</label> <input type="text" name="searchDoro" id="searchDoro"
											class="i_text short"
											onkeypress="javascript:(event.keyCode == 13)? goSearch() : ''; javascript:preventSpace(event);">
										<label for="temp_input2" class="i_screen_hide"
											style="position: absolute; left: 160px; display: block;">건물번호,
											ex) 322</label> <input type="text" class="i_text short" id="bldNum"
											name="bldNum"
											onkeydown="javascript:(event.keyCode == 13)? goSearch() : ''; javascript:preventChar(event);">
										<a style="cursor: pointer;" onclick="javascript:goSearch();"
											class="btn_small"><span class="search">검색</span></a>
									</div>
									<div class="item hide" id="bldArea">
										<label for="temp_input" class="i_screen_hide"
											style="position: absolute; display: block;">건물명,
											ex)반디앤루니스빌딩</label> <input type="text" name="searchBld"
											id="searchBld" class="i_text long"
											onkeypress="javascript:(event.keyCode == 13)? goSearch() : ''; javascript:preventSpace(event);">
										<a style="cursor: pointer;" onclick="javascript:goSearch();"
											class="btn_small"><span class="search">검색</span></a>
									</div>
									<div class="item hide" id="dongArea">
										<label for="temp_input" class="i_screen_hide"
											style="position: absolute; display: block;">동명,
											ex)인사동</label> <input type="text" name="searchDong" id="searchDong"
											class="i_text short"
											onkeypress="javascript:(event.keyCode == 13)? goSearch() : ''; javascript:preventSpace(event);">
										<label for="temp_input2" class="i_screen_hide"
											style="position: absolute; left: 160px; display: block;">지번</label>
										<input type="text" name="searchKJibun" id="searchKJibun"
											class="i_text short"
											onkeydown="javascript:(event.keyCode == 13)? goSearch() : ''; javascript:preventChar(event);">
										<a style="cursor: pointer;" onclick="javascript:goSearch();"
											class="btn_small"><span class="search">검색</span></a>
									</div>
								</div>
								<div name="search_jibun" id="search_jibun"
									style="display: none;">
									<p class="box_notice">주소의 동(읍/리/면) 또는 마지막 부분을 입력하신 후 검색을
										누르세요.</p>
									<div class="item">
										<label for="temp_input" class="i_screen_hide"
											style="position: absolute; display: block;">지번 검색</label> <input
											type="text" name="jibunDong" id="jibunDong"
											class="i_text long"
											onkeypress="javascript:(event.keyCode == 13)? goSearchJibun() : ''">
										<a style="cursor: pointer;"
											onclick="javascript:goSearchJibun();" class="btn_small"><span
											class="search">검색</span></a>
									</div>
								</div>
								<div style="display: none;" name="search_result"
									id="search_result">
									<p class="txt_notice">
										총 <a style="color: red" id="txt_count">0</a>건, 검색결과 주소를 클릭하시면
										자동입력 됩니다.
									</p>
									<table cellpadding="0" cellspacing="0" class="tbl_subject">
										<caption>제목 테이블</caption>
										<colgroup>
											<col width="115">
											<col width="315">
										</colgroup>
										<tbody>
											<tr>
												<th><strong>우편번호</strong></th>
												<th><strong>주소</strong></th>
											</tr>
										</tbody>
									</table>
									<div class="tbl_frame" id="zipCodeList">
										<table cellpadding="0" cellspacing="0" class="">
											<tbody>
												<tr>
													<td class="txt_blank" id="default_txt">검색된 주소가 없습니다.</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>






















				<div class="row_item buy_group">

					<div class="group_info">
						<div class="tbl_qty">
							<span class="txt_num">수량</span> <input type="text"
								id="cntVal_${dto.isbn }" value="1" class="inp_num" size="2"
								style="text-align: right; ime-mode: disabled;"
								onkeydown="onlyNumber();"> <span class="btn_updn_wrap">
								<a href="javascript:cntUp('${dto.isbn }');" class="btn_num_up"></a>
								<a href="javascript:cntDown('${dto.isbn }');" class="btn_num_dn"></a>
							</span>
						</div>
						<div class="tbl_ad">
							<span class="txt_ad">더욱 새로워진 반디앤루니스 옴니채널 <strong
								class="point_red">북셀프3.0</strong>을 확인하세요.
							</span> <a href="/pages/front/service/serviceBookSelf.jsp#st01"
								target="_blank"><span class="sp_btn move">자세히</span></a>
						</div>
					</div>
					<div class="group_info fl_clear buy_btn">
						<div class="btn_zone_left pos_rel"
							style="justify-content: space-between;">
							<div id="container22">
								<a href="javascript:addCart('${isbn}');" class="btn_big"><span
									class="box_bookcart" style="margin-right: 50px;">쇼핑카트 담기</span></a>
								<a href="javascript:go_buy_cnt('4189934');" class="btn_big"><span
									class="box_quickbuy" style="margin-right: 50px;">바로 구매</span></a>
							</div>

							<div class="bookViewPop" id="bookselfInfo"
								style="display: none; bottom: 45px; left: 210px; width: 350px">
								<h3 class="mLine">북셀프 가능매장</h3>
								<div class="laypopCon">(부산)신세계센텀시티점, 롯데몰수원점, 신세계강남점,

									롯데월드몰점, 사당역점, 롯데스타시티점, 신림역점, 롯데울산점, 목동점, 신세계김해점, 대구신세계점,

									롯데피트인산본점</div>
							</div>

						</div>

						<div class="mt15 pos_rel fl_left" id="naverPayDirect"
							style="display: none;">
							<a href="javascript:go_buy_cnt('4189934', 'Y');"><img
								src="/images/detail/2014/btn_naverpay.gif" alt="네이버페이 구매"></a>
							<span><img src="/images/detail/2014/txt_naverpay.gif"
								alt="네이버 ID로 간편결제, 네이버페이"></span> <a
								href="javascript:popLayer('naverpayInfo')"><span
								class="sp_btn help" style="margin-top: 22px">?</span></a>
							<div class="bookViewPop" id="naverpayInfo"
								style="visibility: hidden; top: -20px; left: 60px; width: 320px">
								<h3 class="mLine">네이버페이는?</h3>
								<div class="laypopCon">
									<p class="t_11gr mt5">네이버ID로 별도 앱 설치 없이 신용카드 또는 은행계좌 정보를
										등록하여 네이버페이 비밀번호로 결제할 수 있는 간편결제 서비스 입니다.</p>
								</div>
								<p class="btnClose">
									<img
										src="http://image.bandinlunis.com/images/common/btn_close02.gif"
										alt="close" style="cursor: pointer;"
										onclick="javascript:popHidden('naverpayInfo')">
								</p>
							</div>
						</div>

					</div>
				</div>



				<div class="etc_info">


					<div class="vote">
						<strong>회원리뷰</strong>
						<div class="medium_ratings" style="width: 20pt;"></div>
						<span class="ml10">리뷰[${reviewNum}] 간단평[${simplereviewNum }]
						</span> </span> <a href="#sub02" class="btn_w_comm btype_a4"
							style="height: 18pt;">참여하기</a>
					</div>


					<div class="isbn_info">

						<span class="alt"><strong>ISBN</strong>: ${dto.isbn }</span> <span>${dto.page }</span>


						<span>${dto.bookSize } </span>


					</div>


				</div>

			</div>
			<!--// 오른쪽 영역 -->

			<div class="inner_merge">
				<div class="row_item">

					<div class="section_center">
						<h4 class="txt_title">이 분야의 베스트셀러</h4>

						<ul>
							<c:forEach var="dto33" items="${lists_Best3 }">

								<li><a
									href="/webproject/book_info.action?isbn=${dto33.isbn }"> <img
										src="/webproject/resources/image/book/${dto33.bookImage }"
										alt="" class="d_imgLine"
										onerror="this.src='http://image.bandinlunis.com/images/common/noimg_type04.gif';">
								</a> <a href="javascript:goDetailBook('4002576');"
									class="txt_subject"><strong>${dto33.bookTitle }</strong></a> <span
									class="txt_writer">${dto33.authorName }</span> <strong
									class="point_red">${dto33.bookPrice } </strong></li>
							</c:forEach>

						</ul>

					</div>
					<div class="section_right">
						<img
							src="http://image.bandinlunis.com/upload/banner/20181012/banner20181012112050.jpg">
					</div>
				</div>
			</div>

			<!--// 상품 구매영역 -->

			<div class="tap_zone" id="sub01">
				<ul>
					<li class="on"><a href="#sub01">상품 정보</a></li>
					<li><a href="#sub02">회원리뷰</a></li>
					<li><a href="#sub03">반품/교환</a></li>
					<li><a class="alt"></a></li>
					<!-- 마지막 기본틀 -->
				</ul>
			</div>


			<!-- 책정보 -->




			<!-- 상품 추가 정보 영역 -->
			<div class="inner_info">
				<!-- 공지사항 -->

				<!--// 공지사항 -->







				<!-- 이 책이 속한 분야 -->
				<div class="row_item">
					<div class="title_zone">
						<h3 class="txt_title">이 책이 속한 분야</h3>
					</div>
					<div class="box_contents">
						<ul>
							<li class="mb10"><a
								href="/webproject/book_cate.action?categoryId=${cateDTO3.categoryId }">${cateDTO3.categoryName }</a>
								&gt; <a
								href="/webproject/book_cate.action?categoryId=${cateDTO2.categoryId }">${cateDTO2.categoryName }</a>

								&gt; <a
								href="/webproject/book_cate.action?categoryId=${cateDTO1.categoryId }">${cateDTO1.categoryName }</a>




							</li>

						</ul>
					</div>
				</div>
				<!-- //이 책이 속한 분야 -->





				<!-- 저자/역자 소개 -->


				<div class="row_item">
					<div class="title_zone">
						<h3 class="txt_title">저자 소개</h3>
					</div>

					<div class="box_contents pb40">
						<div class="thumb_zone">
							<div class="img_profile">
								<span class="bg_profile"> <c:choose>
										<c:when test="">
											<img src="/webproject/resources/">

										</c:when>
										<c:otherwise>
											<img
												src="http://image.bandinlunis.com/images/detail/2014/bg_mask.png">
										</c:otherwise>
									</c:choose>


								</span> <span class="btn_txt">자세히 보기</span> <span class="btn_bg"></span>
								<span class="mask"></span>

							</div>

						</div>
						<div class="group_profile">
							<div class="txt_profile_left mt10">
								<span class="author_name"> <a
									href="/front/author/authorProfile.do?authorSeq=8840">${dto2.authorname }</a>
									<span>(1952)</span>
								</span>
								<ul>
									<li>구분 : 저서</li>
									<li>국적 : ${dto2.nationality }</li>
									<li>분류 : ${dto2.category }</li>


								</ul>
							</div>

							<div class="txt_profile_marge">
								<p></p>
								<p>${dto2.introduction }</p>
								<p>&nbsp;</p>
								<p></p>
							</div>
						</div>
					</div>

				</div>







				<!-- //저자/역자 소개 -->



				<!-- 책 속에서 -->
				<div class="row_item">
					<div class="title_zone">
						<h3 class="txt_title">책 속에서</h3>
					</div>
					<div class="box_contents">
						<div class="group_txt">${intro1 }
							<span id="dots">...</span> <span id="more" class="group_txt">
								${intro2 } </span>
						</div>
						<div id="bookDescBtn" class="pr20">
							<button onclick="myFunction()" id="myBtn1">펼쳐 보기</button>
						</div>
					</div>
				</div>
				<!-- //책 속에서 -->



				<!-- 목차 -->
				<div id="cutIndexDesc" class="row_item">
					<div class="title_zone">
						<h3 class="txt_title">목차</h3>
					</div>
					<div class="box_contents">
						<div class="group_txt">${cont1 }
							<span id="dots2">...</span> <span id="more2" class="group_txt">
								${cont2 } </span>
						</div>
						<div id="bookDescBtn" class="pr20">
							<button onclick="myFunction2()" id="myBtn2">펼쳐 보기</button>
						</div>
					</div>

				</div>
			</div>
			<!--// 목차 -->






			<!-- 상품고시정보 -->


			<div class="tap_zone mt40" id="sub02">
				<ul>
					<li><a href="#sub01">상품 정보</a></li>
					<li class="on"><a href="#sub02">회원리뷰</a></li>
					<li><a href="#sub03">반품/교환</a></li>
					<li><a class="alt"></a></li>
					<!-- 마지막 기본틀 -->
				</ul>
			</div>
			<div class="row_item">
				<img
					src="http://image.bandinlunis.com/upload/design/bn/2017/01/bandipoint_info.jpg"
					usemap="#bandipoint_info">
			</div>



			<!-- 리뷰 -->
			<div style="margin-top: 5px">

				<div class="bookViewPop" id="reviewInfo"
					style="visibility: hidden; right: 10px; top: 0; width: 450px">
					<h3 class="mLine">리뷰 혜택 및 이용안내</h3>
					<div class="laypopCon mt15">
						<h4>리뷰 작성 시 혜택</h4>
						<table cellpadding="0" cellspacing="0" class="storeNum card_info">
							<colgroup>
								<col width="220">
								<col width="220">
							</colgroup>
							<tbody>
								<tr>
									<th>구매상품 일반리뷰(150자 이상)</th>
									<td>반딧불 300개 적립</td>
								</tr>
								<tr>
									<th>구매상품 우수리뷰(300자 이상)</th>
									<td>반딧불 600개 적립</td>
								</tr>
								<tr>
									<th>포토 추가(GIFT, 뷰티만 해당)</th>
									<td>반딧불 100개 적립</td>
								</tr>
							</tbody>
						</table>
						<div class="al_center mt10"></div>
						<h4 class="mt20">반딧불이란?</h4>
						<div class="t_11gr mt5" style="line-height: 140%">반디앤루니스에서
							메일 구독, 간단평/서평 작성, 공감하기 등 책과 관련된 컨텐츠 활동을 하는 모든 회원님께 드리는 특별 포인트
							입니다. 반딧불은 10개부터 적립금으로 환전하여 현금처럼 사용할 수 있습니다.</div>

					</div>
					<p class="btnClose">
						<img
							src="http://image.bandinlunis.com/images/common/btn_close02.gif"
							alt="close" style="cursor: pointer;"
							onclick="javascript:popHidden('reviewInfo')">
					</p>
				</div>

				<iframe style="overflow: auto;" id="blogReview"
					src="<%=cp%>/book_review.action?isbn=${isbn }" width="100%"
					height="600px" class="iframe_review" frameborder="0" scrolling="no"></iframe>




			</div>
			<!-- //리뷰 -->

			<!-- 간단평 -->
			<!-- 			src="/front/product/iframeSimpleReview.do?prodId=4189934" -->
			<iframe id="simpleReview" width="100%" class="iframe_review"
				src="<%=cp %>/book_simpleReview.action?isbn=${isbn}"
				style="margin-left: 0" frameborder="0" scrolling="no" height="422"></iframe>
			<!-- //간단평 -->


			<div class="tap_zone mt40" id="sub03">
				<ul>
					<li><a href="#sub01">상품 정보</a></li>
					<li><a href="#sub02">회원리뷰</a></li>
					<li class="on"><a href="#sub03">반품/교환</a></li>
					<li><a class="alt"></a></li>
					<!-- 마지막 기본틀 -->
				</ul>
			</div>







			<!-- 반품/교환 -->
			<div class="inner_info">
				<div class="row_item">
					<div class="title_zone">
						<h3 class="txt_title">반품/교환</h3>
					</div>
					<div class="box_contents">
						<p>상품 설명에 반품/ 교환 관련한 안내가 있는 경우 그 내용을 우선으로 합니다. (업체 사정에 따라 달라질
							수 있습니다)</p>
						<dl class="information">

							<dd>
								<table
									summary="본 상품은 배송 없이 구매 후 바로 다운받아 보는 eBook으로 다운 후에는 취소/환불이 불가능합니다."
									class="table_return">

									<colgroup>
										<col width="18%">
										<col width="82%">
									</colgroup>
									<tbody>
										<tr>
											<th>반품/교환 방법</th>
											<td>홈 &gt; 고객센터 &gt; 자주찾는질문 “반품/교환/환불” 안내 참고 또는 1:1상담게시판</td>
										</tr>
										<tr>
											<th>반품/교환 가능 기간</th>
											<td>반품,교환은 배송완료 후 7일 이내, 상품의 결함 및 계약내용과 다를 경우 문제발견 후 30일
												이내에 신청가능</td>
										</tr>
										<tr>
											<th>반품/교환 비용</th>
											<td>변심 혹은 구매착오의 경우에만 반송료 고객 부담(별도 지정 택배사 없음)</td>
										</tr>
										<tr>
											<th>반품/교환 불가 사유</th>
											<td>
												<ul>
													<li>소비자의 책임 사유로 상품 등이 손실 또는 훼손된 경우</li>
													<li>소비자의 사용, 포장 개봉에 의해 상품 등의 가치가 현저히 감소한 경우 : 예) 화장품,
														식품, 가전제품 등</li>
													<li>복제가 가능한 상품 등의 포장을 훼손한 경우 : 예) 음반/DVD/비디오, 소프트웨어,
														만화책, 잡지, 영상 화보집</li>
													<li>소비자의 요청에 따라 개별적으로 주문 제작되는 상품의 경우 (GIFT주문제작상품)</li>
													<li>디지털 컨텐츠인 eBook, 오디오북 등을 1회 이상 다운로드를 받았을 경우</li>
													<li>시간의 경과에 의해 재판매가 곤란한 정도로 가치가 현저히 감소한 경우</li>
													<li>전자상거래 등에서의 소비자보호에 관한 법률이 정하는 소비자 청약철회 제한 내용에 해당되는
														경우</li>
													<li>해외주문 상품(도서 및 음반)의 경우(파본/훼손/오발송 상품을 제외)</li>
													<li>중고 상품 등 재고의 추가 확보가 어려운 경우 (교환은 어려우나 반품은 가능)</li>
													<li>그밖에 월간지, 화보집, 사진집, 그림도감, 시집류, 중고학습서, 카세트테입, 만화,
														입시자료, 악보, 지도, 여성실용서적 등(파본/훼손/오발송 상품을 제외)</li>
												</ul>
											</td>
										</tr>
										<tr>
											<th>소비자 피해보상<br>환불지연에 따른 배상
											</th>
											<td>
												<ul>
													<li>상품의 불량에 의한 반품, 교환, A/S, 환불, 품질보증 및 피해보상 등에 관한 사항은
														소비자 분쟁해결기준 (공정거래위원회고시)에 준하여 처리됨</li>
													<li>대금 환불 및 환불지연에 따른 배상금 지급 조건, 절차 등은 전자상거래 등에서의 소비자
														보호에 관한 법률에 따라 처리함</li>
												</ul>
											</td>
										</tr>
									</tbody>
								</table>
							</dd>
						</dl>
					</div>
				</div>
			</div>
			<!--// 반품/교환 -->
		</div>
		<br /> <br /> <br /> <br />
	</div>

	<!-- footer -->
	<jsp:include page="../common/footer.jsp" flush="false" />

</body>
</html>