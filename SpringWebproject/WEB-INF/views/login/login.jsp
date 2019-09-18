<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	String alert = (String)request.getSession().getAttribute("loginAlert");
	request.getSession().removeAttribute("loginAlert");
	
%>
<!DOCTYPE html>
<html>
<head>
<title>반디앤루니스 인터넷서점</title>

	<link rel="stylesheet" href="<%=cp%>/resources/css/join.css" type="text/css">
	
	<!-- bootstrap -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="../js/iframeResizer.contentWindow.min.js"></script>
 	<link rel="stylesheet" href="<%=cp%>/resources/css/custom_bootstrap.css" type="text/css">
	<script src="<%=cp%>/resources/js/join.js"></script>
	
	<script type="text/javascript">
	
	$(function(){
		
		var message = '<%=alert%>';
		
		if(message!=null && message!='' && message!='null'){
			alert(message);
		}
	});
	
	</script>
	
</head>

<body style="margin: 0;padding: 0">

<!-- header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<!-- 전체 div -->
<div style="margin: 0 auto; width: 960px;">

<form action="" name="loginForm" method="post">
<div class="login_div">
	<div class="login_left_div">
		<img alt="로그인" src="<%=cp%>/resources/img/login/login_tit.gif">
		<br/><br/>
		<div class="login_message"><b>${message}</b></div>
		<div class="bts"  style="float: left;">		
			<input type="text" name="user_id" placeholder="아이디" style="border-color: bcbcbc; border: 1px solid; margin-bottom: 0px; height: 40px; width: 300px;" class="form-control"> <br/>
			<input type="password" name="userPwd" placeholder="비밀번호" style="border-color: bcbcbc; border: 1px solid; margin-bottom: 10px; height: 40px; width: 300px;" class="form-control" id="login_pwd">		
		</div>
		<div style="float: left; padding-left: 20px">
			<input type="button" value="로그인" onclick="login();" class="login_btn">
		</div>
		<div style="clear: both; margin-bottom: 10px; font-size: 10pt;" class="checkbox">
			<label><input type="checkbox" id="idSave" name="idSave" style=" line-height: 15px; vertical-align: middle;">아이디저장</label>
		</div>
		<div class="href">
			<a href="javascript:showWindow('mem_findId',660)">아이디찾기</a>&nbsp;|&nbsp;
			<a href="javascript:showWindow('mem_findPwd',660)">비밀번호 찾기</a>&nbsp;|&nbsp;
			<a href="<%=cp%>/login/mem_agree.action"><b>회원가입</b></a>
		</div>
	</div>
	<div class="login_right_div">
		<img alt="" src="<%=cp%>/resources/img/login/banner20181012111630.jpg" onclick="javascript:location.href='<%=cp%>/book_info.action?isbn=9788901226736';" style="cursor: pointer;">
	</div>
</div>
</form>

<div>
	<div class="login_under_div">
		<img src="<%=cp%>/resources/img/login/login_service_tit.gif">
	</div>
	<div style="margin: 10px;">
		<img src="<%=cp%>/resources/img/login/login_service_02.gif">
		<img src="<%=cp%>/resources/img/login/login_service_03.gif">
		<img src="<%=cp%>/resources/img/login/login_service_04.gif">
	</div>
</div>

</div>


<jsp:include page="../common/footer.jsp" flush="false"/>

	<script src="<%=cp%>/resources/js/swiper_min.js"></script>
	<script src="<%=cp%>/resources/js/swiper.js"></script>

</body>
</html>