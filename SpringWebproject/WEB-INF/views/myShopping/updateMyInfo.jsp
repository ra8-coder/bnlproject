<%@page import="com.spring.webproject.dto.UserDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	UserDTO dto = new UserDTO();
	dto = (UserDTO) session.getAttribute("userInfo");
	String emailReception = dto.getEmailReception();
	String smsReception = dto.getSmsReception();
	
%>
<!DOCTYPE html>
<html>
<head>
<title>반디앤루니스 인터넷서점</title>

	<link rel="stylesheet" href="<%=cp%>/resources/css/main.css" type="text/css">
	<link rel="stylesheet" href="<%=cp%>/resources/css/myShopping.css" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	<!-- 우편번호 -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<script type="text/javascript">
	
	$(document).ready(function(){
		
		//이메일 수신 동의 라디오버튼 checked 옵션 설정
		if('<%=emailReception%>'=='Y'){
			$('input:radio[name="emailCheck"][value="Y"]').attr("checked", "checked");
			$('#emailReception').val('Y');
		}
		else{
			$('input:radio[name="emailCheck"][value="N"]').attr("checked", "checked");
			$('#emailReception').val('N');
		}
		
		//sms 수신 동의 라디오버튼 checked 옵션 설정
		if('<%=smsReception%>'=='Y'){
			$('input:radio[name="smsCheck"][value="Y"]').attr("checked", "checked");
			$('#smsReception').val('Y');
		}
		else{
			$('input:radio[name="smsCheck"][value="N"]').attr("checked", "checked");
			$('#smsReception').val('N');
		}
		
		$('.emailCheck').on('change',function(){
			var emailRadio = $('input:radio[name="emailCheck"]:checked').val();
			$('#emailReception').val(emailRadio);
		});
		
		$('.smsCheck').on('change',function(){
			var smsRadio = $('input:radio[name="smsCheck"]:checked').val();
			$('#smsReception').val(smsRadio);
		});	
		
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
	});
	
	function selectEmail(){
		
		var f = document.myInfoUpdateForm;

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
	<div class="myInfo_update_div">
		<div style="margin-top: 20px;">
			<b>회원정보</b>는 상품 주문 및 배송에 꼭 필요한 사항들이므로 정확하게 기재해 주시기 바랍니다.
		</div>
		
		<form action="" name="myInfoUpdateForm" method="post">
		
		<div class="myInfo_update_table">
			<table>
				<tr>
					<th>이름</th>
					<td>${userInfo.userName }</td>
					<th>생년월일</th>
					<td>${userInfo.birth }</td>
				</tr>
				<tr>
					<th>회원아이디</th>
					<td>${userInfo.userId }</td>
					<th>닉네임</th>	
					<td>
						<c:if test="${empty userInfo.nickName }"><input type="text" name="nickName" value="${userInfo.userId }"></c:if>
						<c:if test="${!empty userInfo.nickName }"><input type="text" name="nickName" value="${userInfo.nickName }"></c:if>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td colspan="3"><input type="button" value="비밀번호변경" class="changePwdBtn" onclick="showWindow('myShopping/updatePwd',400)" style="height: 25px; font-size: 9pt;"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3">
						<div style="padding-top: 10px; padding-bottom: 10px;">
							<input type="text" name="zipCode" id="zipCode" value="${userInfo.zipCode }">&nbsp;&nbsp;
							<input type="button" value="우편번호찾기" id="findZipcode" class="findZipcode" style="color: white; background-color: #937354; border: none; height: 25px; font-size: 12px; width: 100px; cursor: pointer;"><br/>
							<div>
								<input type="text" name="address1" id="address1" style="width: 350px; margin-top: 3px;" value="${userInfo.address1 }">&nbsp;&nbsp;
								<input type="text" name="address2" id="address2" style="width: 250px;" value="${userInfo.address2 }">
							</div>		
						</div>
					</td>
				</tr>
				<tr>
					<th>이메일(필수)</th>
					<td colspan="3">
						<c:set var="index">${fn:indexOf(userInfo.email,"@") }</c:set>
						<c:set var="lastIndex">${fn:length(userInfo.email)}</c:set>
						<div style="padding-top: 10px; padding-bottom: 10px;">
							<input type="text" name="email1" id="email1" value="${fn:substring(userInfo.email,0,index) }">&nbsp;@
							<input type="text" name="email2" id="email2" value="${fn:substring(userInfo.email,index+1,lastIndex) }">
							<select name="email3" onchange="selectEmail();" class="myInfo_select">
								<option value="">직접입력</option>
								<option value="naver.com">네이버</option>
								<option value="gmail.com">구글(G메일)</option>
								<option value="hanmail.net">다음</option>
								<option value="nate.com">네이트</option>
								<option value="yahoo.com">야후</option>
							</select>
						<br/>
						이메일 수신에 동의하시겠습니까?
						<input type="radio" name="emailCheck" value="Y" class="emailCheck">예
						<input type="radio" name="emailCheck" value="N" class="emailCheck">아니오
						</div>
					</td>
				</tr>
				<tr>
					<th>휴대폰(필수)</th>
					<td colspan="3">
						<c:set var="splitPhone" value="${fn:split(userInfo.phone,'-')}"/>
						<c:forEach var="num" items="${splitPhone }" varStatus="i">
							<c:if test="${i.count==1 }"><c:set var="tel1" value="${num }"/></c:if>
							<c:if test="${i.count==2 }"><c:set var="tel2" value="${num }"/></c:if>
							<c:if test="${i.count==3 }"><c:set var="tel3" value="${num }"/></c:if>
						</c:forEach>	
						<div>
							<input type="text" style="width: 50px;" size="4" maxlength="4" name="tel1" id="tel1" class="onlyNum_4" value="${tel1 }">&nbsp;-
							<input type="text" style="width: 50px;" size="4" maxlength="4" name="tel2" id="tel2" class="onlyNum_4" value="${tel2 }">&nbsp;-
							<input type="text" style="width: 50px" size="4" maxlength="4" name="tel3" id="tel3" class="onlyNum_3" value="${tel3 }"><br/>
							SMS수신에 동의하시겠습니까? 
							<input type="radio" name="smsCheck" class="smsCheck" value="Y">예
							<input type="radio" name="smsCheck" class="smsCheck" value="N">아니오
						</div>
					</td>
				</tr>
				<tr>
					<th>추가연락처</th>
					<td colspan="3">
						<div style="padding-top: 10px; padding-bottom: 10px;">
							<c:set var="splitAddTel" value="${fn:split(userInfo.addTel,'-')}"/>
							<c:forEach var="num2" items="${splitAddTel }" varStatus="j">
								<c:if test="${j.count==1 }"><c:set var="addTel1" value="${num2 }"/></c:if>
								<c:if test="${j.count==2 }"><c:set var="addTel2" value="${num2 }"/></c:if>
								<c:if test="${j.count==3 }"><c:set var="addTel3" value="${num2 }"/></c:if>
							</c:forEach>
							
							<input type="text" style="width: 50px;" size="4" maxlength="4" name="addTel1" id="addTel1" class="onlyNum_4" value="${addTel1 }">&nbsp;-
							<input type="text" style="width: 50px;" size="4" maxlength="4" name="addTel2" id="addTel2" class="onlyNum_4" value="${addTel2 }">&nbsp;-
							<input type="text" style="width: 50px" size="4" maxlength="4" name="addTel3" id="addTel3" class="onlyNum_3" value="${addTel3 }">	
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div style="text-align: center; margin-top: 20px;">
		<!-- hidden -->
		<input type="hidden" name="userId" value="${userInfo.userId }">
		<input type="hidden" name="email" value="">
		<input type="hidden" name="phone" value="">
		<input type="hidden" name="addTel" value="">
		<input type="hidden" name="emailReception" id="emailReception" value="">
		<input type="hidden" name="smsReception" id="smsReception" value="">
		
		<input type="button" value="저장" class="myInfo_update_ok" onclick="updateUserInfo();">
		<input type="button" value="취소" class="myInfo_update_cancel"  onclick="javascript:location.href='<%=cp %>/myShoppingMain.action';">
		</div>
		</form>
	
	</div>

</div>

</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

<script src="<%=cp%>/resources/js/myShopping.js"></script>
	
</body>
</html>