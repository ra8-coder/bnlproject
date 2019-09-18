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
	
	$(document).ready(function(){
		
		$.ajax({
			
			url:"getRetList.action",
			type:"POST",
			success:function(data){
				$('#myRetLists').html(data);	
			},
			error:function(e){
				alert(e.responseText);
			}

		});
		
		//취소/반품/교환 내역
		//기간별 조회		
		$('#getRetList').on('click',function(){
			
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
				
				url:"getRetList.action",
				data:params,
				type:"POST",
				success:function(data){
					$('#myRetLists').html(data);	
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
	<a href="<%=cp %>/main.action">홈</a> > <a href="<%=cp %>/myShoppingMain.action">나의쇼핑</a> > 주문관리 > <b>취소/반품/교환 내역</b>
</div>
<!-- navigation -->
<jsp:include page="./topNavi.jsp" flush="false"/>
<jsp:include page="./sideNavi.jsp" flush="false"/>

<div class="contents">
	<div style="font-size: 13pt; font-weight: bold; padding-bottom: 10px;">
		취소/반품/교환 내역
		<span style="font-size: 10pt; padding-left: 10px; font-weight: normal;">주문 취소 또는 반품 교환하신 내역을 조회하실 수 있습니다.</span>
	</div>
	<div class="sort_box" style="height: 70px;">
		<dl>
			<dt style="line-height: 45px;">기간별 조회</dt>
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
						<a href="#"><img alt="조회" src="<%=cp%>/resources/img/myShopping/btn_sort_search.gif" style="vertical-align: top;" id="getRetList"></a>
					</span>	
				</span>	
			</dd>
		</dl>
	</div>
	
	<div class="myOrderList_table" id="myRetLists">
		<table>
			<tr>
				<th>처리일자</th>
				<th style="width: 365px;">상품명</th>
				<th>수량</th>
				<th>취소/환불금액</th>
				<th>현황</th>
			</tr>
			<tr>
				<td colspan="5" height="100px;">최근 주문내역이 없습니다.</td>
			</tr>
		</table>
	</div>

</div>

</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>