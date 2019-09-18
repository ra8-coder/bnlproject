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

	<link rel="stylesheet" href="<%=cp%>/resources/css/myShopping.css" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="<%=cp%>/resources/js/myShopping.js"></script>
	<script type="text/javascript">
	
	//새 비밀번호1 유효성 검사
	$(document).ready(function(){
		
	$('#newPwd1').on('keyup',function(){

		$(this).val( $(this).val().replace( /[^a-zA-Z0-9]/g, '' ) );

		var temp_pwd = document.getElementById('newPwd1').value;

		if(temp_pwd.length!=0){
			if(temp_pwd.length<10){
				$('#text_pwd1').html("<span id='text_pwd1'>공백없는 10~15자의 영문/숫자 조합</span>");
			}
			else if(temp_pwd.length>15){
				$('#text_pwd1').html("<span id='text_pwd1'>공백없는 10~15자의 영문/숫자 조합</span>");
			}
			else {
				$('#text_pwd1').html("<span id='text_pwd1' style='color: #886e45;'>이용 가능한 비밀번호입니다</span>");
			}
		}
		else {
			$('#text_pwd1').html("<span id='text_pwd1'>공백없는 10~15자의 영문/숫자 조합</span>");
		}

	});
	
	//새 비밀번호2 유효성 검사
	$('#newPwd2').on('keyup',function(){

		$(this).val( $(this).val().replace( /[^a-zA-Z0-9]/g, '' ) );

		var temp_pwd = document.getElementById('newPwd2').value;
		var pwd = document.getElementById('newPwd1').value;
		
		if(temp_pwd.length<1){
			if(temp_pwd.length==0){
				$('#text_pwd2').html("<span id='text_pwd2' style='color: black;'></span>");
			}
			else{
				$('#text_pwd2').html("<span id='text_pwd2' style='color: black;'>비밀번호가 일치하지 않습니다.</span>");
			}
		}
		else{
			if(pwd==temp_pwd){
				$('#text_pwd2').text('');
				document.getElementById('userPwd').value = pwd;
			}
			else{
				$('#text_pwd2').html("<span id='text_pwd2' style='color: #ea5759;'>비밀번호가 일치하지 않습니다.</span>");
			}	
		}
		
	});
	});
	</script>
	
</head>
<body style="padding: 0;margin: 0;">

<div>
	<div style="background-color: #947558; padding: 10px;">
		<font color="white" size="5"><b>비밀번호 변경</b></font>
		<span style="float: right;"><img alt="" src="<%=cp%>/resources/img/login/popTitle_close.jpg" onclick="window.close();" style="cursor: pointer;"></span>
	</div>
	
	<div class="update_pwd_sub">
		비밀번호는 띄어쓰기 없는 10~15자의 영문/숫자 조합으로<br/> 사용하실 수 있으며, 대소문자를 구분합니다.
	</div>
	
	<form action="" name="updatePwdForm" id="updatePwdForm" method="post">
	<div class="updatePwdTable" id="updatePwdTable">
		<table>
			<tr>
				<th>기존(임시)비밀번호</th>
				<td>
					<input type="password" name="userPwd" size="15" maxlength="15">
				</td>
			</tr>
			<tr>
				<th>새 비밀번호</th>
				<td>
					<input type="password" name="newPwd1" id="newPwd1" size="15" maxlength="15"><br/>
					<span id="text_pwd1">공백없는 10~15자의 영문/숫자 조합</span>
				</td>
			</tr>
			<tr>
				<th>새 비밀번호 확인</th>
				<td>
					<input type="password" name="newPwd2" id="newPwd2" size="15" maxlength="15"><br/>
					<span id="text_pwd2">비밀번호를 한번 더 입력해주세요</span>	
				</td>
			</tr>
		</table>

		<div style="text-align: center; margin-top: 20px;">		
			<input type="button" value="확인" class="update_pwd_ok" onclick="updatePwd();">&nbsp;&nbsp;
			<input type="reset" value="취소" class="update_pwd_cancel" onclick="window.close();">
		</div>
	</div>
	
	</form>
</div>


</body>
</html>