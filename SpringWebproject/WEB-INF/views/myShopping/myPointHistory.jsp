<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
			
			url:"getPointList.action",
			type:"POST",
			success:function(data){
				$('#myPointList').html(data);	
			},
			error:function(e){
				alert(e.responseText);
			}

		});
		
		//취소/반품/교환 내역
		//기간별 조회		
		$('#getPointList').on('click',function(){
			
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
			
			var mode = $('#point_mode option:selected').val();
			
			//파라미터 정리
			var pageNum = '${pageNum}';
			
			params = 'fromDate=' + fromDate + '&toDate=' + toDate + "&mode=" + mode;
			
			if(pageNum!=''){
				params += "&pageNum=" + pageNum;
			}
			
			$.ajax({
				
				url:"getPointList.action",
				data:params,
				type:"POST",
				success:function(data){
					$('#myPointList').html(data);	
				},
				error:function(e){
					alert(e.responseText);
				}

			});
			
		});	
		
		$('#point_mode').on('change',function(){
			
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
			
			var mode = $('#point_mode option:selected').val();
			
			//파라미터 정리
			var pageNum = '${pageNum}';
			var params = 'fromDate=' + fromDate + '&toDate=' + toDate + '&mode=' + mode;
			
			if(pageNum!=''){
				params += "&pageNum=" + pageNum;
			}
			
			$.ajax({
				
				url:"getPointList.action",
				data:params,
				type:"POST",
				success:function(data){
					$('#myPointList').html(data);	
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
	<a href="<%=cp %>/main.action">홈</a> > <a href="<%=cp %>/myShoppingMain.action">나의쇼핑</a> > 포인트와 혜택 > <b>적립금</b>
</div>
<!-- navigation -->
<jsp:include page="./topNavi.jsp" flush="false"/>
<jsp:include page="./sideNavi.jsp" flush="false"/>

<div class="contents">
	<div style="font-size: 13pt; font-weight: bold; padding-bottom: 10px;">적립금 | <span style="font-size: 10pt; font-weight: normal;">상품 구매 및 각종 활동 참여 시 적립금이 지급됩니다.</span></div>
	<div class="sort_box" style="height: 25px;">
		<div class="point_box" style="text-align: center;">
			사용 가능한 적립금 : <span class="point_red"><fmt:formatNumber value="${pointValue }" pattern="#,###"/>원</span>
		</div>
		<div class="point_box" style="margin-left: 0px;">
			소멸 예정 적립금 (60일 이내) : <span class="point_red"><fmt:formatNumber value="${exPoint }" pattern="#,###"/>원</span> 
			<input type="button" value="자세히보기" name="point_more" id="point_more" class="point_more" onclick="javascript:location='<%=cp%>/myShopping/expPointDetail.action';">
		</div>
		
		<span></span>
	</div>
	<div class="sort_box" style="height: 100px;">
		<dl>
			<dt>기간별 조회</dt>
			<dd>
				<span style="display: block;">
					<a href="javascript:setDate(0, 15)"><img alt="최근15일" src="<%=cp%>/resources/img/myShopping/btn_date_15d.gif"></a>
					<a href="javascript:setDate(1, 0)"><img alt="1개월" src="<%=cp%>/resources/img/myShopping/btn_date_1m.gif"></a>
					<a href="javascript:setDate(3, 0)"><img alt="3개월" src="<%=cp%>/resources/img/myShopping/btn_date_3m.gif"></a>
					<a href="javascript:setDate(6, 0)"><img alt="6개월" src="<%=cp%>/resources/img/myShopping/btn_date_6m.gif"></a>
					<a href="javascript:setDate(12, 0)"><img alt="6개월" src="<%=cp%>/resources/img/myShopping/btn_date_1y.gif"></a>
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
						<a href="#"><img alt="조회" src="<%=cp%>/resources/img/myShopping/btn_sort_search.gif" style="vertical-align: top;" id="getPointList"></a>
					</span>	
				</span>	
			</dd>
		</dl>
		<dl>
			<dt>내역별 조회</dt>
			<dd>
				<span>
					<select name="mode" style="width: 90px;" class="point_mode" id="point_mode">
						<option value="all">전체내역</option>
						<option value="save">적립내역</option>
						<option value="use">사용내역</option>
					</select>
				</span>
			</dd>
		</dl>
	</div>
	
	<div class="myOrderList_table" id="myPointList">
		<table>
			<tr>
				<th>적립일</th>		
				<th>주문번호</th>
				<th style="width: 365px;">내역</th>
				<th>구분</th>
				<th>금액</th>
			</tr>
			<tr>
				<td colspan="5" height="100px;">적립된 내역이 없습니다.</td>
			</tr>
		</table>
	</div>

</div>




</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>