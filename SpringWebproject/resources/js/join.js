$(document).ready(function(){
	
	
	$('#login_pwd').keypress(function(evt){
		if(evt.keyCode==13){
			login();
		}
	});
	
	
	//약관동의 전체클릭 이벤트
	$('.checkAll').click( function() {
		$('.chk').prop('checked', this.checked);
	});
	
	//아이디 유효성 검사
	$('#userId').on('keyup',function(){

		$(this).val( $(this).val().replace( /[^a-zA-Z0-9-_]/g, '' ) );

		var temp_id = document.getElementById('userId').value;

		if(temp_id.length>0){
			if(temp_id.length<6){
				$('#text_id').html("<span id='text_id' style='color: black;'>6~12자의 영문,숫자,-,_만 사용 가능</span>");
			}
			else if(temp_id.length>12) {
				$('#text_id').html("<span id='text_id' style='color: black;'>6~12자의 영문,숫자,-,_만 사용 가능</span>");
			}
			else{
				//Id 중복체크
				$(function(){
					var params = "userId=" + $('#userId').val();
		
					$.ajax({
						url:"idOverlapCheck.action",
						type:"POST",
						data:params,
						dataType:"json",
						success:function(data){
							if(data==true){
								$('#text_id').html("<span id='text_id' style='color: #886e45;'>사용 가능한 아이디입니다</span>");
							}
							else{
								$('#text_id').html("<span id='text_id' style='color: red;'>중복된 아이디입니다</span>");
							}
						},
						error:function(){
							
						}
					});

				});
			}
		}
		else{
			$('#text_id').html("<span id='text_id' style='color: black;'>6~12자의 영문,숫자,-,_만 사용 가능</span>");
		}
	});

	//패스워드1 유효성 검사
	$('#userPwd1').on('keyup',function(){

		$(this).val( $(this).val().replace( /[^a-zA-Z0-9]/g, '' ) );

		var temp_pwd = document.getElementById('userPwd1').value;

		if(temp_pwd.length!=0){
			if(temp_pwd.length<10){
				$('#text_pwd1').html("<span id='text_pwd1'>10~15자의 영문/숫자 사용</span>");
			}
			else if(temp_pwd.length>15){
				$('#text_pwd1').html("<span id='text_pwd1'>10~15자의 영문/숫자 사용</span>");
			}
			else {
				$('#text_pwd1').html("<span id='text_pwd1' style='color: #886e45;'>이용 가능한 비밀번호입니다</span>");
			}
		}
		else {
			$('#text_pwd1').html("<span id='text_pwd1'>10~15자의 영문/숫자 사용</span>");
		}

	});

	//패스워드2 유효성 검사
	$('#userPwd2').on('keyup',function(){

		$(this).val( $(this).val().replace( /[^a-zA-Z0-9]/g, '' ) );

		var temp_pwd = document.getElementById('userPwd2').value;
		var pwd = document.getElementById('userPwd1').value;

		if(pwd==temp_pwd){
			$('#text_pwd2').text('');
			document.getElementById('userPwd').value = pwd;
		}
		else{
			$('#text_pwd2').text('비밀번호가 일치하지 않습니다.');
		}

	});
	
	//숫자만 입력할 수 있도록
	$('.onlyNum_2').on('keyup',function(){
		$(this).val( $(this).val().replace( /[^0-9]/g, '' ) );
	});

	$('.onlyNum_3').on('keyup',function(){
		$(this).val( $(this).val().replace( /[^0-9]/g, '' ) );
	});

	$('.onlyNum_4').on('keyup',function(){
		$(this).val( $(this).val().replace( /[^0-9]/g, '' ) );
	});
	
	//이메일 입력 유효성 검사
	
	$('#email1').on('keyup',function(){
		$(this).val( $(this).val().replace( /[^a-zA-Z0-9-_]/g, '' ) );
	});
	
	$('#email2').on('keyup',function(){
		$(this).val( $(this).val().replace( /[^a-zA-Z0-9-_.]/g, '' ) );
	});

	//아이디저장 - 쿠키 설정
	var userInputId = getCookie("userInputId");	//쿠키 가져옴

	$("input[name='user_id']").val(userInputId);  //쿠키에 저장되어 있는 아이디를 input에 입력

	if($("input[name='user_id']").val() != ""){	//input이 빈칸이 아니면 체크박스 체크하도록
		$("#idSave").attr("checked", true);
	}
	
	//아이디 찾기
	$('#find_id_okBtn').on('click', function(){
		
		var flag = false;
		
		flag = hiddenValue();
		
		if(flag==false){
			return;
		}
		else{
			var params = $('#findIdForm').serialize();

			$.ajax({
				type:"POST",
				url:"mem_findId_ok.action",
				data: params,
				success:function(data){
					if(!data){
						var html = "입력하신 이름, 생년월일, 휴대폰 번호, 이메일이 일치하는 <br/>회원정보를 찾을 수 없습니다.<br/>";
						html += "가입시 등록하신 정보를 확인 하신 후 다시 입력해 주시기 바랍니다.<br/><br/><br/>";
						html += "<a href='/webproject/mem_findId_ok.action' class='find_pwd_back'>아이디 찾기</a>";
						
						$('#findIdTable').css({margin:'0 auto', width:'450px', border:'5px solid #f8f8f8',padding: '30px',}).css('text-align','center').css('font-size','10pt').css('margin-top','30px');
						$('#findIdTable').html(html);
					
					}
					else{
						var html = "회원님의 아이디는 아래와 같습니다.<br/>";
						html += "로그인 하시면 반디앤루니스의 다양한 혜택을 받으실 수 있습니다.<br/>";
						html += "<span class='finded_id'>";
						html += data;
						html += "</span>";
						html += "<input type='button' value='로그인' class='find_id_to_login' onclick='findIdToLogin();'>";
						
						$('#findIdTable').css({margin:'0 auto', width:'450px', border:'5px solid #f8f8f8',padding: '30px',}).css('text-align','center').css('font-size','10pt').css('margin-top','30px');
						$('#findIdTable').html(html);
					}
				},
				error:function(){
					alert("실패!");
				}
			});
		}
	});
	
	//패스워드 찾기
	$('#find_pwd_okBtn').on('click', function(){
		
		var flag = false;
		
		flag = hiddenValuePwd();
		
		if(flag==false){
			return;
		}
		else{
			var params = $('#findPwdForm').serialize();
			
			$.ajax({
				type:"POST",
				url:"mem_findPwd_ok.action",
				data: params,
				success:function(data){
					if(!data){
						var html = "입력하신 아이디, 이름, 생년월일, 휴대폰 번호, 이메일 중 일치하지 않는 회원정보가 있습니다.<br/>";
						html += "아이디, 이름, 생년월일, 휴대폰 번호를 확인하신 후 다시 입력해주시기 바랍니다.<br/><br/><br/>";
						html += "<a href='/webproject/mem_findPwd.action' class='find_pwd_back'>비밀번호 찾기</a>";
						
						$('#findPwdTable').css({margin:'0 auto', width:'600px', border:'5px solid #f8f8f8',padding: '15px'}).css('text-align','center').css('font-size','10pt').css('margin-top','30px').css('text-decoration','none');
						$('#findPwdTable').html(html);
					}
					else{
						var html = "회원님의 임시 비밀번호는 아래와 같습니다.<br/>";
						html += "임시 비밀번호를 확인하시어, 로그인해주시기 바랍니다.<br/>";
						html += "만약 임시 비밀번호로 로그인이 되지 않는 경우에는, 고객센터로 문의해주시기 바랍니다.<br/>";
						html += "<span class='finded_id'>";
						html += data;
						html += "</span>";
						html += "<input type='button' value='로그인' class='find_id_to_login' onclick='findIdToLogin();'>";
						
						$('#findPwdTable').css({margin:'0 auto', width:'450px', border:'5px solid #f8f8f8',padding: '30px',}).css('text-align','center').css('font-size','10pt').css('margin-top','30px');
						$('#findPwdTable').html(html);
					}
				},
				error:function(){
					alert("실패!");
				}	
			});
		}
	});
	
	$('#find_id_back').on('click', function(){
		$(location).attr('href','webproject/mem_findId.action');
	});
	
	$('#find_pwd_back').on('click', function(){
		$(location).attr('href','webproject/mem_findPwd.action');
	});

});//ready끝

//약관동의 다음 버튼 클릭시
function next(){
	
	for(var i=0; i<agreeForm.agree.length; i++){ 
		
		if(!agreeForm.agree[i].checked){ 
	         alert("필수 약관에 동의해주십시오."); 
	         agreeForm.agree[i].focus(); 
	         return false; 
	    }
	}
	
	agreeForm.action = "/webproject/login/mem_join.action";
	agreeForm.submit();
}

//약관 팝업 + 아이디 찾기 + 비밀번호 찾기 팝업
function showWindow(addr,width) {
	
	var url = "/webproject/" + addr + ".action";

	var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top=90,left=250,height=650,' + 'width=' + width;
	
	window.open(url,"반디앤루니스 인터넷서점",setting);

} 

//로그인 버튼 클릭시 
function login() {

	var f = document.loginForm;

	var id = f.user_id.value;
	id = id.trim();
	if(!id) {
		alert("\n아이디를 입력하세요. ");
		f.user_id.focus();
		return;
	}
	f.user_id.value = id;

	var pwd = f.userPwd.value;
	pwd = pwd.trim();
	if(!pwd) {
		alert("\n비밀번호를 입력하세요. ");
		f.userPwd.focus();
		return;
	}
	f.userPwd.value = pwd;

	if(f.idSave.checked){
		setCookie('userInputId',id,30);
	}
	else{
		deleteCookie('userInputId');
	}
	
	//최근 본 상품 쿠키 챙기기
	var ck = bookCookieInfo(getBookCookie('rcbook'));
	
	//isbn만 array에 옮겨 담음
	var cookieArray = new Array();
	
	if(ck!=null){
		
		for(var i=0;i<ck.length;i++){
			cookieArray.push(ck[i].isbn);
		}
		
		$.ajax ({
			url:"recentCookie.action",
			data:{cookieArray:cookieArray},
			type:"POST",
			success:function(){
				f.action = "login_ok.action";
				f.submit();
			},
			error:function(e){
				alert(e.responseText);
			}
			
		});
	}
	else{
		f.action = "login_ok.action";
		f.submit();
	}
}

//최근 본 상품 쿠키 가져오기
function getBookCookie(cookiename){
	var cookiestring  = document.cookie;
	var cookiearray = cookiestring.split(';');
	
	for(var i=0; i<cookiearray.length; ++i){ 	
	    if(cookiearray[i].indexOf(cookiename)!=-1){
	        var nameVal = cookiearray[i].split("=");
	        nameVal = nameVal[1].trim();
	        return unescape(nameVal);
	    }else{
	    	var cookie = null;
	    }
	}
	
	return cookie;
}

//최근 본 상품 쿠키 split
function bookCookieInfo(cValue) {		
		var cookie = cValue;
		
		if(cookie!=null){
			cookie = cookie.split("/");
	 		var ck = new Array();
	 		
	 		for(i=0;i<cookie.length;i++){
	 			ck[i] = JSON.parse(cookie[i]);
	 		} 		
	 		return ck;
		}else{
			return null;
		}
}

//한글만 입력하도록
function onlyKorean(){
	
	if((event.keyCode<48)||(event.keyCode>57)){
		event.returnValue = false;
	}
	if((event.keyCode>=48)||(event.keyCode<=57)){
		event.returnValue = false;
	}
	
}


//이메일 select 값 input text에 전달하기
function emailInput(formName) {

	var f = "document." + formName;

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

//아이디저장 쿠키 저장
//userInputId=user_id;expires=date;
function setCookie(cookieName, value, exdays){

	var exdate = new Date();
	exdate.setDate(exdate.getDate() + exdays);	//현재날짜 +30일

	var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());

	document.cookie = cookieName + "=" + cookieValue;
}

//아이디저장 쿠키 삭제
function deleteCookie(cookieName){

	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);

	document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

//쿠키 가져오기
//userInputId=user_id;expires=date;
function getCookie(cookieName) {

	cookieName = cookieName + '=';

	var cookieData = document.cookie;	//쿠키 불러오기
	var start = cookieData.indexOf(cookieName);	//쿠키에서 찾아올 값의 index를 가져옴
	var cookieValue = '';	//불러올 값을 저장할 변수 초기화

	if(start != -1){	//쿠키에서 해당하는 cookieName을 찾아냈다면 (즉, 저장된 쿠키가 있다면)
		start += cookieName.length;	//value만을 꺼내기 위해 start의 위치를 앞에서 찾아낸 index에 cookieName의 길이를 더함
		var end = cookieData.indexOf(';', start);	//start부터 ';'가 나오는 곳(value의 끝)을 찾아냄

		if(end == -1){
			end = cookieData.length;
		}

		cookieValue = cookieData.substring(start, end);	//substring으로 value를 찾아냄
	}

	return unescape(cookieValue);
}

//회원가입 : 가입신청
function joinConfirmation(){

	var f = document.joinForm;

	var id = f.userId.value;
	id = id.trim();
	if(!id) {
		alert("\n아이디를 입력하세요. ");
		f.userId.focus();
		return;
	}
	else{
		f.userId.value = id;

		var idSpan = $('#text_id').text();
		var pass = '사용 가능한 아이디입니다';
		if(idSpan!=pass){
			alert("\n아이디를 확인하세요.");
			f.userId.focus();
			return;
		}
	}

	var pwd = f.userPwd1.value;
	pwd = pwd.trim();
	if(!pwd) {
		alert("\n비밀번호를 입력하세요.");
		f.userPwd1.focus();
		return;
	}
	else{
		f.userPwd1.value = pwd;

		var pwdSpan = $('#text_pwd1').text();
		error = '10~15자의 영문/숫자 사용';
		if(pwdSpan==error){
			alert("\n비밀번호를 확인하세요.");
			return;
		}
	}

	pwd = f.userPwd2.value;
	pwd = pwd.trim();
	if(!pwd) {
		alert("\n비밀번호를 한번 더 입력하세요.");
		f.userPwd2.focus();
		return;
	}
	else{
		f.userPwd2.value = pwd;

		var pwd2Span = $('#text_pwd2').text();
		error = '비밀번호가 일치하지 않습니다.';
		if(pwd2Span==error){
			alert("\n비밀번호를 정확히 입력하세요.");
			f.userPwd2.focus();
			return;
		}
	}
	
	var userName = f.userName.value;
	userName = userName.trim();
	if(!userName) {
		alert("\n이름을 입력하세요.");
		f.userName.focus();
		return;
	}
	f.userName.value = userName;

	var birth = f.year.value;
	birth = birth.trim();
	if(!birth) {
		alert("\n생년월일을 입력하세요.");
		f.year.focus();
		return;
	}
	f.year.value = birth;

	birth = f.month.value;
	birth = birth.trim();
	if(!birth) {
		alert("\n생년월일을 입력하세요.");
		f.month.focus();
		return;
	}
	f.month.value = birth;

	birth = f.day.value;
	birth = birth.trim();
	if(!birth) {
		alert("\n생년월일을 입력하세요.");
		f.day.focus();
		return;
	}
	f.day.value = birth;

	var validDate = isValidDate(f.year.value, f.month.value, f.day.value);
	if(validDate==false){
		alert("\n생년월일을 정확히 입력하세요.");
		f.month.focus();
		return;
	}

	var tel = f.tel1.value;
	tel = tel.trim();
	if(!tel) {
		alert("\n휴대폰 번호를 입력하세요.");
		f.tel1.focus();
		return;
	}
	f.tel1.value = tel;

	tel = f.tel2.value;
	tel = tel.trim();
	if(!tel) {
		alert("\n휴대폰 번호를 입력하세요.");
		f.tel2.focus();
		return;
	}
	f.tel2.value = tel;

	tel = f.tel3.value;
	tel = tel.trim();
	if(!tel) {
		alert("\n휴대폰 번호를 입력하세요.");
		f.tel3.focus();
		return;
	}
	f.tel3.value = tel;

	var email = f.email1.value;
	email = email.trim();
	if(!email) {
		alert("\n이메일을 입력하세요.");
		f.email1.focus();
		return;
	}
	f.email1.value = email;

	email = f.email2.value;
	email = email.trim();
	if(!email) {
		alert("\n이메일을 입력하세요.");
		f.email2.focus();
		return;
	}
	f.email2.value = email;

	var zipCode = f.zipCode.value;
	zipCode = zipCode.trim();
	if(zipCode){
		if(!f.address1.value){
			alert("\n주소(배송지)를 정확히 입력해 주세요.");
			f.address1.focus();
			return;
		}
		if(!f.address2.value){
			alert("\n주소(배송지)를 정확히 입력해 주세요.");
			f.address2.focus();
			return;
		}
	}
	if(f.address1.value){
		if(!f.zipCode.value){
			alert("\n주소(배송지)를 정확히 입력해 주세요.");
			f.zipCode.focus();
			return;
		}
		if(!f.address2.value){
			alert("\n주소(배송지)를 정확히 입력해 주세요.");
			f.address2.focus();
			return;
		}
	}
	if(f.address2.value){
		if(!f.zipCode.value){
			alert("\n주소(배송지)를 정확히 입력해 주세요.");
			f.zipCode.focus();
			return;
		}
		if(!f.address1.value){
			alert("\n주소(배송지)를 정확히 입력해 주세요.");
			f.address1.focus();
			return;
		}
	}

	tel = f.addTel1.value;
	if(tel){
		if(!f.addTel2.value){
			alert("\n추가연락처를 정확히 입력해 주세요.");
			f.addTel2.focus();
			return;
		}
		else if(!f.addTel3.value){
			alert("\n추가연락처를 정확히 입력해 주세요.");
			f.addTEl3.focus();
			return;
		}
		
		tel = f.addTel1.value + '-' + f.addTel2.value + '-' + f.addTel3.value;
		f.addTel.value = tel;
	}
	if(f.addTel2.value){
		
		if(!f.addTel1.value){
			alert("\n추가연락처를 정확히 입력해 주세요.");
			f.addTel1.focus();
			return;
		}
		else if(!f.addTel3.value){
			alert("\n추가연락처를 정확히 입력해 주세요.");
			f.addTEl3.focus();
			return;
		}
		
		tel = f.addTel1.value + '-' + f.addTel2.value + '-' + f.addTel3.value;
		f.addTel.value = tel;
	}
	if(f.addTel3.value){
		if(!f.addTel1.value){
			alert("\n추가연락처를 정확히 입력해 주세요.");
			f.addTel1.focus();
			return;
		}
		else if(!f.addTel2.value){
			alert("\n추가연락처를 정확히 입력해 주세요.");
			f.addTEl2.focus();
			return;
		}
		
		tel = f.addTel1.value + '-' + f.addTel2.value + '-' + f.addTel3.value;
		f.addTel.value = tel;
	}
	
	birth = f.year.value + '-' + f.month.value + '-' + f.day.value;
	f.birth.value = birth;

	tel = f.tel1.value + '-' + f.tel2.value + '-' + f.tel3.value;
	f.phone.value = tel;
	
	var phone = $('#phone_text').text();
	error = '이미 등록된 휴대폰 번호입니다.';
	if(phone==error){
		alert("\n휴대폰 번호를 다시 입력하세요.");
		f.tel1.value = "";
		f.tel2.value = "";
		f.tel3.value = "";
		f.tel1.focus();
		return;
	}

	email = f.email1.value + '@' + f.email2.value;
	f.email.value = email;

	if(f.emailCheck.checked){
		f.emailReception.value = 'Y';
	}
	else{
		f.emailReception.value = 'N';
	}
	
	if(f.smsCheck.checked){
		f.smsReception.value = 'Y';
	}
	else{
		f.smsReception.value = 'N';
	}

	f.action = "/webproject/login/mem_join_success.action";

	f.submit();
}

// 날짜 검사
function isValidDate(year, month, day) {
	var days = new Array (31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

     if(year%4==0 && year%100 !=0 || year%400==0){
		days[1]=29;
	 }
     else{
		days[1]=28;
	 }

     if(month < 1 || month > 12){
		return false;
	 }

     if(day > days[month-1] || day < 1){
		return false;
	 }
       
     return true;
}

//아이디 찾기 히든값 정리
function hiddenValue(){

	var f = document.findIdForm;

	var userName = f.userName.value;
	userName = userName.trim();
	if(!userName) {
		alert("\n이름을 입력하세요.");
		f.userName.focus();
		return false;
	}
	f.userName.value = userName;

	var birth = f.year.value;
	birth = birth.trim();
	if(!birth) {
		alert("\n생년월일을 입력하세요.");
		f.year.focus();
		return false;
	}
	f.year.value = birth;

	birth = f.month.value;
	birth = birth.trim();
	if(!birth) {
		alert("\n생년월일을 입력하세요.");
		f.month.focus();
		return false;
	}
	f.month.value = birth;

	birth = f.day.value;
	birth = birth.trim();
	if(!birth) {
		alert("\n생년월일을 입력하세요.");
		f.day.focus();
		return false;
	}
	f.day.value = birth;

	var validDate = isValidDate(f.year.value, f.month.value, f.day.value);
	if(validDate==false){
		alert("\n생년월일을 정확히 입력하세요.");
		f.month.focus();
		return false;
	}

	var tel = f.tel1.value;
	tel = tel.trim();
	if(!tel) {
		alert("\n휴대폰 번호를 입력하세요.");
		f.tel1.focus();
		return false;
	}
	f.tel1.value = tel;

	tel = f.tel2.value;
	tel = tel.trim();
	if(!tel) {
		alert("\n휴대폰 번호를 입력하세요.");
		f.tel2.focus();
		return false;
	}
	f.tel2.value = tel;

	tel = f.tel3.value;
	tel = tel.trim();
	if(!tel) {
		alert("\n휴대폰 번호를 입력하세요.");
		f.tel3.focus();
		return false;
	}
	f.tel3.value = tel;

	var email = f.email1.value;
	email = email.trim();
	if(!email) {
		alert("\n이메일을 입력하세요.");
		f.email1.focus();
		return false;
	}
	f.email1.value = email;

	email = f.email2.value;
	email = email.trim();
	if(!email) {
		alert("\n이메일을 입력하세요.");
		f.email2.focus();
		return false;
	}
	f.email2.value = email;

	birth = f.year.value + '-' + f.month.value + '-' + f.day.value;
	f.birth.value = birth;

	tel = f.tel1.value + '-' + f.tel2.value + '-' + f.tel3.value;
	f.phone.value = tel;

	email = f.email1.value + '@' + f.email2.value;
	f.email.value = email;
	
	return true;

}

function findIdToLogin(){
	
	window.opener.top.location.href = "login.action";
	window.close();
	
}


//비밀번호 찾기 히든값 정리
function hiddenValuePwd(){

	var f = document.findPwdForm;
	
	var userId = f.userId.value;
	userId = userId.trim();
	if(!userId) {
		alert("\n아이디를 입력하세요.");
		f.userId.focus();
		return false;
	}
	f.userId.value = userId;

	var userName = f.userName.value;
	userName = userName.trim();
	if(!userName) {
		alert("\n이름을 입력하세요.");
		f.userName.focus();
		return false;
	}
	f.userName.value = userName;

	var birth = f.year.value;
	birth = birth.trim();
	if(!birth) {
		alert("\n생년월일을 입력하세요.");
		f.year.focus();
		return false;
	}
	f.year.value = birth;

	birth = f.month.value;
	birth = birth.trim();
	if(!birth) {
		alert("\n생년월일을 입력하세요.");
		f.month.focus();
		return false;
	}
	f.month.value = birth;

	birth = f.day.value;
	birth = birth.trim();
	if(!birth) {
		alert("\n생년월일을 입력하세요.");
		f.day.focus();
		return false;
	}
	f.day.value = birth;

	var validDate = isValidDate(f.year.value, f.month.value, f.day.value);
	if(validDate==false){
		alert("\n생년월일을 정확히 입력하세요.");
		f.month.focus();
		return false;
	}

	var tel = f.tel1.value;
	tel = tel.trim();
	if(!tel) {
		alert("\n휴대폰 번호를 입력하세요.");
		f.tel1.focus();
		return false;
	}
	f.tel1.value = tel;

	tel = f.tel2.value;
	tel = tel.trim();
	if(!tel) {
		alert("\n휴대폰 번호를 입력하세요.");
		f.tel2.focus();
		return false;
	}
	f.tel2.value = tel;

	tel = f.tel3.value;
	tel = tel.trim();
	if(!tel) {
		alert("\n휴대폰 번호를 입력하세요.");
		f.tel3.focus();
		return false;
	}
	f.tel3.value = tel;

	var email = f.email1.value;
	email = email.trim();
	if(!email) {
		alert("\n이메일을 입력하세요.");
		f.email1.focus();
		return false;
	}
	f.email1.value = email;

	email = f.email2.value;
	email = email.trim();
	if(!email) {
		alert("\n이메일을 입력하세요.");
		f.email2.focus();
		return false;
	}
	f.email2.value = email;

	birth = f.year.value + '-' + f.month.value + '-' + f.day.value;
	f.birth.value = birth;

	tel = f.tel1.value + '-' + f.tel2.value + '-' + f.tel3.value;
	f.phone.value = tel;

	email = f.email1.value + '@' + f.email2.value;
	f.email.value = email;
	
	return true;

}

