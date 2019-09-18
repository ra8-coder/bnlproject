<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	String mode = request.getParameter("mode");
	
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
	
	$('document').ready(function(){
		
		//엔터 치면 다음단계로
		$('#pre_myinfo_pwd').keypress(function(evt){
			if(evt.keyCode==13){
				checkPwd('${mode }');
			}
		});

	});
	
	
	//회원정보수정 - 비밀번호 재확인
	function checkPwd(mode){
		
		var f = document.checkPwdForm;
		
		var pwd = f.userPwd.value;
		pwd = pwd.trim();
		if(!pwd) {
			alert("\n비밀번호를 입력하세요. ");
			f.userPwd.focus();
			return;
		}
		f.userPwd.value = pwd;
		
		f.action = "<%=cp%>/myShopping/pre_updateMyInfo_ok.action?mode=" + mode;
		
		f.submit();
	}
	
	</script>
	
	
</head>
<body style="padding: 0; margin: 0;">

<!-- header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<!-- 전체 div -->
<div style="margin: 0 auto; width: 960px;">

<div style="margin-top: 12px;">
	<a href="<%=cp %>/main.action">홈</a> > <a href="<%=cp %>/myShoppingMain.action">나의쇼핑</a> > 회원정보 > <b>회원정보수정</b>
</div>
<!-- navigation -->
<jsp:include page="./topNavi.jsp" flush="false"/>
<jsp:include page="./sideNavi.jsp" flush="false"/>

<div class="contents">
	<div style="border-bottom: 1px solid #e1e1e1; font-size: 13pt; font-weight: bold; padding-bottom: 10px;">회원정보수정</div>
	
	<div class="pre_myinfo_div">
		<c:if test="${mode=='update' }">
			고객님의 정보를 안전하게 보호하기 위해 회원정보 수정 전 <b>비밀번호</b>를 입력해주시기 바랍니다.<br/><br/>
		</c:if>
		<c:if test="${mode=='out' }">
			고객님의 정보를 안전하게 보호하기 위해 회원탈퇴 전 <b>비밀번호</b>를 입력해주시기 바랍니다.<br/><br/>
		</c:if>
		
		<span class="pre_myinfo_msg">${pwdErrMessage }</span>
		<form action="" name="checkPwdForm" method="post">
			<div class="pre_myinfo_form">
				<dl class="pre_myinfo_dl">
					<dt>아이디</dt>
					<dd>${userInfo.userId }</dd>
					<dt>비밀번호</dt>
					<dd>
						<input type="password" name="userPwd" id="pre_myinfo_pwd">
					</dd>
				</dl>
			</div>
			<input type="hidden" name="mode" value="${mode }">
			<input type="button" value="다음페이지로" class="pre_myinfo_next_btn" onclick="checkPwd('${mode }');">
		</form>
	</div>
</div>

</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>