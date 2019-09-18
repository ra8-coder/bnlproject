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

</head>

<body style="margin: 0;padding: 0">

<!-- header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<!-- 전체 div -->
<div id="join_agree">

<div class="join_up_div">
	<div class="left_div">
		<img alt="회원가입" src="<%=cp%>/resources/img/login/tit_h1_member.gif">
	</div>
	<div class="right_div" style="float: right;">
		<img alt="" src="<%=cp%>/resources/img/login/img_member_join_info.gif">
	</div>
</div>

<!-- 약관 동의 폼 -->
<form action="" name="agreeForm" method="post">

<div class="agree_all_div">
	<div class="agree_title"><img alt="약관동의" src="<%=cp%>/resources/img/login/tit_h3_agree.gif"> </div>
	<div class="bts">
		<div class="checkbox">
			<div class="agree_main_box">
				<label><input type="checkbox" name="allCheck" class="checkAll"><b>전체동의</b></label>
			</div>
			<div>
				<div class="agree_sub_box">
					<div style="float: left;"><label><input type="checkbox" class="chk" name="agree">"이용 약관"에 동의 (필수)</label></div>
					<div style="float: right;"><input type="button" value="내용보기" onclick="showWindow('rules/rulesInfo',1100);" class="agree_more_btn"></div>
				</div>
				<div class="agree_sub_box">
					<div style="float: left;"><label><input type="checkbox" class="chk" name="agree">개인정보 "필수" 항목에 대한 수집과 이용 동의 (필수)</label></div>
					<div style="float: right;"><input type="button" value="내용보기" onclick="showWindow('rules/rules_privacy',700);" class="agree_more_btn"></div>
				</div>
				<div class="agree_additional_box">
					<div style="float: left;"><label><input type="checkbox" class="chk">개인정보 "선택" 항목에 대한 수집과 이용 동의 (선택)</label></div>
					<div style="float: right;"><input type="button" value="내용보기" onclick="showWindow('rules/rules_privacy2',700);" class="agree_more_btn"></div>
				</div>
				<div class="agree_last_box">
					<br/><b>선택 항목의 경우 동의하지 않아도 회원 가입이 가능하나, 구매 등 서비스 이용시 추가적인 정보 입력이 필요합니다.</b> <br/><br/><br/>
					<input type="button" value="다음" class="agree_ok_btn" onclick="next();">&nbsp;&nbsp;
					<input type="button" value="취소" class="agree_cancel_btn" onclick="javascipt:location.href='<%=cp%>/main.action';">
				</div>
			</div>
		</div>
	</div>
</div>

</form>

</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>