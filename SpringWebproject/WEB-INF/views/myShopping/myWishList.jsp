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
		
		//초기 리스트 자동 불러오기
		$.ajax({
			
			url:"getWishList.action",
			type:"POST",
			success:function(data){
				$('#myWishList').html(data);	
			},
			error:function(e){
				alert(e.responseText);
			}
		});
		
		$('#wish_sort_mode').on('change',function(){
			
			var mode = $('#wish_sort_mode option:selected').val();
			var pageNum = '${pageNum}';
			var params = 'mode=' + mode;
			
			if(pageNum!=''){
				params += "&pageNum=" + pageNum;
			}
			
			$.ajax({
				url:"getWishList.action",
				data:params,
				type:"POST",
				success:function(data){
					$('#myWishList').html(data);	
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
	<a href="<%=cp %>/main.action">홈</a> > <a href="<%=cp %>/myShoppingMain.action">나의쇼핑</a> > 관심 리스트 ><b>위시리스트</b>
</div>
<!-- navigation -->
<jsp:include page="./topNavi.jsp" flush="false"/>
<jsp:include page="./sideNavi.jsp" flush="false"/>

<div class="contents">
	<div style="font-size: 13pt; font-weight: bold; padding-bottom: 10px;">위시리스트 </div>
	<div style="margin-top: 10px;">
		총 ${wishCount }권의 상품이 등록되어 있습니다.
		<span style="float: right;"><img alt="프린트" src="<%=cp%>/resources/img/myShopping/btnW_print_01.gif" onclick="window.print();" style="cursor: pointer;"></span>
	</div>
	
	<div class="wish_sort_box">
		<div class="wish_sort_left">
			<select id="wish_sort_mode">
				<option value="wishDefault">최근순</option>
				<option value="wishOldDate">오래된순</option>
				<option value="wishName">상품명순</option>
				<option value="wishHighPrice">높은가격순</option>
				<option value="wishLowPrice">낮은가격순</option>
				<option value="wishBuy">구매한 상품만</option>
				<option value="wishNoBuy">구매하지 않은 상품만</option>
			</select>
		</div>
		<div class="wish_sort_right">
			<span style="line-height: 20px;"><input type="checkbox" value="all" class="check_all" height="150px;">전체선택</span>
			<input type="button" value="쇼핑카트" class="wish_sort_btn" onclick="javascript:goShoppingCart();">
			<input type="button" value="삭제" class="wish_sort_btn" onclick="deleteWish();">
		</div>
	</div>
	<div id="myWishList">
	
	</div>
	
</div>




</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>