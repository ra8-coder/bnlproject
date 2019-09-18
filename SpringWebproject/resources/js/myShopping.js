$(document).ready(function(){
	
	//이미지 호버 - 새창열기
	$('.wish_book_img').on('mouseover',function(){
		$(this).children('.wish_book_popup').addClass('on');
	});
	$('.wish_book_img').on('mouseleave',function(){
		$(this).children('.wish_book_popup').removeClass('on');
	});
	
	//체크박스 전체선택(위시리스트/최근 본 상품)
	$('.check_all').click( function() {
		$('.checkbox').prop('checked', this.checked);
	});
	
	//셀렉트 박스 날짜 지정(기본값)
	setDefaultDate();	
	
	//주문/배송조회 - ISBN/책서명으로 검색시
	$('#orderListSearchValue').keypress(function(evt){
		if(evt.keyCode==13){
			$('#searchOrdersByName').trigger('click');
		}
	});	
	
	//날짜 셀렉트 박스 onchange 이벤트 발생시 
	$('#fromYear').on('change', function(){	//검색 시작 날짜 연도 변경시
		var fromYear = $('#fromYear').val();
		var fromMonth = $('#fromMonth').val();
		var fromDay = $('#fromDay').val();
		var fromLastDay = getDays(fromYear, fromMonth);

		$('#fromDay').empty();
		for(var i=1;i<fromLastDay+1;i++){
			$('#fromDay').append('<option value="' + i + '">' + i + '</option>');
		}
		$('#fromDay').val(fromDay).attr("selected","selected");
	});
	
	$('#toYear').on('change', function(){	//검색 종료 날짜 연도 변경시
		var toYear = $('#toYear').val();
		var toMonth = $('#toMonth').val();
		var toDay = $('#toDay').val();
		var toLastDay = getDays(toYear, toMonth);

		$('#toDay').empty();
		for(var i=1;i<toLastDay+1;i++){
			$('#toDay').append('<option value="' + i + '">' + i + '</option>');	
		}
		$('#toDay').val(toDay).attr("selected","selected");
		
	});
	
	$('#fromMonth').on('change', function(){	//검색 시작 날짜 월 변경시
		var fromYear = $('#fromYear').val();
		var fromMonth = $('#fromMonth').val();
		var fromDay = $('#fromDay').val();
		var fromLastDay = getDays(fromYear, fromMonth);

		$('#fromDay').empty();
		for(var i=1;i<fromLastDay+1;i++){
			$('#fromDay').append('<option value="' + i + '">' + i + '</option>');
		}
		$('#fromDay').val(fromDay).attr("selected","selected");
	});
	
	$('#toMonth').on('change', function(){	//검색 종료 날짜 월 변경시
		var toYear = $('#toYear').val();
		var toMonth = $('#toMonth').val();
		var toDay = $('#toDay').val();
		var toLastDay = getDays(toYear, toMonth);

		$('#toDay').empty();
		for(var i=1;i<toLastDay+1;i++){
			$('#toDay').append('<option value="' + i + '">' + i + '</option>');	
		}
		$('#toDay').val(toDay).attr("selected","selected");
		
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
	
	//email 수신동의 라디오버튼 옵션 value
	var emailRadio = $('input:radio[name="emailCheck"]:checked').val();
	$('#emailReception').val(emailRadio);
	
	$('input:radio[name="emailCheck"]').change(function(){
		$('#emailReception').val($('input:radio[name="emailCheck"]:checked').val());
	});
	
	//sms 수신동의 라디오버튼 옵션 value
	var smsRadio = $('input:radio[name="smsCheck"]:checked').val();
	$('#smsReception').val(smsRadio);
	
	$('input:radio[name="smsCheck"]').change(function(){
		$('#smsReception').val($('input:radio[name="smsCheck"]:checked').val());
	});
	
	//새 비밀번호1 유효성 검사
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
			$('#text_pwd2').html("<span id='text_pwd2' style='color: black;'>비밀번호가 일치하지 않습니다.</span>");
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

//회원정보수정 저장
function updateUserInfo(){
	
	var f = document.myInfoUpdateForm;
	
	var zipCode = f.zipCode.value;
	if(zipCode){
		if(!f.address1.value){
			alert("\n주소(배송지)를 정확히 입력해 주세요.");
			f.address2.focus();
			return;
		}
		else if(!f.address2.value){
			alert("\n주소(배송지)를 정확히 입력해 주세요.");
			f.address2.focus();
			return;
		}
	}
	else if(!zipCode) {
		if(f.address1.value){
			alert("\n주소(배송지)를 정확히 입력해 주세요.");
			f.address1.focus();
			return;
		}
		else if(f.address2.value){
			alert("\n주소(배송지)를 정확히 입력해 주세요.");
			f.zipCode.focus();
			return;
		}
	}

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
	else if(f.addTel2.value){
		
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
	else if(f.addTel3.value){
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
	
	tel = f.addTel1.value + '-' + f.addTel2.value + '-' + f.addTel3.value;
	f.addTel.value = tel;
	
	tel = f.tel1.value + '-' + f.tel2.value + '-' + f.tel3.value;
	f.phone.value = tel;

	email = f.email1.value + '@' + f.email2.value;
	f.email.value = email;
	
	f.action = "updateMyInfo_ok.action";
	
	f.submit();
	
}

//회원 탈퇴
function memOutCheck(){
	
	if(confirm("탈퇴하시겠습니까?\n모든 회원 정보는 즉시 삭제됩니다.")){
		
		$.ajax ({
			url:"memberOut_pre.action",
			type:"POST",
			success:function(result){
				if(result==true){
					location.href = 'memberOut_ok.action';
				}
				else {
					alert("진행중인 주문내역이 있습니다. \n진행중인 주문이 완료되어야 회원 탈퇴가 가능합니다.");
				}
			},
			error:function(e){
				alert(e.responseText);
			}
			
		});
		
		
	}
	else{
		return;
	}
	
}

//비밀번호 변경 팝업
function showWindow(addr,width) {
	
	var url = "/webproject/" + addr + ".action";

	var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top=90,left=250,height=350,' + 'width=' + width;
	
	window.open(url,"반디앤루니스 인터넷서점",setting);

} 

//비밀번호 변경 확인버튼 클릭시
function updatePwd(){
	
	var f = document.updatePwdForm;
		
	var pwd = f.userPwd.value;
	pwd = pwd.trim();
	if(!pwd) {
		alert("\n비밀번호를 입력하세요.");
		f.userPwd.focus();
		return;
	}
	f.userPwd.value = pwd;
	
	var pwd1 = f.newPwd1.value;
	pwd1 = pwd1.trim();
	if(!pwd1) {
		alert("\n비밀번호를 입력하세요.");
		f.newPwd1.focus();
		return;
	}
	f.newPwd1.value = pwd1;
	
	var pwd2 = f.newPwd2.value;
	pwd2 = pwd2.trim();
	if(!pwd2) {
		alert("\n비밀번호를 입력하세요.");
		f.newPwd2.focus();
		return;
	}
	f.newPwd2.value = pwd2;
	
	if(pwd1!=pwd2){
		alert("\n새 비밀번호가 일치하지 않습니다.");
		f.newPwd1.focus();
		return;
	}
	
	f.action = "updatePwd_ok.action";
		
	f.submit();
}

//말일 구하기
function getDays(year, month){
	
	var day = 30;
	
	if(year%400==0 || year%4 ==0){	//윤년
		if(month==2){
			day = 29;
		}
		if( (month>7 && month%2==0) || (month<=7 && month%2==1) ){
			day = 31;
		}
	}
	else{	//평년
		if(month==2){
			day = 28;
		}
		if( (month>7 && month%2==0) || (month<=7 && month%2==1) ){
			day = 31;
		}
	}
	
	return day;
	
}

//날짜 select option 기본값 입력 (조회기간: 오늘로부터 한달)
function setDefaultDate(){
	
	//조회 시작 날짜
	var fromDate = new Date();	
	
	var fromYear = fromDate.getFullYear();
	var fromMonth = (fromDate.getMonth()+1)-1;
	var fromDay = fromDate.getDate();
	var fromLastDay = getDays(fromYear, fromMonth);
	
	//조회 끝 날짜
	today = new Date();	
	
	var toYear = today.getFullYear();
	var toMonth = today.getMonth()+1;
	var toDay = today.getDate();
	var toLastDay =  getDays(toYear, toMonth);
	
	//셀렉트 박스 element가져와서 옵션 넣기
	var select = document.getElementById('fromYear');
	for(var i=fromYear-10;i<fromYear+1;i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(i==fromYear){
			opt.selected = 'selected';
		}
		select.appendChild(opt);
	}
	
	select = document.getElementById('fromMonth');
	for(var i=1;i<13;i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(i==fromMonth){
			opt.selected = 'selected';
		}
		select.appendChild(opt);
	}
	
	select = document.getElementById('fromDay');
	for(var i=1;i<=fromLastDay;i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(i==fromDay){
			opt.selected = 'selected';
		}
		select.appendChild(opt);
	}	
	
	var select = document.getElementById('toYear');
	for(var i=toYear-10;i<toYear+1;i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(i==toYear){
			opt.selected = 'selected';
		}
		select.appendChild(opt);
	}
	
	select = document.getElementById('toMonth');
	for(var i=1;i<13;i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(i==toMonth){
			opt.selected = 'selected';
		}
		select.appendChild(opt);
	}
	
	select = document.getElementById('toDay');
	for(var i=1;i<=toLastDay;i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(i==toDay){
			opt.selected = 'selected';
		}
		select.appendChild(opt);
	}
	
	
}

//최근15일  1개월  3개월  6개월 조회
function setDate(month, day){
	
	var today, fromYear, fromMonth, fromDay, fromLastDay = '';
	var toYear, toMonth, toDay, toLastDay = '';
	
	
	//최근15일 조회
	if(month<1){
		
		//조회 시작 날짜
		today = new Date();
		
		fromYear = today.getFullYear();
		fromMonth = today.getMonth()+1;
		fromDay = today.getDate()-day;
		fromLastDay = getDays(fromYear, fromMonth);
		
		//조회 끝 날짜
		today = new Date();	
		
		toYear = today.getFullYear();
		toMonth = today.getMonth()+1;
		toDay = today.getDate();
		toLastDay =  getDays(toYear, toMonth);
	}
	else if(month==12){
		//조회 시작 날짜
		today = new Date();
		
		fromYear = today.getFullYear()-1;
		fromMonth = today.getMonth()+1;
		fromDay = today.getDate()
		fromLastDay = getDays(fromYear, fromMonth);
		
		//조회 끝 날짜
		today = new Date();	
		
		toYear = today.getFullYear();
		toMonth = today.getMonth()+1;
		toDay = today.getDate();
		toLastDay =  getDays(toYear, toMonth);
	}
	else{	//최근 1개월,3개월, 6개월 조회
		
		//조회 시작 날짜
		today = new Date();
		
		fromYear = today.getFullYear();
		fromMonth = (today.getMonth()+1)-month;
		fromDay = today.getDate()-day;
		fromLastDay = getDays(fromYear, fromMonth);
		
		//조회 끝 날짜
		today = new Date();	
		
		toYear = today.getFullYear();
		toMonth = today.getMonth()+1;
		toDay = today.getDate();
		toLastDay =  getDays(toYear, toMonth);
	}
	
	//셀렉트 박스 element가져와서 옵션 넣기
	var select = document.getElementById('fromYear');
	select.options.length = 0;	
	for(var i=fromYear-10;i<fromYear+1;i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(i==fromYear){
			opt.selected = 'selected';
		}
		select.appendChild(opt);
	}
	
	select = document.getElementById('fromMonth');
	select.options.length = 0;
	for(var i=1;i<13;i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(i==fromMonth){
			opt.selected = 'selected';
		}
		select.appendChild(opt);
	}
	
	select = document.getElementById('fromDay');
	select.options.length = 0;
	for(var i=1;i<=fromLastDay;i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(i==fromDay){
			opt.selected = 'selected';
		}
		select.appendChild(opt);
	}	
	
	var select = document.getElementById('toYear');
	select.options.length = 0;
	for(var i=toYear-10;i<toYear+1;i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(i==toYear){
			opt.selected = 'selected';
		}
		select.appendChild(opt);
	}
	
	select = document.getElementById('toMonth');
	select.options.length = 0;
	for(var i=1;i<13;i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(i==toMonth){
			opt.selected = 'selected';
		}
		select.appendChild(opt);
	}
	
	select = document.getElementById('toDay');
	select.options.length = 0;
	for(var i=1;i<=toLastDay;i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(i==toDay){
			opt.selected = 'selected';
		}
		select.appendChild(opt);
	}	
	
}

//주문 조회(주문/배송) 리스트 
function getList(pageNum, fromDate, toDate, searchValue){
	
	var params = 'pageNum=' + pageNum;
	
	if(fromDate!=''){
		params += '&fromDate=' + fromDate + '&toDate=' + toDate;
	}
	if(searchValue!=''){
		params = 'pageNum=' + pageNum + '&searchValue=' + searchValue;
	}

	jQuery.ajax({
		url:"getOrderList.action",
		data:params,
		type:"POST",
		success:function(data){
			$('#myOrderList').html(data);	
		},
		error:function(e){
			alert(e.responseText);
		}	
	});
	
}

//취소/반품/교환 내역 조회 리스트 
function getRetList(pageNum, fromDate, toDate, mode){
	
	var params = 'pageNum=' + pageNum;
	
	if(fromDate!=''){
		params += '&fromDate=' + fromDate + '&toDate=' + toDate;
	}
	if(mode!=''){
		params += '&pageNum=' + pageNum + '&mode=' + mode;
	}

	jQuery.ajax({
		url:"getRetList.action",
		data:params,
		type:"POST",
		success:function(data){
			$('#myRetLists').html(data);	
		},
		error:function(e){
			alert(e.responseText);
		}	
	});
	
}

//적립금 리스트
function getPointList(pageNum, fromDate, toDate, mode){
	
	var params = 'pageNum=' + pageNum;
	
	if(fromDate!=''){
		params += '&fromDate=' + fromDate + '&toDate=' + toDate;
	}
	if(mode!=''){
		params += '&mode=' + mode;
	}

	jQuery.ajax({
		url:"getPointList.action",
		data:params,
		type:"POST",
		success:function(data){
			$('#myPointList').html(data);	
		},
		error:function(e){
			alert(e.responseText);
		}	
	});
	
}

//소멸예정 적립금 리스트
function getExpPointList(pageNum, fromDate, toDate, mode){
	
	var params = 'pageNum=' + pageNum;
	
	if(fromDate!=''){
		params += '&fromDate=' + fromDate + '&toDate=' + toDate;
	}
	if(mode!=''){
		params += '&mode=' + mode;
	}

	jQuery.ajax({
		url:"expPointList.action",
		data:params,
		type:"POST",
		success:function(data){
			$('#expPointList').html(data);	
		},
		error:function(e){
			alert(e.responseText);
		}	
	});
	
}

//1:1 상담내역 리스트
function getCounselList(pageNum, fromDate, toDate, mode){
	
	var params = 'pageNum=' + pageNum;
	
	if(fromDate!=''){
		params += '&fromDate=' + fromDate + '&toDate=' + toDate;
	}
	if(mode!=''){
		params += '&mode=' + mode;
	}

	jQuery.ajax({
		url:"getCounselList.action",
		data:params,
		type:"POST",
		success:function(data){
			$('#myCounselList').html(data);	
		},
		error:function(e){
			alert(e.responseText);
		}	
	});
	
}

//리뷰를 기다리는 책 리스트
function getReadyReivewList(pageNum, mode){
	
	var params = 'pageNum=' + pageNum;
	
	if(mode!=''){
		params += '&mode=' + mode;
	}

	jQuery.ajax({
		url:"getReadyReviewList.action",
		data:params,
		type:"POST",
		success:function(data){
			$('#readyReviewList').html(data);	
		},
		error:function(e){
			alert(e.responseText);
		}	
	});
	
}

//리뷰를 기다리는 책 리스트
function getLatesBooksList(pageNum, mode){
	
	var params = 'pageNum=' + pageNum;
	
	if(mode!=''){
		params += '&mode=' + mode;
	}

	jQuery.ajax({
		url:"getLatesBooksList.action",
		data:params,
		type:"POST",
		success:function(data){
			$('#LatesBooksList').html(data);	
		},
		error:function(e){
			alert(e.responseText);
		}	
	});
	
}

//리뷰가 있는 책 리스트
function getMyReviewList(pageNum, mode){
	
	var params = 'pageNum=' + pageNum;
	
	if(mode!=''){
		params += '&mode=' + mode;
	}

	jQuery.ajax({
		url:"getReviewList.action",
		data:params,
		type:"POST",
		success:function(data){
			$('#myReviewList').html(data);	
		},
		error:function(e){
			alert(e.responseText);
		}	
	});
	
}

//위시리스트
function getWishList(pageNum, mode){
	
	var params = 'pageNum=' + pageNum;
	
	if(mode!=''){
		params += '&mode=' + mode;
	}

	jQuery.ajax({
		url:"getWishList.action",
		data:params,
		type:"POST",
		success:function(data){
			$('#myWishList').html(data);	
		},
		error:function(e){
			alert(e.responseText);
		}	
	});
	
}

//한줄평 리스트 가져오기
function getSentenceList(pageNum, mode){
	
	var params = 'pageNum=' + pageNum;
	
	if(mode!=''){
		params += '&mode=' + mode;
	}
	
	jQuery.ajax({
		url:"getSentenceList.action",
		data:params,
		type:"POST",
		success:function(data){
			$('#mySentenceList').html(data);	
		},
		error:function(e){
			alert(e.responseText);
		}	
	});
}

//주문 조회 isbn or 책이름 입력 유효성 검사
function checkValue(){
	if(!$('#orderListSearchValue').val()){
		alert("상품명 또는 ISBN을 입력해주세요.");
		return false;
	}
	return true;
}

//주문 취소
function cancelOrder(orderId,point,usedPoint){
	var check = confirm("정말 주문을 취소하시겠습니까?");
	
	if(usedPoint<0){
		usedPoint=0;
	}
	var url = "cancelOrder.action?orderId=" + orderId + "&point=" + point + "&usedPoint=" + usedPoint; 
	
	if(check){
		location.href= url;
	}
	else{
		return;
	}
}

//반품 신청
function returnOrder(orderId){
	var check = confirm("주문하신 상품을 반품하시겠습니까?");
	var url = "returnOrder.action?orderId=" + orderId; 
	
	if(check){
		location.href= url;
	}
	else{
		return;
	}
}

//구매 완료
function confirmOrder(orderId){
	
	var txt = "주문하신 상품을 구매완료하시겠습니까?\n";
	txt += " '구매완료'가 되면 반품/교환/주문취소는 불가능합니다.";
	var check = confirm(txt);
	var url = "confirmOrder.action?orderId=" + orderId;
	
	if(check){
		location.href= url;
	}
	else{
		return;
	}
	
}

//교환 신청
function exchangeOrder(orderId){
	var check = confirm("주문하신 상품을 교환하시겠습니까?");
	var url = "exchangeOrder.action?orderId=" + orderId;
	
	if(check){
		location.href= url;
	}
	else{
		return;
	}
}

//도서 미리보기 팝업
function popPreview(isbn) {

    if (typeof(isbn) == "undefined" || isbn == "") {
        return;
    }
    
    window.open("/webproject/book_preview.action?isbn=" + isbn, "preview", "width="+screen.availWidth+",height="+screen.availHeight+",resizable=yes,scrollbars=yes");
}

//쇼핑카트에 담기 - 쿠키에 저장
function goShoppingCart(){
	
	var checkArray = chkToArray();
	var items = getCookie('shop');
	var flag = true;
	var ordCnt = 1;
	
	if(checkArray.length==0){
		alert("쇼핑카트에 담을 상품을 선택해주세요.");
		return;
	}
	
	if(items){
		var itemArray=items.split('/');
		var cookie = new Array();
		
		for(i=0;i<itemArray.length;i++){
			cookie[i] = JSON.parse(itemArray[i]);
	 	}
		
		for(i=0;i<checkArray.length;i++){		
			for(j=0;j<cookie.length;j++){
				if(cookie[j].isbn==checkArray[i]){	
					alert("이미 쇼핑카트에 있는 상품입니다.");
					return;	
				}	
			}
			
			flag = false;
		}
		
		if(flag==false){
			
			for(i=0;i<checkArray.length;i++){
				var cookieValue = JSON.stringify({"isbn":checkArray[i],"orderCount":ordCnt});
				itemArray.push(cookieValue);
			}
			setCookie('shop',itemArray.join('/'),1);
			alert("쇼핑카트에 추가되었습니다.")
		}
	}
	else{
		var newArray = new Array();
		
		for(i=0;i<checkArray.length;i++){
			var cookieValue = JSON.stringify({"isbn":checkArray[i],"orderCount":ordCnt});
			newArray.push(cookieValue);
		}
		setCookie('shop',newArray.join('/'),1);
		alert("쇼핑카트에 추가되었습니다.")
	}
	
}

//쿠키 생성
function setCookie(cName, cValue, cDay){
	var expire = new Date();
    expire.setDate(expire.getDate() + cDay);
    cookies = cName + '=' + escape(cValue) + '; path=/ ';
    if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
    document.cookie = cookies;
}


//체크박스 값 배열에 정리하기
function chkToArray(){
	
	//체크박스 선택된 값을 담을 array
	var checkArray = new Array();
	//체크박스 객체
	var chkbox = $('.checkbox');
	
	for(var i=0;i<chkbox.length;i++){
		if(chkbox[i].checked == true){
			checkArray.push(chkbox[i].value);
		}
	}
	
	return checkArray;
}



function addWishList(){
	
	var checkArray = chkToArray();
	
	if(checkArray.length == 0){
		alert("위시리스트에 담을 상품을 선택하세요.");
	}
	else{
		$.ajax ({
			url:"addWishList.action",
			data:{checkArray:checkArray},
			type:"POST",
			success:function(result){
				if(result==true){
					alert("위시리스트에 등록되었습니다.")
				}
				else{
					alert("이미 위시리스트에 등록된 도서입니다.")
				}
			},
			error:function(e){
				alert(e.responseText);
			}
			
		});
	}
	
}

//최근 본 상품 삭제하기
function recentDelete(){
	
	var checkArray = chkToArray();
	
	if(checkArray.length == 0){
		alert("삭제할 상품을 선택하세요.");
	}
	else{
		if(confirm("선택하신 상품을 삭제하시겠습니까?") == true){
			$.ajax ({
				url:"deleteLatesBooks.action",
				data:{checkArray:checkArray},
				type:"POST",
				success:function(){
					location.href="myLatesBooksList.action";
				},
				error:function(e){
					alert(e.responseText);
				}
				
			});
		}
		else{
			return;
		}
	}
}

//위시리스트 삭제하기
function deleteWish(){
	
	var checkArray = chkToArray();
	
	if(checkArray.length == 0){
		alert("삭제할 상품을 선택하세요.");
	}
	else{
		if(confirm("선택하신 상품을 삭제하시겠습니까?") == true){
			$.ajax ({
				url:"deleteWish.action",
				data:{checkArray:checkArray},
				type:"POST",
				success:function(){
					location.href="myWishList.action";
				},
				error:function(e){
					alert(e.responseText);
				}
				
			});
		}
		else{
			return;
		}
	}
	
}

//리뷰 삭제하기
function deleteReview(reviewId){
	
	if(confirm("리뷰를 삭제하시겠습니까?") == true){
		$.ajax ({
			url:"deleteReview.action",
			data:'reviewId='+reviewId,
			type:"POST",
			success:function(){
				location.href="myReviewList.action";
			},
			error:function(e){
				alert(e.responseText);
			}
			
		});
	}
	else{
		return;
	}
	
}

//간단평 삭제하기
function deleteSentence(reviewId){
	
	if(confirm("간단평을 삭제하시겠습니까?") == true){
		$.ajax ({
			url:"deleteSentence.action",
			data:'reviewId='+reviewId,
			type:"POST",
			success:function(){
				location.href="mySentenceList.action";
			},
			error:function(e){
				alert(e.responseText);
			}
			
		});
	}
	else{
		return;
	}
	
}

//리뷰 수정하기
function updateReview(){
	
	var f = document.reviewUpdateForm;
	
	if(!f.reviewTitle.value.trim()){
		alert("리뷰 제목을 입력해주세요.")
		return;
	}
	if(!f.contents.value.trim()){
		alert("내용을 입력해주세요.")
		return;
	}
	
	f.action = "reviewUpdate_ok.action";	
	f.submit();
	
}

//한줄평 등록하기
function createSentence(){
	
	var f = document.sentenceCreateForm;
	
	if(!f.sentence.value.trim()){
		alert("간단평 내용을 입력해주세요.")
		return;
	}
	
	f.action = "sentenceCreate_ok.action";
	f.submit();
}

//한줄평 수정하기
function updateSentence(reviewId){
	
	var f = document.sentenceUpdateForm;
	
	if(!f.sentence.value.trim()){
		alert("간단평 내용을 입력해주세요")
		return;
	}
	else{
		if(confirm("간단평을 수정하시겠습니까?") == true){
			f.action = "updateSentence_ok.action?reviewId=" + reviewId;
			f.submit();
		}
		else{
			return;
		}
	}

}

