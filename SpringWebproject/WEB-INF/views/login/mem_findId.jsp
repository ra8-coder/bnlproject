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

	<link rel="stylesheet" href="<%=cp%>/resources/css/join.css" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="<%=cp%>/resources/js/join.js"></script>
	
	<script type="text/javascript">
	function selectEmail(){
		
		var f = document.findIdForm;

		var cLength = f.email3.options.length;
		var cValue = f.email3.selectedIndex;

		f.email2.value = "";

		if(cValue==(cLength-6)){
			f.email2.readOnly = false;
			f.email2.focus();
		}
		else{
			f.email2.value = f.email3.options[cValue].value;
			f.email2.readOnly = true;
		}
	}
	
	
	</script>
	
</head>
<body style="padding: 0;margin: 0">


<!-- 아이디찾기 -->

<div>
	<div style="background-color: #947558; padding: 10px;">
		<font color="white" size="5"><b>아이디 찾기</b></font>
		<span style="float: right;"><img alt="" src="<%=cp%>/resources/img/login/popTitle_close.jpg" onclick="window.close();" style="cursor: pointer;"></span>
	</div>
	
	<div style="margin: 10px; padding-left: 0px;" class="find_id">
		<ul>
			<li>가입 시의 이름, 생년월일, 휴대폰 번호, 이메일을 입력 해 주십시오.</li>
			<li>위 방법으로 찾기 힘드신 경우 1:1상담을 이용 하시면 빠르게 답변 드리겠습니다. <b><a href="#">1:1상담하기</a></b></li>
		</ul>
	</div>
	
	<form action="" name="findIdForm" id="findIdForm" method="post">
	<div class="findIdTable" id="findIdTable">
		<table>
			<tr>
				<th>이름</th>
				<td>
					<div style="float: left;"><input type="text" name="userName"></div>
					<div style="float: left; padding-left: 10px;">가입 시 등록된 실명</div>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>
					<input type="text" style="width: 50px;" size="4" maxlength="4" name="year" id="year" class="onlyNum_4">년&nbsp;
					<input type="text" style="width: 50px" size="2" maxlength="2" name="month" id="month" class="onlyNum_2">월&nbsp;
					<input type="text" style="width: 50px" size="2" maxlength="2" name="day" id="day" class="onlyNum_2">일
				</td>
			</tr>
			<tr>
				<th>휴대폰 번호</th>
				<td>
					<div style="float: left;">
						<input type="text" style="width: 50px;" size="4" maxlength="4" name="tel1" id="tel1" class="onlyNum_4">&nbsp;-
						<input type="text" style="width: 50px;" size="4" maxlength="4" name="tel2" id="tel2" class="onlyNum_4">&nbsp;-
						<input type="text" style="width: 50px" size="4" maxlength="4" name="tel3" id="tel3" class="onlyNum_4">
					</div>
					<div style="float: left; padding-left: 10px;">가입 시 등록된 번호</div>				
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div style="padding-top: 10px; padding-bottom: 10px;">
						<input type="text" name="email1" id="email1">&nbsp;@
						<input type="text" name="email2" id="email2">
						<select name="email3" onchange="selectEmail();" class="joinTable_select">
							<option value="">직접입력</option>
							<option value="naver.com">네이버</option>
							<option value="gmail.com">구글(G메일)</option>
							<option value="hanmail.net">다음</option>
							<option value="nate.com">네이트</option>
							<option value="yahoo.com">야후</option>
						</select>
						<br/>
						가입 시 등록된 메일
					</div>
				</td>
			</tr>
		</table>

		<div style="text-align: center; margin-top: 20px;">
			<!-- hidden -->
			<input type="hidden" name="birth" id="birth" value="">
			<input type="hidden" name="phone" id="phone" value="">
			<input type="hidden" name="email" id="email" value="">
		
			<input type="button" value="확인" class="find_id_okBtn" id="find_id_okBtn">&nbsp;&nbsp;
			<input type="reset" value="다시입력" class="find_id_cancelBtn" onclick="document.findIdForm.userName.focus();">
		</div>
	</div>
	
	</form>
</div>

</body>
</html>