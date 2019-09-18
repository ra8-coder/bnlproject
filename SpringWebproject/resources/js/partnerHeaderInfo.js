
function getPartnerCookie(cookieName) {
	var cookie = document.cookie;
	    
	if(cookie.length < 0 || cookie.indexOf(cookieName + "=") < 0){  return "";  }
	
	var s_index = cookie.indexOf(cookieName + "=") + cookieName.length;
	var e_index = (cookie.indexOf(";", s_index) < 0) ? cookie.length : cookie.indexOf(";", s_index); 

	return unescape(cookie.substring(s_index+1, e_index));  
}

var partnerHeaderInfo = "";
var partnerCookieVal = getPartnerCookie("PARTNER");
if (partnerCookieVal == "101") {
	//partnerHeaderInfo = "<script language=\"javascript\" src=\"http://shopping.naver.com/shoppingBar/bar.nhn?mn=\ubc18\ub514\uc564\ub8e8\ub2c8\uc2a4&t=js\"></script> ";
}
else if (partnerCookieVal == "135") {
	partnerHeaderInfo = "<script language=\"javascript\" src=\"http://cashbagmall.okcashbag.com/mall/cTop4Bandinlunis.js\"></script> ";
}
else if(partnerCookieVal == "146") {
	partnerHeaderInfo = '<link rel="stylesheet" href="http://bokjimall.net/skin_combi1/css/style_asp.css" type="text/css">';
	partnerHeaderInfo += '<script language="javascript" src="http://bokjimall.net/skin_combi1/css/aspjs.js"></script>';
	partnerHeaderInfo += '<script language="javascript" src="http://bokjimall.net/skin_combi1/asp_js.js"></script>';
}
else if(partnerCookieVal == "151") {
	partnerHeaderInfo = '<script language="javascript" src="https://allthat.shinhancard.com/asn/ASNASNCMN/ASNTitle.shc?type=A032"></script>';
}
else if(partnerCookieVal == "155") {
	partnerHeaderInfo = '<script language="javascript" src="http://www.cultureland.co.kr/asp/mall/Shopping_cland.js?cpgm=bandi"></script>';
}
else if(partnerCookieVal == "175") {
	//2014.07.31 占쏙옙占쏙옙
	partnerHeaderInfo = '<script language="javascript" src="https://link.shoploung.bccard.com/shop_header.php?shop_id=bandibook&charset=euckr"></script>';
}
else if(partnerCookieVal == "178") {
	partnerHeaderInfo = '<script language="javascript" src="http://goodbookworld.com/css/goodbookworld.js"></script>';
}
else if(partnerCookieVal == "380") {
	partnerHeaderInfo = '<script language="javascript" src="http://hyundaicard.com/js/common/outlink_header_hc.js"></script>';
}


if (partnerHeaderInfo != "") {
	document.write(partnerHeaderInfo);
}