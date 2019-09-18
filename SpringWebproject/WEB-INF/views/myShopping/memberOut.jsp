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
	
</head>
<body style="padding: 0; margin: 0;">

<!-- header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<!-- 전체 div -->
<div style="margin: 0 auto; width: 960px;">

<div style="margin-top: 12px;">
	<a href="<%=cp %>/main.action">홈</a> > <a href="<%=cp %>/myShoppingMain.action">나의쇼핑</a> > 회원정보 > <b>회원 탈퇴</b>
</div>

<!-- navigation -->
<jsp:include page="./topNavi.jsp" flush="false"/>
<jsp:include page="./sideNavi.jsp" flush="false"/>

<div class="contents">
	<div style="font-size: 13pt; font-weight: bold; padding-bottom: 10px; margin-bottom: 20px;">회원탈퇴</div>
	
	<b>회원 탈퇴 안내</b>
	<div class="summary_box">
		<ul>
			<li>회원탈퇴 시 고객님의 회원정보는 전자상거래 상에서의 소비자보호 법률에의거한 반디앤루니스 개인정보보호정책에따라 관리됩니다.</li>
			<li>비 현금성 포인트인 적립금은 탈퇴 즉시 삭제 처리되어 환급되지 않으며, 재가입하셔도 복원되지 않습니다.</li>
			<li>진행중인 거래(구매/반품/취소 등) 내역이 있는 경우는 회원탈퇴가 불가능하오니, 거래 종료 후 회원 탈퇴 하실 수 있습니다.</li>
			<li><span class="point_red">회원탈퇴 시 모든 회원정보는 자동으로 즉시 삭제됩니다.</span></li>
		</ul>
	</div >
		
	<div style="text-align: center;">
		<input type="button" value="탈퇴하기" class="myInfo_update_ok" onclick="memOutCheck();">
		<input type="button" value="돌아가기" class="myInfo_update_cancel"  onclick="javascript:location.href='<%=cp %>/myShoppingMain.action';">	
	</div>

</div>


</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>