<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<!DOCTYPE html>
<html>
<head>
<title>반디앤루니스 인터넷서점</title>

	<link rel="stylesheet" href="<%=cp%>/resources/css/main.css" type="text/css">
	<link rel="stylesheet" href="<%=cp%>/resources/css/myShopping.css" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="<%=cp%>/resources/js/myShopping.js"></script>
	
	<script type="text/javascript">
	
	//주문/배송 조회
	$(document).ready(function(){
		
		//초기 리스트 자동 불러오기
		$.ajax({
			
			url:"getOrderList.action",
			type:"POST",
			success:function(data){
				$('#myOrderList').html(data);	
			},
			error:function(e){
				alert(e.responseText);
			}

		});
		
		//주문/배송 조회
		//기간별 조회		
		$('#searchOrdersByDate').on('click',function(){
			
			var fromMonth = '0' + $('#fromMonth option:selected').val();
			fromMonth = fromMonth.substring(fromMonth.length, fromMonth.length-2);
			var fromDay = '0' + $('#fromDay option:selected').val();
			fromDay = fromDay.substring(fromDay.length, fromDay.length-2);
			var toMonth = '0' + $('#toMonth option:selected').val();
			toMonth = toMonth.substring(toMonth.length, toMonth.length-2);
			var toDay = '0' + $('#toDay option:selected').val();
			toDay = toDay.substring(toDay.length, toDay.length-2);
			
			var fromDate = $('#fromYear option:selected').val() + '-' 
							+ fromMonth + '-'+ fromDay;

			var toDate = $('#toYear option:selected').val() + '-' 
							+ toMonth + '-'	+ toDay;
			
			//파라미터 정리
			var pageNum = '${pageNum}';
			
			params = 'fromDate=' + fromDate + '&toDate=' + toDate;
			
			if(pageNum!=''){
				params += "&pageNum=" + pageNum;
			}
			
			$.ajax({
				
				url:"getOrderList.action",
				data:params,
				type:"POST",
				success:function(data){
					$('#myOrderList').html(data);	
				},
				error:function(e){
					alert(e.responseText);
				}

			});
			
		});
		
		//상품명 조회
		$('#searchOrdersByName').on('click',function(){
			var searchValue = $('#orderListSearchValue').val();
			var pageNum = '${pageNum}';
			
			var params = "searchValue=" + searchValue;
			
			if(pageNum!=''){
				params += "&pageNum=" + pageNum;
			}
			
			$.ajax({
				
				url:"getOrderList.action",
				data:params,
				type:"POST",
				beforeSend:checkValue,
				success:function(data){
					$('#myOrderList').html(data);	
				},
				error:function(e){
					alert(e.responseText);
				}

			});
			
		});

	});
	
	</script>
	
	
</head>
<body style="padding: 0; margin: 0;">

<!-- header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<!-- 전체 div -->
<div style="margin: 0 auto; width: 960px;">

<div style="margin-top: 12px;">
	<a href="<%=cp %>/main.action">홈</a> > <a href="<%=cp %>/myShoppingMain.action">나의쇼핑</a> > 주문관리 ><b>주문/배송조회</b>
</div>
<!-- navigation -->
<jsp:include page="./topNavi.jsp" flush="false"/>
<jsp:include page="./sideNavi.jsp" flush="false"/>

<!-- 본문 -->
<div class="contents">
	<div style="font-size: 13pt; font-weight: bold; padding-bottom: 10px;">주문/배송조회</div>
	<div class="sort_box">
		<dl>
			<dt>기간별 조회</dt>
			<dd>
				<span style="display: block;">
					<a href="javascript:setDate(0, 15)"><img alt="최근15일" src="<%=cp%>/resources/img/myShopping/btn_date_15d.gif"></a>
					<a href="javascript:setDate(1, 0)"><img alt="1개월" src="<%=cp%>/resources/img/myShopping/btn_date_1m.gif"></a>
					<a href="javascript:setDate(3, 0)"><img alt="3개월" src="<%=cp%>/resources/img/myShopping/btn_date_3m.gif"></a>
					<a href="javascript:setDate(6, 0)"><img alt="6개월" src="<%=cp%>/resources/img/myShopping/btn_date_6m.gif"></a>
				</span>
				<span style="width: 500px; margin-top: 5px; display: block;">
					<span><select name="fromYear" id="fromYear"></select></span>
					<span><select name="fromMonth" id="fromMonth"></select></span>
					<span><select name="fromDay" id="fromDay"></select></span>
					<span>&nbsp;-&nbsp;</span>
					<span><select name="toYear" id="toYear"></select></span>
					<span><select name="toMonth" id="toMonth"></select></span>
					<span><select name="toDay" id="toDay"></select></span>
					<span style="display: inline; height: 22px;">
						<a href="#"><img alt="조회" src="<%=cp%>/resources/img/myShopping/btn_sort_search.gif" style="vertical-align: top;" id="searchOrdersByDate"></a>
					</span>	
				</span>	
			</dd>
		</dl>
		<dl>
			<dt>상품명 조회</dt>
			<dd>
				<span><input type="text" style="height: 19px;" name="orderListSearchValue" id="orderListSearchValue"></span>
				<span style="margin-right: 5px;"><a href="#"><img alt="조회" src="<%=cp%>/resources/img/myShopping/btn_sort_search.gif" style="vertical-align: top;" name="searchOrdersByName" id="searchOrdersByName"></a></span>
				상품명 또는 ISBN 검색
			</dd>
		</dl>
		<dl>
			<dd style="width: 650px; margin-left: 18px;">조회기간은 최대 1년 단위로 설정하실 수 있으며, 주문번호를 클릭하시면 주문에 대한 상세정보를 보실 수 있습니다.</dd>
		</dl>
	</div>
		
	<div class="myOrderList_table" id="myOrderList">
		<table>
			<tr>
				<th>주문번호</th>
				<th style="width: 365px;">상품명</th>
				<th>주문일자</th>
				<th>수령예상일</th>
				<th>주문금액</th>
			</tr>
			<tr>
				<td colspan="5" height="100px;">최근 주문내역이 없습니다.</td>
			</tr>
		</table>
	</div>

	<div class="myOrder_under_div">주문/배송상태</div>
	<div>
		<img alt="" src="<%=cp%>/resources/img/myShopping/my_order_step.gif">
	</div>
</div>


</div>


<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>