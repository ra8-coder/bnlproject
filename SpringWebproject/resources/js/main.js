
//베스트셀러 hover시 이미지 띄우기
function hoverImg(num) {
	
	var img = document.getElementById("link_img"+num).src;
	var link = document.getElementById("img_link"+num).href;
	
	document.getElementById("bs_link").href = link;
	document.getElementById("bs_img").src = img;
}	


//메인화면 로드시 기본값
$(function() {
	
	var data = document.getElementById("data");
	var noData = document.getElementById("no_data");
	
	var ck = cookieInfo(getCookie('book'));
		todayView(ck); 
 
   		if($('.swiper-slide-active #isbn').val()!=null){
		noData.style.display = 'none';
		data.style.display = 'block';
		listRecomm(ck[0].isbn);
	}else if($('.swiper-slide-active #isbn').val()==null){
		noData.style.display = 'block';
		data.style.display = 'none';
	}
	
	document.getElementById("bs_link").href = document.getElementById("img_link1").href;
	document.getElementById("bs_img").src = document.getElementById("link_img1").src;
	
	newBookAll();
	issueBook();	
	
});	



	
//기대신간 전체
function newBookAll() {
	
	var url = "<%=cp%>/newbookall.action";
	
	$.post(url,function(args){
		$("#new_book").html(args);
	});	
}

//기대신간 카테고리별
function newBook(nb) {

	var url = "<%=cp%>/newbook.action";
	
	$.post(url,{nb:nb},function(args){
		$("#new_book").html(args);
	});
}

//이슈북
function issueBook() {

	var url = "<%=cp%>/issuebook.action";
	
	$.post(url,function(args){
		$("#issue_book").html(args);
	});
}



//쿠키 가져오기
function getCookie(cookiename){
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

//쿠키 뿌리기
function cookieInfo(cValue) {		
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