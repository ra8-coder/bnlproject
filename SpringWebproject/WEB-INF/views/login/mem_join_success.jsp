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
	
	<style type="text/css">
	.move_btn {color: #755a2a; background-color: #fff; border: 1px solid #755a2a; height: 40px; width: 150px; font-size: 12pt; font-weight: bold; cursor: pointer; border-radius: 5px;}
	.move_btn:hover {color: #755a2a; background-color: #fff; border: 2px solid #755a2a; height: 40px; width: 150px; font-size: 12pt; font-weight: bold; cursor: pointer;}
	</style>

</head>
<body>

<!-- header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<!-- 전체 div -->
<div style="margin: 0 auto; width: 960px;">
	<div style="margin-top: 50px;">
	<img alt="" src="<%=cp%>/resources/img/login/sucess_box.jpg"><br/>
	</div>
	<div style="width: 960px; text-align: center;">
		<input type="button" value="메인 페이지로" class="move_btn" onclick="javascipt:location.href='<%=cp%>/main.action';">
		<input type="button" value="로그인 페이지로" class="move_btn" onclick="javascipt:location.href='<%=cp%>/login.action';">
	</div>
</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

<script type="text/javascript">
	window.onload = function(){
		alert("반디앤루니스 가입을 환영합니다. 신규가입 축하 적립금이 지급되었습니다(유효기간 30일). 나의 쇼핑정보에서 확인해주세요.");
	}
	
</script>

</body>
</html>