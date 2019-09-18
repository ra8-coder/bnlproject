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
	
	//초기 리스트 자동 불러오기
	$(document).ready(function(){
		$.ajax({
		
			url:"expPointList.action",
			type:"POST",
			success:function(data){
				$('#expPointList').html(data);	
			},
			error:function(e){
				alert(e.responseText);
			}

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
	<a href="<%=cp %>/main.action">홈</a> > <a href="<%=cp %>/myShoppingMain.action">나의쇼핑</a> > 포인트와 혜택 ><b>적립금</b>
</div>
<!-- navigation -->
<jsp:include page="./topNavi.jsp" flush="false"/>
<jsp:include page="./sideNavi.jsp" flush="false"/>

<div class="contents">
	<div style="font-size: 13pt; font-weight: bold; padding-bottom: 10px;">소멸 예정 적립금 | <span style="font-size: 10pt; font-weight: normal;">적립일로부터 1년 미사용 금액이 자동 소멸됩니다.</span></div>
	<div class="exp_point_detail_box">
		60일 이내소멸 예정 적립금 : <span class="point_red"><fmt:formatNumber value="${exPoint }" pattern="#,###"/>원</span>
	</div>
	
	<div class="exp_point_detail_table" id="expPointList">

	</div>
	
	<div class="exp_point_notice">
		<ul>
			<li>적립금은 지급일로부터 1년간 유효하며, 1년이 경과된 적립금은 순차적으로 소멸됩니다.</li>
			<li>'이벤트 적립금'은 이벤트 기간 내에만 사용할 수 있으며, 별도 유효기간이 적용됩니다.</li>
		</ul>
	</div>
	

</div>

</div>


<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>