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
<link rel="stylesheet" href="/webproject/resources/common/css/shopCartList.css" type="text/css"/>

<!-- 반디앤루니스 아이콘  -->
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

<!-- order 스크립트  -->
<script type="text/javascript" src="/webproject/resources/jsforJ/order.js"></script>

<!-- 우편번호 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		/* orderCalc(); */
		
		//우편번호 검색 및 주소 가져오기
		$('#fZipCode').on('click',function(){
			
			new daum.Postcode({
		        oncomplete: function(data) {
		        	
		        	var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
	                
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;

	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }
		            
	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('rcvr_zip1').value = data.zonecode; //5자리 새우편번호 사용
	                document.getElementById('rcvr_addr1').value = fullAddr;

	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById('rcvr_addr2').focus();
	                
		        }
		    }).open();
							
		});
		
		$('#deli2_01').on('click', function(){
			
			document.getElementById('recipientName').value= 
			document.getElementById('rcvr_tel2_part2').value=$('#rcvr_tel2_part2').val();
			document.getElementById('rcvr_tel2_part3').value=$('#rcvr_tel2_part3').val();
			document.getElementById('rcvr_zip1').value=$('#rcvr_zip1').val();
			document.getElementById('rcvr_addr1').value=$('#rcvr_addr1').val();

		});

		$('#deli2_02').on('click', function(){
			
			document.getElementById('recipientName').value = "";
			document.getElementById('rcvr_tel2_part2').value = "";
			document.getElementById('rcvr_tel2_part3').value = "";
			document.getElementById('rcvr_zip1').value = "";
			document.getElementById('rcvr_addr1').value = "";

		});

	});

	</script>

</head>
<body>
<jsp:include page="../common/header.jsp" flush="false"/>

<div id="contentBody">
        <div id="contentWrap">          
            <div class="conWrap">
            	<div class="orderStepN">
                    <h2><img src="/webproject/resources/images/order/h2_order.gif" alt="주문/결제"></h2>

	                    <dl class="benefitA bf_order">
	                   		<dt class="bftit">나의 사용가능 혜택:</dt>
	                   		<dd>
	                   		적립금 <strong>${leftPoint }</strong>원
	                   		</dd>
	                    </dl>
                    
					<!-- 복합결제 아닐 시 -->
                   		<p class="step"> <img src="/webproject/resources/images/order/navi_step02.gif" alt="쇼핑카트 > 주문/결제 > 주문완료"> </p>
                </div>
                
				<form  id="getDone" action="<%=cp%>/order_ok.action" method="post">
					<%-- <input type="hidden" id="userInfo" name="userInfo" value="${sessionScope.userInfo }"/> --%>
				<fieldset>
					
		            	<h3 class="orderTit mt20 pos_rel">
		            		<img src="/webproject/resources/images/order/h3_order_step01.gif" alt="1. 주문상품 확인">
		            		
			            		<span class="dedu_txt">도서 소득공제 상품</span> <span class="sp_btn sp_help" onmouseover="javascript:popLayer('deductionInfo')" onmouseout="javascript:popHidden('deductionInfo')"><span>?</span></span>
		            			<div class="bookViewPop al_left" id="deductionInfo" style="visibility: hidden; left 20px; top: 22px; width: 320px;">
		            				<h3 class="mLine">도서 소득공제 대상 안내</h3>
		            				<div class="laypopCon t_12 t_normal">
		            					<p class="mt5">
											저자, 발행인, 발행일, 출판사, 국제표준도서번호(ISBN. 다만, 전자책의 경우
											ECN 포함)이 기록된 간행물로 종이책(학술서, 만화, 학습참고서 포함), 전자책
											(오디오북, 웹툰, 웹소설 포함)<br>
											(※ 잡지, eBook 대여, 과세도서 제외)
										</p>
									</div>
								</div>
		            	</h3>
		            	
		            	<table cellpadding="0" cellspacing="0" class="orderTable">
		            		<colgroup><col width="55"><col><col width="90"><col width="120"><col width="100"><col width="100"><col width="130"></colgroup>
		            		<tbody><tr>
		            			<th colspan="2">주문상품</th>
		            			<th>수량</th>
		            			<th>주문금액</th>
		            			<th>배송비</th>
		            			<th>예상적립금</th>
		            			<th>주문 금액 합계</th>
		            			<th style="display: none"><input type="checkbox" id="bandiDeduction" class="checkAll"></th> 
		            		</tr>
		            	<c:set var="i" value="0"/>
						<c:forEach var="dto" items="${lists }">
						<c:set var="i" value="${i+1 }"/>
						<c:choose>
							<c:when test="${i eq 1 }">
								<tr class="prodViewAll" style="display: table-row">
			            			<td>
			            				<span class="book_img"><img src="<%=cp %>/resources/image/book/${dto.bookImage }"></span>
			            			</td>
			            			<td class="prod_name"> [도서] ${dto.bookTitle }</td>
			            			<td>${dto.orderCount }개</td>
			            			<td><strong>${dto.discountedPrice }원</strong></td>
			            			<td rowspan="${num }">
				            		10,000원 이상<br>무료배송<br>
				            		/미만시 2,000원
				            		</td>
			            			<td>${dto.point }원</td>
			            			<td><strong class="t_red">${dto.discountedPrice*dto.orderCount }원</strong></td>
			            			<td style="display: none;">
           						        <input type="checkbox" id="checkBox_${dto.seqNum }" name="seqArr3" class="check_bandiDeduction" value="${dto.seqNum }" checked="checked">
						   				<input type="hidden"  id="pricePerBook_${dto.seqNum}" name="pricePerBook" value="${dto.discountedPrice}"/>
						
										<input type="hidden" class="storeId_1" value="${dto.seqNum }"/>
										<input type="hidden" id="storeIdVal_${dto.seqNum }" value="1"/>
						
										<input type="hidden" id="maxVal_${dto.seqNum }"  name="maxVal" value="999">
										<input type="hidden" id="saleCostVal_${dto.seqNum }" name="price" value="${dto.discountedPrice }"/>
										
						   				<input type="hidden" id="marketSaleVal_${dto.seqNum }" name="marketSaleVal" value="${dto.bookPrice }"/>
						   				<input type="hidden" id="prodPointVal_${dto.seqNum }" name="rodPointVal" value="${dto.point }"/>
						   				<input type="hidden" id="bundleDeliYnVal_${dto.seqNum }" name="bundleDeliYnVal" value="Y"/>
						   				<input type="hidden" id="discountRate_${dto.seqNum }" name="discountRate" value="${dto.discountRate }"/>
						   				<input type="hidden" id="prodIdArr_${dto.seqNum }" name="isbn" value="${dto.isbn }"/>
						   				<input type="hidden" id="prod_name_${dto.seqNum }" name="prod_name" value="${dto.bookTitle }"/>
						   				<input type="hidden" id="optSeqVal_${dto.seqNum }" name="optSeqVal" value=""/>
						   				<input type="hidden" name="is_sale_yn"  value="Y"/>
						   				<input type="hidden" id="prodTypeArr_${dto.seqNum }" name="prodType" value="01"/>
						   				<input type="hidden" id="flag_${dto.seqNum }" name="flag" value="0"/>
						   				<input type="hidden" id="preSaleYnVal_${dto.seqNum }" name="preSaleYnVal" value="N"/>
						   				<input type="hidden" id="orderCnt_${dto.seqNum }" name="orderCount" value="${dto.orderCount }"/> 	
			            				<input type="hidden" id="row_num" value="${num }"/>
			            				<input type="hidden" name="userId" value=${userInfo.userId }/>
			            				
			            			</td>
		            			</tr>
		            			
							</c:when>
							<c:otherwise>
							
								<tr class="prodViewAll" style="display: table-row">
			            			<td>
			            				<span class="book_img"><img src="<%=cp %>/resources/image/book/${dto.bookImage }"></span>
			            			</td>
			            			<td class="prod_name"> [도서] ${dto.bookTitle }</td>
			            			<td>${dto.orderCount }개</td>
			            			<td><strong>${dto.discountedPrice }원</strong></td>
			            			
			            			<td>${dto.point }원</td>
			            			<td><strong class="t_red">${dto.discountedPrice*dto.orderCount }원</strong></td>
			            			<td style="display: none;">
           						        <input type="checkbox" id="checkBox_${dto.seqNum }" name="seqArr3" class="check_bandiDeduction" value="${dto.seqNum }" checked="checked">
						   				<input type="hidden"  id="pricePerBook_${dto.seqNum}" name="pricePerBook" value="${dto.discountedPrice}"/>
						
										<input type="hidden" class="storeId_1" value="${dto.seqNum }"/>
										<input type="hidden" id="storeIdVal_${dto.seqNum }" value="1"/>
						
										<input type="hidden" id="maxVal_${dto.seqNum }"  name="maxVal" value="999">
										<input type="hidden" id="saleCostVal_${dto.seqNum }" name="price" value="${dto.discountedPrice }"/>
										
						   				<input type="hidden" id="marketSaleVal_${dto.seqNum }" name="marketSaleVal" value="${dto.bookPrice }"/>
						   				<input type="hidden" id="prodPointVal_${dto.seqNum }" name="rodPointVal" value="${dto.point }"/>
						   				<input type="hidden" id="bundleDeliYnVal_${dto.seqNum }" name="bundleDeliYnVal" value="Y"/>
						   				<input type="hidden" id="discountRate_${dto.seqNum }" name="discountRate" value="${dto.discountRate }"/>
						   				<input type="hidden" id="prodIdArr_${dto.seqNum }" name="isbn" value="${dto.isbn }"/>
						   				<input type="hidden" id="prod_name_${dto.seqNum }" name="prod_name" value="${dto.bookTitle }"/>
						   				<input type="hidden" id="optSeqVal_${dto.seqNum }" name="optSeqVal" value=""/>
						   				<input type="hidden" name="is_sale_yn"  value="Y"/>
						   				<input type="hidden" id="prodTypeArr_${dto.seqNum }" name="prodType" value="01"/>
						   				<input type="hidden" id="flag_${dto.seqNum }" name="flag" value="0"/>
						   				<input type="hidden" id="preSaleYnVal_${dto.seqNum }" name="preSaleYnVal" value="N"/>
						   				<input type="hidden" id="orderCnt_${dto.seqNum }" name="orderCount" value="${dto.orderCount }"/> 	
			            			</td>
			            			
		            			</tr>
							</c:otherwise>
						</c:choose>        	
	            		</c:forEach>
	            			

		            	</tbody></table>
		            	
		            	<script type="text/javascript">
		            	$(document).ready(function() {
		            		calC();
		            	});
		            	</script>
		            	
		            	<div class="overflow">
		            		 
		            		<div class="fl_left mt10 ml10 receive_check">
			            		<!-- <div class="mb5">반디상품 <strong id="bandi_deli_expect">2018년 10월 17일(수)</strong></div> -->
				            </div>
			            	<div class="fl_right mt10">
			            		<span class="t_11gr mr5">주문상품 변경을 원하시면 </span>
		            			<a href="javascript:goCart();"><img src="/webproject/resources/images/order/btn_order_cartmodify.gif" alt="쇼핑카트 수정하기"></a>
			            	</div>
		            	</div>
		            	
	            		<h3 class="orderTit mt40 fl_clear"><img src="/webproject/resources/images/order/h3_order_step02.gif" alt="2. 배송방법 선택"></h3>
		            	
          					
		            	<div class="order_deli">
			            	<table cellpadding="0" cellspacing="0" class="orderTable2" width="728">
			            		<colgroup><col width="140"><col width="588"></colgroup>
			            		<tbody><tr id="tr_deliCode" style="display: table-row;">
			            			<th>배송방법</th>
			            			<td>
			            				<span><input type="radio" name="deli_code" id="deli_01" value="01" class="mt3m mr3 btn_deliCode" checked=""><label for="deli_01">일반택배</label></span>   				
			            			</td>
			            		</tr>
						
			            		<tr id="tr_deliAddrSelect" style="display: table-row;">
			            			<th>배송지선택</th>
			            			<td>
			            				<span><input type="radio" name="deli_input_type" id="deli2_01" value="01" class="mt3m mr3" checked=""><label for="deli2_01">기본배송지</label></span> 
			            				<span class="ml15"><input type="radio" name="deli_input_type" id="deli2_02" value="02" class="mt3m mr3"><label for="deli2_02">새로입력</label></span>	
			            			</td>
			            		</tr>
			            		
			            		<tr id="tr_deliName" style="display: table-row;">
			            			<th class="line_none pb0">받으실 분</th>
			            			<td class="line_none pb0"><input type="text" name="recipientName" id="recipientName" size="20" maxlength="20" value="${userInfo.userName }" class="o_input"></td>
			            		</tr>
			            		<tr id="tr_deliMobile" style="display: table-row;">
			            			<th class="line_none pb0">휴대폰</th>
			            			<td class="line_none pb0">
			            				<select name="rcvr_tel2_part1">
			            					<option value="010">010</option>
			            					<option value="011">011</option>
			            					<option value="016">016</option>
			            					<option value="017">017</option>
			            					<option value="018">018</option>
			            					<option value="019">019</option>
			            					<option value="0502">0502</option>
			            					<option value="0503">0503</option>
			            					<option value="0504">0504</option>
			            					<option value="0505">0505</option>
			            					<option value="0506">0506</option>
			            					<option value="0507">0507</option>
			            					<option value="0508">0508</option>
			            					<option value="0509">0509</option>
			            				</select> 
			            					-
			            				<input type="text" name="rcvr_tel2_part2" id="rcvr_tel2_part2" size="4" maxlength="4" value="${addPhone2 }" class="o_input" style="ime-mode:disabled;width:20%" onkeypress="goNumCheck();"> -
			            				<input type="text" name="rcvr_tel2_part3" id="rcvr_tel2_part3" size="4" maxlength="4" value="${addPhone3 }" class="o_input" style="ime-mode:disabled;width:20%" onkeypress="goNumCheck();">
			            				
			            			</td>
			            		</tr>
			            		<tr id="tr_deliPhone" style="display: table-row;">
			            			<th>유선전화 (선택)</th>
			            			<td>
			            				<select name="rcvr_tel1_part1"><option value="02">02</option><option value="031">031</option><option value="032">032</option><option value="033">033</option><option value="041">041</option><option value="042">042</option><option value="043">043</option><option value="044">044</option><option value="051">051</option><option value="052">052</option><option value="053">053</option><option value="054">054</option><option value="055">055</option><option value="061">061</option><option value="062">062</option><option value="063">063</option><option value="064">064</option><option value="070">070</option><option value="0502">0502</option><option value="0503">0503</option><option value="0504">0504</option><option value="0505">0505</option><option value="0506">0506</option><option value="0507">0507</option><option value="0508">0508</option><option value="0509">0509</option></select> -            				
			            				<input type="text" name="rcvr_tel1_part2" size="4" maxlength="4" value="" class="o_input" style="ime-mode:disabled;" onkeypress="goNumCheck();"> -
			            				<input type="text" name="rcvr_tel1_part3" size="4" maxlength="4" value="" class="o_input" style="ime-mode:disabled;" onkeypress="goNumCheck();">
			            				<input type="hidden" name="rcvr_tel1" value="">
			            			</td>
			            		</tr>
			            		<tr id="tr_deliAddr" style="display: table-row;">
			            			<th>주소</th>
			            			<td>
			            				<p>
			            					<input type="text" id="rcvr_zip1" name="zipCode" size="6" value="${userInfo.zipCode }" class="o_input" readonly="">
			            					<input type="hidden" name="rcvr_zip2" value="">
			            					
			            						<img src="/webproject/resources/images/order/btn_order_zipcode.gif" class="mt2 btn_popPost" id="fZipCode" alt="우편번호찾기" style="cursor:pointer;">
			            					
			            				</p>
			            				<p class="mt5">
			            					<input type="text" id="rcvr_addr1" name="address1" value="${userInfo.address1 }" size="30" class="o_input" readonly="">
			            					<input type="text" id="rcvr_addr2" name="address2" size="40" class="o_input" value="${userInfo.address2 }" alt="나머지 주소 입력" style="color:grey;">
			            				</p>
			            				<p class="mt5 t_11gr">우편번호를 찾지 못하시거나 주소 입력에 어려움을 느끼실 경우 고객센터 1577-4030으로 문의 주십시오.</p>
			            				<input type="hidden" name="rcvr_post" value="">
			            			</td>
			            		</tr>

			            		<tr class="tr_deliEng" style="display:none;">
			            			<th class="line_none pb0">City</th>
			            			<td class="line_none pb0"><input type="text" name="eng_rcvr_city" size="25" class="o_input"></td>
			            		</tr>
			            		<tr class="tr_deliEng" style="display:none;">
			            			<th class="line_none pb0">State/Province</th>
			            			<td class="line_none pb0"><input type="text" name="eng_rcvr_state" size="25" class="o_input"></td>
			            		</tr>
			            		<tr class="tr_deliEng" style="display:none;">
			            			<th class="line_none">Address</th>
			            			<td class="line_none">
			            				<input type="text" name="eng_rcvr_addr1" size="30" class="o_input"> <input type="text" name="eng_rcvr_addr2" size="40" class="o_input">
			            			</td>
			            		</tr>
			            	</tbody></table>
			            	
			            	
			            	<div class="order_deli_box" style="display: block;">
			            		<h4 class="order_deli_tit">주문자 정보</h4>
			            		<dl class="order_buy_info">
			            			<dt>이름</dt>
		            				<dd>
		            					<input type="text" name="sndr_name" size="15" value="${userInfo.userId }" class="o_input">
		            				</dd>
			            				
			            			<dt>휴대폰</dt>
			            			<dd>
										<select name="sndr_tel2_part1" style="width:49px;height:20px;"><option value="">선택</option><option value="010" selected="selected">010</option><option value="011">011</option><option value="016">016</option><option value="017">017</option><option value="018">018</option><option value="019">019</option><option value="0502">0502</option><option value="0503">0503</option><option value="0504">0504</option><option value="0505">0505</option><option value="0506">0506</option><option value="0507">0507</option><option value="0508">0508</option><option value="0509">0509</option></select>-<input type="text" name="sndr_tel2_part2" value="${addPhone2 }" maxlength="4" size="4" class="o_input" style="ime-mode:disabled;width:25%;" onkeypress="goNumCheck();">-<input type="text" name="sndr_tel2_part3" value="${addPhone3 }" maxlength="4" size="4" class="o_input" style="ime-mode:disabled;width:25%;" onkeypress="goNumCheck();">
										<input type="hidden" name="sndr_tel2">
										<input type="hidden" name="sndr_tel1" value="">
			           				</dd>
			           				
			            			<dt>이메일</dt>
			            			<dd>
			            				<input type="text" name="sndr_mail" size="18.5" maxlength="40" class="o_input" value="${userInfo.email }">
			            				<input type="hidden" name="sndr_post" value="">
			            				<input type="hidden" name="sndr_addr1" value="">
			            				<input type="hidden" name="sndr_addr2" value="">
			            				<input type="hidden" name="sndr_num" value="8807121">
			            			</dd>
			            		</dl>
			            	</div>
			            	
			            	<div class="order_deli_box cvsnetInfo" style="display: none;">
			            		<h4 class="order_deli_tit">편의점 택배 안내</h4>
			            		<div class="mt10 ml10 mr10">주문 시 가까운 편의점을 선택하시면 24시간 영업을 하고 있는 편의점에서 주문하신 도서를 받으실 수 있습니다.</div>
			            		<div class="mt10 ml10 mr10 al_center">
			            			<img src="/webproject/resources/images/order/btn_order_cvsinfo.gif" id="btn_cvsNetInfo" alt="편의점 택배 더 보기" style="cursor:pointer;">
			            			<img src="/webproject/resources/images/order/btn_order_cvsdeli.gif" id="btn_cvsNetInfo2" alt="편의점 배송 시간 안내" style="cursor:pointer;">
			            		</div>
			            		
			            		<ul class="dotList mt10 ml10 mr10">
			            			<li><strong class="t_org">당일배송 상품</strong>은 <strong class="t_org">‘일반택배’</strong> 를 이용 해 주십시오. </li>
			            			<li class="mt10">편의점 택배는 안내된 <strong class="t_org">예상수령일보다 다소 지연</strong>되어 도착할 수 있습니다. </li>
			            			<li class="mt10">이용 가능한 편의점은 GS25 와 CU 입니다.(제주도와 도서지역 제외) </li>
			            		</ul>
			            		
			            		<div class="deli_box_close">
			            			<img src="/webproject/resources/images/order/btn_order_close.gif" alt="닫기" style="cursor:pointer;">
			            		</div>
			            	</div>
			            	
			            	<div class="order_deli_box foreignInfo" style="display:none">
			            		<h4 class="order_deli_tit">해외 배송 안내  </h4>
			            		<div class="mt10 ml10 mr10 al_center">
			            			<img src="/webproject/resources/images/order/btn_order_foreign.gif" id="btn_globalDeliCost" alt="해외배송비 안내" style="cursor:pointer;">
			            		</div>
			            		<ul class="dotList mt10 ml10 mr10">
			            			<li>해외 배송 시 주소는 <strong class="t_org">필히 영문으로 입력</strong> 해 주세요.</li>
			            			<li class="mt10">해외배송은 DHL로 배송되며, 도서상품의 경우 무게와 상관없이 <strong class="t_org">주문 권수대로 배송료를 부과</strong>합니다. 단, CD/DVD 등 도서 이외의 상품이 포함되어 있는 경우는 DHL 정상 운임이 적용됩니다.</li>
			            			<li class="mt10">무게가 많이 나가는 도서는 배송료를 추가로 부담할 수 있습니다.</li>
			            			<li class="mt10">배송 소요기간은 도서 재고확보여부에 따라 더 늘어날 수 있습니다. </li>			            			
			            			<li class="mt10">해당 상품은 각 국가별 면세 기준에 의하여 해외 배송료 외에 <strong class="t_org">통관 관세가 추가 될 수도</strong> 있습니다. 
			            			추가된 관련 관세는 <strong class="t_org">수령인 부담이니</strong> 유의하시기 바랍니다. (수령인의 서류미비로 인하여 통관 또는 배송이 지연될 수도 있습니다.)</li>
			            		</ul>
			            		<div class="deli_box_close">
			            			<img src="/webproject/resources/images/order/btn_order_close.gif" alt="닫기" style="cursor:pointer;">
			            		</div>
			            	</div>
			            	
			            	<div class="order_deli_box deli_info" style="display:none">
			            		<h4 class="order_deli_tit">최근 배송지 목록</h4>
			            		<ul class="deli_list">
			            			
			            			
			            			
			            			
			            		</ul>
			            		<div class="deli_box_close">
			            			<img src="/webproject/resources/images/order/btn_order_close.gif" alt="닫기" style="cursor:pointer;">
			            		</div>
			            	</div>
			            	
			            	
			            </div>
			            
			            
		            	<table cellpadding="0" cellspacing="0" class="orderTable2" id="todayDeliTab" width="960" style="display: none;">
		            		<tbody><tr>
		            			<th>당일배송</th>
		            			<td>
		            				<span><input type="radio" name="todayDeliYn" id="today_deli_y" value="Y" class="mt3m mr3" checked=""><label for="today_deli_y">당일배송</label></span> 
		            				<span class="ml15"><input type="radio" name="todayDeliYn" id="today_deli_n" value="N" class="mt3m mr3"><label for="today_deli_n">일반배송(내일 이후 도착 / 단, 주말/공휴일 경우 예외)</label></span>
		            			</td>
		            		</tr>
		            	</tbody></table>
		            	
		            	
		            	<table cellpadding="0" cellspacing="0" class="orderTable2" id="abroad_deli" width="960" style="display:none">
		            		<tbody><tr>
		            			<td>
		            				<p>＊중국, 일본, 태국 등 지역이 넓은 국가는 일부 지역에 한해 DHL택배 → 현지택배를 통해 배송됩니다.<br>
    									(현지택배로 배송 시 예상 수령일보다 2~3일 더 소요될 수 있습니다.)</p>
		            			</td>
		            		</tr>
		            	</tbody></table>
		            	
		            	
		            	<h3 class="orderTit mt40"><img src="/webproject/resources/images/order/h3_order_step03.gif" alt="3. 할인정보"></h3>
		            	<table cellpadding="0" cellspacing="0" class="orderTable2" width="960" style="">
		            		<colgroup><col width="140"><col width="270"><col></colgroup>
		            		<tbody><tr>
		            			<th class="line_none pb0" style="height: 34px; padding-top: 5px;">적립금</th>
		            			<td class="line_none pb0" style="height: 34px; padding-top: 5px;">
		            				<span class="s_con01"><input type="text" name="reserve_point" id="reserve_point" maxlength="8" class="o_input use_point" value="0" size="18" min="" max="" style="ime-mode;disabled;"></span>
		            				<span class="s_con02"> 원 / <strong class="t_org">${leftPoint }원</strong></span>
		            				<input type="hidden" id="reserve_point_max" value="${leftPoint }">
		            			</td>
		            			<td class="line_none pb0"></td>
		            		</tr>

		            		
		            		
		            		
		            		<!-- 금액대별 반디상품권 팝업 레이어 -->
							<tr id="my_bookcoupon_area" style="display:none">
								<td class="coupon_order_w" colspan="3">
									<div class="coupon_order_use" id="result_bookcoupon_area"></div> 
									<div class="al_center mt20">
										<span id="btn_apply_bookcoupon" class="btn_bu_comm btype_a3" style="cursor:pointer;">반디상품권 적용하기</span>
										<!-- <a href="javascript:$('#my_bookcoupon_area').toggle();" class="btn_w_comm btype_a3">닫기</a>  -->
										<a href="#" onclick="javascript:$('#my_bookcoupon_area').toggle();" class="btn_w_comm btype_a3">닫기</a>
									</div>
								</td>
							</tr>
							<!--// 금액대별 반디상품권 팝업 레이어 -->
		            	</tbody></table>
		            	
		            	
		            	<div class="pos_rel">
			            	<table cellpadding="0" cellspacing="0" class="orderTable_tatol" width="960">
			            		<colgroup><col width="250"><col width="230"><col><col width="232"></colgroup>
			            		<tbody><tr>
			            			<th>주문금액 합계</th>
			            			<th>배송/포장비</th>
			            			<th>할인금액</th>
			            			<th>결제금액</th>
			            		</tr>
			            		<tr>
			            			<td><span id="bandiDeduction_totSaleCost">0</span><span class="t_14">원</span></td>
			            			<td><span id="bandiDeduction_totDeliCost">0</span><span class="t_14">원</span><br><span class="t_11gr" id="finalDeliCostInfo"></span></td>
			            			<td><span id="totDiscountCost">0</span><span class="t_14">원</span><br><span class="t_11gr" id="finalDiscountCostInfo"></span></td>
			            			<td class="total"><span id="totOrdCost">0</span><span class="t_14">원</span></td>
			            		</tr>
			            	</tbody></table>
			            	<span class="order_plus"></span><span class="order_minus"></span><span class="order_same"></span>
			            	<span id="span_partner_text" style="float:right"></span>
		            	</div>
		            	
		           		<h3 class="orderTit mt40"><img src="/webproject/resources/images/order/h3_order_step04.gif" alt="4. 결제정보"></h3>
		           		<div class="order_pay">
		            		<div class="payInfo">
			            		<div class="payInfo_wrap">
				            		<h4 class="none">결제수단선택</h4>		            		
				            	</div>
				            	
				            	<div class="pay_wrap">
				            		<div class="pay_total">
				            			<dl class="pan_con01">
				            				<dt><img src="/webproject/resources/images/order/h3_order_totalpay.gif" alt="최종 결제 금액"></dt>
				            				<dd><span class="finalCashCost">0</span><span class="t_14">원</span></dd>
				            			</dl>
				            		</div> 
				            		<div class="mt10">
				            			<img src="/webproject/resources/images/order/btn_order_pay.gif" id="btn_order" alt="결제하기" style="cursor:pointer;">
				            			<img src="/webproject/resources/images/ajax-loader.gif" id="btn_order_loading" alt="로딩" style="display:none;width:212px;">
				            		</div>
				            		<div class="mt10">
				            			<!-- 약관체크 인증시 비회원은 동의했으므로 생략 -->
				            			
					            			<div class="pay_receipt">
					            				<span class="receipt_check"><input type="checkbox" id="item03" name="item03"></span>
					            				개인정보 선택 항목의 수집에 동의합니다. <a href="javascript:popUpRules2();" class="btn_w_comm btype_a4">내용보기</a>
					            			</div>
						            		<div class="pay_receipt">
						            			<span class="receipt_check"><input type="checkbox" id="item04" name="item04"></span>
						            			 배송 등을 위해 제3자 정보제공에 동의합니다. <a href="javascript:popUpRules3();" class="btn_w_comm btype_a4">내용보기</a>
						            		</div>

				            		</div> 
				            		
			            			<dl class="pay_point">
			            				<dt><span class="fl_left">적립가능액</span> <span class="fl_right"><strong class="finalProdPoint">1,440</strong>원</span></dt>			            				      				           				 
			            			</dl>
			            			<ul class="mt10 ml5">
				                    	<li class="dot_comm t_11gr">5만원이상 추가적립/멤버십/바로온2% 적립금은 비도서, 뷰티 포함 구매 시 적용됩니다. (도서 제외)</li>
				                    	<li class="dot_comm t_11gr mt5">업체배송 상품은 추가적립 대상에서 제외됩니다. (상품페이지, 쇼핑카트에서 업체배송 확인 가능)</li>
				                    	<li class="dot_comm t_11gr mt5">적립가능액은 쿠폰, 적립금등 보조결제 수단 따라 약간의 금액 차이가 있을수가 있습니다.</li>
				                    	<li class="dot_comm t_11gr mt5">적립금 지급 시기는 구매완료 시점에 자동 지급 됩니다.</li>		                    	
				                    </ul>
				            	</div>

				            	<div id="cashReceiptDiv" style="display:none;">

				            	<div>
				            		
				            	</div>

        				        </div>
        				        				            	
				            	<div>
				            		<iframe id="iframe_settleInfo" src="http://blog.noroo.co.kr/common/namo/binary/images/000061/170619000000374_O.jpg" frameborder="0" width="728" scrolling="no" height="630"></iframe>
				            	</div>
				            	<div>
				            		<iframe id="iframe_settleInfo_bandi" src="http://www.bandinlunis.com/front/main.do" frameborder="0" width="728" scrolling="no" height="0"></iframe>
				            	</div>
				            	
				            </div>	           		
		           		</div>
	           		</fieldset>
            	</form>
            	
            </div>
        </div>
     </div>
     



   
     
     
     
<jsp:include page="../common/footer.jsp" flush="false" /> 
</body>
</html>