<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/webproject/resources/js/multiCart.js"></script>

<table cellpadding="0" cellspacing="0" class="orderTable">
	<colgroup>
		<col width="55">
		<col>
		<col width="92">
		<col width="92">
		<col width="72">
		<col width="92">
		<col width="90">
		<col width="40">
	</colgroup>
	<tbody>
	 
		<tr>
			<th colspan="2">상품명</th>
			<th>수령예상일</th>
			<th>판매가</th>
			<th>수량</th>
			<th>합계</th>
			<th>담기/삭제</th>   
			<th><input type="checkbox" id="bandiDeduction" class="checkAll"></th>                			
		</tr>
	
	<c:forEach var="dto" items="${lst }">	
		<tr>
			<td>
				<span class="book_img"><img src="<%=cp %>/resources/image/book/${dto.bookImage }" onerror=""></span> 
			</td>
			<td class="prod_name">
				<span class="block t_14"><a href="<%=cp %>/book_info.action?isbn=${dto.isbn}">[도서]${dto.bookTitle }</a></span>
				<span class="block mt3 t_gr">${dto.authorName } | ${dto.publisher }</span>	
			</td>
			
			<td id="bandi_deli_term_48116888">
				2018년<br>10월 13일(토)
			</td>

			<td>
				<strong>${dto.discountedPrice }원</strong><br>
				(10%<strong class="point_b">↓</strong>)<br>
				(<strong class="point_o">P</strong> ${dto.point }원)
			</td>

			<td>
				<span class="num_c">
					<input type="text" name="cntVal" id="cntVal_${dto.seqNum}" value="${dto.orderCount }" class="o_input_num fl_left" size="3" onkeydown="onlyNumber();" onkeyup="cntChange('${dto.isbn}');" style="text-align:right;ime-mode:disabled;">
					<span class="num_c_up"><img src="/webproject/resources/images/searchN/btn_num_up.gif" alt="" onclick="cntUp2('${dto.seqNum }');" style="cursor:pointer;"></span>
					<span class="num_c_dn"><img src="/webproject/resources/images/searchN/btn_num_down.gif" alt="" onclick="cntDown2('${dto.seqNum }');" style="cursor:pointer;"></span>
				</span>
				<img src="/webproject/resources/images/searchN/btn_cart_modify.gif" alt="수정" class="mt5" onclick="updateShopCart('${dto.isbn}','${dto.seqNum }')" style="cursor:pointer;">
			</td>

			<td>
				
				<strong id="costVal_${dto.seqNum }">${dto.discountedPrice * dto.orderCount }원</strong>

			</td>  
			         			
			<td>
				<img src="/webproject/resources/images/searchN/btn_cart_wishlist.gif" alt="위시리스트 담기" onclick="add_wish_common('${dto.isbn}');" style="cursor:pointer;"><br>
				<img src="/webproject/resources/images/searchN/btn_cart_del.gif" alt="삭제" class="mt5" onclick="deleteShopCart('${dto.seqNum}')" style="cursor:pointer;">
			</td>
			
			<td>
		        <input type="checkbox" id="checkBox_${dto.seqNum }" name="seqArr3" class="check_bandiDeduction" value="${dto.seqNum }" checked="checked">
   				<input type="hidden" id="pricePerBook_${dto.seqNum}" name="pricePerBook" value="${dto.discountedPrice}"/>

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
	</c:forEach>
		
	</tbody>
</table>

<div class="cart_pay_total">
	<span class="fl_left mt3 ml10" id="bandiDeduction_totOrdCnt">수량: 1종(1개)</span>
	<span class="fl_right al_right">
		<span class="di_in mt3 mr5">총 상품 금액: <span id="bandiDeduction_totSaleCost">13,500</span>원</span>
		<span class="di_in al_top mr5"><img src="/webproject/resources/images/searchN/ico_cart_plus.gif" alt=""></span>
		<span class="di_in mt3 mr5">배송비: <span id="bandiDeduction_totDeliCost">0</span>원</span>
		<span class="di_in al_top mr5"><img src="/webproject/resources/images/searchN/ico_cart_same.gif" alt=""></span>
		<span class="di_in mt3 mr10">주문금액 합계: <span class="t_red"><span id="bandiDeduction_totOrdCost">0</span>원</span></span>
	</span>
</div>
<div class="cart_point_total al_right"> 
	<span id="span_prevInfo"></span>
	<strong class="mr10">적립가능액 : <span class="point_b">상품적립금 <span id="bandiDeduction_totPoint">0</span>원</span></strong>
</div>

<script type="text/javascript">
$(document).ready(function(){
	
	
	orderCalc();
	
	$(".checkAll").each(function(){
		this.checked = true;
	});
	
	if($(".check_bandiDeduction").size() > 0)	$("#bandi_deduction_list").show();
	if($(".check_bandi").size() > 0)			$("#bandi_list").show();
	if($(".check_store").size() > 0)			$("#store_list").show();


	//전체선택&해제
	$(".checkAll").click(function(){
		if(this.checked) {
			$(".check_"+this.id).prop("checked",true);
		}else {
			$(".check_"+this.id).prop("checked",false);
		}
		
	});
	
});

</script>
