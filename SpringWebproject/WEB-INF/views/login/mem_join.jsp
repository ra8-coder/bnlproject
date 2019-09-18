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

	<link rel="stylesheet" href="<%=cp%>/resources/css/custom_bootstrap.css" type="text/css">
	<link rel="stylesheet" href="<%=cp%>/resources/css/main.css" type="text/css">
	<link rel="stylesheet" href="<%=cp%>/resources/css/join.css" type="text/css">
	
	<!-- bootstrap -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="<%=cp%>/resources/js/join.js"></script>
	
	<!-- 우편번호 -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<script type="text/javascript">
	
	$(document).ready(function(){
		
		//우편번호 검색 및 주소 가져오기
		$('#findZipcode').on('click',function(){
			
			new daum.Postcode({
		        oncomplete: function(data) {
		        	
		        	var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
	                
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;

	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }
		            
	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('zipCode').value = data.zonecode; //5자리 새우편번호 사용
	                document.getElementById('address1').value = fullAddr;

	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById('address2').focus();
	                
		        }
		    }).open();
							
		});
		
		
		$('#tel3').on('keyup',function(){
			
			if($('#tel3').val().length>3){
				
				var tel = $('#tel1').val() + "-" + $('#tel2').val() + "-" + $('#tel3').val();
				
				$(function(){
					
					var params = "phone=" + tel;
					
					$.ajax({
						url:"phoneOverlapCheck.action",
						type:"POST",
						data:params,
						dataType:"json",
						success:function(data){
							if(data==true){
								$('#phone_text').html("");
							}
							else{
								$('#phone_text').html("<span id='text_id' style='color: red;'>이미 등록된 휴대폰 번호입니다.</span>");
							}
						},
						error:function(){
							
						}
					});
					
				});
			}
			
			
		});
		
		
	});
	
	function selectEmail(){
		
		var f = document.joinForm;

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
<body style="margin: 0;padding: 0">

<!-- header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<!-- 전체 div -->
<div style="margin: 0 auto; width: 960px;">

<!-- 회원가입 -->
<div class="join_title_div">
	<div class="join_title_left">
		<img alt="회원가입" src="<%=cp%>/resources/img/login/tit_h1_member.gif">
	</div>
	<div class="join_title_right">
		<img alt="" src="<%=cp%>/resources/img/login/img_member_join_info.gif">
	</div>
</div>
<hr size="2" color="black">

<form name="joinForm" action="" method="POST">

<div class="joinTable">
	<span class="joinTable_sub_title">필수 정보 입력</span>
	<table>
		<tr>
			<th>아이디</th>
			<td>
				<div style="float: left;"><input type="text" style="width: 200px;" name="userId" id="userId" size="12" maxlength="12"></div>
				<div style="float: left; padding-left: 10px; line-height: 25px;"><span id="text_id">6~12자의 영문,숫자,-,_만 사용 가능</span></div>
				
			</td>
		</tr>
		<tr style="border-bottom: 1px solid #d5d5d5; border-top: 1px solid #d5d5d5; text-align: left; height: 45px;">
			<th>비밀번호</th>
			<td>
				<div style="float: left;"><input type="password" style="width: 200px;" name="userPwd1" id="userPwd1" size="15" maxlength="15"></div>	
				<div style="float: left; padding-left: 10px; line-height: 25px;"><span id="text_pwd1">10~15자의 영문/숫자 사용</span></div>	
			</td>
		</tr>
		<tr>
			<th>비밀번호확인</th>
			<td>
				<div style="float: left;"><input type="password" size="15" maxlength="15" style="width: 200px;" name="userPwd2" id="userPwd2"></div>
				<div style="float: left; padding-left: 10px; line-height: 25px;"><span id="text_pwd2"></span></div>
			</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>
				<div style="float: left;"><input type="text" name="userName" id="userName" onkeypress="onlyKorean();"></div>
				<div style="float: left; padding-left: 10px; line-height: 25px;"><span id="text_name">한글로 입력해주세요.</span></div>
			</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>
				<div style="float: left;">
					<input type="text" style="width: 50px;" size="4" maxlength="4" name="year" id="year" class="onlyNum_4">년&nbsp;
					<input type="text" style="width: 50px" size="2" maxlength="2" name="month" id="month" class="onlyNum_2">월&nbsp;
					<input type="text" style="width: 50px" size="2" maxlength="2" name="day" id="day" class="onlyNum_2">일
				</div>
				<div style="float: left; padding-left: 10px; line-height: 25px;"><span id="text_birth">예: 2000년 01월 01일</span></div>
				
			</td>
		</tr>
		<tr>
			<th>휴대폰 번호</th>
			<td>
				<input type="text" style="width: 50px;" size="4" maxlength="4" name="tel1" id="tel1" class="onlyNum_3">&nbsp;-
				<input type="text" style="width: 50px;" size="4" maxlength="4" name="tel2" id="tel2" class="onlyNum_4">&nbsp;-
				<input type="text" style="width: 50px" size="4" maxlength="4" name="tel3" id="tel3" class="onlyNum_4">
				<span id="phone_text"></span>
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
					아이디 찾기, 비밀번호 찾기 시 본인확인을 위해 정확히 입력해 주세요.
				</div>
			</td>
		</tr>
		<tr>
			<th>정보수신여부</th>
			<td>
				<div class="bts">
					<div class="checkbox">
						<label><input type="checkbox" name="emailCheck">&nbsp;이메일 수신동의</label>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="checkbox" name="smsCheck">&nbsp;SMS/MMS 수신동의</label>
					</div>
				</div>	
			</td>
		</tr>
	</table>
</div>

<br/><br/>

<div class="joinTable">
	<span class="joinTable_sub_title">선택 정보 입력 <font size="3" color="#4dafca">(입력하지 않아도 가입 가능)</font></span>
	<table>
		<tr>
			<th>닉네임</th>
			<td><input type="text" name="nickName" id="nickName"></td>
		</tr>
		<tr>
			<th>주소(배송지)</th>
			<td>
				<div style="padding-top: 10px; padding-bottom: 10px;">
					<input type="text" name="zipCode" id="zipCode">&nbsp;&nbsp;
					<input type="button" value="우편번호찾기" id="findZipcode" class="findZipcode" style="color: white; background-color: #886e45; border: none; height: 25px; font-size: 12px; width: 100px;"><br/>
					<div>
						<input type="text" name="address1" id="address1" style="width: 350px; margin-top: 3px;">&nbsp;&nbsp;
						<input type="text" name="address2" id="address2" style="width: 250px;">
					</div>		
				</div>
			</td>
		</tr>
		<tr>
			<th>추가연락처</th>
			<td>
				<input type="text" style="width: 50px;" size="4" maxlength="4" name="addTel1" id="addTel1" class="onlyNum_4">&nbsp;-
				<input type="text" style="width: 50px;" size="4" maxlength="4" name="addTel2" id="addTel2" class="onlyNum_4">&nbsp;-
				<input type="text" style="width: 50px" size="4" maxlength="4" name="addTel3" id="addTel3" class="onlyNum_3">	
			</td>
		</tr>
	</table>

</div>

<!-- hidden 정리 -->
<input type="hidden" name="userPwd" id="userPwd" value="">
<input type="hidden" name="birth" id="birth" value="">
<input type="hidden" name="phone" id="phone" value="">
<input type="hidden" name="email" id="email" value="">
<input type="hidden" name="emailReception" id="emailReception" value="">
<input type="hidden" name="smsReception" id="smsReception" value="">
<input type="hidden" name="addTel" id="addTel" value="">

<div style="text-align: center; margin-top: 20px; margin-bottom: 20px;">
	<input type="button" value="가입신청" class="join_ok_btn" onclick="joinConfirmation();">&nbsp;&nbsp;
	<input type="button" value="취소하기" class="join_cancel_btn" onclick="javascipt:location.href='<%=cp%>/main.action';">
</div>

</form>

</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>