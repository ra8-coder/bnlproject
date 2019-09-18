//function getXMLHttpRequest(){
//	
//	if(window.ActiveXObject){//IE인 경우
//		try {
//			// 5.0 이후
//			return new ActiveXObject("Msxml2.XMLHTTP");
//		} catch (e) {
//			// 5.0 이전
//			return new ActiveXObject("Microsoft");
//			
//		}
//	}else if(window.XMLHttpRequest){
//	 	// IE 가 아닌경우 
//		return new XMLHttpRequest();
//	}
//	
//}
//
//// Ajax를 요청
//
//var httpRequest = null;
//
//function sendRequest(url,params,callback,method){
//	
//	httpRequest = getXMLHttpRequest();
//	
//	//method 처리 
//	var httpMethod = method?method:"GET";
//	
//	if(httpMethod != "GET" && httpMethod != "POST"){
//		httpMethod = "GET";
//	}
//	
//	//data 처리 
//	var httpParams = (params == null || params == "") ? null : params;
//	
//	//url 처리
//	var httpUrl = url;
//	if(httpMethod == "GET" && httpParams != null){
//		httpUrl += "?" + httpParams;
//	}
//	
//	
//	httpRequest.open(httpMethod,httpUrl, true);
//	httpRequest.setRequestHeader("Content-type","application/x-www-form-urlencode"); // 정석 
//	
//	httpRequest.onreadystatechange = callback;
//	
//	httpRequest.send(httpMethod = "POST" ? httpParams: null);
//	
//	
//}

/**
 * 
 */

function getXMLHttpRequest() {
	var xmlReq = false;
	
	if (window.XMLHttpRequest) { // Non-Microsoft browsers
			xmlReq = new XMLHttpRequest();
	}else if (window.ActiveXObject) {
		try {
			xmlReq = new ActiveXObject("Msxml2.XMLHTTP");
			// XMLHttpRequest in later versions of Internet Explorer
		} catch (e1) {
		
			try {
				xmlReq = new ActiveXObject("Microsoft.XMLHTTP");
				// Try version supported by older versions of Internet Explorer
			}catch (e2) {
				// Unable to create an XMLHttpRequest with ActiveX
			}
		}
	}
	return xmlReq;
}

//Ajax를 요청
var httpRequest = null;
function sendRequest(url,params,callback,method) {
	
	httpRequest = getXMLHttpRequest();
	
	//method처리
	var httpMethod = method ? method : "GET";
	if(httpMethod!="GET" && httpMethod!="POST"){
		httpMethod = "GET";
	}
	
	//DATA처리
	var httpParams = (params==null || params=="")?null:params;
	
	//url처리
	var httpUrl = url;
	if(httpMethod=="GET" && httpParams!=null){
		httpUrl += "?"+httpParams;
	}
	
	httpRequest.open(httpMethod,httpUrl,true);
	httpRequest.setRequestHeader("content-type","application/x-www-form-urlencoded");
	
	httpRequest.onreadystatechange = callback;
	httpRequest.send(httpMethod=="POST"? httpParams : null);
	
}















