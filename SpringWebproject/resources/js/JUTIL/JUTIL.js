/**********************************************************************************************************************************************************************************
	작성자 : 김기석
	작성일 : 2007.06.18

	목적 :
		- 웹 기반의 자바스크립트 유틸 모음

	참고사항 :
		- 
**********************************************************************************************************************************************************************************/



if(typeof(jutil) != "object"){			jutil			= {};	}
if(typeof(jutil.xmlhttp) != "object"){	jutil.xmlhttp	= {};	}





/**********************************************************************************************************************************************************************************
	jutil 환경변수 설정부
**********************************************************************************************************************************************************************************/
jutil.debug				= 1;		// 디버깅 옵션
jutil.global			= this;		// 전역 오브젝트 설정. 현재 포함되어 있는 문서를 지시하게 된다.
jutil.include_path		= "";		// include 에서 사용하는 기본 경로 정보
jutil.include_info		= {};		// 현재 include 되어 있는 상태 정보
jutil.include_js_path	= "";		// include_js 에서 사용하는 기본 경로 정보
jutil.vars				= {};		// jutil을 활용해서 전역변수를 컨트롤 할때 사용하는 오브젝트



/**********************************************************************************************************************************************************************************
	jutil 기능 구현부
**********************************************************************************************************************************************************************************/
jutil.error = function(message, exception){
	/*	에러를 발생시킨다.
	*/
	if(exception){			message += "\n\n" + jutil.errorToString(exception);	}
	if(jutil.debug > 0){	alert(message);										}
	throw exception || Error(message);
}


jutil.errorToString = function(exception){
	/*	에러메세지를 반환한다.
	*/
	if(exception.description){	return exception.description;	}
	if(exception.message){		return exception.message;		}
	return exception;
}



jutil.e = function(){
	/*	document에 등록된 구성요소중에서 지정된 아이디의 오브젝트를 반환한다.
	*/
	// 파라미터 검토
	if(arguments.length == 0){	return null;	}
	else{
		// 길이와 방법 체크
		var length	= 0;		var method	= "id";
		if(arguments[arguments.length-1] != "name" && arguments[arguments.length-1] != "id") {
			length	= arguments.length;														}
		else {
			length	= arguments.length - 1;		method	= arguments[arguments.length-1];	
		}
	}

	// 오브젝트 로드
	var elements = new Array();
	for(var i=0 ; i < length ; i++){
		var element = (method == "id") ? document.getElementById(arguments[i]) : document.getElementsByName(arguments[i]);
		if(!element && method == "id"){
			element = document.getElementsByName(arguments[i]);
		}
		elements.push(element);
	}

	return (length == 1) ? elements[0] : elements;
}


jutil.o = function(){
	/*	document에 등록된 구성요소중에서 지정된 아이디의 오브젝트를 반환한다.
			- jutil.e는 배열로 반환하고 jutil.o 는 오브젝트로 반환한다.
	*/
	if(arguments.length == 0){	return null;	}
	var rv = {}

	for(var i=0 ; i < arguments.length ; i++){
		var obj = document.getElementById(arguments[i]);
		if(obj == null){	obj = document.getElementsByName(arguments[i]);	}
		rv[arguments[i]] = obj.tagName ? obj : null;
	}
	return rv;
}


jutil.v = function(){
	/*	document에 등록된 구성요소중에서 지정된 아이디의 오브젝트의 값을 반환한다.
			- 2개 이상의 값이 전달된 경우에는 오브젝트 방식으로 값을 반환한다.
			- 각 필요한 태그는 그때 정의한다. 현재는 미완성 상태이다.
	*/
	if(arguments.length == 0){	return null;	}

	var rv = {}
	for(var i=0 ; i < arguments.length ; i++){

		var obj = document.getElementById(arguments[i]);
		if(obj == null){	obj = document.getElementsByName(arguments[i]);	}

		if(typeof(obj.length) == "number"){		// 길이값이 존재하는 경우. select 오브젝트나 name으로 읽어온 경우
			switch(obj.tagName){
				case "SELECT" :
					rv[arguments[i]] = obj.value;
					break;
				default :
					jutil.error("jutil.v : " + obj.tagName + "에 대한 기능이 정의되지 않았습니다.");
					break;
			}
		}else{									// 길이값이 존재하지 않는 경우. id에서 읽어온 경우
			switch(obj.tagName.toUpperCase()){
				case "INPUT" :
					switch(obj.type.toUpperCase()){
						case "RADIO" :
							var objs = document.getElementsByName(arguments[i]);
							for(var j=0 ; j < objs.length ; j++){
								if(objs[j].checked){	rv[arguments[i]] = objs[j].value;	}
							}
							break;
						case "TEXT" :
							rv[arguments[i]] = obj.value;
							break;
						default :
							jutil.error("jutil.v : " + obj.type + "에 대한 기능이 정의되지 않았습니다.");
							break;
					}

					break;
				case "TEXTAREA" :
					rv[arguments[i]] = obj.value;
					break;
				default :
					jutil.error("jutil.v : " + obj.tagName + "에 대한 기능이 정의되지 않았습니다.");
					break;
			}
		}
	}
	return rv;
}



jutil.parseHTML = function(htmlStr){
	/*	HTML 문자열을 받아서 오브젝트로 반환한다.
			파이어 폭스용, appendChild 와 같이 오브젝트가 필요한 경우에 사용한다.
	*/
	var r = document.body.ownerDocument.createRange();
	r.setStartBefore(document.body);
	return r.createContextualFragment(htmlStr);
}


jutil.include = function(name){
	/*	자바스크립트 파일을 include 시킨다.
			기본 경로가 설정되어 있지 않으면 현재 문서경로를 기본값으로 한다.
			name에 확장자는 제외하고 처리한다.
			지정한 경로에서 하위 경로는 /문자로 설정한다. => . 문자로 할경우 파일명에 . 문자가 존재하면 문제가 생긴다.
			2번 이상 로드되지 않는다. 오로지 1번만 로드 시킨다.
			읽어들일 파일은 utf8 형식을 권장. 한글에서 문제가 발생할 수 있음.
	*/
	try{
		var path = "";

		if(this.include_path.length == 0){
			path = jutil.getHtmlUrl() + name + ".js";
		}else{	path = this.include_path + name + ".js";	}
		if(jutil.include_info[path]){	return true;	}
		var str = jutil.xmlhttp.request_url(path);
		eval(str);
		jutil.include_info[path] = true;
		return true;
	}catch(e){
		jutil.error("jutil.include : " + name + " 라이브러리를 읽어오는데 실패했습니다.", e);
		return false;
	}
}


jutil.include_js = function(name){
	/*	자바스크립트 파일을 include 시킨다.
			기본 경로가 설정되어 있지 않으면 현재 문서경로를 기본값으로 한다.
			name에 확장자는 제외하고 처리한다.
			지정한 경로에서 하위 경로는 /문자로 설정한다. => . 문자로 할경우 파일명에 . 문자가 존재하면 문제가 생긴다.
			2번 이상 로드된다. 2번 이상부터는 기존에 로드된 js 파일을 제거하고 다시 로드한다.
			경로가 틀렸을 경우 에러가 발생하지 않는다.

			2007.07.18
				- name에 js 확장자가 포함되어 있으면 url로 간주하고 기본경로가 아닌 지정된 경로에서 로드 시킨다.
	*/
	try{
		var path = "";

		if(name.indexOf(".js") >= 0){	path = name;	}
		else{
			if(this.include_js_path.length == 0){
				path = jutil.getHtmlUrl() + name + ".js";
			}else{	path = this.include_path + name + ".js";	}
		}

		var head			= document.getElementsByTagName("HEAD").item(0);
		var objScriptOld	= jutil.e(path);
		if(objScriptOld){	head.removeChild(objScriptOld);		}
		var objScript		= document.createElement("SCRIPT");
		objScript.language	= "javascript";
		objScript.src		= path;
		objScript.type		= "text/javascript";
		objScript.id		= path;
		head.appendChild(objScript);
	}catch(e){
		jutil.error("jutil.include_js : " + name + " 라이브러리를 읽어오는데 실패했습니다.", e);
		return false;
	}
}




jutil.checkObject = function(obj){
	/*	해당 오브젝트의 키와 값을 출력한다.
			- 개발용
	*/
	var arr = [];
	for(var key in obj){	arr.push(key + " : " + obj[key] + "\n");	}
	alert(arr.join(""));
}


jutil.getHtmlUrl = function(){
	/*	현재 html 문서의 기본 경로 정보를 반환한다.
	*/
	var arr = this.global.location.href.split("/");
	arr.splice(arr.length - 1, 1);
	return arr.join("/") + "/";
}


jutil.getObjectKey = function(obj){
	/*	해당 오브젝트의 키를 배열로 반환한다.
	*/
	var rv = Array();
	for(var key in obj){	rv.push(key);	}
	return rv;
}

jutil.getBaseUrl = function(){
	/*	JUTIL.js 가 존재하는 경로 정보를 반환한다.
	*/
	var scripts = jutil.global.document.getElementsByTagName("SCRIPT");
	for(var i=0 ; i < scripts.length ; i++){
		if(scripts[i].src.indexOf("JUTIL.js") >= 0){		return scripts[i].src.replace(/JUTIL.js/gi, "");	break;	}
	}
}


jutil.getUrl = function(){
	/*	현재 접근 경로 정보를 반환한다.
	*/
	var path	= jutil.global.location.href;
	var pos		= path.indexOf("?");
	var url		= "";
	var param	= "";

	if(pos >= 0){
		url		= path.substring(0, pos);
		param	= path.substring(pos+1, path.length);
	}else{
		url		= path;
	}
	
	return {"url" : url, "param" : param}
}


jutil.queryString = function(key){
	var info = jutil.global.location.href.split("?");
	if(info.length > 1){
		var set = info[1].split("&");
		for(var i=0 ; i < set.length ; i++){
			var arr = set[i].split("=");
			if(arr[0] == key){	return arr[1];	}
		}
		return null;
	}else{	return null;	}
}


jutil.getEvent = function(evt){
	/*	브라우저에 맞는 이벤트 객체를 반환한다.
	*/
	return event ? event : evt;
}

jutil.eventSrc = function(evt){
	/*	이벤트가 발생한 소스 오브젝트를 반환한다.
			- 이벤트를 잡는 방법이 다르다.
			- return evt.target.className ? evt.target : evt.target.parentNode
	*/
	if(jutil.BWInfo().name == "MSIE"){	return window.event.srcElement;										}
	else{								return evt.target.tagName ? evt.target : evt.target.parentNode;		}
}


jutil.eventAdd = function(obj, eve, func){
	/*	이벤트 등록 처리를 한다.
			MSIE와 기타 브라우저의 이벤트 적용 함수가 틀리다.
			크로스 브라우징을 위해서 지원하는 기능
	*/
	var info = jutil.BWInfo();

	if(info.name == "MSIE"){	obj.attachEvent(eve, func);									}
	else{						obj.addEventListener(eve.replace(/on/gi, ""), func, false);	}
}


jutil.eventRemove = function(obj, eve, func){
	/*	이벤트 제거 처리를 한다.
			MSIE와 기타 브라우저의 이벤트 적용 함수가 틀리다.
			크로스 브라우징을 위해서 지원하는 기능
	*/
	var info = jutil.BWInfo();

	if(info.name == "MSIE"){	obj.detachEvent(eve, func);										}
	else{						obj.removeEventListener(eve.replace(/on/gi, ""), func, false);	}
}




jutil.BWInfoSave	= null;
jutil.BWInfo = function(){
	/*	사용자의 브라우저 정보를 반환한다.
	*/
	if(jutil.BWInfoSave != null){	return jutil.BWInfoSave;	}

	var name	= "";
	var version	= "";
	var strUA	= navigator.userAgent;

	// IE 검증
	var s = "MSIE";
	if((i = strUA.indexOf(s)) >= 0){
		name = "MSIE";			version = parseFloat(strUA.substr(i + s.length));
	}

	// 넷스케이프 검증
	var s = "Netscape6/";
	if((i = strUA.indexOf(s)) >= 0){
		name = "NETSCAPE6";		version = parseFloat(strUA.substr(i + s.length));
	}

	// Gecko 검증. Firefox 포함
	var s = "Gecko/";
	if((i = strUA.indexOf(s)) >= 0){
		name = "GECKO";			version = parseFloat(strUA.substr(i + s.length));
	}

	// 리턴
	jutil.BWInfoSave = { "name" : name, "version" : version	}
	return jutil.BWInfoSave;
}



jutil.objInfo = function(parentName, obj, step_){
	/*	오브젝트의 기본 구조 정보를 반환한다.
	*/
	var rv		= new Array();
	var step	= (typeof(step_) != "number") ? 0 : step_;

	try{
		// style 키값을 검증해서 해당 키가 존재하면 HTML 오브젝트로 간주하고 넘어간다. 
		if(obj.style){	return rv;	}

		// 정보수집
		for(var key in obj){
			rv.push({
				"obj"		: obj, 
				"name_full"	: parentName + "." + key, 
				"name"		: key, 
				"type"		: typeof(obj[key]), 
				"data"		: obj[key], 
				"step"		: step, 
				"sub"		: null 
			});

			if(typeof(obj[key]) == "object" && key != "global"){
				rv[rv.length-1]["sub"] = jutil.objInfo(parentName + "." + key, obj[key], step+1);
			}
		}
	}catch(ex){
		// firefox에서는 세부정보까지 획득하려 하다가 Permission denied 가 발생한다. => XMLHttpRequest.channel 정보를 획득할때
		//jutil.error("jutil.objInfo 에서 장애가 발생했습니다.", ex);
	}

	return rv;
}


jutil.baseInfoData	= null;
jutil.baseInfo = function(id_tree, id_help, name_, obj_){
	/*	jutil의 기본 구조정보를 보여준다.
	*/
	var name		= name_ ? name_ : "jutil";
	var obj			= obj_ ? obj_ : jutil;
	var treeArea	= jutil.e(id_tree);

	jutil.widget.tree.clear(id_tree);
	jutil.baseInfoData	= null;
	jutil.baseInfoData	= rebuild(jutil.objInfo(name, obj));

	try{
		for(var i=0 ; i < jutil.baseInfoData.length ; i++){
			var objHeader	= document.createElement("DIV");
			//var up_item		= jutil.baseInfoData[i]["name_full"].substring(0, jutil.baseInfoData[i]["name_full"].indexOf(jutil.baseInfoData[i]["name"]) - 1);
			var up_item		= jutil.baseInfoData[i]["name_full"].substring(0, jutil.baseInfoData[i]["name_full"].length - jutil.baseInfoData[i]["name"].length - 1);
			objHeader.setAttribute("id", jutil.baseInfoData[i]["name_full"]);
			objHeader.innerHTML	=	"<span onclick=\"jutil.baseInfoView('" + id_help + "', " + i + ")\" style='cursor:pointer; font-size:8pt;'>" + 
									"	<span style='color:red;'>" + jutil.baseInfoData[i]["name"] + "</span> " + "<span style='color:blue;'>[" + jutil.baseInfoData[i]["type"] + "]</span>" + 
									"</span>";
			treeArea.appendChild(objHeader);

			jutil.widget.tree.add({
				"id_area"		: id_tree, 
				"item"			: objHeader.id, 
				"item_up"		: (up_item == name ? "" : up_item), 
				"width"			: "300", 
				"sub_display"	: "no" 
			});
		}
	}catch(ex){
		jutil.error("jutil.baseInfo 에서 장애가 발생했습니다.", ex);
	}


	function rebuild(info){
		/*	전달받은 오브젝트의 정보를 재구성한다.
		*/
		var rv		= Array();
		var name	= Array();
		for(var i=0 ; i < info.length ; i++){	name.push(info[i]["name"]);	}
		name.sort(resort);

		for(var i=0 ; i < name.length ; i++){
			for(var j=0 ; j < info.length ; j++){
				if(name[i] == info[j]["name"]){
					rv.push(info[j]);

					if(info[j]["sub"] != null){
						rv = rv.concat(rebuild(info[j]["sub"]));
					}
					break;
				}
			}
		}

		return rv;
	}


	function resort(a, b){
		/*	알파벳 순으로 재정열을 한다.
		*/
		if(a.length > 0 && b.length > 0 && a.charCodeAt(0) != b.charCodeAt(0)){	return a.charCodeAt(0) - b.charCodeAt(0);	}
		if(a.length > 1 && b.length > 1 && a.charCodeAt(1) != b.charCodeAt(1)){	return a.charCodeAt(1) - b.charCodeAt(1);	}
		if(a.length > 2 && b.length > 2 && a.charCodeAt(2) != b.charCodeAt(2)){	return a.charCodeAt(2) - b.charCodeAt(2);	}
		if(a.length > 3 && b.length > 3 && a.charCodeAt(3) != b.charCodeAt(3)){	return a.charCodeAt(3) - b.charCodeAt(3);	}
		if(a.length > 4 && b.length > 4 && a.charCodeAt(4) != b.charCodeAt(4)){	return a.charCodeAt(4) - b.charCodeAt(4);	}
		if(a.length > 5 && b.length > 5 && a.charCodeAt(5) != b.charCodeAt(5)){	return a.charCodeAt(5) - b.charCodeAt(5);	}
		if(a.length > 6 && b.length > 6 && a.charCodeAt(6) != b.charCodeAt(6)){	return a.charCodeAt(6) - b.charCodeAt(6);	}
		if(a.length > 7 && b.length > 7 && a.charCodeAt(7) != b.charCodeAt(7)){	return a.charCodeAt(7) - b.charCodeAt(7);	}
		if(a.length > 8 && b.length > 8 && a.charCodeAt(8) != b.charCodeAt(8)){	return a.charCodeAt(8) - b.charCodeAt(8);	}
		if(a.length > 9 && b.length > 9 && a.charCodeAt(9) != b.charCodeAt(9)){	return a.charCodeAt(9) - b.charCodeAt(9);	}
		if(a.length > 10 && b.length > 10 && a.charCodeAt(10) != b.charCodeAt(10)){	return a.charCodeAt(10) - b.charCodeAt(10);	}
		if(a.length > 11 && b.length > 11 && a.charCodeAt(11) != b.charCodeAt(11)){	return a.charCodeAt(11) - b.charCodeAt(11);	}
		if(a.length > 12 && b.length > 12 && a.charCodeAt(12) != b.charCodeAt(12)){	return a.charCodeAt(12) - b.charCodeAt(12);	}

		return a.length - b.length;
	}
}


jutil.baseInfoMake = function(name_){
	/*	오브젝트의 기본 정보를 보여준다.
			jutil.baseInfo 의 기능을 사용하면서 인터페이스만 구성한다.
	*/
	var name		= name_ ? name_ : "jutil";

	try{	var obj = eval(name);	}
	catch(ex){
		alert("jutil.baseInfoMake : " + name + "은 오브젝트가 아닙니다.");
		return;
	}

	if(!jutil.e("jutil_jutil_baseinfoMakeInput")){
		var objInput	= document.createElement("INPUT");
		objInput.id		= "jutil_jutil_baseinfoMakeInput";
		objInput.value	= name;
		jutil.global.document.body.appendChild(objInput);

		var objBtn		= document.createElement("BUTTON");
		//objBtn.onclick	= "jutil.baseInfoMake(jutil.e('jutil_jutil_baseinfoMakeInput').value)";
		jutil.eventAdd(objBtn, "onclick", jutil.baseInfoMakeBtnClick);
		objBtn.value	= "CHECK";
		document.body.appendChild(objBtn);

		var objTable	= jutil.dhtml.getTableObject("jutil_baseinfoMakeTable", 1, 2);
		document.body.appendChild(objTable);
		var objTds		= objTable.getElementsByTagName("TD");
		objTable.width	= "100%";
		objTable.border	= "1";
		objTds[0].width	= "350";
		objTds[0].bgColor	= "#FFFFFF";
		objTds[1].bgColor	= "#FFFFFF";
		objTds[0].vAlign	= "top";
		objTds[1].vAlign	= "top";
		jutil.baseInfo(objTds[0].id, objTds[1].id, name, obj);
	}else{
		jutil.baseInfo("jutil_baseinfoMakeTable_td_0_0", "jutil_baseinfoMakeTable_td_0_1", name, obj);
	}
	
}


jutil.baseInfoMakeBtnClick = function(){
	jutil.baseInfoMake(jutil.e("jutil_jutil_baseinfoMakeInput").value);
}


jutil.baseInfoView = function(id_help, idx){
	/*	jutil의 기본 구조정보의 상세정보를 보여준다.
	*/
	jutil.help(id_help, jutil.baseInfoData[idx]);
}


jutil.helpDom	= null;
jutil.help		= function(id_help, data){
	/*	각 기능에 대한 도움말을 구현한다.
	*/
	//for(var key in data){	alert(key);	}

	// 도움말 정보 로드
	if(jutil.helpDom == null){ jutil.helpDom = jutil.xml.getXmlInfo(jutil.getBaseUrl() + "HELP.xml").documentElement; }

	// 도움말 항목 선택 - 해당 항목이 없으면 null값을 리턴한다.
	var info = jutil.xml.selectSingleNode(jutil.helpDom, "info[@id='" + data["name_full"] + "']");

	// 도움말 내용 구성
	var arr = Array();

		// 기본정보 구성
		arr.push("<table cellpadding=5 cellspacing=0 border=0 width=100% bgcolor='#999999'>");
		arr.push("<tr bgcolor='#FFFFFF'><td style='font-family:돋움체; font-size:10pt; font-weight:bold;'>" + data["name_full"] + "</td></tr>");
		arr.push("</table>");


		// 도움말 정보가 존재하는 경우 도움말 정보 구성
		if(info != null){
			arr.push("<table cellpadding=5 cellspacing=1 border=0 width=100% bgcolor='#999999'>");
			arr.push("<tr bgcolor='#FFFFFF'><td style='font-family:돋움체; font-size:9pt; line-height:180%;' width=150>기능 및 목적</td>");
			arr.push("<td style='font-family:돋움체; font-size:9pt; line-height:180%;'>" + jutil.xml.getNodeValue(jutil.xml.selectSingleNode(info, "func"), 4) + "</td></tr>");
			arr.push("<tr bgcolor='#FFFFFF'><td style='font-family:돋움체; font-size:9pt; line-height:180%;'>참고사항</td>");
			arr.push("<td style='font-family:돋움체; font-size:9pt; line-height:180%;'>" + info.selectSingleNode("comments").text + "</td></tr>");
			arr.push("<tr bgcolor='#FFFFFF'><td style='font-family:돋움체; font-size:9pt; line-height:180%;'>파라미터</td>");
			arr.push("<td style='font-family:돋움체; font-size:9pt; line-height:180%'>" + info.selectSingleNode("parameter").text + "</td></tr>");
			arr.push("<tr bgcolor='#FFFFFF'><td style='font-family:돋움체; font-size:9pt; line-height:180%;'>히스토리</td>");
			arr.push("<td style='font-family:돋움체; font-size:9pt; line-height:180%;'>" + info.selectSingleNode("history").text + "</td></tr>");
			arr.push("</table><br>");
		}

		// 기본정보 구성
		arr.push("<table cellpadding=5 cellspacing=1 border=0 width=100% bgcolor='#999999'>");
		arr.push("<tr bgcolor='#FFFFFF'><td style='font-family:돋움체; font-size:9pt; line-height:180%;' width=150>full name</td>");
		arr.push("<td style='font-family:돋움체; font-size:9pt; line-height:180%;'>" + data["name_full"] + "</td></tr>");
		arr.push("<tr bgcolor='#FFFFFF'><td style='font-family:돋움체; font-size:9pt; line-height:180%;'>key</td>");
		arr.push("<td style='font-family:돋움체; font-size:9pt; line-height:180%;'>" + data["name"] + "</td></tr>");
		arr.push("<tr bgcolor='#FFFFFF'><td style='font-family:돋움체; font-size:9pt; line-height:180%;'>type</td>");
		arr.push("<td style='font-family:돋움체; font-size:9pt; line-height:180%;'>" + data["type"] + "</td></tr>");
		arr.push("<tr bgcolor='#FFFFFF'><td style='font-family:돋움체; font-size:9pt; line-height:180%;'>value</td>");
		arr.push("<td style='font-family:돋움체; font-size:9pt; line-height:180%;' nowrap>" + (data["data"] + "").replace(/</gi , "&lt").replace(/>/gi , "&gt").replace(/\n/gi, "<br>").replace(/\t/gi, "&nbsp;&nbsp;&nbsp;&nbsp;") + "</td></tr>");
		arr.push("</table>");


	jutil.e(id_help).innerHTML = arr.join("");
}



jutil.isObject = function(obj){
	/*	해당 항목이 오브젝트인지를 검증한다.
	*/
	return typeof(obj) == "object";
}


/**********************************************************************************************************************************************************************************
	jutil.xmlhttp 관련 기능 구현부
**********************************************************************************************************************************************************************************/
jutil.xmlhttp.xmlDom	= null;			// 마지막으로 전달 받은 XML 정보




jutil.xmlhttp.getXmlHttp = function(){
	/*	xml http 오브젝트를 반환한다. => 오브젝트가 생성되지 않았다면 오브젝트를 생성한다.
	*/
	try{				return new ActiveXObject("MSXML2.XMLHTTP");		}
	catch(e){
		try{			return new ActiveXObject("Microsoft.XMLHTTP");		}
		catch(e){
			try{		return new XMLHttpRequest();						}
			catch(e){	return null;										}
		}
	}
}





jutil.xmlhttp.request_url = function(url, is_async, user_fn, att_id){
	/*	해당 경로의 내용을 읽어서 해당 아이디에 내용을 붙여 넣거나 지정한 함수에 전달되는 파라미터로 처리하거나 읽어온 내용을 리턴한다.
			- url만 지정되어 있는 경우에는 내용을 비동기 방식으로 읽어서 리턴 시킨다.
			- user_fn이 지정된 경우에는 읽어온 내용을 user_fn의 파라미터로 실행시킨다.
			- att_id가 지정된 경우에는 해당 아이디의 오브젝트에 붙여 넣는다. => innerHTML로 적용
	*/
	var http			= jutil.xmlhttp.getXmlHttp();
	var responseText	= "";
	var is_async		= typeof(is_async) != "boolean" ? false : is_async;


	http.open("GET", url, is_async);

	if(is_async){	// 비동기 방식
		http.onreadystatechange = function(){
			if(http.readyState == 4){
				if(http.status == 200){
					try{
						// 전달받은 문자열로부터 xml object를 생성한다. => 반환값의 xml 구문을 검증하기 위해서임... requestXML을 사용하지 않고 requestText를 사용함.
						responseText = http.responseText;

						// 사용자 지정 함수 실행
						if(typeof(user_fn) == "function"){	user_fn(responseText);	}

						// 붙여넣기
						if(typeof(att_id) == "string" && att_id.length > 0){	jutil.e(att_id).innerHTML = responseText;	}
					}catch(ex){
						jutil.error("jutil.xmlhttp.request_url 에서 장애가 발생했습니다." , ex);
					}
				}else{	// 응답 실패
					jutil.error("jutil.xmlhttp.request_url : " + url + " 경로가 잘못되었습니다.");
				}
			}
		}

		http.send(null);
	}else{		// 동기 방식 - firefox에서는 동기방식에서는 onreadystatechange를 지원하지 않는다.
		http.send(null);

		try{
			// 전달받은 문자열로부터 xml object를 생성한다. => 반환값의 xml 구문을 검증하기 위해서임... requestXML을 사용하지 않고 requestText를 사용함.
			responseText = http.responseText;

			// 사용자 지정 함수 실행
			if(typeof(user_fn) == "function"){	user_fn(responseText);	}

			// 붙여넣기
			if(typeof(att_id) == "string" && att_id.length > 0){	jutil.e(att_id).innerHTML = responseText;	}
		}catch(ex){
			jutil.error("jutil.xmlhttp.request_url 에서 장애가 발생했습니다." , ex);
		}
	}

	// 읽어온 내용 리턴
	return responseText;
}



jutil.extend = function(func, name){
	/*	해당 함수를 전역함수로 확장한다.
		자주사용하는 함수는 전역함수로 확장해서 편이성을 확장한다.
	*/
	jutil.global[name] = func;
}



jutil.load_path	= "";
jutil.load = function(id, category, control, js_load){
	/*	해당 경로의 htm, js파일을 읽어온다.
			jutil.load_path 에 설정된 경로를 기본 경로로 사용한다.
			기존에 JS 파일이 존재하는 경우 삭제 시키고 다시 불러온다.
	*/
	var url = jutil.load_path + category + "/" + control;
	jutil.xmlhttp.request_url(url + ".htm", false, "", id);
	jutil.include_js(url + ".js");
}


jutil.vars.layers	= {};
jutil.layer_add = function(){
	/*	layer_view 함수에서 활용할 레이어를 등록한다.
			사용자 인터페이스를 컨트롤 하기 위한 함수
	*/
	if(!jutil.isObject(jutil.vars.layers[arguments[0]])){	jutil.vars.layers[arguments[0]] = {};	}

	for(var i=1 ; i < arguments.length ; i++){
		var obj = jutil.e(arguments[i]);
		jutil.vars.layers[arguments[0]][arguments[i]] = obj;
		obj.style.display	= "none";
	}
}

jutil.layer_view = function(key, view_id){
	/*	등록된 항목들 중에서 해당 항목을 보여주고 나머지는 숨긴다.
	*/
	var is_process = false;
	for(var id in jutil.vars.layers[key]){
		if(id == view_id){	is_process = true;	}
		jutil.vars.layers[key][id].style.display = (id == view_id) ? "" : "none";
	}

	if(!is_process){	jutil.error("jutil.layer_view : " + view_id + "항목은 등록되어 있지 않습니다.");	}
}


/**********************************************************************************************************************************************************************************
	필요라이브러리 include
**********************************************************************************************************************************************************************************/
jutil.loadBaseLib = function(){
	/*	필요한 기본 라이브러리를 로드 시킨다.
	*/
	try{
		jutil.include_path	= jutil.getBaseUrl();
		jutil.include("lib/XMLHTTP");
		jutil.include("lib/XML");
		jutil.include("lib/COOKIE");
		jutil.include("lib/DATASET");
		jutil.include("lib/DATETIME");
		jutil.include("lib/DHTML");
		jutil.include("lib/FORM");
		jutil.include("lib/ARRAY");
		jutil.include("lib/STRING");
		jutil.include("lib/UPLOAD");
		jutil.include("lib/VOD");
		jutil.include("widget/TREE");
		jutil.include("widget/TREE_HTML");
		jutil.include("widget/HELP");
		jutil.include("widget/LIST");
		jutil.include("widget/FILL");
		jutil.include("widget/ARRANGE1");
		jutil.include("widget/ARRANGE2");
		jutil.include("widget/ARRANGE_H1");
		jutil.include("widget/SKY_LOCATION");
		jutil.include("widget/POPUP");
		jutil.include("widget/CALENDAR");
		jutil.include("ext/loader");
		jutil.include("JUTIL_CONFIG");
	}catch(e){
		jutil.error("jutil.loadBaseLib : 기본라이브러리를 읽어오는데 실패했습니다.", e);
	}
}

//jutil.loadBaseLib();


/**********************************************************************************************************************************************************************************
	작성자 : 김기석
	작성일 : 2007.06.18

	목적 :
		- 웹 기반의 자바스크립트 유틸 모음
		- XMLHTTP 처리 관련 기능 모음

	참고사항 :
		- jutil에서 기본적으로 사용되어야 하는 기능 몇가지는 JUTIL.js에 포함시켜놓았다.
**********************************************************************************************************************************************************************************/


if(typeof(jutil) != "object"){			jutil			= {};	}
if(typeof(jutil.xmlhttp) != "object"){	jutil.xmlhttp	= {};	}


// 서버측에 요청하는 기본 경로 정보
jutil.xmlhttp.baseUrl	= "";



jutil.xmlhttp.post = function(url, info, is_async, user_fn){
	/*	일반폼의 post 방식으로 해당 정보를 요청한다.
			- 폼의 submit과 동일한 방식인가?
	*/
	var http		= jutil.xmlhttp.getXmlHttp();
	var sendData	= "";
	var sendDataArr	= Array();

	for(var key in info){
		sendDataArr.push(key + "=" + info[key]);
	}
	sendData = sendDataArr.join("&");

	http.open("POST", url, is_async);	// true : 비동기, false : 동기
	http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	if(is_async){		// 비동기 방식
		http.onreadystatechange	= function(){
			if(http.readyState == 4){
				if(http.status == 200){
					try{
						var result = http.responseText;

						// 사용자 지정 함수 실행
						if(result && typeof(user_fn) == "function"){	user_fn(result);	}
					}catch(ex){
						jutil.error("jutil.xmlhttp.post 에서 장애가 발생했습니다." , ex);
						jutil.xmlhttp.xmlDom = null;
					}
				}else{	// 응답 실패
					jutil.error("jutil.xmlhttp.post : " + url + " 경로가 잘못되었습니다.");
				}
			}
		}
		http.send(sendData);
	}else{				// 동기방식
		http.send(sendData);

		try{
			// 전달받은 문자열로부터 xml object를 생성한다. => 반환값의 xml 구문을 검증하기 위해서임... requestXML을 사용하지 않고 requestText를 사용함.
			var result = http.responseText;

			// 사용자 지정 함수 실행
			if(result && typeof(user_fn) == "function"){	user_fn(result);	}
			
			// 동기 방식인 경우 결과값 리턴
			return result;
		}catch(ex){
			jutil.error("jutil.xmlhttp.post 에서 장애가 발생했습니다." , ex);
		}
	}
}



jutil.xmlhttp.request = function(url, xmlDom, is_async, user_fn){
	/*	XML HTTP를 통해서 서버측에 데이터 요청을 한다.
			url			: 요청할 서버 경로
			xmlDom		: 요청시 같이 전송할 xml 문서
			is_async	: 요청방식 true => 비동기, false => 동기
			user_fn		: 요청이 완료된후 실행할 사용자 정의 함수

			한글처리에서 장애가 발생하는 경우 다음과 같이 인코딩과 문자셋을 조정해서 컨트롤 한다.
				req.setRequestHeader("encoding","ks_c_5601-1987");
				req.setRequestHeader("Content-Type","text/xml; charset='ks_c_5601-1987'");

				//xmlhttp.onreadystatechange	= Function("this.set_onreadystatechange_handle('" + user_fn + "');");
	*/
	var http = jutil.xmlhttp.getXmlHttp();

	http.open("POST", url, is_async);	// true : 비동기, false : 동기

	if(is_async){		// 비동기 방식
		http.onreadystatechange	= function(){
			if(http.readyState == 4){
				if(http.status == 200){
					try{
						// 전달받은 문자열로부터 xml object를 생성한다. => 반환값의 xml 구문을 검증하기 위해서임... requestXML을 사용하지 않고 requestText를 사용함.
						var objXml = jutil.xml.getXmlInfo(http.responseText, "string");

						// xml object의 document element를 맴버변수에 할당한다. - 확장 기능외에 추가적으로 기능구현이 필요한 경우에 사용. 비동기 방식으로 처리를 할 경우 비정상적인 데이터를 얻을 수 있다.
						jutil.xmlhttp.xmlDom = objXml.documentElement;

						// 사용자 지정 함수 실행
						if(objXml != null && typeof(user_fn) == "function"){	user_fn(objXml.documentElement);	}
					}catch(ex){
						jutil.error("jutil.xmlhttp.request 에서 장애가 발생했습니다." , ex);
						jutil.xmlhttp.xmlDom = null;
					}
				}else{	// 응답 실패
					jutil.error("jutil.xmlhttp.request : " + url + " 경로가 잘못되었습니다.");
				}
			}
		}
		http.send(xmlDom);
	}else{				// 동기방식
		http.send(xmlDom);

		try{
			// 전달받은 문자열로부터 xml object를 생성한다. => 반환값의 xml 구문을 검증하기 위해서임... requestXML을 사용하지 않고 requestText를 사용함.
			var objXml = jutil.xml.getXmlInfo(http.responseText, "string");

			// xml object의 document element를 맴버변수에 할당한다. - 확장 기능외에 추가적으로 기능구현이 필요한 경우에 사용. 비동기 방식으로 처리를 할 경우 비정상적인 데이터를 얻을 수 있다.
			jutil.xmlhttp.xmlDom = objXml.documentElement;

			// 사용자 지정 함수 실행
			if(objXml != null && typeof(user_fn) == "function"){	user_fn(objXml.documentElement);	}
		}catch(ex){
			jutil.error("jutil.xmlhttp.request_url 에서 장애가 발생했습니다." , ex);
		}
	}
}


jutil.xmlhttp.requestCommon = function(info, is_async, user_fn, is_alert_){
	/*	서버측에 데이터 요청 및 처리 요청을 한다.
			info의 구성요소에는 반드시 svc_id 항목이 존재 해야 한다.
			jutil.xml.getXmlInfoBasePath 에 설정되어 있는 경로를 기본 경로로 클라이언트측 경로를 설정한다.
	*/
	var requestXML = jutil.xml.getXmlRebuild(info, jutil.xml.getXmlInfoBase(info["svc_id"]));
	if(is_alert_){	alert(jutil.xml.serializeToString(requestXML));	}
	jutil.xmlhttp.request(jutil.xmlhttp.baseUrl, requestXML, is_async, user_fn);
}


/**********************************************************************************************************************************************************************************
	작성자 : 김기석
	작성일 : 2007.06.18

	목적 :
		- 웹 기반의 자바스크립트 유틸 모음
		- XML 처리 관련 기능 모음

	참고사항 :
		- 
**********************************************************************************************************************************************************************************/


if(typeof(jutil) != "object"){		jutil			= {};	}
if(typeof(jutil.xml) != "object"){	jutil.xml		= {};	}



jutil.xml.getXmlDomId = ["Msxml2.DOMDocument.5.0", "msxml2.domdocument.4.0", "Msxml2.DOMDocument.3.0", "Msxml2.DOMDocument", "Microsoft.DOMDocument"];
jutil.xml.getXmlDom = function(){
	/*	xml document object 를 생성해서 반환한다.
	*/
	var objXml = null;

	if(typeof(ActiveXObject) == "function"){
		for(var i=0 ; i < jutil.xml.getXmlDomId.length ; i++){ 
			try{			objXml = new ActiveXObject(jutil.xml.getXmlDomId[i]);	}
			catch(ex){}

			if(objXml != null){		return objXml;	}
		}

		if(objXml == null){	jutil.error("jutil.xml.getXmlDom 에서 오브젝트를 생성하지 못했습니다.");	}
	}else{
		try{
			objXml = jutil.global.document.implementation.createDocument("", "", null);
		}catch(ex){
			jutil.error("jutil.xml.getXmlDom 에서 오브젝트를 생성하지 못했습니다.", ex);
		}
	}

	return objXml;
}


jutil.xml.getXmlInfo = function(strXML, opt_){
	/*	xml 파일로부터 내용을 읽거나, xml 문자열로부터 XML 정보를 구성해서 XML DOM을 반환한다.
			- strXML		: xml파일의 위치 정보 또는 xml 정보 문자열
			- opt_			: strXML 파라미터의 정보가 xml정보 문자열인지 xml 오브젝트인지를 지정. string,object
			- is_alert_		: 파싱 에러가 발생했을 경우에는 해당 에러 메세지를 출력할지 여부를 설정. true, false
		참고사항
			- 파일에서 읽어올 경우 XML 문서는 UTF8로 구성되어 있어야 한글처리에서 문제가 발생하지 않는다.
	*/
	// 파라미터 정리
	var opt			= (opt_) ? opt_ : "object";

	// xml 데이터 로드
	var objXml		= jutil.xml.getXmlDom();

	if(typeof(ActiveXObject) == "function"){			// 익스플로어
		objXml.async	= false;								// sync 옵션 설정. 동기화
		if(opt == "string"){	objXml.loadXML(strXML);		}	// 문자열을 xml object에 로드한다.
		else{					objXml.load(strXML);		}	// xml 파일을 xml object에 로드한다.

		// 파서의 에러 체크
		if(objXml.parseError.errorCode != 0){
			jutil.error("jutil.xml.getXmlInfo : " + objXml.parseError.reason + "\n\n" + objXml.parseError.srcText + "\n\n\n\n" + strXML);
			return null;
		}
	}else{												// 넷스케이프, 파이어폭스
		try{
			// 옵션이 string이 아니라면 실제 내용을 xmlhttp를 통해서 읽어온다.
			if(opt != "string"){	strXML = jutil.xmlhttp.request_url(strXML);	}
			var xmlParser	= new DOMParser();
			objXml			= xmlParser.parseFromString(strXML, "text/xml");
			delete xmlParser;
		}catch(ex){
			jutil.error("jutil.xml.getXmlInfo", ex);
		}
	}

	if(objXml == null){
		jutil.error("jutil.xml.getXmlInfo : XML 정보를 획득하는데 실패했습니다.");
	}



	// xml정보 반환
	return objXml;
}



jutil.xml.getXmlToObject = function(node, step_){
	/*	XML 데이터를 object 방식의 데이터를 전환해서 반환한다.
			- 반환되는 오브젝트의 구조가 복잡하므로 유의해서 살펴봐야 한다. 
			- 배열과 키의 조합
			- items는 고정되어서 사용되는 키값이다.
			- 실제 코드에서 별 도움이 되지 않을듯 하다
			- 가급적이면 사용하지 않는것이 좋다.
	*/
	var step		= (typeof(step_) == "number") ? step_ : 1;
	var obj			= {};
	var nodes		= jutil.xml.childNodes(node);
	var tagnames	= jutil.xml.getTagNames(node);


	// 최초접근에 대한 처리
	if(step == 1){
		obj[node.tagName]	= Array();
		var attrs			= node.attributes;
		var info			= {};

		// 속성 등록
		for(var i=0 ; i < attrs.length ; i++){	info[attrs[i].nodeName] = attrs[i].nodeValue;	}
		info.items	= Array();	// items 항목은 내부적으로 고정시켜서 사용한다.
		info.items.push(jutil.xml.getXmlToObject(node, step+1));
		obj[node.tagName].push(info);
	}else{
		for(var i=0 ; i < tagnames.length ; i++){
			obj[tagnames[i]] = Array();
		}


		for(var i=0 ; i < nodes.length ; i++){
			var child_cnt	= jutil.xml.childNodes(nodes[i]).length;
			var attrs		= nodes[i].attributes;
			var info		= {};

			// 속성 등록
			for(var j=0 ; j < attrs.length ; j++){	info[attrs[j].nodeName] = attrs[j].nodeValue;	}
			info.items	= Array();	// items 항목은 내부적으로 고정시켜서 사용한다.

			if(child_cnt > 0){
				info.items.push(jutil.xml.getXmlToObject(nodes[i], step+1));
				obj[nodes[i].tagName].push(info);
			}else{				obj[nodes[i].tagName]	= jutil.xml.getNodeValue(nodes[i]);		}		
		}
	}


	return obj;
}


jutil.xml.getNodeSearchs = function(XmlElement, searchTagName, searchValue, returnTagName){
	/*	해당 노드의 하위 노드중에서 해당 태그의 값이 검색하는 값과 일치하는 해당 노드들을 반환한다.
	*/
	var rv = jutil.xml.getNode(returnTagName);
	var datas	= jutil.xml.childNodes(XmlElement);

	for(var i=0 ; i < datas.length ; i++){
		if(jutil.xml.selectSingleNodeValue(datas[i], searchTagName) == searchValue){
			rv.appendChild(datas[i].cloneNode(true));
		}
	}
	return rv;
}


jutil.xml.getNodeSearch = function(XmlElement, searchTagName, searchValue){
	/*	해당 노드의 하위 노드중에서 해당 태그의 값이 검색하는 값과 일치하면 해당 노드를 반환한다.
	*/
	var nodes = jutil.xml.childNodes(XmlElement);

	for(var i=0 ; i < nodes.length ; i++){
		if(jutil.xml.selectSingleNodeValue(nodes[i], searchTagName) == searchValue){
			return nodes[i];
		}
	}
	return null;
}


jutil.xml.getNodeSearchValue = function(XmlElement, searchTagName, searchValue, targetTagName){
	/*	해당 노드의 하위 노드중에서 해당 태그의 값이 검색하는 값인 경우 해당 타겟 노드의 값을 반환한다.
	*/
	var node = jutil.xml.getNodeSearch(XmlElement, searchTagName, searchValue);
	return node == null ? "" : jutil.xml.selectSingleNodeValue(node, targetTagName);
}





jutil.xml.serializeToString = function(objXml){
	/*	XML 오브젝트를 받아서 문자열을 반환한다.
			- IE에서는 그냥 .xml로 처리가 되지만 타 브라우저에서는 serializeToString를 사용해야 한다.
	*/
	if(jutil.BWInfo().name == "MSIE"){	return objXml.xml;		}
	else{
		var serializer = new XMLSerializer();
		xml = serializer.serializeToString(objXml);
		delete serializer;
		return xml;
	}
}



jutil.xml.childNodes = function(node, nodeType_){
	/*	해당 노드에서 지정한 노드타입의 하위 노드들을 배열로 반환한다.
			nodeType
				1 : XMLElement
	*/
	var nodeType	= (nodeType_) ? nodeType_ : 1;
	var rv = Array();

	for(var i=0 ; i < node.childNodes.length ; i++){
		if(node.childNodes[i].nodeType == nodeType){	rv.push(node.childNodes[i]);	}
	}
	return rv;
}




jutil.xml.selectSingleNode = function(node, path){
	/*	해당 path의 노드를 반환한다. - IE에서만 selectSingleNode를 지원하기 때문에 따로 기능을 구현한다.
			- IE를 기준으로 기능을 구현한다.
			- IE 방식의 코딩을 유지할 경우에 필요하다.
			- path에서 attribute를 지정하지 않으면 selectNode에서 반환된 값의 첫번째 항목의 값을 반환한다.
	*/
	if(path.indexOf("[") < 0){
		var nodes = jutil.xml.selectNode(node, path);

		if(nodes.length > 0){	return nodes[0];	}
		else{					return null;		}
	}else{
		var tags	= path.substring(0, path.indexOf("["));
		var attrs	= path.substring(path.indexOf("[") + 2, path.indexOf("]")).replace(/\'/gi, "").replace(/\"/gi, "").split("&");
		var nodes	= jutil.xml.selectNode(node, tags);

		for(var i=0 ; i < nodes.length ; i++){
			var check_value	= true;
			for(var j=0 ; j < attrs.length ; j++){
				var attr = attrs[j].split("=");
				if(nodes[i].getAttribute(attr[0]) != attr[1]){	check_value = false;	}
			}
			if(check_value){	return nodes[i];	}
		}
		return null;
	}
}


jutil.xml.selectSingleNodeValue = function(node, path){
	/*	해당 path의 노드의 값을 반환한다.
			- IE를 기준으로 기능을 구현한다.
			- IE 방식의 코딩을 유지할 경우에 필요하다.
			- path에서 attribute를 지정하지 않으면 selectNode에서 반환된 값의 첫번째 항목의 값을 반환한다.
	*/
	var n = jutil.xml.selectSingleNode(node, path);
	return jutil.xml.getNodeValue(n);
}


jutil.xml.selectNode = function(XmlElement, path){
	/*	해당 path의 노드를 배열로 반환한다. - IE에서만 selectNode를 지원하기 때문에 따로 기능을 구현한다.
			- IE를 기준으로 기능을 구현한다.
			- IE 방식의 코딩을 유지할 경우에 필요하다.
	*/
	var rv		= Array();
	var tags	= path.split("/");
	var nodes	= selectNodePath(XmlElement, tags);

	for(var i=0 ; i < nodes.length ; i++){
		if(nodes[i].tagName == tags[tags.length-1]){	rv.push(nodes[i]);	}
	}
	return rv;



	/*	해당 태그 목록의 모든 노드를 반환한다.
	*/
	function selectNodePath(XmlElement, tags, idx_){
		var idx		= (idx_) ? idx_ : 0;
		var nodes	= selectNodeFromTagName(XmlElement, tags[idx]);
		var rv		= nodes;
		if(idx < tags.length){
			for(var i=0 ; i < nodes.length ; i++){	rv = rv.concat(selectNodePath(nodes[i], tags, idx+1));	}
		}

		return rv;
	}


	/*	해당 XML Element의 바로 밑의 하위 요소중에서 해당 태그이름의 요소를 반환한다.
			- 2개 이상의 값이 존재한다면 첫번째 값만을 반환한다.
	*/
	function selectNodeFromTagName(XmlElement, tagName){
		var rv = Array();
		for(var i=0 ; i < XmlElement.childNodes.length ; i++){
			if(XmlElement.childNodes[i].nodeType == 1){
				if(XmlElement.childNodes[i].tagName == tagName){	rv.push(XmlElement.childNodes[i]);	}
			}
		}
		return rv;
	}
}



jutil.xml.getXmlInfoBasePath = "./";	// 기본 경로
jutil.xml.getXmlInfoBase = function(path){
	/*	jutil.xml.getXmlInfo 와 동일하지만 지정된 경로에 존재하는 XML 파일의 정보를 읽어온다.
			- 일반적으로 XML파일은 동일장소에 모아두고 사용하므로 기능을 확장해 놓는다.
			- 경로정보는 일반 경로구분인 / 문자를 사용한다. "."문자로 진행하려고 했지만 파일명에 .존재하면 문제가 생긴다.
	*/
	return jutil.xml.getXmlInfo(jutil.xml.getXmlInfoBasePath + path + ".xml", "object");
}


jutil.xml.getTagNames = function(node){
	/*	해당 노드의 하위 태그 목록을 배열로 반환한다.
	*/
	var rv = Array();
	var nodes	= jutil.xml.childNodes(node);
	for(var i=0 ; i < nodes.length ; i++){	rv.push(nodes[i].tagName);	}
	return rv;
}



jutil.xml.getNodeValue = function(node, nodeType){
	/*	해당 노드의 해당 타입의 값을 반환한다.
			- 동일타입이 여러개 있을 경우에는 첫번쨰 항목의 값을 반환한다.
			- nodeType 정보
				3 : 일반텍스트
				4 : CDATA
			- nodeType을 지정하지 않은 경우에는 CDATA가 존재하면 CDATA를 반환하고, 아니면 일반 텍스트 노드에서 값을 반환한다.
	*/
	if(nodeType){
		for(var i=0 ; i < node.childNodes.length ; i++){
			//alert(node.childNodes[i].nodeType + " : " + node.childNodes[i].nodeValue);
			if(node.childNodes[i].nodeType == nodeType){	return node.childNodes[i].nodeValue;	}
		}
	}else{	return jutil.xml.getNodeValue(node, jutil.xml.hasCDATA(node) ? 4 : 3);	}
	return null;
}


jutil.xml.setNodeValue = function(node, value, nodeType){
	/*	해당 노드의 값을 변경한다.
			- nodeType 정보
				3 : 일반텍스트
				4 : CDATA
			- nodeType을 지정하지 않은 경우에는 CDATA가 존재하면 CDATA를 변경하고, 아니면 일반 텍스트를 변경한다.
	*/
	if(nodeType){
		if(node.childNodes.length > 0){
			for(var i=0 ; i < node.childNodes.length ; i++){
				if(node.childNodes[i].nodeType == nodeType){	node.childNodes[i].nodeValue = value;	}
			}
		}else{	node.appendChild(jutil.xml.getXmlDom().createCDATASection(value));	}
	}else{	return jutil.xml.setNodeValue(node, value, jutil.xml.hasCDATA(node) ? 4 : 3);	}
	return node;
}


jutil.xml.hasCDATA = function(node){
	/*	해당 노드가 CDATA 노드를 가지고 있는지 여부를 반환한다.
	*/
	for(var i=0 ; i < node.childNodes.length ; i++){	if(node.childNodes[i].nodeType == 4){	return true;	}	}
	return false;
}



jutil.xml.getNode = function(tagName, value_){
	/*	일반 XmlElement를 생성해서 반환한다.
	*/
	var xmlDoc			= jutil.xml.getXmlDom();
	var node			= xmlDoc.createElement(tagName);
	if(value_){	node.appendChild(value_);	}
	return node;
}


jutil.xml.getCdataNode = function(tagName, text){
	/*	일반 CDATA 노드를 생성해서 반환한다.
	*/
	var xmlDoc			= jutil.xml.getXmlDom();
	var node			= xmlDoc.createElement(tagName);
	var cdataSection	= xmlDoc.createCDATASection(text);
	node.appendChild(cdataSection);
	return node;
}


jutil.xml.convertWinStr = function(str){
	/*	윈도우의 엑셀이나 워드 프로그램에서 특정 문자셋이 올경우 서버측에서 문자열 처리에서 에러가 발생한다. 
			- 서버측에서 처리하지 않고 스크립트단에서 문자열을 제거한다.
			- 일단은 해당 코드를 모두 처리하는 방식으로 구성한다.
			- 39번이 싱글 쿼테이션이다. => 이부분은 스킵을 하고 넘어가도록 한다. => 현재함수에 오기 전에 앞단에서 처리해줘야 한다.

			- 전송되는 XML 정보는 UTF-8이고 서버측에서는 iconv를 사용하해서 euc-kr로 변환할때 에러가 발생하게 된다.
			- 또한 실제 윈도우의 문자셋에서도 에러가 발생한다.
			- 위와 같은 문제가 발생하는 문자코드는 무시하고 전송하도록 문자열을 재구성한다.
	*/
		var rv	= "";
		var str	= str + "";

		for(var i=0 ; i < str.length ; i++){
			//alert(str.charCodeAt(i) + "=>" + str.substring(0, i+1));

			var ascii_code = str.charCodeAt(i);

			// 허용가능 문자 체크
			if(
				(ascii_code >= 48 && ascii_code <= 57) ||	// 숫자
				(ascii_code >= 65 && ascii_code <= 90) ||	// 영어 - 대문자
				(ascii_code >= 97 && ascii_code <= 122) ||	// 영어 - 소문자
				(ascii_code >= 33 && ascii_code <= 47) ||	// 특수문자
				(ascii_code >= 58 && ascii_code <= 64) ||
				(ascii_code >= 91 && ascii_code <= 96) ||
				(ascii_code >= 123 && ascii_code <= 126) || 
				(ascii_code >= 9312 && ascii_code <= 9326) ||	// 원 숫자
				(ascii_code >= 9332 && ascii_code <= 9346) ||	// 괄호 숫자
				(ascii_code >= 9372 && ascii_code <= 9397) ||	// 괄호 영어 소문자
				(ascii_code >= 9424 && ascii_code <= 9449) ||	// 원문자 영어 소문자
				(ascii_code >= 9635 && ascii_code <= 9641) || (ascii_code == 9632) ||	// 네모
				ascii_code == 9650 || ascii_code == 9651 ||	ascii_code == 9654 || ascii_code == 9655 ||	ascii_code == 9660 || ascii_code == 9661 ||	ascii_code == 9664 ||	ascii_code == 9665 ||	// 삼각형
				(ascii_code >= 9670 && ascii_code <= 9672) ||	// 마름모
				(ascii_code >= 9678 && ascii_code <= 9681) || (ascii_code == 9675) ||	// 원
				(ascii_code >= 9824 && ascii_code <= 9837) ||	// 기타도형
				(ascii_code >= 12593 && ascii_code <= 12686) ||	// 한글 - 조합
				(ascii_code >= 12800 && ascii_code <= 12828) ||	// 한글 - 괄호
				(ascii_code >= 12896 && ascii_code <= 12923) ||	// 한글 - 원
				(ascii_code >= 44032 && ascii_code <= 55203) ||	// 한글 - 완성
				ascii_code == 32 || ascii_code == 10 || ascii_code == 9			// 스페이스, 리턴, 탭
			){
				rv += str.substring(i, i+1);
			}
		}

		return rv;
}




jutil.xml.getXmlRebuild = function(infoArr, requestXML){
	/*	오브젝트와 XML DOM을 받아서 오브젝트의 정보를 XML DOM에 채워서 반환한다. 서버로 xml 정보를 전송하기 전에 데이터를 채워 넣을 경우에 필요
			- client 측 XML 파일을 컨트롤 하기 위한 확장 기능
	*/
	try{
		var DOM = requestXML.documentElement;
		var DOM_RemoveNodes	= Array();
		var DOM_AddNodes	= Array();


		// 윈도우 특수문자 처리 - 서버측 문자열 처리와 createCDATASection 문자열 처리를 함께 커버한다.
		for(var key in infoArr){
			infoArr[key] = typeof(infoArr[key]) == "object" ? infoArr[key] : jutil.xml.convertWinStr(infoArr[key]);
		}

		var infos = jutil.xml.childNodes(DOM);
		for(var i=0 ; i < infos.length ; i++){
			var info = infos[i];

			if(infos[i].getAttribute("is_loop") != "yes"){				// 단일 실행 처리
				var infoNodes = jutil.xml.childNodes(info);

				for(var j=0 ; j < infoNodes.length ; j++){
					var node	= infoNodes[j];
					var tagName	= node.tagName;

					switch(node.getAttribute("type")){
						case "attribute" :		// 배열에서 읽어오기
							var text	= infoArr[tagName];
							if(text != null){
								//node.text	= (text.length == 0) ? node.getAttribute("default") : text;
								var value = (text.length == 0) ? node.getAttribute("default") : text;
								var cdataSection = requestXML.createCDATASection(value);

								node.text = "";
								node.appendChild(cdataSection);
							}else{
								if(typeof(node.getAttribute("default")) == "string"){
									//node.text = node.getAttribute("default");
									//var value = (text.length == 0) ? node.getAttribute("default") : text;
									var cdataSection = requestXML.createCDATASection(node.getAttribute("default"));
									node.text = "";
									node.appendChild(cdataSection);
								}else{
									alert(tagName + "의 값을 구성하는데 장애가 발생했습니다.");
								}
							}

							break;
						case "user_fn" :		// 사용자가 지정한 함수를 통해서 값을 획득하기
							try{
								var text	= eval(node.getAttribute("user_fn") + "(infoArr)");
								node.text	= (!text) ? node.getAttribute("default") : text;
							}catch(ex){
								jutil.error("jutil.xml.getXmlRebuild : " + node.getAttribute("user_fn"), ex);
							}
							break;
					}
				}
			}else{													// 다중 실행 처리
				// 루프의 수를 계산한다.
				var infoNodes	= jutil.xml.childNodes(info);
				var loop		= 0;

				for(var j=0 ; j < infoNodes.length ; j++){
					var node	= infoNodes[j];
					var tagName	= node.tagName;

					if(node.getAttribute("type") == "attribute" && node.getAttribute("is_loop") == "yes"){
						if(typeof(infoArr[tagName]) == "object"){
							loop = infoArr[tagName].length;
							j = infoNodes.length;
						}
					}
				}

				// 루프의 수가 0인 경우 해당 info 노드를 제거하고, 아니면, 해당 횟수만큼 info 노드를 생성한다.
				if(loop == 0){
					DOM_RemoveNodes[DOM_RemoveNodes.length] = info;
				}else{
					for(var j=0 ; j < loop ; j++){
						// 원본의 복사본 생성
						var infoClone		= info.cloneNode(true);
						var infoCloneNodes	= jutil.xml.childNodes(infoClone);

						for(var k=0 ; k < infoCloneNodes.length ; k++){
							var node	= infoCloneNodes[k];
							var tagName	= node.tagName;

							switch(node.getAttribute("type")){
								case "attribute" :		// 배열에서 읽어오기
									var text	= (typeof(infoArr[tagName]) == "object") ? infoArr[tagName][j] : infoArr[tagName];

									if(text != null){
										//node.text	= (text.length == 0) ? node.getAttribute("default") : text;
										var value = (text.length == 0) ? node.getAttribute("default") : text;
										var cdataSection = requestXML.createCDATASection(value);
										node.text = "";
										node.appendChild(cdataSection);
									}else{
										if(node.getAttribute("default")){
											//node.text = node.getAttribute("default");
											//var value = (text.length == 0) ? node.getAttribute("default") : text;
											var cdataSection = requestXML.createCDATASection(node.getAttribute("default"));
											node.text = "";
											node.appendChild(cdataSection);
										}else{
											alert(tagName + "의 값을 구성하는데 장애가 발생했습니다.");
										}
									}

									break;
								case "user_fn" :		// 사용자가 지정한 함수를 통해서 값을 획득하기
									var text	= eval(node.getAttribute("user_fn") + "(infoArr)");
									node.text	= (!text) ? node.getAttribute("default") : text;
									break;
							}
						}
						DOM_AddNodes[DOM_AddNodes.length] = infoClone;
					}

					// 원본구조정보 노드를 삭제 정보에 추가 처리
					DOM_RemoveNodes[DOM_RemoveNodes.length] = info;
				}			
			}
		}



		// 노드 재정리
		for(var i=0 ; i < DOM_AddNodes.length ; i++){		DOM.appendChild(DOM_AddNodes[i]);		}
		for(var i=0 ; i < DOM_RemoveNodes.length ; i++){	DOM.removeChild(DOM_RemoveNodes[i]);	}

		// 값 반환
		return requestXML;
	}catch(ex){
		jutil.error("jutil.xml.getXmlRebuild", ex);
	}
}


/**********************************************************************************************************************************************************************************
	작성자 : 김기석
	작성일 : 2007.06.18

	목적 :
		- 웹 기반의 자바스크립트 유틸 모음
		- 쿠키 처리 관련 기능 모음

	참고사항 :
		- 
**********************************************************************************************************************************************************************************/


if(typeof(jutil) != "object"){			jutil			= {};	}
if(typeof(jutil.cookie) != "object"){	jutil.cookie	= {};	}



jutil.cookie.set_cookie = function (name, value, expireSec_, domain_){
	/*	쿠키를 설정한다.
			- 쿠키의 유효기간은 초단위로 설정한다.
			- 쿠키의 유효기간을 지정하지 않으면 브라우저를 닫을때까지 유지가 된다.
			- 자바에서 설정한 쿠키의 경우 decodeURIComponent를 활용해야 한다. 서버측에서는 utf-8로 설정한 경우
	*/
	// 쿠키에 적용되는 문자열 구성
	var cookie_str = name + "=" + escape(value) + "; path=/;";
	//var cookie_str = name + "=" + value + "; path=/;";


	// domain 설정
	if(typeof(domain_) == "string" || typeof(domain_) == "number"){
		cookie_str += " domain=" + domain_ + ";";
	}


	// expire 설정
	if(typeof(expireSec_) == "string" || typeof(expireSec_) == "number"){
		var todayDate = new Date();
		todayDate.setSeconds(todayDate.getSeconds() + expireSec_);
		cookie_str += " expires=" + todayDate.toGMTString() + ";";
	}


	// 쿠키설정
	document.cookie = cookie_str;
}



jutil.cookie.get_cookie = function(name){
	/*	쿠키의 값을 반환한다.
	*/
	// 해당 이름의 쿠키값의 시작 위치를 찾고 없으면 공백 문자를 리턴한다.
	var pos_s = document.cookie.indexOf(name + "=");
	if(document.cookie.indexOf(name + "=") < 0){	return "";	}


	// 해당 이름의 쿠키의 종료 값의 범위를 찾는다.
	var pos_e = document.cookie.indexOf(";", pos_s);
	if(pos_e < 0){	pos_e = document.cookie.length;		}		// 가장 마지막에 설정된 쿠키의 값


	// 쿠키의 값을 리턴
	return unescape(document.cookie.substring(pos_s + name.length + 1, pos_e));
}


/**********************************************************************************************************************************************************************************
	작성자 : 김기석
	작성일 : 2007.06.21

	목적 :
		- 웹 기반의 자바스크립트 유틸 모음
		- 서버측에 데이터 요청을 해서 받은 XML 정보를 컨트롤 하는 확장 함수 모음.

	참고사항 :
		- 서버측의 서비스 매니저에서 반환되는 데이터셋을 중심으로 구현
**********************************************************************************************************************************************************************************/


if(typeof(jutil) != "object"){			jutil			= {};	}
if(typeof(jutil.dataset) != "object"){	jutil.dataset	= {};	}


jutil.dataset.getDatasetList = function(DOM){
	/*	서버로부터 받은 데이터셋에서 데이터셋의 아이디 정보를 배열로 반환한다.
	*/
	var rv = Array();

	for(var i=0 ; i < DOM.childNodes.length ; i++){
		var result = DOM.childNodes[i];

		// 하위 노드가 result가 아니라면 다음 노드로 이동
		if(result.tagName != "result"){		continue;	}

		// result 노드의 하위노드(dataset)의 정보를 읽는다.
		for(var j=0 ; j < result.childNodes.length ; j++){
			var dataset = result.childNodes[j];
			if(dataset.tagName == "dataset"){	rv[rv.length] = dataset.getAttribute("id");	}
		}
	}

	// 데이터셋 목록을 반환
	return rv;
}


jutil.dataset.getDataset = function(DOM, dataset_id){
	/*	리턴된 XML DOCUMENT에서 지정된 아이디의 데이터셋을 반환한다.
			- 여러개의 result가 반환될 경우에도 사용가능
			- 단 모든 데이터셋의 아이디가 달라야 한다. 
			- 데이터셋의 아이디가 동일한 경우 처음 나오는 데이터셋을 반환한다.
	*/
	for(var i=0 ; i < DOM.childNodes.length ; i++){
		var result = DOM.childNodes[i];

		// 하위 노드가 result가 아니라면 다음 노드로 이동
		if(result.tagName != "result"){		continue;	}

		// result 노드의 하위노드(dataset)의 정보를 읽는다.
		for(var j=0 ; j < result.childNodes.length ; j++){
			var ds = result.childNodes[j];

			if(ds.tagName == "dataset"){
				if(ds.getAttribute("id") == dataset_id){	return ds;	}
			}
		}
	}
	return null;
}


jutil.dataset.getTagNames = function(ds){
	/*	해당 데이터셋의 하위 태그 목록을 반환한다. => 실제 데이터 영역의 태그 정보를 반환
	*/
	try{
		for(var i=0 ; i < ds.childNodes.length ; i++){
			var data = ds.childNodes[i];
			if(data.tagName == "data"){	return jutil.xml.getTagNames(data);	}
		}
		return Array();
	}catch(ex){
		jutil.error("jutil.dataset.getTagNames 에서 장애가 발생했습니다.", ex);
	}
}



jutil.dataset.getSingleData = function(DOM, dataset_id){
	/*	반환된 XML DOCUMENT에서 해당 데이터셋 아이디의 값을 반환한다.
			- 지정된 아이디의 데이터셋에는 하나의 값만 존재 할 경우에 사용
			- COUNT, MAX, MIN 과 같이 단일값을 읽어들일때 사용
	*/
	var ds = jutil.dataset.getDataset(DOM, dataset_id);
	if(ds){
		if(ds.childNodes.length > 0){
			var nodes = jutil.xml.childNodes(jutil.xml.childNodes(ds)[0]);
			return jutil.xml.getNodeValue(nodes[0], 4);
		}
	}
	return null;
}



jutil.dataset.getDataNode = function(info){
	/*	데이터 정보를 받아서 데이터 노드를 생성해서 반환한다.
			- 데이터를 입력한 후에 변경된 내용을 새로 불러오지 않고 갱신할때 활용한다.
	*/
	var xmlDoc	= jutil.xml.getXmlDom();
	var data	= xmlDoc.createElement("data");

	for(var key in info){
		var node			= xmlDoc.createElement(key);
		node.appendChild(xmlDoc.createCDATASection(info[key]));
		data.appendChild(node);
	}
	return data;
}


jutil.dataset.getDatasetNode = function(infos){
	/*	데이터셋 정보를 받아서 데이터셋 노드를 생성해서 반환한다.
			- 서버로부터 받는 데이터셋이 아니라 로컬에서 데이터셋을 생성해서 사용할 경우에 활용한다.
	*/
	var ds		= jutil.xml.getXmlDom().createElement("dataset");
	for(var i=0 ; i < infos.length ; i++){	ds.appendChild(jutil.dataset.getDataNode(infos[i]));	}
	return ds;
}


jutil.dataset.getDataText = function(ds, search_node, search_value, return_node){
	/*	데이터셋에서 해당 노드의 값이 지정한 값인 경우 지정한 노드의 값을 반환한다.
			특정 코드의 값을 읽을 경우에 사용된다.
	*/
	try{
		var datas = jutil.xml.childNodes(ds);
		for(var i=0 ; i < datas.length ; i++){
			var d		= datas[i];
			var value	= jutil.xml.selectSingleNodeValue(d, search_node);
			if(value == search_value){	return jutil.xml.selectSingleNodeValue(d, return_node);	}
		}
		return "";
	}catch(ex){
		jutil.error("jutil.dataset.getDataText 에서 장애가 발생했습니다.", ex);
	}
}


jutil.dataset.setDataText = function(ds, info, condition, return_type_){
	/*	데이터셋에서 해당 조건에 맞는 data 항목을 찾아서 지정된 정보로 업데이트 시킨다.
			- 리턴 타입
				data	: 실제 수정된 데이터 노드를 반환한다.
				idx		: 수정된 노드의 인덱스를 반환한다.
				dataset	: 수정된 데이터셋 전체를 반환한다.	=> 실제 데이터셋을 반환하지 않더라도 xml node 오브젝트는 참조변수이기 때문에 변경된 값이 그대로 적용된다.
	*/
	var return_type = (return_type_) ? return_type_ : "data";		// 리턴 타입을 지정한다.

	var datas		= jutil.xml.childNodes(ds);
	for(var i=0 ; i < datas.length ; i++){
		var data			= datas[i];
		var is_condition	= true;
		

		for(var key in condition){
			if(jutil.xml.selectSingleNodeValue(data, key) != condition[key]){	is_condition = false;	}
		}

		if(is_condition){
			for(var key in info){
				var node	= jutil.xml.selectSingleNode(data, key);
				jutil.xml.setNodeValue(node, info[key]);
			}

			if(return_type == "data"){	return data;	}
			if(return_type == "idx"){	return i;		}

			i = datas.length;
		}
	}

	if(return_type == "dataset"){	return dataset;		}
}



jutil.dataset.view = function(ds, view_id){
	/*	서버로부터 데이터셋의 내용 확인하기
			- 실제 개발시 내용을 검증할때 활용
	*/
	var header		= new Array();
	var body		= new Array();
	var tagNames	= jutil.dataset.getTagNames(ds);

	// 헤더구성
	for(var i=0 ; i < tagNames.length ; i++){	header[i] = "<TD nowrap>" + tagNames[i] + "</TD>";	}

	// 내용구성
	var datas	= jutil.xml.childNodes(ds);
	for(var i=0 ; i < datas.length ; i++){
		body[i]	= "<TR bgcolor='#FFFFFF'>";
		for(var j=0 ; j < tagNames.length ; j++){	body[i] += "<TD nowrap>" + jutil.xml.selectSingleNodeValue(datas[i], tagNames[j]) + "</TD>";	}
		body[i]	+= "</TR>";
	}

	jutil.e(view_id).innerHTML = "<TABLE border=0 cellspacing=1 cellpadding=2 bgcolor='#999999'><TR bgcolor='#EEEEEE'>" + header.join("") + "</TR>" + body.join("") + "</TABLE>";
}



/************************************************************************************************************************************************************
	실제 서버에 특정 요청을 해서 처리하는 함수들... update, insert 와 같은 기능을 수행
************************************************************************************************************************************************************/

jutil.dataset.select = function(table, fields, condition, order, limit, is_async, user_fn, is_alert_){
	/*	일반 선택 처리 함수
			- 데이터셋을 요청한다.
			- 일단 조건절의 구성은 = 조건의 AND 연산으로 고정시킨다.

			table		: 읽어올 테이블명
			fields		: 읽어올 필드명. 배열로 구성한다.	=> Array("USER_CODE", "USER_PASS", "USER_NAME", "USER_GROUP")
			condition	: 읽어올 조건. 오브젝트 및 배열로 구성한다.
							var condition	=	{
													"user_group" : Array(1, "01")
												}
							오브젝트의 키가 필드이름이 되고, 배열의 첫번째 값은 0,1 로 구성되며 1인 경우에는 문자열로 싱글 쿼테이션을 자동으로 붙인다.
			order		: 정렬순서. USER_CODE ASC
			limit		: mysql의 limit 옵션. 0, 1000
			is_async	: 동기화 여부
			user_fn		: 읽어온 데이터를 처리할 함수
	*/
	// 항목 정리
	var where			= "";
	if(typeof(condition) == "object"){
		for(var key in condition){	where += key.toUpperCase() + "=" + ((condition[key][0] == 1) ? "'" + condition[key][1] + "' AND " : condition[key][1] + " AND ");	}
	}

	// 데이터 처리 요청
	var info =	{
					"svc_id"		: "jutil/jutil_common_select", 
					"table"			: table, 
					"fields"		: fields.join(","), 
					"where"			: (where.length > 0) ? "WHERE " + where.substring(0, where.length - 4) : "", 
					"order"			: (order.length > 0) ? "ORDER BY " + order : "", 
					"limit"			: (limit.length > 0) ? "LIMIT " + limit : ""
				}
	jutil.xmlhttp.requestCommon(info, is_async, user_fn, is_alert_);
}



jutil.dataset.insert = function(table, info, is_async, user_fn, is_alert_){
	/*	일반 입력 처리를 한다.
			info 정보 구성법
				var info		=	{
										"user_code" : Array(1, jutil.e("user_code").value), 
										"user_pass" : Array(1, jutil.e("user_pass").value), 
										"user_name" : Array(1, jutil.e("user_name").value), 
										"user_group" : Array(1, "01") 
									}
	*/

	// 항목 정리
	var fields = "";
	var values = "";

	for(var key in info){
		fields += key.toUpperCase() + ", ";
		values += (info[key][0] == 1) ? "'" + info[key][1].replace(/\'/g, "") + "', " : info[key][1] + ", ";
	}

	// 데이터 처리 요청
	var info =	{
					"svc_id"	: "jutil/jutil_common_insert", 
					"table"		: table, 
					"fields"	: fields.substring(0, fields.length - 2), 
					"values"	: values.substring(0, values.length - 2)
				}
	jutil.xmlhttp.requestCommon(info, is_async, user_fn, is_alert_);
}


jutil.dataset.update = function(table, info, condition, is_async, user_fn, is_alert_){
	/*	일반 업데이트 처리

		var info		=	{
								"user_pass" : Array(1, jutil.e("user_pass").value), 
								"user_name" : Array(1, jutil.e("user_name").value), 
								"user_group" : Array(1, "01") 
							}

		var condition	=	{
								"user_code" : Array(1, jutil.e("user_code").value) 
							}
	*/
	// 항목 정리
	var field_n_value	= "";
	var where			= "";

	for(var key in info){		field_n_value	+= key.toUpperCase() + "=" + ((info[key][0] == 1) ? "'" + info[key][1].replace(/\'/g, "") + "', " : info[key][1] + ", ");						}
	for(var key in condition){	where			+= key.toUpperCase() + "=" + ((condition[key][0] == 1) ? "'" + condition[key][1] + "' AND " : condition[key][1] + " AND ");	}

	// 데이터 처리 요청
	var info =	{
					"svc_id"		: "jutil/jutil_common_update", 
					"table"			: table, 
					"field_n_value"	: field_n_value.substring(0, field_n_value.length - 2), 
					"where"			: where.substring(0, where.length - 4)
				}
	jutil.xmlhttp.requestCommon(info, is_async, user_fn, is_alert_);
}


jutil.dataset.remove = function(table, info, is_async, user_fn, is_alert_){
	/*	일반 삭제 처리 함수
	*/
	// 항목 정리
	var where = "";
	for(var key in info){	where += key.toUpperCase() + "=" + ((info[key][0] == 1) ? "'" + info[key][1] + "' AND " : info[key][1] + " AND ");	}

	// 데이터 처리 요청
	var info =	{
					"svc_id"	: "jutil/jutil_common_remove", 
					"table"		: table, 
					"where"		: where.substring(0, where.length - 4)
				}
	jutil.xmlhttp.requestCommon(info, is_async, user_fn, is_alert_);
}

/**********************************************************************************************************************************************************************************
	작성자 : 김기석
	작성일 : 2007.06.21

	목적 :
		- 웹 기반의 자바스크립트 유틸 모음
		- 날짜 및 시간에 대한 확장 기능을 구현

	참고사항 : 
			- 윤달 체크는 1979년 6월 12일이 윤달이다. => 양력으로 1979년 8월 4일이다.
			- 음력은 윤달 처리가 필요하기 때문에 각각의 개월 정의가 13개로 정의된다.
			- 음력정보는 1은 29일, 2는 30일, 3은 29일 윤달, 4는 30일 윤달로 표현된 정보이다.
**********************************************************************************************************************************************************************************/

if(typeof(jutil) != "object"){			jutil			= {};	}
if(typeof(jutil.datetime) != "object"){	jutil.datetime	= {};	}


jutil.datetime.lunarTable = new Array(			// 1881-2050년까지의 음력 데이터
	"1212122322121", "1212121221220", "1121121222120", "2112132122122", "2112112121220", 
	"2121211212120", "2212321121212", "2122121121210", "2122121212120", "1232122121212", 
	"1212121221220", "1121123221222", "1121121212220", "1212112121220", "2121231212121", 
	"2221211212120", "1221212121210", "2123221212121", "2121212212120", "1211212232212", 
	"1211212122210", "2121121212220", "1212132112212", "2212112112210", "2212211212120", 
	"1221412121212", "1212122121210", "2112212122120", "1231212122212", "1211212122210", 
	"2121123122122", "2121121122120", "2212112112120", "2212231212112", "2122121212120", 
	"1212122121210", "2132122122121", "2112121222120", "1211212322122", "1211211221220", 
	"2121121121220", "2122132112122", "1221212121120", "2121221212110", "2122321221212", 
	"1121212212210", "2112121221220", "1231211221222", "1211211212220", "1221123121221", 
	"2221121121210", "2221212112120", "1221241212112", "1212212212120", "1121212212210", 
	"2114121212221", "2112112122210", "2211211412212", "2211211212120", "2212121121210", 
	"2212214112121", "2122122121120", "1212122122120", "1121412122122", "1121121222120", 
	"2112112122120", "2231211212122", "2121211212120", "2212121321212", "2122121121210", 
	"2122121212120", "1212142121212", "1211221221220", "1121121221220", "2114112121222", 
	"1212112121220", "2121211232122", "1221211212120", "1221212121210", "2121223212121", 
	"2121212212120", "1211212212210", "2121321212221", "2121121212220", "1212112112210", 
	"2223211211221", "2212211212120", "1221212321212", "1212122121210", "2112212122120", 
	"1211232122212", "1211212122210", "2121121122210", "2212312112212", "2212112112120", 
	"2212121232112", "2122121212110", "2212122121210", "2112124122121", "2112121221220", 
	"1211211221220", "2121321122122", "2121121121220", "2122112112322", "1221212112120", 
	"1221221212110", "2122123221212", "1121212212210", "2112121221220", "1211231212222", 
	"1211211212220", "1221121121220", "1223212112121", "2221212112120", "1221221232112", 
	"1212212122120", "1121212212210", "2112132212221", "2112112122210", "2211211212210", 
	"2221321121212", "2212121121210", "2212212112120", "1232212122112", "1212122122120", 
	"1121212322122", "1121121222120", "2112112122120", "2211231212122", "2121211212120", 
	"2122121121210", "2124212112121", "2122121212120", "1212121223212", "1211212221220", 
	"1121121221220", "2112132121222", "1212112121220", "2121211212120", "2122321121212", 
	"1221212121210", "2121221212120", "1232121221212", "1211212212210", "2121123212221", 
	"2121121212220", "1212112112220", "1221231211221", "2212211211220", "1212212121210", 
	"2123212212121", "2112122122120", "1211212322212", "1211212122210", "2121121122120", 
	"2212114112122", "2212112112120", "2212121211210", "2212232121211", "2122122121210", 
	"2112122122120", "1231212122212", "1211211221220", "2121121321222", "2121121121220", 
	"2122112112120", "2122141211212", "1221221212110", "2121221221210", "2114121221221"
);


// 양력 각달의 일수를 저장한 배열
jutil.datetime.solarTable = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);



jutil.datetime.lunar_days_year = function(year){
	/*	해당 음력 연도의 날짜수를 반환
	*/
	var sum = 0;
	for(var i=0 ; i < 13 ; i++){
		if(parseInt(jutil.datetime.lunarTable[year-1881].charAt(i))){
			sum += 29 + ((parseInt(jutil.datetime.lunarTable[year-1881].charAt(i)) + 1) % 2);
		}
	}
	return sum;
}


jutil.datetime.get_yun_month = function(year){
	/*	해당 음력 연도에 존재하는 윤달의 인덱스를 반환한다.
			- 윤달이 존재하지 않으면 13을 반환한다.
	*/
	var yun = 0;
	do{
		if(parseInt(jutil.datetime.lunarTable[year-1881].charAt(yun)) > 2){	break;	}
		yun++;
	}while(yun <= 12);

	return yun;
}


jutil.datetime.lunar_days_month = function(year, month, is_yun){
	/*	해당 음력월의 날짜수를 반환한다.
	*/
	var yun_month	= jutil.datetime.get_yun_month(year);
	var yun_add		= (month <= yun_month-1 && !is_yun) ? 0 : 1;	// 윤달을 포함한 윤달 이후의 달은 인덱스를 +1을 해주어야 한다.

	return 29 + ((parseInt(jutil.datetime.lunarTable[year-1881].charAt(month-1+yun_add)) + 1) % 2);
}



jutil.datetime.solar_days_month = function(year, month){
	/*	해당 양력월의 날짜수를 반환한다.
	*/
	var check_date	= new Date(year, month, 0);
	return check_date.getDate();
}



jutil.datetime.get_days_solar = function(year, month, day){
	/*	서기를 기준으로 지정한 날짜까지의 지나온 날짜를 반환한다.
	*/
	var sum = 0;

	// 현재 연도의 지나온 날을 계산
	for(var i=0 ; i < month-1 ; i++){	sum += jutil.datetime.solarTable[i];	}
	if(month > 2 && ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)){	sum++;	}	// 현재 년도가 윤년이고 3월 이상인 경우에 +1 처리
	sum += parseInt(day);

	// 작년까지의 윤년의 개수 카운트
	var nYear366 = parseInt((year - 1) / 4) - parseInt((year - 1) / 100) + parseInt((year - 1) / 400);

	// 최종 계산
	return sum + (year - 1) * 365 + nYear366;
}


jutil.datetime.solar_to_lunar = function(year, month, day){
	/*	양력 날짜를 음력 날짜로 반환한 정보를 반환
	*/
	// 리턴 구조 생성
	var rv			=	{
							"year"		: 1880, 
							"month"		: 1, 
							"day"		: 1, 
							"is_yun"	: false
						}
	var days_start	= 686685;												// 서기 1년 1월 1일 부터 1881년 1월 1일 이전의 지난 날짜수
	var ndays		= jutil.datetime.get_days_solar(year, month, day) - days_start;	// 음력의 기준이 되는 1881년 1월 1일 부턴 지정한 날짜까지의 경과한 날짜수

	
	// 음력 연도 계산
	var tmpDays = ndays;
	do{
		rv["year"]++;
		var days	= jutil.datetime.lunar_days_year(rv["year"]);
		if(tmpDays <= days){	ndays = tmpDays;	}
		tmpDays -= days;
	}while(tmpDays > 0);


	// 음력 월 및 계산
	var yun_idx = jutil.datetime.get_yun_month(rv["year"]);

	var is_yun	= false;
	var tmpDays = ndays;
	for(var i=1 ; i <= (yun_idx < 13 ? 13 : 12) ; i++){
		var days = 0;
		if(i < yun_idx){	days = jutil.datetime.lunar_days_month(rv["year"], i, false);	rv["month"] = i;	}
		if(i == yun_idx){	days = jutil.datetime.lunar_days_month(rv["year"], i-1, true);	rv["month"] = i;	}
		if(i > yun_idx){	days = jutil.datetime.lunar_days_month(rv["year"], i-1, false);	rv["month"] = i-1;	}

		if(tmpDays <= days){
			rv["day"]	= tmpDays;												// 마지막으로 남은 날짜수가 실제 날짜가 된다.
			if(yun_idx < 13 && i == yun_idx + 1){	rv["is_yun"] = true;	}	// 윤달 정보 구성


			break;
		}

		tmpDays -= days;
	}

	return rv;
}



jutil.datetime.getWeekInfo = function(year, month, week){
	/*	해당 연도, 월, 주에 해당하는 시작날짜와 종료날짜를 Object로 반환한다.
			- 일요일부터 토요일로 기간을 산정한다.
	*/
	var firstDate	= new Date(year, month-1, 1);
	var startDate	= new Date(year, month-1, 1 - firstDate.getDay() + (7 * (week-1)));
	var endDate		= new Date(year, month-1, 1 - firstDate.getDay() + (7 * (week-1)) + 6);
	return {"startDate" : startDate, "endDate" : endDate}	
}

/**********************************************************************************************************************************************************************************
	작성자 : 김기석
	작성일 : 2007.06.18

	목적 :
		- 웹 기반의 자바스크립트 유틸 모음
		- 동적 HTML 기능을 구현하기 위한 기본 라이브러리 모음

	참고사항 :
		- 
**********************************************************************************************************************************************************************************/


if(typeof(jutil) != "object"){			jutil		= {};	}
if(typeof(jutil.dhtml) != "object"){	jutil.dhtml	= {};	}



jutil.dhtml.display = function(o, display){
	/*	해당 오브젝트나 아이디의 오브젝트의 display 값을 컨트롤 한다.
	*/
	switch(typeof(o)){
		case "string" :
			var obj = jutil.e(o);
			if(obj != null){	obj.style.display = display;	} 
			break;
		case "object" :
			o.style.display = display;
			break;
	}
}


jutil.dhtml.getOffsetLeft = function(obj){
	/*	해당 오브젝트의 절대좌표값을 반환 => LEFT
			- 일반 offsetLeft의 경우 부모객체를 기준으로한 좌표 정보를 반환한다.
	*/
	var retval = 0;
	var border, scroll;

	if (obj)
	{
		retval += obj.offsetLeft;
		border	= obj.currentStyle ? parseInt(obj.currentStyle.borderLeftWidth) : 0;
		scroll	= (obj.tagName == "BODY") ? 0 : parseInt(obj.scrollLeft);

		if (!isNaN(border)) retval += border;
		if (!isNaN(scroll)) retval -= scroll;
		retval += jutil.dhtml.getOffsetLeft(obj.offsetParent);
	}

	return retval;
}


jutil.dhtml.getOffsetTop = function(obj){
	/*	해당 오브젝트의 절대좌표값을 반환 => TOP
	*/
	var retval = 0;
	var border, scroll;


	if (obj)
	{
		retval += obj.offsetTop;
		border	= obj.currentStyle ? parseInt(obj.currentStyle.borderTopWidth) : 0;
		scroll	= (obj.tagName == "BODY") ? 0 : parseInt(obj.scrollTop);
		if (!isNaN(border)) retval += border;
		if (!isNaN(scroll)) retval -= scroll;
		retval += jutil.dhtml.getOffsetTop(obj.offsetParent);
	}

	return retval;
}



jutil.dhtml.cb = function(obj, color){
	/*	해당 오브젝트의 배경색을 변경한다.
	*/
	obj.style.backgroundColor = color; 
}


jutil.dhtml.getTableObject = function(id_table, rows, cols){
	/*	기본적인 테이블 오브젝트의 구조를 구성해서 반환한다.
			- 동적으로 테이블을 구성할 경우에 기본적이 테이블을 반환한다.
	*/
	var oTable	= document.createElement("TABLE");
	var oTbody	= document.createElement("TBODY");

	for(var i=0 ; i < rows ; i++){
		var oTr = document.createElement("TR");
		oTr.setAttribute("id", id_table + "_tr_" + i);

		for(var j=0 ; j < cols ; j++){
			var oTd = document.createElement("TD");
			oTd.setAttribute("id", id_table + "_td_" + i + "_" + j);
			oTr.appendChild(oTd);
		}

		oTbody.appendChild(oTr);
	}

	oTable.setAttribute("id", id_table + "_table");
	oTable.appendChild(oTbody);

	return oTable;
}




/************************************************************************************************************************************************
	해당 이미지의 크기가 지정한 크기보다 큰 경우 이미지의 크기를 지정한 크기로 변경한다.
		img 태그의 onload이벤트에 적용한다.
************************************************************************************************************************************************/
jutil.dhtml.img_resize_max = function(obj, max_width){
	var height;
	
	if ( obj.width > max_width ) { 
	   var height = obj.height/(obj.width / max_width);
	   obj.width = max_width
	   obj.height = height;
	}
}




/************************************************************************************************************************************************
	해당 오브젝트를 중앙에 위치 시킨다.
************************************************************************************************************************************************/
jutil.dhtml.set_center = function(id){
	var obj = jutil.e(id);
	var pos	= jutil.dhtml.get_center(id);
	obj.style.position	= "absolute";
	obj.style.left		= parseInt(pos["x"]) + "px";
	obj.style.top		= parseInt(pos["y"]) + "px";
}


/************************************************************************************************************************************************
	지정된 오브젝트의 크기를 고려해서 중앙에 위치할 수 있는 좌표값을 반환한다.
		- offset의 값을 기준으로 하는데 offset의 값이 정확히 올라오지 않는 경우에는 style에 설정된 값을 기준으로 한다.
************************************************************************************************************************************************/
jutil.dhtml.get_center = function(id){
	var obj = jutil.e(id);
	var rv = {	"x" : 0, "y" : 0	}

	var width	= obj.offsetWidth != 0 ? obj.offsetWidth : parseInt(obj.style.width);
	var height	= obj.offsetHeight != 0 ? obj.offsetHeight : parseInt(obj.style.height);


	rv["x"] = document.body.offsetWidth / 2 - width / 2 + document.body.scrollLeft;
	rv["y"] = document.body.offsetHeight / 2 - height / 2 + document.body.scrollTop;

	return rv;
}





/************************************************************************************************************************************************
	오브젝트의 위치 변경
************************************************************************************************************************************************/
jutil.dhtml.move = function(obj, x, y, speed_, time_, is_remove_, fn_name_){
	/*	해당 오브젝트를 지정된 위치로 이동 시킨다.
	*/
	// 스타일 속성 처리
	if(obj.style.position != "absolute"){	obj.style.position = "absolute";	}

	// 파라미터 처리
	var speed		= (speed_) ? speed_ : 10;
	var time		= (time_) ? time_ : 1;
	var is_remove	= (is_remove_) ? is_remove_ : false;
	var fn_name		= (fn_name_) ? fn_name_ : false;

	var rate_x	= (obj.offsetTop - y)/(obj.offsetLeft - x);			// 기울기 계산
	var rate_y	= (obj.offsetLeft - x)/(obj.offsetTop - y);			// 기울기 계산
	var step_x	= (obj.offsetLeft - x) >= 0 ? -1 * speed : speed;	// 진행 스텝 계산
	var step_y	= (obj.offsetTop - y) >= 0 ? -1 * speed : speed;	// 진행 스텝 계산

	if(
		(step_x > 0 && obj.offsetLeft + step_x < x) || 
		(step_x < 0 && obj.offsetLeft + step_x > x) ||
		(step_y > 0 && obj.offsetTop + step_y < y) ||
		(step_y < 0 && obj.offsetTop + step_y > y)
	){
		if(rate_x <= 1 && rate_x >= -1){	// 가로 방향이 긴 경우
			obj.style.left	= obj.offsetLeft + step_x;
			obj.style.top	= obj.offsetTop + step_x * rate_x;
		}else{								// 세로 방향이 긴 경우
			obj.style.left	= obj.offsetLeft + step_y * rate_y;
			obj.style.top	= obj.offsetTop + step_y;
		}
		
		obj.is_move_ing	= true;
		obj.timer_move = setTimeout("jutil.dhtml.move(document.getElementById('" + obj.id + "'), " + x + ", " + y + ", " + speed + ", " + time + ", " + is_remove + ", \"" + fn_name + "\")", time);
	}else{
		obj.style.left	= x;
		obj.style.top	= y;

		obj.is_move_ing	= false;
		obj.timer_move	= null;


		// 제거 옵션이 있을 경우 현재 오브젝트의 상위오브젝트로부터 현재 오브젝트를 제거한다.
		if(is_remove){	obj.parentNode.removeChild(obj);	}

		// 함수 실행 옵션이 있을 경우 해당 함수를 실행한다.
		if(fn_name){	eval(fn_name);						}
	}
}



/************************************************************************************************************************************************
	오브젝트의 크기 변경
************************************************************************************************************************************************/
jutil.dhtml.resize = function(obj, width, height, speed_, time_){
	/*	지정된 오브젝트의 가로, 세로 크기를 변경한다.
			- setTimeout을 사용하므로 object로 받아서 처리하는게 편하다.
			- 변화의 비율의 차이가 클 경우에는 시각적 효과가 거의 없을 수 있다.
				가로방향은 2의 크기 변화이고, 세로방향은 200의 변화가 있을 경우 시각적 효과는 거의 없다.
	*/
	// 기본정보 구성
	var speed		= (speed_) ? speed_ : 1;
	var time		= (time_) ? time_ : 1;
	var obj_width	= obj.offsetWidth;
	var obj_height	= obj.offsetHeight;

	// 재조정할 방향 설정 => 크기를 늘리는지 줄이는지에 따른 변환 체크
	var range_width		= obj_width < width ? 1 * speed : -1 * speed;
	var range_height	= obj_height < height ? 1 * speed : -1 * speed;

	var range_step_width = (obj_width - width) < 0 ? (obj_width - width) * -1 : (obj_width - width);
	var range_step_height = (obj_height - height) < 0 ? (obj_height - height) * -1 : (obj_height - height);

	// 가로, 세로의 이동 범위 재조정 => 각각의 크기와 비율로 계산 => 변화의 종료시기를 통일시키기 위한 작업
	if(range_step_width > range_step_height){	range_width = range_width * range_step_width / range_step_height;	}
	else{										range_height = range_height * range_step_height / range_step_width;	}


	// 실제 이동 처리
	if(
		(obj_width > width + speed) ||
		(obj_width < width - speed) ||
		(obj_height > height + speed) ||
		(obj_height < height - speed)
	){
		// 가로 방향 크기 조정
		if((obj_width <= width && (obj_width + range_width) >= width) || (obj_width >= width && (obj_width + range_width) <= width)){
			obj.style.width = width;
		}else{
			obj.style.width	= obj_width + range_width;
		}


		// 세로 방향 크기 조정
		if((obj_height <= height && (obj_height + range_height) >= height) || (obj_height >= height && (obj_height + range_height) <= height)){
			obj.style.height = height;
		}else{
			obj.style.height	= obj_height + range_height;
		}

		setTimeout("jutil.dhtml.resize(document.getElementById('" + obj.id + "'), " + width + ", " + height + ", " + speed + ", " + time + ")", time);
		//alert("set_resize(document.getElementById('" + obj.id + "'), " + width + ", " + height + ", " + speed + ", " + time + ")");
	}else{
		obj.style.width		= width;
		obj.style.height	= height;
		if(width == 0 || height == 0){	obj.style.display = "none";		}
	}
}


jutil.dhtml.resize_direction = function(obj, size, direction, step_, time_){
	/*	지정된 오브젝트의 가로또는 세로 크기를 변경한다.
			- setTimeout을 사용하므로 object로 받아서 처리하는게 편하다.
			
			- 파라미터
			obj			: 크기를 변경할 오브젝트
			size		: 변경할 크기
			direction	: 가로 또는 세로 방향 지시. width, height
			step_		: 변경할 단계 사이즈
			time_		: 재호출 주기
	*/
	var step		= (step_) ? step_ : 2;
	var time		= (time_) ? time_ : 2;
	var obj_size	= (direction == "width") ? obj.offsetWidth : obj.offsetHeight;
	var dir			= (obj_size < size) ? 1 : -1;

	if((obj_size <= size + step) && (obj_size >= size - step)){
		if(direction == "width"){	obj.style.width		= size;		}
		else{						obj.style.height	= size;		}
	}else{
		if(direction == "width"){	obj.style.width		= obj_size + step * dir;		}
		else{						obj.style.height	= obj_size + step * dir;		}
		setTimeout("jutil.dhtml.resize_direction(document.getElementById('" + obj.id + "'), " + size + ", '" + direction + "', " + step + ", " + time + ")", time);
	}

}



/************************************************************************************************************************************************
	마우스 MOVE 관련 기초 함수들...
************************************************************************************************************************************************/
jutil.dhtml.mouseMoveFuncs	= Array();
jutil.dhtml.mouseMoveAdd	= function(func){
	/*	마우스 move 이벤트에 적용시킬 함수를 attach 시킨다.
	*/
	jutil.dhtml.mouseMoveFuncs.push(func);

	if(jutil.dhtml.mouseMoveFuncs.length == 1){
		jutil.eventAdd(jutil.global.document.body, "onmousemove", jutil.dhtml.mouseMoveTrace);
	}
}


jutil.dhtml.mouseMoveRemove = function(func){
	/*	마우스 move 이벤트에 제거시킬 함수를 detach 시킨다.
	*/
	for(var i=0 ; i < jutil.dhtml.mouseMoveFuncs.length ; i++){
		if(jutil.dhtml.mouseMoveFuncs[i] == func){	jutil.dhtml.mouseMoveFuncs.splice(i, 1);	break;	}
	}

	//	마우스 move 와 관련된 함수가 없는 경우에는 이벤트를 제거한다.
	if(jutil.dhtml.mouseMoveFuncs.length == 0){
		jutil.eventRemove(jutil.global.document.body, "onmousemove", jutil.dhtml.mouseMoveTrace);
	}
}



jutil.dhtml.mouseMoveTrace = function(evt){
	/*	마우스의 위치를 추적하는 함수
			- 넷스케이프의 경우 내용이 없는 경우에는 위치를 잡아내지 못할 수 있다.
			- 실제 웹 사이트에서는 페이지 전체에 내용이 들어오므로 작업에는 큰 무리가 없을 것 같다.
	*/
	var x	= evt.pageX ? evt.pageX : event.x;
	var y	= evt.pageY ? evt.pageY : event.y;

	for(var i=0 ; i < jutil.dhtml.mouseMoveFuncs.length ; i++){
		jutil.dhtml.mouseMoveFuncs[i](x, y);
	}
}


/************************************************************************************************************************************************
	마우스를 따라다니는 오브젝트 기능 구현
************************************************************************************************************************************************/
jutil.dhtml.mouseFollowObjectInfo = Array();
jutil.dhtml.mouseFollowObject = function(obj, x_, y_, moveFunc_){
	/*	해당 오브젝트가 마우스를 따라다니게 한다.
			obj			: 마우스를 따라다니게할 오브젝트
			x_			: x 축 보정값
			y_			: y 축 보정값
			moveFunc_	: 오브젝트 이동시 추가로 실행할 함수. 파라미터로 오브젝트의 x,y 좌표 및 마우스의 x,y 좌표를 전달한다.
	*/
	obj.style.position	= "absolute";
	jutil.dhtml.mouseFollowObjectInfo.push({"obj" : obj, "x" : x_ ? x_ : 0, "y"	: y_ ? y_ : 0, "moveFunc" : typeof(moveFunc_) == "function" ? moveFunc_ : null });

	if(jutil.dhtml.mouseFollowObjectInfo.length == 1){
		jutil.dhtml.mouseMoveAdd(jutil.dhtml.mouseFollowObjectTrace);
	}
}


jutil.dhtml.mouseFollowObjectRemove = function(obj){
	/*	해당 오브젝트가 마우스를 따라다니는 것을 종료한다.
	*/
	for(var i=0 ; i < jutil.dhtml.mouseFollowObjectInfo.length ; i++){
		var info = jutil.dhtml.mouseFollowObjectInfo[i];
		if(info["obj"] == obj){	jutil.dhtml.mouseFollowObjectInfo.splice(i, 1);	break;	}
	}

	if(jutil.dhtml.mouseFollowObjectInfo.length == 0){
		jutil.dhtml.mouseMoveRemove(jutil.dhtml.mouseFollowObjectTrace);
	}
}


jutil.dhtml.mouseFollowObjectTrace = function(x, y){
	/*	해당 오브젝트가 마우스를 따라다니게 한다.
			/// 마우스 버튼 상태에 따른 옵션을 체크할 수 있어야 한다.
			/// 옵션이 깨졌을 경우에 보완할 수 있는 기능이 추가 되어야 한다.
	*/
	for(var i=0 ; i < jutil.dhtml.mouseFollowObjectInfo.length ; i++){
		var info = jutil.dhtml.mouseFollowObjectInfo[i];
		info["obj"].style.left	= x + info["x"];
		info["obj"].style.top	= y + info["y"];

		if(info["moveFunc"] != null){	info["moveFunc"](info["obj"], x + info["x"], y + info["y"], x, y);	}
	}
}


/************************************************************************************************************************************************
	오브젝트가 드래그 가능하게 기능을 변경
************************************************************************************************************************************************/
jutil.dhtml.mouseDragAbleInfo	= Array();	// 드래그 가능하게 적용된 오브젝트들의 정보
jutil.dhtml.mouseDragAble = function(obj, startFunc_, dragFunc_, endFunc_){
	/*	해당 오브젝트가 드래그 가능하게 변경한다.
			obj			: 드래그를 적용할 오브젝트
			startFunc_	: 드래그 시작 포인트에서 실행되는 함수
			dragFunc_	: 드래그 도중에 실행되는 함수
			endFunc_	: 드래그 종료 포인트에서 실행되는 함수
	*/
	// 중복 체크
	for(var i=0 ; i < jutil.dhtml.mouseDragAbleInfo.length ; i++){
		var info = jutil.dhtml.mouseDragAbleInfo[i];
		if(info["obj"] == obj){
			alert("jutil.dhtml.mouseDragAble : " + obj.id + " 는 이미 드래그 가능 상태입니다.");
			return;
		}
	}

	// 드래그 오브젝트 설정
	obj.jutil_dhtml_mouseDragAble = "yes";

	// 정보 설정
	jutil.dhtml.mouseDragAbleInfo.push({ "obj" : obj, "startFunc" : (startFunc_ ? startFunc_ : null), "dragFunc" : (dragFunc_ ? dragFunc_ : null), "endFunc" : (endFunc_ ? endFunc_ : null) });

	// 필요한 스타일 설정
	obj.style.cursor	= "pointer";

	// 필요 이벤트 핸들 설정
	jutil.eventAdd(obj, "onmousedown", jutil.dhtml.mouseDragAbleStart);
	jutil.eventAdd(obj, "onmouseup", jutil.dhtml.mouseDragAbleEnd);
}


jutil.dhtml.mouseDragAbleRemove = function(obj){
	/*	해당 오브젝트의 드래그 가능 상태를 제거한다.
	*/


	// 오브젝트가 이동중인 상태에서 제거가 바로 발생하는 경우를 체크한다. => 이 코드는 jutil.dhtml.mouseDragAbleEnd에 있는 코드와 동일하다.
	for(var i=0 ; i < jutil.dhtml.mouseFollowObjectInfo.length ; i++){
		if(jutil.dhtml.mouseFollowObjectInfo[i]["obj"] == obj){
			// 추가함수 실행
			for(var i=0 ; i < jutil.dhtml.mouseDragAbleInfo.length ; i++){
				if(jutil.dhtml.mouseDragAbleInfo[i]["obj"] == obj){
					if(typeof(jutil.dhtml.mouseDragAbleInfo[i]["callFunc"]) == "function"){	jutil.dhtml.mouseDragAbleInfo[i]["callFunc"](obj);	}
					break;
				}
			}

			// 드래그 종료 처리
			jutil.dhtml.mouseFollowObjectRemove(obj);
		}
	}


	// 오브젝트에 설정된 이벤트 핸들 제거
	jutil.eventRemove(obj, "onmousedown", jutil.dhtml.mouseDragAbleStart);
	jutil.eventRemove(obj, "onmouseup", jutil.dhtml.mouseDragAbleEnd);
	obj.style.cursor	= "default";
	obj.jutil_dhtml_mouseDragAble = "no";

	
	// 정보에서 제거
	for(var i=0 ; i < jutil.dhtml.mouseDragAbleInfo.length ; i++){
		var info = jutil.dhtml.mouseDragAbleInfo[i];
		if(info["obj"] == obj){	jutil.dhtml.mouseDragAbleInfo.splice(i, 1);	break;	}
	}
}



jutil.dhtml.mouseDragAbleGetInfo = function(obj){
	/*	드래그 가능 오브젝트중에서 해당 오브젝트의 설정 정보를 반환한다.
	*/
	for(var i=0 ; i < jutil.dhtml.mouseDragAbleInfo.length ; i++){
		if(jutil.dhtml.mouseDragAbleInfo[i]["obj"] == obj){
			return jutil.dhtml.mouseDragAbleInfo[i];
			break;
		}
	}
}


jutil.dhtml.mouseDragAbleStart = function(evt){
	/*	드래그가 가능한 오브젝트의 onmousedown 이벤트 핸들
			- 마우스의 위치와 오브젝트의 위치를 체크 => 오브젝트의 실제 위치를 보정
			- 오브젝트가 마우스를 따라다니는 이벤트 설정
	*/
	var x		= evt.pageX ? evt.pageX : event.x;
	var y		= evt.pageY ? evt.pageY : event.y;
	var obj		= jutil.eventSrc(evt);


	// 선택방지 옵션을 설정한다.
	jutil.global.document.body.onselectstart = function(){	return false;	};


	// 실제 드래그가 설정된 오브젝트를 찾는다.
	while(true){
		if(!obj.jutil_dhtml_mouseDragAble){	obj = obj.parentNode;	}
		else{
			if(obj.jutil_dhtml_mouseDragAble == "yes"){	break;		}
		}
	}
	var obj_x	= jutil.dhtml.getOffsetLeft(obj);
	var obj_y	= jutil.dhtml.getOffsetTop(obj);


	// 시작 함수 체크
	var info = jutil.dhtml.mouseDragAbleGetInfo(obj);
	if(typeof(info["startFunc"]) == "function"){	info["startFunc"](obj, obj_x, obj_y, x, y);	}


	// 드래그 시작
	jutil.dhtml.mouseFollowObjectRemove(obj);					// 창밖에서 마우스 버튼을 뗀경우에 계속 따라다니게 된다. 이경우를 방지 하기 위해서 한번 제거 해주고 다시 적용한다.
	jutil.dhtml.mouseFollowObject(obj, obj_x - x, obj_y - y, (typeof(info["dragFunc"]) == "function") ? info["dragFunc"] : null);
}


jutil.dhtml.mouseDragAbleEnd = function(evt){
	/*	드래그가 가능한 오브젝트의 onmousedown 이벤트 핸들
			- 마우스의 위치와 오브젝트의 위치를 체크 => 오브젝트의 실제 위치를 보정
			- 오브젝트가 마우스를 따라다니는 이벤트 설정
	*/

	// 오브젝트 찾기
	var obj		= jutil.eventSrc(evt);
	while(true){
		if(!obj.jutil_dhtml_mouseDragAble){	obj = obj.parentNode;	}
		else{
			if(obj.jutil_dhtml_mouseDragAble == "yes"){	break;		}
		}
	}

	// 이벤트 발생 정보
	var x		= evt.pageX ? evt.pageX : event.x;
	var y		= evt.pageY ? evt.pageY : event.y;


	// 오브젝트의 위치 정보
	var obj_x	= jutil.dhtml.getOffsetLeft(obj);
	var obj_y	= jutil.dhtml.getOffsetTop(obj);


	// 선택방지 옵션을 설정한다.
	jutil.global.document.body.onselectstart = function(){	return true;	};


	// 종료 함수 체크
	var info = jutil.dhtml.mouseDragAbleGetInfo(obj);
	if(typeof(info["endFunc"]) == "function"){	info["endFunc"](obj, obj_x, obj_y, x, y);	}



	// 드래그 종료 처리
	jutil.dhtml.mouseFollowObjectRemove(obj);
}


/************************************************************************************************************************************************
	오브젝트가 드래그 가능하게하는 기능을 확장
		- 특정 영역에 대해서 드래그 이벤트 설정
		- 특정 영역은 전체 영역의 하위 영역으로 존재해야 한다.
		- 현재는 따로 remove 함수를 제공하지 않는다.
************************************************************************************************************************************************/
jutil.dhtml.mouseDragAbleExtInfo	= Array();
jutil.dhtml.mouseDragAbleExt = function(objFocus, objDrag, startFunc_, dragFunc_, endFunc_){
	/*	특정 영역에 대해서 드래그가 가능한 기능을 제공
			objFocus	: 드래그 이벤트를 시작할 오브젝트
			objDrag		: 실제 드래그를 구현할 오브젝트
			callFunc_	: 드래그가 종료된 시점에서 실행할 함수
	*/
	// 중복 체크
	for(var i=0 ; i < jutil.dhtml.mouseDragAbleExtInfo.length ; i++){
		var info = jutil.dhtml.mouseDragAbleExtInfo[i];
		if(info["objFocus"] == objFocus){
			alert("jutil.dhtml.mouseDragAbleExt : " + objFocus.id + " 는 이미 드래그 가능 상태입니다.");
			return;
		}
	}

	
	// 오브젝트에 드래그 확장 오브젝트여부 체크를 위한 플래그 설정
	objFocus.jutil_dhtml_mouseDragAbleExt = "yes";
	objFocus.style.cursor = "pointer";


	// 기본 정보 설정
	jutil.dhtml.mouseDragAbleExtInfo.push({ "objFocus" : objFocus, "objDrag" : objDrag, "startFunc" : (startFunc_ ? startFunc_ : null), "dragFunc" : (dragFunc_ ? dragFunc_ : null), "endFunc" : (endFunc_ ? endFunc_ : null) });


	// 이벤트 핸들 컨트롤
	jutil.eventAdd(objFocus, "onmousedown", jutil.dhtml.mouseDragAbleExtStart);
}


jutil.dhtml.mouseDragAbleExtRemove = function(objFocus){
	/*	드래그 가능상태를 해제한다.
	*/
	var idx = 0;
	for(var i=0 ; i < jutil.dhtml.mouseDragAbleExtInfo.length ; i++){
		var info = jutil.dhtml.mouseDragAbleExtInfo[i];
		if(info["objFocus"] == objFocus){
			idx = i;
			objFocus.jutil_dhtml_mouseDragAbleExt = "no";
			objFocus.style.cursor = "arrow";
			jutil.eventRemove(objFocus, "onmousedown", jutil.dhtml.mouseDragAbleExtStart);
			break;
		}
	}

	jutil.dhtml.mouseDragAbleExtInfo = jutil.array.removeAt(jutil.dhtml.mouseDragAbleExtInfo, idx);
}



jutil.dhtml.mouseDragAbleExtStart = function(evt){
	/*	특정 영역에 대해서 드래그가 가능한 기능을 시작
	*/
	// 이벤트 발생 오브젝트 획득
	var obj	= jutil.eventSrc(evt);
	while(true){
		if(!obj.jutil_dhtml_mouseDragAbleExt){	obj = obj.parentNode;	}
		else{
			if(obj.jutil_dhtml_mouseDragAbleExt == "yes"){	break;		}
		}
	}


	// 해당 오브젝트와 연결된 정보 획득 및 이벤트 설정
	for(var i=0 ; i < jutil.dhtml.mouseDragAbleExtInfo.length ; i++){
		var info = jutil.dhtml.mouseDragAbleExtInfo[i];
		if(obj == info["objFocus"]){
			jutil.dhtml.mouseDragAbleRemove(info["objDrag"]);					// 창밖에서 마우스 버튼을 뗀경우에 계속 따라다니게 된다. 이경우를 방지 하기 위해서 한번 제거 해주고 다시 적용한다.
			jutil.dhtml.mouseDragAble(info["objDrag"], info["startFunc"], info["dragFunc"], jutil.dhtml.mouseDragAbleExtEnd);
			break;
		}
	}
}

jutil.dhtml.mouseDragAbleExtEnd = function(obj, obj_x, obj_y, mouse_x, mouse_y){
	/*	특정 영역에 대해서 드래그가 가능한 기능을 종료
	*/
	// 해당 오브젝트와 연결된 정보 획득 및 이벤트 설정
	for(var i=0 ; i < jutil.dhtml.mouseDragAbleExtInfo.length ; i++){
		var info = jutil.dhtml.mouseDragAbleExtInfo[i];
		if(obj == info["objDrag"]){
			jutil.dhtml.mouseDragAbleRemove(info["objDrag"]);

			// 추가함수 실행
			if(typeof(info["endFunc"]) == "function"){	info["endFunc"](obj, obj_x, obj_y, mouse_x, mouse_y);	}
			break;
		}
	}
}



/**********************************************************************************************************************************************************************************
	작성자 : 김기석
	작성일 : 2007.06.18

	목적 :
		- 웹 기반의 자바스크립트 유틸 모음
		- 폼 처리 관련 기능 모음

	참고사항 :
		- 
**********************************************************************************************************************************************************************************/


if(typeof(jutil) != "object"){			jutil		= {};	}
if(typeof(jutil.form) != "object"){		jutil.form	= {};	}


/*	기본 message
*/
jutil.form.validateMsg = {};
jutil.form.validateMsg.empty 		= "필수입력 항목입니다.";
jutil.form.validateMsg.num 			= "숫자만 입력가능합니다.";
jutil.form.validateMsg.num_point1	= "소수점은 입력이 불가능합니다.";
jutil.form.validateMsg.num_point2	= "소수점 이하 $1 자리까지 입력가능합니다.";
jutil.form.validateMsg.num_minmax	= "입력 값의 범위는 $1 이상, $2 이하 입니다.";
jutil.form.validateMsg.num_min		= "$1 이상의 값만 입력가능합니다.";
jutil.form.validateMsg.num_max		= "$1 이하의 값만 입력가능합니다.";
jutil.form.validateMsg.eng			= "영어만 입력가능합니다.";
jutil.form.validateMsg.eng_big		= "영어 대문자만 입력가능합니다.";
jutil.form.validateMsg.eng_small	= "영어 대문자만 입력가능합니다.";

/*	정규식
*/
jutil.form.validateRegExp 			= {};
jutil.form.validateRegExp.eng 		= new RegExp(/[^a-z]/i);
jutil.form.validateRegExp.engBig 	= new RegExp(/[^A-Z]/g);
jutil.form.validateRegExp.engSmall 	= new RegExp(/[^a-z]/g);
jutil.form.validateRegExp_num	 	= new RegExp(/^(-)?((?:[1-9]\d*)|(?:0))?(\.\d*)?$/);


jutil.form.validate = function(obj){
	/*	입력폼의 유효성 검사를 한다.
	*/

	// 파라미터의 타입에 따라 element를 가져온다
	var elements = null;
	
	if(typeof(obj) == "object"){
		elements = jutil.form.getFormElements(obj);
	}else{
		//elements = jutil.form.getFormElements(jutil.e(obj));
		elements = jutil.form.getFormElements(eval("document." + obj));
	}



	for(var i=0 ; i < elements.length ; i++){
		var element = elements[i];
		
		// 임시 코드 (숨겨져있는 element는 검사 하지 않는다.
		if(element.style.display == "none"){	continue;	}
		
		switch(element.tagName.toUpperCase()){
			case "INPUT" :

				switch(element.type.toUpperCase()){
					case "PASSWORD" :
					case "TEXT" :
						if(element.getAttribute("validate") == "on"){											if(!jutil.form.validate_empty(element))		return false;		}
						if(element.validate_minmax && element.validate_minmax.length > 0){		if(!jutil.form.validate_minmax(element))	return false;		}
						else{
							// 최소최대값 검증의 선행으로 숫자검증 함수가 동작 되므로 최소최대값 검증이 설정 되어 있지 않을 경우만, 따로 숫자검증을 진행한다.
							if(element.validate_num && element.validate_num.length > 0){	if(!jutil.form.validate_num(element)) 		return false;		}
						}
						if(element.validate_eng && element.validate_eng.length > 0){			if(!jutil.form.validate_eng(element))		return false;		}
						break;
					case "CHECKBOX" :
						if(element.getAttribute("validate") == "on"){											if(!jutil.form.validate_empty(element))		return false;		}
						break;
					case "RADIO" :
					case "FILE" :
					case "HIDDEN" :						
					case "IMAGE" :
					case "SUBMIT" :
					case "BUTTON" :	break;		// submit, button은 검증하지 않는다.
					default :
						jutil.error("jutil.form.validate : " + element.type + "에 대한 기능정의가 없습니다.");
						return false;
				}

				break;
			case "TEXTAREA" :
				if(element.getAttribute("validate") == "on"){	if(!jutil.form.validate_empty(element)) return false;		}
				break;
			case "SELECT" :	break;		// select는 검증하지 않는다.
			default :
				jutil.error("jutil.form.validate : " + element.tagName + "에 대한 기능정의가 없습니다.");
				return false;
		}
	}

	return true;
}



jutil.form.validate_empty = function(obj){
	/*	해당 오브젝트의 값이 비어있는지를 체크한다.
			- 공백도 비어있는것으로 처리한다.
			- 체크박스의 경우에는 1개 이상 선택을 했을 경우 true를 반환한다.
	*/
	if(obj.tagName == "TEXTAREA" || (obj.tagName == "INPUT" && (obj.type.toUpperCase() == "TEXT" || obj.type.toUpperCase() == "PASSWORD" || obj.type.toUpperCase() == "CHECKBOX") )){
	}else{
		return true;
	}

	if(obj.tagName == "INPUT" && obj.type.toUpperCase() == "CHECKBOX"){		// 체크박스
		var objs	= jutil.e(obj.name, "name");

		for(var i=0 ; i < objs.length ; i++){
			switch(obj.type.toUpperCase()){
				case "CHECKBOX" :
					if(objs[i].checked){	return true;	}
					break;
				default :
					jutil.error("jutil.form.validate_empty : " + obj.type + "에 대한 정의가 없습니다.");
					return false;
			}
		}

		var msg = obj.validate_msg ? obj.validate_msg : jutil.form.validateMsg.empty;
		alert(msg);
		obj.focus();	
		return false;
	}else{																	// 일반 입력폼
		if(jutil.string.trim(obj.value).length == 0){
			var msg = obj.getAttribute("validate_msg") ? obj.getAttribute("validate_msg") : jutil.form.validateMsg.empty;
			alert(msg);
			obj.focus();
			return false;
		}else{	return true;	}
	}
}

 
jutil.form.validate_num = function(obj) {
	/*	해당 오브젝트의 값이 숫자인지 체크한다.
			- validate_num = "on"			: 정수만허용 (default) 
			- validate_num = "on|float,3"	: 소수점 3자리까지 허용  
			- 공백을 제거후 값이 존재 하지 않을 경우 동작하지 않는다. 
			- INPUT type="text"와 Textarea 
	*/
	if(obj.tagName != "INPUT" || obj.type.toUpperCase() != "TEXT"){		return true;		}

	// 폼값의 좌우 공백제거 
	obj.value	= jutil.string.trim(obj.value);
	var value	= obj.value;
	var opts	= Array();
	var opt		= obj.validate_num;
	var msg		= obj.validate_num_msg ? obj.validate_num_msg : jutil.form.validateMsg.num;
	var	mode	= "default";
	var decimalPoint = 0;

	// 예외 처리
	if(value == ""){					return true;		}		// 값이 없을 경우 처리하지 않는다.
	if(opt.substring(0, 2) != "on"){	return true;		}		// 옵션이 지정되지 않을 경우 처리하지 않는다.
	
	// 지정된 옵션 정보 가져오기
	opts = opt.split("|");

	// 각 옵션에 따른 처리 모드 변경
	if(opts.length == 1){
		mode = "default";

	}else if(opts[1].indexOf("float") > -1){
		mode = "float";

		// 허용할 소수점 자리수 정보 가져오기
		decimalPoint = parseInt(opts[1].substring(opts[1].indexOf(",") + 1));
		if(isNaN(decimalPoint)){		decimalPoint = 0;		}					// 정보가 숫자가 아닐경우 소수점자리수 제한을 하지 않는다.
	}

	switch(mode){
		case "float" :
			if(isNaN(value)){
				alert(msg);
				obj.focus();
				return false;
			}else{
				// 소수점 앞에 값이 없을 경우 0을 채워넣고, 폼값도 변경한다.
				if(value.substring(0, 1) == "."){	obj.value  = value = "0"+value;		}
				if(value.substring(0, 2) == "-."){	obj.value  = value = value.replace(/\-\./, "-0.");		}

				if(decimalPoint > 0){
					var floatValues = value.split(".");

					// 소수점 이하의 값이 존재하고, 제한된 자리수 이상일경우 
					if(floatValues.length > 1 && floatValues[1].length > decimalPoint){
						alert(jutil.form.validateMsg.num_point2.replace(/\$1/g, decimalPoint));
						obj.focus();
						return false;
					}
				}
			}
			break;
		default :
			if(isNaN(value)){
				alert(msg);
				obj.focus();
				return false;
			}else{
				if(value.indexOf(".") > -1){
					alert(jutil.form.validateMsg.num_point1);
					obj.focus();
					return false;
				}
			}
			break;
	}
	
	return true;
}



jutil.form.validate_minmax = function(obj){
	/*	해당 오브젝트의 값이 범위 내의 값인지 체크한다.
			- validate_minmax = "on"			: 정수만허용 (default) 
			- jutil.form.validate_num을 선행후 동작한다. (validate_num 이 지정되어 있지 않을경우, validate_num옵션을 default 값으로 지정후 동작한다.)
			- 
			- 공백을 제거후 값이 존재 하지 않을 경우 동작하지 않는다. 
			- INPUT type="text"와 Textarea 
	*/
	if(obj.tagName != "INPUT" || obj.type.toUpperCase() != "TEXT"){		return true;		}

	obj.validate_num		= obj.validate_num ? obj.validate_num : "on";
	obj.validate_num_msg	= obj.validate_num_msg ? obj.validate_num_msg : jutil.form.validateMsg.num;

	// 숫자가 아닐경우 처리하지 않는다.
	if(!jutil.form.validate_num(obj)){
		return false;
	}

	// 폼값의 좌우 공백제거 
	obj.value	= jutil.string.trim(obj.value);
	var value	= obj.value;
	var opts	= Array();
	var opt		= obj.validate_minmax;
	var msg		= obj.validate_minmax_msg;
	opts		= opt.split(",");

	var min		= opts[0];
	var max		= opts[1];

	if(min != "" && max != ""){
		if(value*1 < min*1 || value*1 > max*1){
			msg = msg ? msg : jutil.form.validateMsg.num_minmax;
			msg = msg.replace(/\$1/g, min);
			msg = msg.replace(/\$2/g, max);
			alert(msg);
			obj.focus();
			return false;
		}
	}else if(min != ""){
		if(value*1 < min*1){
			msg = msg ? msg : jutil.form.validateMsg.num_min;
			msg = msg.replace(/\$1/g, min);
			alert(msg);
			obj.focus();
			return false;
		}
	}else if(max != ""){
		if(value*1 > max*1){
			msg = msg ? msg : jutil.form.validateMsg.num_max;
			msg = msg.replace(/\$1/g, max);
			alert(msg);
			obj.focus();
			return false;
		}
	}
	
	return true;
}


jutil.form.validate_eng = function(obj){
	/*	해당 오브젝트의 숫자인지 체크한다.
			- validate_eng = "on"			: 영어만허용 (default) 
			- validate_num = "on|big"		: 영어 대문자만 허용
			- validate_num = "on|small"		: 영어 소문자만 허용   
			- 공백을 제거후 값이 존재 하지 않을 경우 동작하지 않는다. 
			- INPUT type="text"와 Textarea 
	*/
	if(obj.tagName != "INPUT" || obj.type.toUpperCase() != "TEXT"){		return true;		}

	// 폼값의 좌우 공백제거 
	obj.value	= jutil.string.trim(obj.value);
	var value	= obj.value;
	var opts	= Array();
	var opt		= obj.validate_eng;
	var	mode	= "default";
	var regexp	= "";

	// 예외 처리
	if(value == ""){					return true;		}		// 값이 없을 경우 처리하지 않는다.
	if(opt.substring(0, 2) != "on"){	return true;		}		// 옵션이 지정되지 않을 경우 처리하지 않는다.
	
	// 지정된 옵션 정보 가져오기
	opts = opt.split("|");

	// 각 옵션에 따른 처리 모드 변경
	if(opts.length == 1){						mode = "default";		}
	else if(opts[1].indexOf("big") > -1){		mode = "big";			}
	else{										mode = "small";			}

	switch(mode){
		case "big" :
			regexp	= jutil.form.validateRegExp.engBig;
			msg		= obj.validate_eng_msg ? obj.validate_eng_msg : jutil.form.validateMsg.engBig;
			break;
		case "small" :
			regexp	= jutil.form.validateRegExp.engSmall;
			msg		= obj.validate_eng_msg ? obj.validate_eng_msg : jutil.form.validateMsg.engSmall;
			break;
		default :
			regexp	= jutil.form.validateRegExp.eng;
			msg		= obj.validate_eng_msg ? obj.validate_eng_msg : jutil.form.validateMsg.eng;
			break;
	}
	
	if(regexp.test(value)){
		alert(msg);
		obj.focus();
		return false;
	}
	
	return true;
}

jutil.form.validateHandler_eng = function(obj, opt_){
	/*	폼의 이벤트 핸들러로 지정하여 영어 이외의 값들이 입력될 경우, 영어 이외 값을 지운다.
			- 이벤트 발생 시점의 문제로 인해 아래와 같이 두개의 이벤트 항목에 지정한다.
			   onkeydown="jutil.form.validateHandler_eng()"
			   onblur="jutil.form.validateHandler_eng()"
	*/
	
	var opt = opt_ ? opt_ : "";
	var value = obj.value;
	var regexp = "";
	var repexp = "";
	
	switch(opt){
		case "big" :	regexp = jutil.form.validateRegExp.engBig;		break;
		case "small" :	regexp = jutil.form.validateRegExp.engSmall;	break;
		default :		regexp = jutil.form.validateRegExp.eng;			break;
	}

	value = value.replace(regexp, repexp);
	obj.value = value;
}


jutil.form.getCheckboxValue = function(name){
	/*	해당 이름의 체크박스에서 선택된 값들을 배열로 반환한다.
	*/
	var rv	= Array();
	var obj = jutil.e(name, "name");
	for(var i=0 ; i < obj.length ; i++){
		if(obj[i].checked){	rv.push(obj[i].value);	}
	}
	return rv;
}

jutil.form.getRadioValue = function(name){
	/*	해당 이름의 라디오버튼에서 선택된 값을 반환한다.
	*/
	var obj = jutil.e(name, "name");
	for(var i=0 ; i < obj.length ; i++){
		if(obj[i].checked){	return obj[i].value;	}
	}
	return null;
}

jutil.form.getCheckboxValue = function(name){
	/*	해당 이름의 체크박스에서 선택된 값들을 배열로 반환한다.
	*/
	var obj = jutil.e(name, "name");
	var rv	= Array();
	for(var i=0 ; i < obj.length ; i++){
		if(obj[i].checked){	rv.push(obj[i].value);	}
	}
	return rv;
}


jutil.form.setChecked = function(name, arr){
	/*	해당 이름의 체크박스에서 해당 값에 해당 하는 항목을 체크처리 한다.
			- 라디오버튼에도 사용가능
	*/
	var obj = jutil.e(name, "name");
	for(var i=0 ; i < obj.length ; i++){
		obj[i].checked = jutil.array.in_array(arr, obj[i].value);
	}
}


jutil.form.setCheckAll = function(name, checked){
	/*	해당 이름의 체크박스를 전체 선택, 해제 처리한다.
	*/
	var obj = jutil.e(name, "name");
	for(var i=0 ; i < obj.length ; i++){
		obj[i].checked = checked;
	}
}


jutil.form.setSelect = function(name, value){
	/*	해당 name이나 id인 항목의 select 오브젝트에서 value값에 해당하는 항목을 선택 처리한다.
	*/
	var o	= jutil.o(name);
	var sel	= o[name];

	if(sel.tagName == "SELECT"){
		for(var i=0 ; i < sel.length ; i++){
			if(sel[i].value == value){
				sel[i].selected = true;
			}
		}
	}else{
		jutil.error(name + " 오브젝트는 SELECT 오브젝트가 아닙니다.");
	}
}


jutil.form.fill = function(node, info){
	/*	xml 정보와 fill 정보를 받아서 데이터를 채워넣는다.
	*/
	try{
		for(var key in info){
			var obj		= jutil.e(info[key]);

			if(obj){
				var value	= jutil.xml.selectSingleNodeValue(node, key);

				switch(obj.tagName){
					case "INPUT" : 

						switch(obj.type.toUpperCase()){
							case "TEXT" :	obj.value	= value;	break;
							case "CHECKBOX" :
								jutil.form.setChecked(obj.name, value.split(","));
								break;
							default :
								jutil.error("jutil.form.fill : " + obj.type.toUpperCase() + "에 대한 기능이 정의되지 않았습니다.");
								return;
						}

						break;
					case "TEXTAREA" :		obj.value	= value;	break;
					case "SELECT" :
						for(var i=0 ; i < obj.length ; i++){	obj[i].selected = (obj[i].value == value);	}
						break;
					default :
						jutil.error("jutil.form.fill : " + obj.tagName + "에 대한 기능이 정의되지 않았습니다.");
						return;
				}
			}else{	jutil.error("jutil.form.fill : " + info[key] + "항목이 존재하지 않습니다.");	}
		}
	}catch(ex){		jutil.error("jutil.form.fill : ", ex);	}
}


jutil.form.clear = function(id){
	/*	해당 오브젝트의 하위 오브젝트중에서 FORM 구성요소의 값을 모두 지운다.
	*/
	var elements = jutil.form.getFormElements(jutil.e(id));

	for(var i=0 ; i < elements.length ; i++){
		var obj = elements[i];

		switch(obj.tagName){
			case "INPUT" :
				switch(obj.type){
					case "text" : 		obj.value = "";																			break;
					case "checkbox" :	jutil.form.setChecked(obj.name, []);													break;
					default :			jutil.error("jutil.form.clear : " + obj.type + "에 대한 기능이 정의되지 않았습니다.");	break;
				}
				break;
			case "TEXTAREA" :	obj.value = "";																					break;
			case "SELECT" :		obj[0].selected = true;																			break;
			default :			jutil.error("jutil.form.clear : " + obj.tagName + "에 대한 기능이 정의되지 않았습니다.");		break;
		}
	}
}


jutil.form.getFormElements = function(obj){
	/*	해당 오브젝트의 하위 오브젝트중에서 FORM 구성요소를 배열로 반환한다.
			- 라디오, 체크박스등은 미결
	*/
	var rv = Array();
	var objs = obj.getElementsByTagName("INPUT");
	for(var i=0 ; i < objs.length ; i++){	rv.push(objs[i]);	}
	var objs = obj.getElementsByTagName("TEXTAREA");
	for(var i=0 ; i < objs.length ; i++){	rv.push(objs[i]);	}
	var objs = obj.getElementsByTagName("SELECT");
	for(var i=0 ; i < objs.length ; i++){	rv.push(objs[i]);	}


	return rv;
}



jutil.form.checkbox = function(info){
	/*	체크박스 구성정보를 받아서 해당 영역에 체크박스를 구성한다.
	*/
	if(info["type"]){
		switch(info["type"]){
			case "xml" :	jutil.form.checkbox_xml(info);	break;
			case "dwr" :	jutil.form.checkbox_dwr(info);	break;
			default :
				jutil.error("jutil.form.checkbox : " + info["type"] + "에 대한 기능이 정의되지 않았습니다.");
				return;
		}
	}else{
		jutil.error("jutil.form.checkbox : type 항목이 지정되지 않았습니다.");
		return;
	}
}


jutil.form.checkbox_dwr = function(info){
	/*	DWR 정보를 받아서 체크박스를 구성한다.
			data		: 체크박스를 구성할 DWR 데이터
			cols		: 가로방향의 개수
			area_id		: 체크박스를 적용할 영역의 아이디
			field_value	: DWR 데이터중에서 체크박스의 값으로 지정
			field_text	: DWR 데이터중에서 체크박스의 내용으로 지정, Array로 전달될 경우에는 콤마로 구분해서 모두 출력됨.
			
			적용할 영역의 하위 항목들은 초기화 시킨다.
	*/
	try{
		var cols			= info["cols"] ? info["cols"] : info.data.length;
		var rows			= info["cols"] ? parseInt(info.data.length / cols) + 1 : 1;
		var objTable		= jutil.dhtml.getTableObject("jutil_form_checkbox_dwr_table_" + Math.random(), rows, cols);
		var objTds			= objTable.getElementsByTagName("TD");
		var objArea			= jutil.e(info["area_id"]);
		var attr			= info["attr"] ? info["attr"] : ""; 

		if(info.checkedValue){
			var checkedValue		= (typeof(info.checkedValue) == "string") ? info.checkedValue.split(",") : info.checkedValue;
		}else{	var checkedValue	= Array();	} 

		for(var i=0 ; i < info.data.length ; i++){
			var value	= info.data[i][info["field_value"]];
			var checked	= jutil.array.in_array(checkedValue, value) ? " checked" : "";

			if(typeof(info["field_text"]) != "object"){
				var text = info.data[i][info["field_text"]];
			}else{
				var arr	= [];
				for(var j=0 ; j < info["field_text"].length ; j++){
					arr.push(info.data[i][info["field_text"][i]]);
				}
				var text = arr.join(",");
			}
			
			
			objTds[i].noWrap		= true;
			objTds[i].style.padding	= "2px 3px 2px 3px";
			objTds[i].innerHTML	= "<input type='checkbox' id='" + info["object_id"] + "' name='" + info["object_id"] + "' value='" + value + "' " + checked + " " + attr + "> " + text;
		}
		objArea.innerHTML	= "";
		objArea.appendChild(objTable);
	}catch(ex){	jutil.error("jutil.form.checkbox_dwr : " + ex);	}
}


jutil.form.checkbox_xml = function(info){
	/*	XML 정보를 받아서 체크박스를 구성한다.
			data		: 체크박스를 구성할 XML 데이터
			cols		: 가로방향의 개수
			area_id		: 체크박스를 적용할 영역의 아이디
			field_value	: XML 데이터중에서 체크박스의 값으로 지정할 노드의 태그이름
			field_text	: XML 데이터중에서 체크박스의 내용으로 지정할 노드의 태그이름
			
			적용할 영역의 하위 항목들은 초기화 시킨다.
	*/
	try{
		var datas		= jutil.xml.childNodes(info["data"]);
		var cols		= info["cols"] ? info["cols"] : datas.length;
		var rows		= info["cols"] ? parseInt(datas.length / cols) + 1 : 1;
		var objTable	= jutil.dhtml.getTableObject("jutil_form_checkbox_xml_table_" + Math.random(), rows, cols);
		var objTds		= objTable.getElementsByTagName("TD");
		var objArea		= jutil.e(info["area_id"]);


		for(var i=0 ; i < datas.length ; i++){
			var value	= jutil.xml.selectSingleNodeValue(datas[i], info["field_value"]);

			if(typeof(info["field_text"]) != "object"){
				var text = jutil.xml.selectSingleNodeValue(datas[i], info["field_text"]);
			}else{
				var arr	= [];
				for(var j=0 ; j < info["field_text"].length ; j++){
					arr.push(jutil.xml.selectSingleNodeValue(datas[i], info["field_text"][j]));
				}
				var text = arr.join(",");
			}
			
			
			objTds[i].noWrap	= true;
			objTds[i].innerHTML	= "<input type='checkbox' id='" + info["object_id"] + "' name='" + info["object_id"] + "' value='" + value + "'> " + text;
		}

		objArea.innerHTML	= "";
		objArea.appendChild(objTable);
	}catch(ex){	jutil.error("jutil.form.checkbox_xml : " + ex);	}
}



jutil.form.select = function(info){
	/*	모든 select 인터페이스를 구성한다.
	*/
	if(info["type"]){
		switch(info["type"]){
			case "array" :	jutil.form.select_arr(info);	break;
			case "xml" :	jutil.form.select_xml(info);	break;
			case "dwr" :	jutil.form.select_dwr(info);	break;
			case "obj" :	jutil.form.select_obj(info);	break;
			case "num" :	jutil.form.select_num(info);	break;
			default :
				jutil.error("jutil.form.select : " + info["type"] + "에 대한 기능이 정의되지 않았습니다.");
				return;
		}
	}else{
		jutil.error("jutil.form.select : type 항목이 지정되지 않았습니다.");
		return;
	}
}


/*
	 2008-07-11 jerryju, 순서 Select 박스 구성시, 역순 추가 합니다.

	- 기존 것은 start < end 건만 제대로 디스플레이 되었습니다. (1,2,3,4,5 이런 방식)
	  역순으로 start > end 로 들어 올 경우 디스플레이 안되던 것을 
	  디스플레이 되도록 기능 추가 합니다.(5,4,3,2,1 이런 방식)
*/
jutil.form.select_num = function(info){
	/*	숫자 범위를 기준으로 select 인터페이스를 구성한다.
	*/

	// 파라미터 검증
	if(!info["start"]){			jutil.error("jutil.form.select_num : start 항목이 지정되지 않았습니다.");		return;	}
	if(!info["end"]){			jutil.error("jutil.form.select_num : end 항목이 지정되지 않았습니다.");			return;	}
	if(!info["area_id"]){		jutil.error("jutil.form.select_num : area_id 항목이 지정되지 않았습니다.");		return;	}


	// 인터페이스 구성
	var arr			= new Array();
	var id			= info["object_id"] ? info["object_id"] : Math.random();
	var onchange	= info["fn_name_onchange"] ? " onchange=\"" + info["fn_name_onchange"] + "(this);\"" : "";
	var style		= info["style"] ? " style=\"" + info["style"] +"\"" : " style=\"border:1pt solid #999999; font-size:9pt; color:#333333;\"";
	//onchange		= get_edit_mode_onchange(info, onchange);

	//arr.push("<select id=\"" + id + "\"" + onchange + style + get_edit_mode_attribute(info) + ">");
	arr.push("<select id=\"" + id + "\" name=\"" + id + "\"" + onchange + style + ">");
	if(typeof(info["subject"]) == "string"){	arr.push("<option>" + info["subject"] + "</option>");	}
	if(info["start"] <= info["end"]) {
		for(var i=info["start"] ; i <= info["end"] ; i++){
			var value		= i;
			var text		= i + (info["tail"] ? info["tail"] : "");
			var is_select	= info["selected_value"] == value ? true : false;
			arr.push("<option value=\"" + value + "\" " + (is_select ? "selected" : "") + ">" + text + "</option>");
		}
	} else {
		// 2008-07-11 jerryju, 역순추가
		for(var i=info["start"] ; i >= info["end"] ; i--){
			var value		= i;
			var text		= i + (info["tail"] ? info["tail"] : "");
			var is_select	= info["selected_value"] == value ? true : false;
			arr.push("<option value=\"" + value + "\" " + (is_select ? "selected" : "") + ">" + text + "</option>");
		}
	}
	arr.push("</select>");

	// 등록 및 리턴
	jutil.e(info["area_id"]).innerHTML = arr.join("");
	return jutil.e(id);
}



jutil.form.select_dwr = function(info){
	/*	DWR을 통해서 반환된 리스트 데이터를 기준으로 select 인터페이스를 구성한다.
		리턴되는 타입은 java.util.List 이다.
	*/

	// 파라미터 검증
	if(!info["data"]){			jutil.error("jutil.form.select_dwr : data 항목이 지정되지 않았습니다.");		return;	}
	if(!info["field_value"]){	jutil.error("jutil.form.select_dwr : field_value 항목이 지정되지 않았습니다.");	return;	}
	if(!info["field_text"]){	jutil.error("jutil.form.select_dwr : field_text 항목이 지정되지 않았습니다.");	return;	}
	if(!info["area_id"]){		jutil.error("jutil.form.select_dwr : area_id 항목이 지정되지 않았습니다.");		return;	}


	// 인터페이스 구성
	var arr			= new Array();
	var id			= info["object_id"] ? info["object_id"] : Math.random();
	var onchange	= info["fn_name_onchange"] ? " onchange=\"" + info["fn_name_onchange"] + "(this);\"" : "";
	var style		= " style=\"border:1pt solid #999999; font-size:9pt; color:#333333;\"";
	//onchange		= get_edit_mode_onchange(info, onchange);

	//arr.push("<select id=\"" + id + "\"" + onchange + style + get_edit_mode_attribute(info) + ">");
	var multiple = "";
	if(info["multiple"] == "Y")	multiple = "multiple size='10' style='width:150px;'";
	arr.push("<select id=\"" + id + "\" name=\"" + id + "\"" + onchange + style + multiple +" >");
	if(typeof(info["subject"]) == "string"){	arr.push("<option value=''>" + info["subject"] + "</option>");	}
	for(var i=0 ; i < info["data"].length ; i++){
		var value		= info["data"][i][info["field_value"]];
		var text		= info["data"][i][info["field_text"]];
		var is_select	= info["selected_value"] == value ? true : false;
		arr.push("<option value=\"" + value + "\" " + (is_select ? "selected" : "") + ">" + text + "</option>");
	}
	arr.push("</select>");

	// 등록 및 리턴
	jutil.e(info["area_id"]).innerHTML = arr.join("");
	return jutil.e(id);
}



jutil.form.select_obj = function(info){
	/*	오브젝트 방식의 데이터를 받아서 select 인터페이스를 구성한다.
	*/

	// 파라미터 검증
	if(!info["data"]){			jutil.error("jutil.form.select_obj : data 항목이 지정되지 않았습니다.");		return;	}
	if(!info["area_id"]){		jutil.error("jutil.form.select_obj : area_id 항목이 지정되지 않았습니다.");		return;	}


	// 인터페이스 구성
	var arr			= new Array();
	var id			= info["object_id"] ? info["object_id"] : Math.random();
	var onchange	= info["fn_name_onchange"] ? " onchange=\"" + info["fn_name_onchange"] + "(this);\"" : "";
	var style		= " style=\"border:1pt solid #999999; font-size:9pt; color:#333333;\"";
	//onchange		= get_edit_mode_onchange(info, onchange);

	//arr.push("<select id=\"" + id + "\"" + onchange + style + get_edit_mode_attribute(info) + ">");
	arr.push("<select name=\"" + id + "\" id=\"" + id + "\"" + onchange + style + ">");
	if(typeof(info["subject"]) == "string"){	arr.push("<option value=''>" + info["subject"] + "</option>");	}
	
	for(var key in info["data"]){
		var value		= key;
		var text		= info["data"][key];
		var is_select	= info["selected_value"] == value ? true : false;
		arr.push("<option value=\"" + value + "\" " + (is_select ? "selected" : "") + ">" + text + "</option>");	
	}
	arr.push("</select>");

	// 등록 및 리턴
	jutil.e(info["area_id"]).innerHTML = arr.join("");
	return jutil.e(id);
}



jutil.form.select_arr = function(info){
	/*	1차 배열을 받아서 select 인터페이스를 구성한다.
	*/
	if(!info["data"]){			jutil.error("jutil.form.select_arr : data 항목이 지정되지 않았습니다.");		return;	}
	if(!info["area_id"]){		jutil.error("jutil.form.select_arr : area_id 항목이 지정되지 않았습니다.");		return;	}

	// 인터페이스 구성
	var arr			= new Array();
	var id			= info["object_id"] ? info["object_id"] : Math.random();
	var onchange	= info["fn_name_onchange"] ? " onchange=\"" + info["fn_name_onchange"] + "(this);\"" : "";
	var style		= " style=\"border:1pt solid #999999; font-size:9pt; color:#333333;\"";

	arr.push("<select id=\"" + id + "\"" + onchange + style + ">");
	if(info["subject"]){	arr.push("<option>" + info["subject"] + "</option>");	}
	for(var i=0 ; i < info["data"].length ; i++){
		var is_select = info["selected_value"] ? (info["selected_value"] == info["data"][i] ? true : false) : false;
		arr.push("<option value=\"" + info["data"][i] + "\" " + (is_select ? "selected" : "") + ">" + info["data"][i] + "</option>");
	}
	arr.push("</select>");

	// 등록 및 리턴
	jutil.e(info["area_id"]).innerHTML = arr.join("");
	return jutil.e(id);
}


jutil.form.select_xml = function(info){
	/*	select 폼 구성요소 정보를 받아서 select 인터페이스를 구성한다.
		XML 데이터를 받아서 구성된다.
	*/
	// 파라미터 검증
	if(!info["data"]){			jutil.error("jutil.form.select_xml : data 항목이 지정되지 않았습니다.");		return;	}
	if(!info["field_value"]){	jutil.error("jutil.form.select_xml : field_value 항목이 지정되지 않았습니다.");	return;	}
	if(!info["field_text"]){	jutil.error("jutil.form.select_xml : field_text 항목이 지정되지 않았습니다.");	return;	}
	if(!info["area_id"]){		jutil.error("jutil.form.select_xml : area_id 항목이 지정되지 않았습니다.");		return;	}


	// 인터페이스 구성
	var arr			= new Array();
	var id			= info["object_id"] ? info["object_id"] : Math.random();
	var onchange	= info["fn_name_onchange"] ? " onchange=\"" + info["fn_name_onchange"] + "(this);\"" : "";
	var style		= " style=\"border:1pt solid #999999; font-size:9pt; color:#333333;\"";
	//onchange		= get_edit_mode_onchange(info, onchange);

	//arr.push("<select id=\"" + id + "\"" + onchange + style + get_edit_mode_attribute(info) + ">");
	arr.push("<select id=\"" + id + "\"" + onchange + style + ">");
	if(typeof(info["subject"]) == "string"){	arr.push("<option>" + info["subject"] + "</option>");	}
	var datas = jutil.xml.childNodes(info["data"]);
	for(var i=0 ; i < datas.length ; i++){
		var value		= jutil.xml.selectSingleNodeValue(datas[i], info["field_value"]);
		var text		= jutil.xml.selectSingleNodeValue(datas[i], info["field_text"]);
		var is_select	= info["selected_value"] ? (jutil.xml.selectSingleNodeValue(datas[i], info["selected_value"]) == value ? true : false) : false;
		arr.push("<option value=\"" + value + "\" " + (is_select ? "selected" : "") + ">" + text + "</option>");
	}
	arr.push("</select>");


	// 등록 및 리턴
	jutil.e(info["area_id"]).innerHTML = arr.join("");
	return jutil.e(id);
}


jutil.form.limitStringInfo = {}
jutil.form.limitStringInfo.num	= String("0123456789").split("");		// 숫자만 허용할 경우

jutil.form.limitString = function(obj, checkInfo, msg, allowDeny){
	/*	text 입력폼에 해당 문자만 등록이 가능하도록 설정한다.
			input type="text" 나 textarea에 설정
			onblur에 이벤트를 적용한다.
	*/
	obj.jutil_form_limitStringInfo		= checkInfo;
	obj.jutil_form_limitStringAllowDeny	= allowDeny ? allowDeny : "allow";
	obj.jutil_form_limitStringMsg		= msg;
	jutil.eventAdd(obj, "onblur", jutil.form.limitStringCheck);
}


jutil.form.limitStringCheck = function(){
	/*	jutil.form.limitString 의 이벤트를 실제 체크하는 함수
	*/
	var obj				= jutil.eventSrc();
	var checkInfo		= eval(obj.jutil_form_limitStringInfo);
	var allowDeny		= obj.jutil_form_limitStringAllowDeny;
	var msg				= obj.jutil_form_limitStringMsg;
	var checkValue		= obj.value;
	var is_msg			= false;


	if(allowDeny == "allow"){
		var replaceValue = Array();
		chkArr = checkValue.split("");
		
		for(var i=0 ; i < chkArr.length ; i++){
			if(jutil.array.in_array(checkInfo, chkArr[i])){
				replaceValue.push(chkArr[i]);
			}else{	is_msg = true;	}
		}
		obj.value = replaceValue.join("");
	}else{
	}

	if(is_msg){		alert(msg);		obj.focus();		}
}


/**********************************************************************************************************************************************************************************
	작성자 : 김기석
	작성일 : 2007.07.10

	목적 :
		- 웹 기반의 자바스크립트 유틸 모음
		- 배열 처리 관련 기능 모음

	참고사항 :
		- 
**********************************************************************************************************************************************************************************/


if(typeof(jutil) != "object"){			jutil			= {};	}
if(typeof(jutil.array) != "object"){	jutil.array		= {};	}


jutil.array.in_array = function(arr, value){
	/*	해당 값이 해당 배열에 존재하는지 여부를 반환한다.
	*/
	for(var i=0 ; i < arr.length ; i++)
		if(arr[i] == value)	return true;
	return false;
}


jutil.array.removeAt = function(arr, idx){
	/*	배열에서 지정한 위치의 정보를 삭제한다.
	*/
	var rv = [];
	for(var i=0 ; i < arr.length ; i++){	if(i != idx){	rv.push(arr[i]);	}	}
	return rv;
}


jutil.array.insertAt = function(arr, idx, obj){
	/*	배열에서 지정한 위치에 해당 오브젝트를 추가한다.
			- splice 함수가 이상해서 루프로 처리
	*/
	var rv = [];
	if(arr.length > 0){
		for(var i=0 ; i < arr.length ; i++){
			if(i == idx){	rv.push(obj);	}
			rv.push(arr[i]);
		}
	}else{	rv.push(obj);	}
	return rv;
}


jutil.array.removeLast = function(arr, n){
	/*	배열에서 마지부터 n개 항목을 제거한다.
	*/
	var n	= typeof(n) == "number" ? n : 0;
	var rv	= [];
	for(var i=0 ; i < arr.length - n ; i++){	rv.push(arr[i]);	}
	return rv;
}


/**********************************************************************************************************************************************************************************
	작성자 : 김기석
	작성일 : 2007.07.10

	목적 :
		- 웹 기반의 자바스크립트 유틸 모음
		- 배열 처리 관련 기능 모음

	참고사항 :
		- 
**********************************************************************************************************************************************************************************/


if(typeof(jutil) != "object"){			jutil			= {};	}
if(typeof(jutil.string) != "object"){	jutil.string	= {};	}


jutil.string.trim = function(str){
	/*	좌우 공백 제거처리
	*/
	return str.replace(/^\s+|\s+$/g,"");
}

jutil.string.ltrim = function(str){
	/*	좌측 공백 제거 처리
	*/
	return str.replace(/^\s+/,"");
}


jutil.string.rtrim = function(str){
	/*	우측 공백 제거 처리
	*/
	return str.replace(/\s+$/,"");
}


jutil.string.replace = function(str, search, replace){
	/*	해당 문자열을 찾아서 변경한다.
			replace와 동일 기능
			함수가 필요한 경우에 활용한다.
	*/
	return str.replace(new RegExp(search, "gim"), replace);
}


jutil.string.right_cut = function(str, length){
	/*	문자열에서 오른쪽에서 n개 문자를 제거해서 반환한다.
	*/
	return str.substring(0, str.length - length);
}


jutil.string.left = function(str, length){
	/*	문자열에서 왼쪽에서 n번째 까지의 문자를 반환한다.
	*/
	return str.substring(0, length);
}


jutil.string.right = function(str, length){
	/*	문자열에서 오른쪽에서 n번째 까지의 문자를 반환한다.
	*/
	return str.substring(str.length - length, str.length);
}


jutil.string.comma = function(str){
	/*	문자열에 콤마 추가 - 금액을 표시할때 사용
	*/
	var newVal = "";
	str = str + "";
	str = str.replace(/,/g,"") + "";
	for(var i=str.length-1 ; i >=0 ; i--){
		newVal = str.substring(i, i+1) + newVal;
		var chkVal = newVal.replace(/,/gi,"");
		if(chkVal.length%3 == 0 && i != 0){	newVal = "," + newVal;	}
	}
	return newVal;
}


jutil.string.getFileExt = function(str){
	/*	파일 경로정보를 받았을 경우에 해당 파일의 확장자를 반환한다.
	*/
	var tmpArr = str.split(".");
	return tmpArr[tmpArr.length - 1];
}




/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2007.11.23

	기능 : 
			- 파일 업로드 기능을 처리하기 위한 클래스

	참고사항 : 
			- 서버측의 파일 매니저와 연동되어서 사용된다.
			- 서버측의 파일 매니저는 지정된 임시폴더에 파일을 저장하고 파일정보를 리턴해주는 것으로 기능을 종료한다.
			- 실제 파일 복사는 각각의 기능에서 처리한다.
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){			jutil			= {};			}
if(typeof(jutil.upload) != "object"){	jutil.upload	= new UPLOAD;	}




/*	클래스 시작
*/
function UPLOAD(){
	/*	클래스 전역 변수 정의부분
	*/
	this.list_id;


	/*	클래스에 필요한 정보를 초기화 한다.
	*/
	this.init = init;
	function init(conf){
		config	= conf;					// 정보 설정
	}


	/*	파일 등록 인터페이스를 구성한다.
			limit : 첨부용량 사이즈
			att_num : 첨부파일개수 제한
	*/
	this.form = form;
	function form(list_id, target, allow_type, limit, att_num){
		//var objWin = window.open("/site/aion/test.htm", "jutil_upload_window", "width=420, height=150");
		var objWin	= window.open("", "jutil_upload_window", "width=420, height=150");
		var objList	= jutil.e(list_id);
		objList.jutil_upload_att_num	= att_num;

		var html = Array();
		html.push("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>");
		html.push("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>");
		html.push("<HTML>");
		html.push("<HEAD>");
		html.push("<TITLE> 파일첨부 </TITLE>");
		html.push("");
		html.push("<style>");
		html.push("	td{		font-size : '9pt';	}");
		html.push("	.box{	border : 1pt solid;	}");
		html.push("	.link{	cursor : 'pointer';	}");
		html.push("</style>");
		html.push("");
		html.push("");
		html.push("</HEAD>");
		html.push("<BODY topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>");
		html.push("<script language='javascript' src='" + jutil.getBaseUrl() + "/JUTIL.js'></script>");
		html.push("<script language='javascript'>");
		html.push("	function doSubmit(){");
		html.push("		var file = jutil.e('attFile');");
		html.push("");
		html.push("		if(file.value == ''){");
		html.push("			alert('파일을 선택해 주십시오');");
		html.push("			file.focus();");
		html.push("			return;");
		html.push("		}");
		html.push("");
		html.push("		var f = jutil.e('jutil_upload_form');");
		html.push("		f.action = jutil.upload.action;");
		html.push("		f.submit();");
		html.push("	}");
		html.push("</script>");
		html.push("");
		html.push("<table cellpadding=0 cellspacing=0 border=0 width=100% height=100%>");
		html.push("	<form name='jutil_upload_form' action='' enctype='multipart/form-data' method='post'>");
		html.push("	<input type='hidden' name='act' value='add'>");
		html.push("	<input type='hidden' name='list_id' value='" + list_id + "'>");
		html.push("	<input type='hidden' name='att_num' value='" + att_num + "'>");
		html.push("	<input type='hidden' name='allow_type' value='" + allow_type + "'>");
		html.push("	<input type='hidden' name='target' value='" + target + "'>");
		html.push("	<input type='hidden' name='limit' value='" + limit + "'>");
		html.push("	<tr>");
		html.push("		<td align=center>");
		html.push("");
		html.push("			<TABLE cellpadding=2 cellspacing=1 border=0 width=400 height=130 bgcolor=#999999>");
		html.push("				<TR bgcolor=#FFFFFF>");
		html.push("					<TD align=center>");
		html.push("						파일첨부 : <input type='file' name='attFile' class='box'>");
		html.push("");
		html.push("						<div style='padding-top:15;'>");
		html.push("							<span class='link' onclick='doSubmit()'>[확인]</span>");
		html.push("							<span class='link' onclick='window.close()'>[취소]</span>");
		html.push("						</div>");
		html.push("					</TD>");
		html.push("				</TR>");
		html.push("			</TABLE>");
		html.push("");
		html.push("		</td>");
		html.push("	</tr>");
		html.push("	</form>");
		html.push("</table>");
		html.push("</BODY>");
		html.push("</HTML>");

		
		objWin.document.write(html.join(""));
	}




	/*	첨부된 파일정보를 받아서 목록 및 버튼을 처리한다.
	*/
	this.add = add;
	function add(list_id, name, size){
		var objList		= jutil.e(list_id);

		this.set_att_info(list_id, name, size);
		this.list_add(list_id, name, size);

		var att_info	= this.get_att_info(list_id);
		if(att_info.length >= objList.jutil_upload_att_num){	this.btn_display(list_id, "none");	}
		//if(att_info.length >= 1){	this.btn_display(list_id, "none");	}
	}


	/*	해당 목록 영역에 첨부된 파일정보중에서 해당 파일 정보를 삭제한다.
	*/
	this.remove_att_info = remove_att_info;
	function remove_att_info(list_id, name){
		var objList		= jutil.e(list_id);
		var att_info	= this.get_att_info(list_id);
		var tmp_info	= Array();

		for(var i=0 ; i < att_info.length ; i++){
			if(att_info[i]["name"] != name){
				tmp_info.push(att_info[i]);
			}
		}

		// 재설정
		objList.jutil_upload_att_info = "";
		for(var i=0 ; i < tmp_info.length ; i++){
			this.set_att_info(list_id, tmp_info[i]["name"], tmp_info[i]["size"]);
		}
	}

	

	/*	해당 목록 영역에 첨부된 파일정보를 반환한다.
	*/
	this.get_att_info = get_att_info;
	function get_att_info(list_id){
		var rv			= Array();
		var objList		= jutil.e(list_id);
		var att_info	= (objList.jutil_upload_att_info) ? objList.jutil_upload_att_info : "";

		if(att_info.length > 0){
			var info = att_info.split("&");

			for(var i=0 ; i < info.length ; i++){
				var arr = info[i].split("=");
				rv.push({"name" : arr[0], "size" : arr[1]});
			}
		}

		return rv;
	}



	/*	해당 목록 영역에 첨부된 파일정보를 추가한다.
	*/
	this.set_att_info = set_att_info;
	function set_att_info(list_id, name, size){
		var objList		= jutil.e(list_id);
		var att_info	= (objList.jutil_upload_att_info) ? objList.jutil_upload_att_info : "";
		att_info += (att_info.length > 0) ? "&" + name + "=" + size : name + "=" + size;
		objList.jutil_upload_att_info = att_info;
	}




	/*	파일등록 목록에 첨부된 파일을 추가한다.
	*/
	this.list_add = list_add;
	function list_add(list_id, name, size){
		// 실제 등록된 내용 디스플레이
		var objDiv			= document.createElement("DIV");
		objDiv.id			= "jutil_upload_file_list_" + name;
		objDiv.innerHTML	=	"<table cellpadding=0 cellspacing=0 border=0 width=100%>" +
								"	<tr>" +
								"		<td>" + name + "</td>" + 
								"		<td width=50 align=right><span style='cursor:hand;' onclick=\"jutil.upload.remove('" + list_id + "', '" + name + "')\"><img src='" + jutil.getBaseUrl() + "images/upload/" + jutil.upload.image.remove + "' border=0></span></td>" + 
								"	</tr>" + 
								"</table>";
		jutil.e(list_id).appendChild(objDiv);
	}


	/*	파일등록 목록에서 해당 파일정보를 삭제한다.
	*/
	this.list_remove = list_remove;
	function list_remove(list_id, name){
		var objDiv	= jutil.e("jutil_upload_file_list_" + name);
		objDiv.parentNode.removeChild(objDiv);
	}



	/*	파일 첨부 버튼의 디스플레이를 컨트를한다.
	*/
	this.btn_display = btn_display;
	function btn_display(list_id, opt){
		jutil.e(list_id + "Btn").style.display = opt;
	}



	/*	해당 리스트의 파일을 삭제한다.
	*/
	this.remove = remove;
	function remove(list_id, name){
		var objList	= jutil.e(list_id);
		var url		= jutil.upload.action + "?act=remove&fname=" + name + "&list_id=" + list_id;
		var result	= jutil.xmlhttp.request_url(url, false);

		if(result == "success"){
			this.list_remove(list_id, name);
			this.remove_att_info(list_id, name);

			var att_info = this.get_att_info(list_id);
			if(att_info.length < objList.jutil_upload_att_num){	this.btn_display(list_id, "");	}
		}else{
			alert("파일을 삭제하는데 장애가 발생 했습니다.");
		}
	}
}


/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2008.05.26

	기능 : 
			- 동영상 플레이어를 컨트롤 하는 기본 클래스

	참고사항 : 
			- 윈도우 미디어 플레이어 버전 11을 기준으로 기본적인 컨트롤 기능을 구현한다.
			- HTML 에서는 다음 태그로 플레이어를 삽입한다.
				<embed 
					id="mplayer"
					TYPE="application/x-mplayer2" 
					pluginspage="http://www.microsoft.com/windows/mediaplayer/en/download/Win32IE4x86.asp" 
					filename="sample.avi"
					Name="Vod Player"
					ShowControls="0"
					AutoStart="0"
					ShowDisplay="0"
					ShowPositionControls="0"
					ShowTracker="1"
					autoresize="0"
					ShowStatusBar="0"
					ClickToPlay="1"
					EnableFullScreenControls="1"
					SendKeyboardEvents="1"
					volume="-720"
					sendMouseClickEvents="1"
					SendMouseMoveEvents="1"
				></embed>
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){			jutil		= {};				}
if(typeof(jutil.vod) != "object"){		jutil.vod	= new VOD;			}


/*	클래스 시작
*/
function VOD(){
	/*	클래스 전역 변수 정의부분
	*/



	/*	동영상을 플레이 한다.
	*/
	this.play = play;
	function play(playerId){
		var oPlayer = jutil.e(playerId);
		if(oPlayer){
			if(oPlayer.Duration > 0){	oPlayer.play();	}
		}else{			this.trace(playerId + " 플레이어가 존재하지 않습니다.");	}
	}


	/*	동영상을 정지 시킨다.
	*/
	this.stop = stop;
	function stop(playerId){
		var oPlayer = jutil.e(playerId);
		if(oPlayer){
			if(oPlayer.Duration > 0){	oPlayer.stop();	}										
		}else{			this.trace(playerId + " 플레이어가 존재하지 않습니다.");	}

	}


	/*	동영상을 멈춤 시킨다.
	*/
	this.pause = pause;
	function pause(playerId){
		var oPlayer = jutil.e(playerId);
		if(oPlayer){	oPlayer.pause();											}
		else{			this.trace(playerId + " 플레이어가 존재하지 않습니다.");	}
	}


	/*	현재 동영상의 플레이 위치를 퍼센트로 반환한다.
	*/
	this.getPlayPosition = getPlayPosition;
	function getPlayPosition(playerId){
		var oPlayer = jutil.e(playerId);
		if(oPlayer){
			return Math.round(oPlayer.CurrentPosition / oPlayer.Duration * 100);
		}else{			this.trace(playerId + " 플레이어가 존재하지 않습니다.");	}
	}


	/*	현재 동영상의 플레이 위치를 퍼센트로 지정한다.
	*/
	this.setPlayPosition = setPlayPosition;
	function setPlayPosition(playerId, posPer){
		var oPlayer = jutil.e(playerId);
		if(oPlayer){
			var pos = oPlayer.Duration * posPer / 100;
			oPlayer.CurrentPosition = pos;
		}else{			this.trace(playerId + " 플레이어가 존재하지 않습니다.");	}
	}



	/*	현재 플레이 타임을 반환한다.
	*/
	this.getCurrentPosition = getCurrentPosition;
	function getCurrentPosition(playerId){
		var oPlayer = jutil.e(playerId);
		if(oPlayer){	return oPlayer.CurrentPosition;									}
		else{			this.trace(playerId + " 플레이어가 존재하지 않습니다.");	}
	}




	/*	전체 플레이 타임을 반환한다.
	*/
	this.getDuration = getDuration;
	function getDuration(playerId){
		var oPlayer = jutil.e(playerId);
		if(oPlayer){	return oPlayer.Duration;									}
		else{			this.trace(playerId + " 플레이어가 존재하지 않습니다.");	}
	}



	/*	음소거
			- 플레이어의 음소거 속성에 따라 자동으로 전환처리
	*/
	this.Mute = Mute;
	function Mute(playerId){
		var oPlayer = jutil.e(playerId);
		if(oPlayer){
			oPlayer.Mute = !oPlayer.Mute;
		}else{			this.trace(playerId + " 플레이어가 존재하지 않습니다.");	}
	}


	/*	음소거 설정
	*/
	this.setMute = setMute;
	function setMute(playerId, opt){
		var oPlayer = jutil.e(playerId);
		if(oPlayer){	oPlayer.Mute = opt;									}
		else{			this.trace(playerId + " 플레이어가 존재하지 않습니다.");	}
	}

	/*	현재 볼륨 정보를 퍼센트로 반환한다.
			- 볼륨은 -10000 부터 0까지의 값을 가진다.(0이 최대값이다.)
	*/
	this.getVolume = getVolume;
	function getVolume(playerId){
		var oPlayer = jutil.e(playerId);
		if(oPlayer){	return oPlayer.Volume;										}
		else{			this.trace(playerId + " 플레이어가 존재하지 않습니다.");	}
	}


	/*	볼륨값을 지정한다.
	*/
	this.setVolume = setVolume;
	function setVolume(playerId, vol){
		var oPlayer = jutil.e(playerId);
		if(oPlayer){	oPlayer.Volume = vol;										}
		else{			this.trace(playerId + " 플레이어가 존재하지 않습니다.");	}
	}



	/*	테스트용 함수
	*/
	this.test = test;
	function test(playerId){
		var oPlayer = jutil.e(playerId);
		if(oPlayer){
			var arr = Array();

			for(var key in oPlayer){
				arr.push(key + "\n" + oPlayer[key] + "\n\n");
			}

			jutil.e("debugArea").value = arr.join("");

		}else{			this.trace(playerId + " 플레이어가 존재하지 않습니다.");	}
	}



	/*	메세지 처리
	*/
	this.trace = trace;
	function trace(msg){
		alert(msg);
	}
}



/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2007.05.29

	기능 : 
			- TREE 인터페이스를 구현하는 기능을 제공하는 클래스

	참고사항 : 
			- 깊이를 파이어폭스에서는 90, 익스플로어에서는 29 이상 들어갈 경우에 하위항목이 정상적으로 표출되지 않는 경우가 발생한다.
				- 실제 너무 깊이 들어갈 일이 없으므로 그냥 진행한다. 
				- 함수 호출의 시간차에서 문제가 발생하는 것으로 추측
				- 실제 HTML DOM에서 하위 오브젝트의 컨트롤에서 문제가 제기 될 수도 있음

				2007.06.22 일 JUTIL 용으로 코드 변경 작업
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){				jutil				= {};		}
if(typeof(jutil.widget) != "object"){		jutil.widget		= {};		}
if(typeof(jutil.widget.tree) != "object"){	jutil.widget.tree	= {};		}



jutil.widget.tree.current_area	= null;		// 마지막으로 컨트롤 되고 있는 트리 영역오브젝트
jutil.widget.tree.current_item	= null;		// 마지막으로 컨트롤 되고 있는 트리 아이템
jutil.widget.tree.items			= {};		// 트리에 등록된 아이템 오브젝트를 가지고 있는 오브젝트



jutil.widget.tree.imgInfo		= {
	/*	트리에서 사용하는 이미지 관련된 정보를 가지고 있는 오브젝트
	*/
	"path"	: jutil.getBaseUrl() + "/images/tree/", 
	"close"	: "plus.gif", 
	"open"	: "minus.gif", 
	"base"	: "none.gif" 
}




jutil.widget.tree.clear = function(id_area){
	/*	해당 영역의 트리 관련 정보를 초기화 한다.
			- 기존에 트리를 구현한 영역에 다시 트리를 구현할 경우에는 반드시 초기화를 시켜야 한다.
			- 기존의 아이템은 모두 제거 되므로 다시 사용할 수 없다.
	*/
	try{
		if(jutil.widget.tree.items[id_area]){
			for(var key in jutil.widget.tree.items[id_area]){
				var item = jutil.widget.tree.items[id_area][key];

				if(item["obj"].parentNode){
					item["obj"].parentNode.removeChild(item["obj"]);
				}
			}

			jutil.widget.tree.items[id_area]	= null;
			jutil.widget.tree.current_area		= null;
			jutil.widget.tree.current_item		= null;
		}
	}catch(ex){
		jutil.error("jutil.widget.tree.clear 에서 장애가 발생했습니다.", ex);
	}
}


jutil.widget.tree.add_pool		= Array();


jutil.widget.tree.add = function(info){
	/*	아이템을 등록한다.
			- 연속으로 appendChild가 발생할 경우 IE에서는 hangup이 발생할 수 있다.
			- 이때문에 타이머로 0.001초씩 딜레이를 적용한다.
	*/
	// 등록할때 아이템을 숨긴다.
	var obj = jutil.e(info.item);
	obj.style.display	= "none";
	

	// 아이템 매니저를 구동시킨다.
	jutil.widget.tree.add_pool.push(info);
	setTimeout("jutil.widget.tree.addManager()", 10);
}


jutil.widget.tree.add_item = function(info){
	/*	아이템을 등록한다.
			info는 오브젝트로 생성할 아이템의 정보를 포함하고 있다.
			info["id_area"]	: 트리를 생성할 영역의 아이디
			info["item"]	: 트리에 추가할 항목의 아이디
			info["item_up"]	: 트리에 추가할 항목의 상위 아이템의 아이디
	*/
	// 등록할때 아이템을 보이게 한다. => 이 라인이 밑으로 가면 해당 오브젝트를 못찾는다. 반드시 여기에 위치해야 한다.
	var obj = jutil.e(info.item);
	obj.style.display	= "";


	// 등록 처리시작
	jutil.widget.tree.add_process = true;
	var attrs	= jutil.widget.tree.getItemAttribute(info);
	if(!jutil.widget.tree.checkItem(attrs)){		return;		}
	var item	= jutil.widget.tree.getItem(attrs["id_area"], attrs["item"]);	// jutil.widget.tree.items 의 참조변수이므로 이 항목이 변경되면 jutil.widget.tree.items 도 같이 적용된다.

	
	// 실제등록처리
	if(attrs["item_up"] == ""){		jutil.widget.tree.current_area.appendChild(item["obj"]);								}
	else{
		try{
			var subLayer = jutil.widget.tree.getItemObjSub(attrs["item_up"]).appendChild(item["obj"]);
			jutil.widget.tree.setIcon(attrs["item_up"], attrs["sub_display"] == "yes" ? "open" : "close");
		}catch(ex){
			jutil.error("jutil.widget.tree.add_item : " + attrs["item"] + "을 등록하는데 실패 했습니다.", ex);
		}
	}

	jutil.widget.tree.add_process = false;
}


jutil.widget.tree.addManager = function(){
	/*	아이템 등록 처리 매니저
	*/
	var info = jutil.widget.tree.add_pool[0];
	jutil.widget.tree.add_pool.splice(0, 1);
	jutil.widget.tree.add_item(info);

	//	트리에 아이템이 모두 등록된 후에 항목이 디스플레이 되도록 한다.
	if(jutil.widget.tree.add_pool.length == 0){	jutil.widget.tree.current_area.style.display	= "";		}
	else{										jutil.widget.tree.current_area.style.display	= "none";	}
}


jutil.widget.tree.checkItem = function(attrs){
	/*	트리를 구성하는 아이템 정보가 정상적으로 구성되어 있는지 체크한다.
			- 관련된 기본 설정 및 값이 존재하지 않을 경우 자동으로 생성한다.
			- 해당 아이템 오브젝트도 같이 생성한다.
	*/
	try{
		// 생성 영역체크
		jutil.widget.tree.current_area	= jutil.e(attrs["id_area"]);
		if(jutil.widget.tree.current_area == null){	jutil.error("jutil.widget.tree.checkItem : 트리를 생성할 [" + attrs["id_area"] + "]영역이 존재하지 않습니다.");	return false;	}


		// 등록하려는 오브젝트의 존재 여부 체크
		if(jutil.e(attrs["item"]) == null){		jutil.error("jutil.widget.tree.checkItem : [" + attrs["item"] + "] 오브젝트는 존재하지 않습니다.");	return false;	}


		// 동일 아이디 존재 여부 체크
		if(!jutil.widget.tree.items[attrs["id_area"]]){						jutil.widget.tree.items[attrs["id_area"]]					= {};									}
		if(jutil.widget.tree.items[attrs["id_area"]][attrs["item"]]){		jutil.error("jutil.widget.tree.checkItem : [" + attrs["id_area"] + "]영역에 [" + attrs["item"] + "] 아이템은 이미 등록되었습니다.");	return false;	}
		else{																jutil.widget.tree.items[attrs["id_area"]][attrs["item"]]	= { "attrs" : attrs, "obj" : jutil.widget.tree.getItemObj(attrs) };							}
	}catch(ex){
		jutil.error("jutil.widget.tree.checkItem 에서 장애가 발생했습니다.", ex);
	}

	return true;
}


jutil.widget.tree.getItem = function(id_area, item){
	/*	해당 영역에 해당 이름으로 등록되 아이템을 반환한다.
	*/
	try{		return jutil.widget.tree.items[id_area][item];	}
	catch(ex){
		jutil.error("jutil.widget.tree.getItem 에서 장애가 발생했습니다.", ex);
		return null;
	}
}


jutil.widget.tree.getItemObjSub = function(id_item){
	/*	해당 아이템 아이디의 하위 레이어 영역 오브젝트를 반환한다.
	*/
	return jutil.e("jutil_widget_tree_item_sub_" + id_item);
}



jutil.widget.tree.setIcon = function(id_item, opt){
	/*	해당 아이템의 아이디를 받아서 아이콘을 설정한다.
	*/
	var objIcon	= jutil.e("jutil_widget_tree_item_icon_" + id_item);
	objIcon.src	= jutil.widget.tree.imgInfo.path + jutil.widget.tree.imgInfo[opt];
}



jutil.widget.tree.getItemObj = function(attrs){
	/*	아이템 정보를 받아서 실제 아이템을 생성한다.
	*/
	var obj				= document.createElement("DIV");
	var objHeader		= document.createElement("DIV");
	var objSub			= document.createElement("DIV");
	var objHeaderTable	= jutil.dhtml.getTableObject("jutil_widget_tree_item_header_table_" + attrs["item"], 1, 2);
	var objIcon			= document.createElement("IMG");

	objHeader.appendChild(objHeaderTable);
	obj.appendChild(objHeader);
	obj.appendChild(objSub);

	// 기본 레이아웃 설정
	obj.setAttribute("id", "jutil_widget_tree_item_" + attrs["item"]);
	objHeader.setAttribute("id", "jutil_widget_tree_item__header_" + attrs["item"]);
	objSub.setAttribute("id", "jutil_widget_tree_item_sub_" + attrs["item"]);
	objIcon.setAttribute("id", "jutil_widget_tree_item_icon_" + attrs["item"]);
	
	obj.style.width				= attrs["width"];
	objSub.style.paddingLeft	= attrs["sub_padding"];
	objSub.style.display		= attrs["sub_display"] == "yes" ? "" : "none";


	// 아이콘 설정
	objIcon.src				= jutil.widget.tree.imgInfo.path + jutil.widget.tree.imgInfo.base;
	objIcon.style.cursor	= "pointer";
	jutil.eventAdd(objIcon, "onmousedown", Function("jutil.widget.tree.subItemDisplay('" + attrs["item"] + "');"));	// onclick으로 설정할 경우에는 DOCK의 dock_item_focus() 함수와 충돌이 발생한다. => 이벤트 자체가 발생하지 않는다.

	// 아이템 인터페이스 구성 - 테이블
	var objTds		= objHeaderTable.getElementsByTagName("TD");
	var objTds_0	= objTds[0];
	var objTds_1	= objTds[1];
	objHeaderTable.border		= 0;
	objHeaderTable.cellPadding	= 0;
	objHeaderTable.cellSpacing	= 0;
	objHeaderTable.width		= "100%";
	objTds_0.width				= 1;
	objTds_1.style.paddingLeft	= 5;
	objTds_0.appendChild(objIcon);
	objTds_1.appendChild(jutil.e(attrs["item"]));

	return obj;	
}

jutil.widget.tree.subItemDisplay = function(id_item){
	/*	트리에서 하위 아이템의 디스플레이를 컨트롤 한다.
	*/
	var subLayer = jutil.widget.tree.getItemObjSub(id_item);

	if(subLayer.childNodes.length > 0){
		var dp = subLayer.style.display;

		if(dp == "none"){
			subLayer.style.display	= "";
			jutil.widget.tree.setIcon(id_item, "open");
		}else{
			subLayer.style.display	= "none";
			jutil.widget.tree.setIcon(id_item, "close");
		}
	}
}

jutil.widget.tree.getItemAttribute = function(info){
	/*	트리에서 사용하는 기본 속성 정보를 반환한다.
	*/
	var attrs = new Object;

	// 기본 정보 구성
	for(var key in info){	attrs[key] = info[key];	}

	// 기본값 설정
	if(typeof(attrs["width"]) != "string"){				attrs["width"]				= "200";		}		// 가로 크기
	if(typeof(attrs["item_up"]) != "string"){			attrs["item_up"]			= "";			}		// 상위아이템 정보
	if(typeof(attrs["sub_display"]) != "string"){		attrs["sub_display"]		= "yes";		}		// 처음 디스플레이를 할때 하위 항목 디스플레이 여부
	if(typeof(attrs["sub_padding"]) != "string"){		attrs["sub_padding"]		= "20";			}		// 하위 항목의 들여쓰기의 깊이

	return attrs;
}


/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2007.08.27

	기능 : 
			- TREE 인터페이스를 구현하는 기능을 제공하는 클래스

	참고사항 : 
			- 기존의 TREE.js의 경우 DOM 기반으로 구성이 되어 있기 때문에 대량의 항목을 등록하는 경우 속도 저하의 문제가 발생했다.
			- 여기에서는 배열의 join을 이용해서 기본적인 html 기반으로 구성한다.
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){					jutil					= {};				}
if(typeof(jutil.widget) != "object"){			jutil.widget			= {};				}
if(typeof(jutil.widget.tree_html) != "object"){	jutil.widget.tree_html	= new TREE_HTML;	}



function TREE_HTML(){
	this.infos		= {}
	this.imgInfo	= {
		/*	트리에서 사용하는 이미지 관련된 정보를 가지고 있는 오브젝트
		*/
		"path"	: jutil.getBaseUrl() + "/images/tree/", 
		"close"	: "plus.gif", 
		"open"	: "minus.gif", 
		"base"	: "none.gif" 
	}



	this.clear = clear;
	function clear(id_area){
		this.infos[id_area]			= {}
		jutil.e(id_area).innerHTML	= "";
	}



	this.add = add;
	function add(info_){
		/*	트리 항목을 등록한다.
		*/
		if(typeof(this.infos[info_.id_area]) != "object"){			this.infos[info_.id_area]		= {}		}
		if(typeof(this.infos[info_.id_area].items) != "object"){	this.infos[info_.id_area].items	= Array();	}
		this.infos[info_.id_area].items.push(info_);
	}


	this.make = make;
	function make(info_){
		/*	실제 트리 인터페이스를 구현한다.
		*/
		if(typeof(this.infos[info_.id_area].config) != "object"){	this.infos[info_.id_area].config	= info_;	}
		var info	= this.infos[info_.id_area];
		var items	= info.items;
		if(typeof(items) != "object"){	jutil.error("jutil.widget.tree_html.make : 등록된 아이템이 존재하지 않습니다.");	return;	}
		var config	= this.get_config(info.config);
		var html	= this.make_item(config, items, "", 0);

		// 등록 처리
		jutil.e(config.id_area).innerHTML = html.join("");
	}


	this.make_item = make_item;
	function make_item(config, items, start_id, step){
		/*	실제 html 문자열을 구성하는 재귀함수
		*/
		var html = new Array();

		for(var i=0 ; i < items.length ; i++){
			var item	= items[i];

			if(item.id_up == start_id){
				var has_sub	= this.has_sub_item(items, item.id);
				var style	= (typeof(item.style) == "string") ? item.style : config.style;

				html.push("<div id='" + item.id + "' style='border:0pt solid;'>");

				// 하위 항목이 존재하는 경우와 존재하지 않는 경우에 따라서 구분해서 처리
				if(has_sub){
					html.push("<table cellpadding=0 cellspacing=0 border=0 width=100%>");
					html.push("<tr>");
					html.push("<td width=1 style='padding-left:" + (step * config.depth) + ";'>");
					html.push("<img src='" + this.imgInfo.path + (config.sub_display == "yes" ? this.imgInfo.close : this.imgInfo.open) + "' style='cursor:pointer;' onclick=\"jutil.widget.tree_html.sub_view(this, '" + item.id + "')\">");
					html.push("</td>");
					html.push("<td style='" + style + "'>" + item.subject + "</td>");
					html.push("</tr>");
					html.push("</table>");

					html.push("<table cellpadding=0 cellspacing=0 border=0 width=100% id='" + item.id + "_sub' style='display:" + (item.sub_display == "yes" ? "" : "none") + ";'>");
					html.push("<tr><td>");
					html = html.concat(this.make_item(config, items, item.id, step+1));
					html.push("</td></tr>");
					html.push("</table>");
				}else{
					html.push("<table cellpadding=0 cellspacing=0 border=0 width=100%>");
					html.push("<tr>");
					html.push("<td width=1 style='padding-left:" + (step * config.depth) + ";'><img src='" + this.imgInfo.path + this.imgInfo.base + "'></td>");
					html.push("<td style='" + style + "'>" + item.subject + "</td>");
					html.push("</tr>");
					html.push("</table>");
				}

				html.push("</div>");
			}
		}

		return html;
	}


	this.sub_view = sub_view;
	function sub_view(img, id){
		/*	트리의 하위 항목 디스플레이 컨트롤
		*/
		var objSub	= jutil.e(id + "_sub");
		var display	= objSub.style.display;

		if(display == "none"){	// 보이기
			objSub.style.display	= "";
			img.src					= this.imgInfo.path + this.imgInfo.open;
		}else{					// 숨기기
			objSub.style.display = "none";
			img.src					= this.imgInfo.path + this.imgInfo.close;
		}
	}




	this.get_config = get_config;
	function get_config(config){
		/*	필요한 항목이 설정되지 않은 경우에 여기에서 기본값을 설정한다.
		*/
		if(typeof(config.sub_display) != "string"){		config.sub_display		= "yes";						}		// 하위 항목 디스플레이 여부
		if(typeof(config.depth) != "string"){			config.depth			= "20";							}		// 들여쓰기 깊이
		if(typeof(config.style) != "string"){			config.style			= "font-size:9pt; padding:2;";	}		// 기본스타일

		return config;
	}

	
	this.has_sub_item = has_sub_item;
	function has_sub_item(items, id){
		/*	해당 항목이 하위 항목을 가지고 있는지 여부를 반환한다.
		*/
		for(var i=0 ; i < items.length ; i++){
			if(items[i].id_up == id){	return true;	}
		}

		return false;
	}
}

/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2007.06.28

	기능 : 
			- 도움말 인터페이스를 구현하는 기능을 제공하는 클래스

	참고사항 : 
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){				jutil				= {};		}
if(typeof(jutil.widget) != "object"){		jutil.widget		= {};		}
if(typeof(jutil.widget.help) != "object"){	jutil.widget.help	= {};		}




/**********************************************************************************************************************************
	기존에 만들어진 도움말 오브젝트를 실제 도움말이 필요한 부분이 추가하는 방식의 기능
**********************************************************************************************************************************/
jutil.widget.help.make_01_info = Array();
jutil.widget.help.make_01 = function(obj_target, obj_help, x_, y_){
	/*	미리 만들어진 도움말 내용을 해당 타겟 오브젝트의 도움말로 활용한다.
	*/
	var x = x_ ? x_ : 0;
	var y = y_ ? y_ : 0;


	// 동일 오브젝트 검증
	for(var i=0 ; i < jutil.widget.help.make_01_info.length ; i++){
		var info = jutil.widget.help.make_01_info[i];
		if(info["obj_target"] == obj_target){
			alert(obj.id + " 오브젝트는 이미 등록되어 있습니다.");
			return;
		}
	}

	// 정보저장
	jutil.widget.help.make_01_info.push({ "id" : obj_target.id, "obj_target" : obj_target, "obj_help" : obj_help, "x" : x, "y" : y });
	obj_help.style.position	= "absolute";
	obj_help.style.display	= "none";


	// 이벤트 설정
	jutil.eventAdd(obj_target, "onmouseover", jutil.widget.help.make_01_onmouseover);
	jutil.eventAdd(obj_target, "onmouseout", jutil.widget.help.make_01_onmouseout);
}


jutil.widget.help.make_01_remove = function(obj_target){
	/*	등록된 도움말 기능을 제거한다.
	*/
	for(var i=0 ; i < jutil.widget.help.make_01_info.length ; i++){
		var info = jutil.widget.help.make_01_info[i];
		if(info["obj_target"] == obj_target){
			jutil.widget.help.make_01_info.splice(i, 1);
			break;
		}
	}

	// 이벤트 제거
	jutil.eventRemove(obj_target, "onmouseover", jutil.widget.help.make_01_onmouseover);
	jutil.eventRemove(obj_target, "onmouseout", jutil.widget.help.make_01_onmouseout);
}


jutil.widget.help.make_01_onmouseover = function(evt){
	/*	jutil.widget.help.make_01 에서 사용하는 onmouseover 핸들
			- 도움말 오브젝트가 마우스를 따라다니게 한다.
	*/

	var id = (jutil.BWInfo().name == "MSIE") ? event.srcElement.id : evt.target.id;

	for(var i=0 ; i < jutil.widget.help.make_01_info.length ; i++){
		var info = jutil.widget.help.make_01_info[i];
		if(info["id"] == id){
			info["obj_help"].style.display = "";
			jutil.dhtml.mouseFollowObject(info["obj_help"], info["x"], info["y"]);
			break;
		}
	}
}


jutil.widget.help.make_01_onmouseout = function(evt){
	/*	jutil.widget.help.make_01 에서 사용하는 onmouseout 핸들
			- 도움말 오브젝트가 마우스를 따라다니는 것을 종료한다.
	*/

	var id = (jutil.BWInfo().name == "MSIE") ? event.srcElement.id : evt.target.id;

	for(var i=0 ; i < jutil.widget.help.make_01_info.length ; i++){
		var info = jutil.widget.help.make_01_info[i];
		if(info["id"] == id){
			info["obj_help"].style.display = "none";
			jutil.dhtml.mouseFollowObjectRemove(info["obj_help"]);
			break;
		}
	}
}




/**********************************************************************************************************************************
	도움말 내용을 받아서 도움말이 필요한 영역에 그대로 적용하는 기능
		- 디자인은 자체적으로 제공하는 기능으로 제한된다.
**********************************************************************************************************************************/

// 도움말 상자의 기본 레이아웃 - JUTIL_CONFIG.js 에서 추가 확장이 가능하다.
jutil.widget.help.make_02_layout = Array();
jutil.widget.help.make_02_layout.push("<div style='border:1pt solid #999999; width:200; height:100; padding:5; background-color:#EEEEEE;'>[msg]</div>");

jutil.widget.help.make_02_info = Array();

jutil.widget.help.make_02 = function(layout, obj, msg, x_, y_){
	/*	문자열을 받아서 도움말을 구성한다.
	*/
	var x = x_ ? x_ : 0;
	var y = y_ ? y_ : 0;


	// 동일 오브젝트 검증
	for(var i=0 ; i < jutil.widget.help.make_02_info.length ; i++){
		var info = jutil.widget.help.make_02_info[i];
		if(info["obj"] == obj){
			alert(obj.id + " 오브젝트는 이미 등록되어 있습니다.");
			return;
		}
	}

	// 오브젝트를 만든다.
	var div	= document.createElement("DIV");
	div.setAttribute("id", "jutil_widget_help_make_02_" + obj.id + "_help");
	div.innerHTML = jutil.widget.help.make_02_layout[layout].replace(/\[msg\]/gi, msg);
	div.style.position	= "absolute";
	div.style.display	= "none";
	jutil.global.document.body.appendChild(div);



	// 정보 설정
	jutil.widget.help.make_02_info.push({ "id" : obj.id, "layout" : layout, "obj" : obj, "help" : div, "msg" : msg, "x" : x, "y" : y });


	// 이벤트 설정
	jutil.eventAdd(obj, "onmouseover", jutil.widget.help.make_02_onmouseover);
	jutil.eventAdd(obj, "onmouseout", jutil.widget.help.make_02_onmouseout);
}


jutil.widget.help.make_02_remove = function(obj){
	/*	등록된 도움말 기능을 제거한다.
	*/
	for(var i=0 ; i < jutil.widget.help.make_02_info.length ; i++){
		var info = jutil.widget.help.make_02_info[i];
		if(info["obj"] == obj){
			jutil.widget.help.make_02_info.splice(i, 1);
			break;
		}
	}

	// 도움말 오브젝트 제거
	info["help"].parentNode.removeChild(info["help"]);

	// 이벤트 제거
	jutil.eventRemove(obj, "onmouseover", jutil.widget.help.make_02_onmouseover);
	jutil.eventRemove(obj, "onmouseout", jutil.widget.help.make_02_onmouseout);
}



jutil.widget.help.make_02_onmouseover = function(evt){
	/*	jutil.widget.help.make_02 의 onmouseover 이벤트 핸들
	*/
	var id = (jutil.BWInfo().name == "MSIE") ? event.srcElement.id : evt.target.id;

	for(var i=0 ; i < jutil.widget.help.make_02_info.length ; i++){
		var info = jutil.widget.help.make_02_info[i];

		if(info["id"] == id){
			info["help"].style.display	= "";
			jutil.dhtml.mouseFollowObject(info["help"], info["x"], info["y"]);
			break;
		}
	}
}

jutil.widget.help.make_02_onmouseout = function(evt){
	/*	jutil.widget.help.make_02 의 onmouseout 이벤트 핸들
	*/
	var id = (jutil.BWInfo().name == "MSIE") ? event.srcElement.id : evt.target.id;

	for(var i=0 ; i < jutil.widget.help.make_02_info.length ; i++){
		var info = jutil.widget.help.make_02_info[i];

		if(info["id"] == id){
			info["help"].style.display	= "none";
			jutil.dhtml.mouseFollowObjectRemove(info["help"]);
			break;
		}
	}
}



/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2007.06.29

	기능 : 
			- 목록 인터페이스를 구현하는 필요한 기능을 제공하는 클래스

	참고사항 : 
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){				jutil				= {};		}
if(typeof(jutil.widget) != "object"){		jutil.widget		= {};		}
if(typeof(jutil.widget.list) != "object"){	jutil.widget.list	= {};		}



jutil.widget.list.make_dwr_table = function(info){
	/*	DWR에서 받은 데이터를 사용해서 목록 인터페이스를 테이블 형태로 구성한다.
			data			: dwr로 부터 전달받은 데이터
			area			: 인터페이스를 적용할 영역
			table_header	: 테이블 헤더
			table_footer	: 테이블 풋터
	*/
	var listHtml = Array();
	var list_num	= (info.total_data ? info.total_data : 0) - ((info.cpage ? info.cpage : 0) - 1) * (info.list_num ? info.list_num : 0);		// 시작 글번호 계산 => 전체데이터의수 - (현재페이지 - 1) * 리스트의개수	
	
	listHtml.push(info.table_header);
	for(var i=0 ; i < info.data.length ; i++){
		var html = info.body;
		for(var key in info.data[i]){
			html = jutil.widget.list.replace(html, "[" + key + "]", info.data[i][key]);
		}

		html = jutil.widget.list.replace(html, "[auto_num]", list_num--);	// 일련번호 처리 => 템플릿의 변수를 auto_num으로 고정처리 => 페이징 처리가 포함되어 있을 경우에만 정상 구현된다.
		html = jutil.widget.list.fn_exec(html);								// 전처리 함수 실행
		listHtml.push(html);												// 목록 문자열에 해당 행 추가 등록 처리
	}
	listHtml.push(info.table_footer);

	// 적용
	jutil.e(info.area).innerHTML = listHtml.join("");
}



jutil.widget.list.make_dwr = function(info){
	/*	DWR 노드를 받아서 목록 인터페이스를 구현한다.
			data		: dwr로부터 전달받은 데이터
			area		: 목록을 구현할 템플릿 영역
			list_num	: 리스트의 개수. 페이징 처리시
			cpage		: 현재 페이지 번호. 페이징 처리시
			total_data	: 전체 데이터의 개수. 페이징 처리시
			page_num	: 페이지번호의 개수
			fn_name		: 페이징에서 처리할 함수명
			fn_args		: 페이징에서 처리할 파라미터 정보 
	*/
	// 목록을 구현할 HTML 오브젝트 체크
	var objCont	= jutil.e(info.area, info.area + "Tpl", info.area + "Loading");
	if(!objCont[0].JUTIL_WIDGET_LIST_DWR_TPL){	objCont[0].JUTIL_WIDGET_LIST_DWR_TPL = objCont[1].innerHTML;	}


	// 로딩 및 목록 디스플레스 설정
	objCont[1].style.display	= "none";
	objCont[2].style.display	= "block";


	// 목록을 구현할 항목 정보 획득 및 데이터의 수 검토
	if(info.data.length == 0){
		objCont[1].style.display	= "none";
		objCont[2].style.display	= "none";

		var objPaging = jutil.e(info.area + "Paging");
		if(objPaging && objPaging.style){	objPaging.style.display	= "none";	}
		return;
	}
	// 실제 목록 구현 시작
	var listHtml	= new Array();									// 최종적으로 목록을 구현할 DIV에 넣어줄 문자열
	var list_num	= (info.total_data ? info.total_data : 0) - ((info.cpage ? info.cpage : 0) - 1) * (info.list_num ? info.list_num : 0);		// 시작 글번호 계산 => 전체데이터의수 - (현재페이지 - 1) * 리스트의개수


	for(var i=0 ; i < info.data.length ; i++){
		var html = objCont[0].JUTIL_WIDGET_LIST_DWR_TPL;

		for(var key in info.data[i]){
			html = jutil.widget.list.replace(html, "[" + key + "]", info.data[i][key]);
		}

		html = jutil.widget.list.replace(html, "[auto_num]", list_num--);	// 일련번호 처리 => 템플릿의 변수를 auto_num으로 고정처리 => 페이징 처리가 포함되어 있을 경우에만 정상 구현된다.
		html = jutil.widget.list.fn_exec(html);								// 전처리 함수 실행
		listHtml.push(html);												// 목록 문자열에 해당 행 추가 등록 처리
	}



	// 목록 처리 및 로딩중 숨기기
	objCont[1].innerHTML		= listHtml.join("");
	objCont[1].style.display	= "block";
	objCont[2].style.display	= "none";

	// 페이징 처리
	var objPaging = jutil.e(info.area + "Paging");
	if(objPaging.style){
		objPaging.style.display	= "";
		jutil.widget.list.paging_01(objPaging.id, info.list_num, info.page_num, info.cpage, info.total_data, info.fn_name, info.fn_args);
	}
}





jutil.widget.list.make_01 = function(node, idArea, list_num_, page_num_, cpage_, total_data_, fn_name_, fn_args_){
	/*	XML 노드를 받아서 목록 인터페이스를 구현한다.
			node		: 일반 XML Element
			tagName		: 해당 노드의 하위노드중에서 목록으로 구현할 노드의 태그 이름
			idArea		: 목록을 구현할 템플릿 영역
			list_num_	: 리스트의 개수. 페이징 처리시
			cpage_		: 현재 페이지 번호. 페이징 처리시
			total_data_	: 전체 데이터의 개수. 페이징 처리시
	*/
	// 목록을 구현할 HTML 오브젝트 체크
	var objCont	= jutil.e(idArea, idArea + "Tpl", idArea + "Loading");
	if(!objCont[0].JUTIL_WIDGET_LIST_01_TPL){	objCont[0].JUTIL_WIDGET_LIST_01_TPL = objCont[1].innerHTML;	}


	// 로딩 및 목록 디스플레스 설정
	objCont[1].style.display	= "none";
	objCont[2].style.display	= "block";


	// 목록을 구현할 노드 정보 획득 및 데이터의 수 검토
	var nodes = jutil.xml.childNodes(node);
	if(nodes.length == 0){
		objCont[1].style.display	= "none";
		objCont[2].style.display	= "none";

		var objPaging = jutil.e(idArea + "Paging");
		if(objPaging && objPaging.style){	objPaging.style.display	= "none";	}
		return;
	}


	// 실제 목록 구현 시작
	var tagNames	= jutil.xml.getTagNames(nodes[0]);				// 템플릿에서 치환할 정보들...
	var listHtml	= new Array();									// 최종적으로 목록을 구현할 DIV에 넣어줄 문자열
	var list_num	= (total_data_ ? total_data_ : 0) - ((cpage_ ? cpage_ : 0) - 1) * (list_num_ ? list_num_ : 0);		// 시작 글번호 계산 => 전체데이터의수 - (현재페이지 - 1) * 리스트의개수


	for(var i=0 ; i < nodes.length ; i++){
		var html = objCont[0].JUTIL_WIDGET_LIST_01_TPL;

		// 기본 값 치환
		for(var j=0 ; j < tagNames.length ; j++){
			var data = jutil.xml.selectSingleNode(nodes[i], tagNames[j]);
			html = jutil.widget.list.replace(html, "[" + tagNames[j] + "]", jutil.xml.getNodeValue(data));
		}


		html = jutil.widget.list.replace(html, "[auto_num]", list_num--);	// 일련번호 처리 => 템플릿의 변수를 auto_num으로 고정처리 => 페이징 처리가 포함되어 있을 경우에만 정상 구현된다.
		html = jutil.widget.list.fn_exec(html);								// 전처리 함수 실행
		listHtml.push(html);												// 목록 문자열에 해당 행 추가 등록 처리
	}


	// 목록 처리 및 로딩중 숨기기
	objCont[1].innerHTML		= listHtml.join("");
	objCont[1].style.display	= "block";
	objCont[2].style.display	= "none";

	// 페이징 처리
	var objPaging = jutil.e(idArea + "Paging");
	if(objPaging){
		objPaging.style.display	= "";
		jutil.widget.list.paging_01(objPaging.id, list_num_, page_num_, cpage_, total_data_, fn_name_, fn_args_);
	}
}


jutil.widget.list.paging_01_color	= "#000000";
jutil.widget.list.paging_01 = function(idArea, list_num, page_num, cpage, total_data, fn_name, fn_args_){
	/*	페이징 처리에 필요한 정보를 받아서 페이지 인터페이스를 구현한다.
			idArea		: 페이징을 구현할 영역의 아이디
			list_num	: 목록에 보여주는 개수
			page_num	: 페이지 목록에 보여주는 개수
			cpage		: 현재페이지 번호
			total_data	: 전체 데이터의 개수
			fn_name		: 각 항목 클릭시 실행할 함수 이름
			fn_arg_		: 각 페이지 번호를 클릭할 경우에 실행할 함수에 전달할 인자 정보. 배열로 구성된다.
	*/
	var rv			= "";
	var total_page	= parseInt((total_data - 1) / list_num) + 1;
	var spage		= parseInt((cpage - 1) / page_num) * page_num + 1;
	var fn_args		= fn_args_ ? "'" + fn_args_.join("','") + "',": "";


	// 첫페이지 링크 구성, 이전 n 페이지 링크 구성, 이전 페이지 링크 구성
	if(cpage != 1){			rv += "<a href=\"javascript:" + fn_name + "(" + fn_args + "'1')\" style='text-decoration:none; color:" + jutil.widget.list.paging_01_color + ";' onFocus='blur()'>[처음]</a> ";													}
	if(spage != 1){			rv += "<a href=\"javascript:" + fn_name + "(" + fn_args + "'" + ((parseInt(spage) - parseInt(page_num))) + "')\" style='text-decoration:none; color:" + jutil.widget.list.paging_01_color + ";' onFocus='blur()'>◀◀</a> ";		}
	if(cpage != 1){			rv += "<a href=\"javascript:" + fn_name + "(" + fn_args + "'" + ((parseInt(cpage) - 1)) + "')\" style='text-decoration:none; color:" + jutil.widget.list.paging_01_color + ";' onFocus='blur()'>◀</a> ";						}

	// 페이지 번호 리스트 구성
	for(i = spage ; i < (parseInt(spage) + parseInt(page_num)) ; i++){
		rv += " <a href=\"javascript:" + fn_name + "(" + fn_args + "'" + i + "');\" style='text-decoration:none; color:" + jutil.widget.list.paging_01_color + ";' onFocus='blur()'>" + ((i == cpage) ? "<b>[" + i + "]</b>" : "[" + i + "]") + "</a> ";
		if(i >= total_page)	i = spage + page_num + 1;	// 전체 페이지를 넘어갈 경우
	}

	// 다음 페이지 링크 구성, 다음 n 페이지 링크 구성, 마지막 페이지 링크 구성
	if(cpage < total_page){												rv += "<a href=\"javascript:" + fn_name + "(" + fn_args + "'" + (parseInt(cpage) + 1) + "');\" style='text-decoration:none; color:" + jutil.widget.list.paging_01_color + ";' onFocus='blur()'>▶</a> ";						}
	if(parseInt(spage) + parseInt(page_num) <= parseInt(total_page)){	rv += "<a href=\"javascript:" + fn_name + "(" + fn_args + "'" + (parseInt(spage) + parseInt(page_num)) + "');\" style='text-decoration:none; color:" + jutil.widget.list.paging_01_color + ";' onFocus='blur()'>▶▶</a> ";	}
	if(cpage < total_page){												rv += "<a href=\"javascript:" + fn_name + "(" + fn_args + "'" + total_page + "');\" style='text-decoration:none; color:" + jutil.widget.list.paging_01_color + ";' onFocus='blur()'>[마지막]</a> ";							}


	// 적용 및 리턴
	var objArea = jutil.e(idArea);
	if(objArea != null){	objArea.innerHTML = rv;	}
	return rv;
}


jutil.widget.list.replace = function(str, searchStr, replaceStr){
	/*	문자열 치환 처리 함수 - xml 서비스에서 치환처리를 할 경우 value값에 대한 처리를 위해서 따로 함수 제작
			innerHTML을 할 경우 value에 더블쿼테이션이 사라진다.
			원형 함수 => GetStrReplace()
	*/
	var loop	= true;
	var pos		= 0;

	while(loop){
		pos = str.indexOf(searchStr);

		if(pos > -1){
			if(str.substring(pos-6, pos) == "value="){
				str = str.substring(0, pos) + "\"" + replaceStr + "\"" + str.substring(pos+searchStr.length, str.length);
			}else{
				str = str.substring(0, pos) + replaceStr + str.substring(pos+searchStr.length, str.length);
			}
		}else{
			loop = false;
		}
	}

	return str;
}



jutil.widget.list.fn_exec = function(html){
	/*	html 템플릿에서 값까지 처리된 문자열을 받아서 함수 목록을 뽑아 낸다음 해당 함수들 실행한 결과값이 포함되어 있는 html 문자열을 반환한다.
			- 내부용
	*/
	var pos_s = 0;
	var pos_e = 0;
	var fn_list	= Array();


	// 함수목록 읽어오기
	while(pos_s < html.length){
		pos_s = html.indexOf("[[", pos_e);															// 시작 포인트 찾기
		if(pos_s > pos_e){			pos_e = html.indexOf("]]", pos_s);	}							// 종료 포인트 찾기
		if(pos_s < 0 || pos_e < 0){	pos_s = html.length + 1;	}									// 루프 종료 처리
		if(pos_s < pos_e){			fn_list[fn_list.length] = html.substring(pos_s+2, pos_e);	}	// 함수명 등록 처리
	}

	// 함수 실행하기
	for(var i=0 ; i < fn_list.length ; i++){	html = this.replace(html, "[[" + fn_list[i] + "]]", eval(fn_list[i]));	}

	return html;
}


jutil.widget.list.get_page_limit_info = function(info){
	/*	목록 데이터를 요청을 할때 필요한 리미트 정보를 반환한다.
	*/
	if(!info["cpage"] || !info["list_num"]){	return false;	}
	return " " + (info["cpage"] - 1) * info["list_num"] + ", " + info["list_num"] + " ";
}



/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2008.05.07

	기능 : 
			- 데이터를 채워넣는 인터페이스를 구현하는데 필요한 기능을 제공하는 클래스

	참고사항 : 
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){				jutil				= {};		}
if(typeof(jutil.widget) != "object"){		jutil.widget		= {};		}
if(typeof(jutil.widget.fill) != "object"){	jutil.widget.fill	= {};		}



jutil.widget.fill.innerHtmlById = function(info){
	/*	json 방식의 오브젝트 정보를 받아서 해당 아이디의 구성요소에 innerHTML 방식으로 데이터를 채워넣는다.
	*/
	
	// 전달 정보 검증 및 처리
	if(!info.data){			jutil.error("jutil.widget.fill.innerHtmlById : data 항목이 지정되지 않았습니다.");		return;	}
	var tail	= info.tail ? info.tail : "";
	
	// 채워넣기
	for(var key in info.data){
		var obj = jutil.e(key + tail);
		if(obj){	obj.innerHTML = info.data[key];	}
	}
}


jutil.widget.fill.replaceHTML = function(area, data){
	/*	해당 영역의 내용을 불러와서 해당 데이터를 채워넣는다. 
		데이터는 JSON 방식의 데이터이다.
	*/
	var objArea = jutil.e(area);
	var html	= objArea.innerHTML;
	
	for(var key in data){
		html = jutil.widget.fill.replace(html, "[" + key + "]", data[key]);
		html = jutil.widget.fill.fn_exec(html);
	}
	
	objArea.innerHTML 		= html;
	objArea.style.display	= "block";
}


jutil.widget.fill.replace = function(str, searchStr, replaceStr){
	/*	문자열 치환 처리 함수 - xml 서비스에서 치환처리를 할 경우 value값에 대한 처리를 위해서 따로 함수 제작
			innerHTML을 할 경우 value에 더블쿼테이션이 사라진다.
			원형 함수 => GetStrReplace()
	*/
	var loop	= true;
	var pos		= 0;

	while(loop){
		pos = str.indexOf(searchStr);

		if(pos > -1){
			if(str.substring(pos-6, pos) == "value="){
				str = str.substring(0, pos) + "\"" + replaceStr + "\"" + str.substring(pos+searchStr.length, str.length);
			}else{
				str = str.substring(0, pos) + replaceStr + str.substring(pos+searchStr.length, str.length);
			}
		}else{
			loop = false;
		}
	}

	return str;
}



jutil.widget.fill.fn_exec = function(html){
	/*	html 템플릿에서 값까지 처리된 문자열을 받아서 함수 목록을 뽑아 낸다음 해당 함수들 실행한 결과값이 포함되어 있는 html 문자열을 반환한다.
			- 내부용
	*/
	var pos_s = 0;
	var pos_e = 0;
	var fn_list	= Array();


	// 함수목록 읽어오기
	while(pos_s < html.length){
		pos_s = html.indexOf("[[", pos_e);															// 시작 포인트 찾기
		if(pos_s > pos_e){			pos_e = html.indexOf("]]", pos_s);	}							// 종료 포인트 찾기
		if(pos_s < 0 || pos_e < 0){	pos_s = html.length + 1;	}									// 루프 종료 처리
		if(pos_s < pos_e){			fn_list[fn_list.length] = html.substring(pos_s+2, pos_e);	}	// 함수명 등록 처리
	}

	// 함수 실행하기
	for(var i=0 ; i < fn_list.length ; i++){	html = this.replace(html, "[[" + fn_list[i] + "]]", eval(fn_list[i]));	}

	return html;
}


/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2007.07.19

	기능 : 
			- 레이어를 n개씩 나열해주는 기능을 제공
			- 드래그 및 오브젝트 이동 가능

	참고사항 : 
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){						jutil					= {};					}
if(typeof(jutil.widget) != "object"){				jutil.widget			= {};					}
if(typeof(jutil.widget.arrange1) != "object"){		jutil.widget.arrange1	= new ARRANGE1;		}



function ARRANGE1(){

	this.info			= {}			// 아이템 및 환경 설정 정보
	this.drag_start_x	= null;			// 드래그 시작 좌표 정보
	this.drag_start_y	= null;
	this.drag_item		= null;			// 드래그 되고 있는 아이템
	this.drag_info		= null;			// 드래그 되고 있는 아이템의 전체 설정정보
	this.change_item	= null;			// 현재 드래그 되고 있는 아이템과 변경할 아이템 정보
	this.change_item_p	= null;			// 현재 드래그 되고 있는 아이템과 변경할 이전에 체크된 아이템 정보
	this.is_guide_move	= false;		// 가이드 라인이 이동상태인지를 체크한다.



	/*	아이템을 등록한다.
	*/
	this.add = add;
	function add(area_id, item_id, drag_area_id){
		try{
			if(typeof(this.info[area_id]) != "object"){
				this.info[area_id] = {
					"area"	: jutil.e(area_id), 
					"items"	: []
				}
			}
			this.info[area_id]["items"].push({
				"area"		: jutil.e(area_id), 
				"objItem"	: jutil.e(item_id), 
				"objDrag"	: jutil.e(drag_area_id) 
			});
		}catch(ex){		jutil.error("jutil.widget.arrange1.add", ex);	}
	}


	/*	영역을 생성한다.
	*/
	this.make = make;
	function make(area_id, cols, width, height, padding){
		try{
			var objArea		= this.info[area_id]["area"];
			var items		= this.info[area_id]["items"];

			this.info[area_id]["cols"]		= cols;
			this.info[area_id]["rows"]		= parseInt(items.length / cols) + 1;
			this.info[area_id]["width"]		= width;
			this.info[area_id]["height"]	= height;
			this.info[area_id]["padding"]	= padding;


			// 영역정보 오브젝트 구성
			var guide = document.createElement("DIV");
			guide.id				= "jutil_widget_arrange1_layout_guide_" + area_id;
			guide.style.position	= "absolute";
			guide.style.border		= "1pt solid blue";
			guide.style.left		= -1000;
			guide.style.top			= -1000;
			objArea.appendChild(guide);
			this.info[area_id]["guide"] = guide;

		
			// 실제 레이아웃 구성
			var objTable	= jutil.dhtml.getTableObject("jutil_widget_arrange1_layout_table_" + area_id, this.info[area_id]["rows"], this.info[area_id]["cols"]);
			objArea.appendChild(objTable);

			var objTds		= objTable.getElementsByTagName("TD");
			for(var i=0 ; i < items.length ; i++){
				items[i]["objItem"].style.width		= "100%";
				items[i]["objItem"].style.height	= "100%";
				items[i]["objItem"].style.overflow	= "auto";


				items[i]["td"]		= objTds[i];
				items[i]["sortno"]	= i;
				objTds[i].id		= "jutil_widget_arrange1_layout_table_td_" + i;
				objTds[i].vAlign	= "top";
				objTds[i].Align		= "center";
				objTds[i].width		= this.info[area_id]["width"];
				objTds[i].height	= this.info[area_id]["height"];
				jutil.dhtml.mouseDragAbleExt(items[i]["objDrag"], items[i]["objItem"], this.dragStart, this.dragMove, this.dragEnd);


				eval("var objTds" + i + " = objTds[" + i + "];");
			}

			for(var i=0 ; i < items.length ; i++){
				eval("objTds" + i + ".appendChild(items[" + i + "]['objItem']);");

//items[i]["objItem"].style.position	= "absolute";
//items[i]["objItem"].style.left		= "0";
//items[i]["objItem"].style.top		= "0";

			}

			objTable.border			= 0;
			objTable.cellPadding	= this.info[area_id]["padding"];
			objTable.cellSpacing	= 0;
//this.refresh(area_id);
		}catch(ex){		jutil.error("jutil.widget.arrange1.make", ex);	}
	}


	this.dragStart = dragStart;
	function dragStart(obj, obj_x, obj_y, mouse_x, mouse_y){
		/*	드래그 시작 함수
				이벤트 핸들이기 때문에 this 키워드를 사용할 수 없다.
		*/
		jutil.widget.arrange1.drag_info		= jutil.widget.arrange1.get_drag_info(obj);
		jutil.widget.arrange1.drag_item		= obj;
		jutil.widget.arrange1.drag_start_x	= obj_x;
		jutil.widget.arrange1.drag_start_y	= obj_y;
	}


	this.dragMove = dragMove;
	function dragMove(obj, obj_x, obj_y, mouse_x, mouse_y){
		/*	드래그 이동중에 실행하는 함수
				- 해당 아이템이 다른 이동 영역 위에 있는지를 체크한다.
		*/

		// 가이드 라인이 이동하고 있는 경우에는 가이드 라인 표시를 하지 않는다.
		if(!jutil.widget.arrange1.is_guide_move){
			var items	= jutil.widget.arrange1.drag_info["items"];
			var item	= jutil.widget.arrange1.get_change_item(obj, mouse_x, mouse_y);

			if(item != jutil.widget.arrange1.change_item){
				jutil.widget.arrange1.change_item = item;
				jutil.widget.arrange1.display_guide_area();
			}
		}
	}



	this.dragEnd = dragEnd;
	function dragEnd(obj, obj_x, obj_y, mouse_x, mouse_y){
		/*	드래그 종료 함수
		*/
		if(jutil.widget.arrange1.change_item == null || jutil.widget.arrange1.change_item["objItem"] == obj){
			jutil.dhtml.move(obj, jutil.widget.arrange1.drag_start_x, jutil.widget.arrange1.drag_start_y, 40, 1, false, "jutil.widget.arrange1.repair('" + obj.id + "')");
		}else{
			jutil.widget.arrange1.change_info(obj);
			jutil.widget.arrange1.refresh(jutil.widget.arrange1.drag_info["area"].id);
		}
	}


	this.change_info = change_info;
	function change_info(drag_obj){
		/*	드래그된 아이템을 기준으로 정렬순서 정보를 갱신한다.
		*/
		var dragItem		= this.get_item_info(drag_obj);
		var changeSortno	= this.change_item["sortno"];
		var dragSortno		= dragItem["sortno"];
		var update_type		= dragSortno < changeSortno ? -1 : 1;	// -1 : 앞의 항목이 뒤로 간 경우, 1 : 뒤의 항목이 앞으로 간 경우

		for(var i=0 ; i < this.drag_info["items"].length ; i++){
			var sortno = this.drag_info["items"][i]["sortno"];

			if(update_type < 0){
				if(sortno > dragSortno && sortno <= changeSortno){	this.drag_info["items"][i]["sortno"]--;					}
				if(sortno == dragSortno){							this.drag_info["items"][i]["sortno"] = changeSortno;	}
			}else{
				if(sortno < dragSortno && sortno >= changeSortno){	this.drag_info["items"][i]["sortno"]++;					}
				if(sortno == dragSortno){							this.drag_info["items"][i]["sortno"] = changeSortno;	}
			}
		}

		/*
		var s = "";
		for(var i=0 ; i < this.drag_info["items"].length ; i++){
			s += this.drag_info["items"][i]["objItem"].id + " => " + this.drag_info["items"][i]["sortno"] + "\n";
		}
		alert(s);
		*/
	}


	this.refresh = refresh;
	function refresh(area_id){
		/*	갱신된 정보를 기준으로 디스플레이를 갱신한다.
		*/
		var info = this.info[area_id];

		for(var i=0 ; i < info["items"].length ; i++){
			var item	= get_item_by_sortno(info["items"], i);
			item["td"]	= jutil.e("jutil_widget_arrange1_layout_table_td_" + i);
			
			jutil.dhtml.move(item["objItem"], jutil.dhtml.getOffsetLeft(item["td"]) + info["padding"], jutil.dhtml.getOffsetTop(item["td"]) + info["padding"], 20, 1, false, "jutil.widget.arrange1.repair('" + item["objItem"].id + "')");
		}


		/*	해당 아이템 목록중에서 지정된 정렬 번호를 가지고 있는 아이템을 반환한다.
		*/
		function get_item_by_sortno(items, sortno){
			for(var i=0 ; i < items.length ; i++){
				if(items[i]["sortno"] == sortno){	return items[i];	}
			}
		}
	}


	this.repair = repair;
	function repair(id){
		/*	아이템을 복구 시킨다.
		*/
		var itemInfo = this.get_item_info(jutil.e(id));
		itemInfo["objItem"].style.position	= "";
		itemInfo["td"].appendChild(itemInfo["objItem"]);

		this.change_item						= null;
		this.change_item_p						= null;

		if(this.drag_info){
			this.drag_info["guide"].style.left		= -1000;
			this.drag_info["guide"].style.top		= -1000;
		}
	}


	this.display_guide_area = display_guide_area;
	function display_guide_area(){
		/*	아이템이 변경될 영역의 정보를 디스플레이 해준다.
		*/
		if(this.change_item != this.change_item_p){
			if(this.change_item_p == null && this.change_item != null){		// 가이드라인을 생성하는 경우
				this.drag_info["guide"].style.left		= jutil.dhtml.getOffsetLeft(this.change_item["td"]);
				this.drag_info["guide"].style.top		= jutil.dhtml.getOffsetTop(this.change_item["td"]);
				this.drag_info["guide"].style.width		= this.change_item["td"].offsetWidth;
				this.drag_info["guide"].style.height	= this.change_item["td"].offsetHeight;
			}
			
			if(this.change_item_p != null && this.change_item != null){		// 가이드라인을 이동하는 경우
				jutil.widget.arrange1.is_guide_move = true;
				jutil.dhtml.move(this.drag_info["guide"], jutil.dhtml.getOffsetLeft(this.change_item["td"]), jutil.dhtml.getOffsetTop(this.change_item["td"]), 40, 1, false, "jutil.widget.arrange1.is_guide_move = false;");
				//jutil.dhtml.resize_direction(this.drag_info["guide"], this.change_item["td"].offsetWidth, "width", 40, 1);
			}

			if(this.change_item == null){		// 가이드라인을 제거하는 경우
				this.drag_info["guide"].style.left		= -1000;
				this.drag_info["guide"].style.top		= -1000;
			}

			this.change_item_p = this.change_item;
		}
	}


	this.get_change_item = get_change_item;
	function get_change_item(obj, mouse_x, mouse_y){
		/*	아이템이 이동중에 변경해야 할 td 영역을 체크한다.
		*/
		var items = this.drag_info["items"];

		for(var i=0 ; i < items.length ; i++){
			var x		= jutil.dhtml.getOffsetLeft(items[i]["td"]);
			var y		= jutil.dhtml.getOffsetTop(items[i]["td"]);
			var width	= items[i]["td"].offsetWidth;
			var height	= items[i]["td"].offsetHeight;

			if(	mouse_x > x && mouse_x < x+width && 
				mouse_y > y && mouse_y < y+height){
					return items[i];
			}
		}

		return null;
	}


	this.get_drag_info = get_drag_info;
	function get_drag_info(obj){
		/*	현재 드래그 하고 있는 아이템이 속한 영역 오브젝트를 반환한다.
		*/
		for(var area_id in this.info){
			var items = this.info[area_id]["items"]

			for(var i=0 ; i < items.length ; i++){
				if(items[i]["objItem"] == obj){
					return this.info[area_id];
				}
			}
		}
	}


	this.get_item_info = get_item_info;
	function get_item_info(obj){
		/*	해당 아이템의 정보를 반환한다.
		*/
		for(var area_id in this.info){
			var items = this.info[area_id]["items"]

			for(var i=0 ; i < items.length ; i++){
				if(items[i]["objItem"] == obj){
					return items[i];
				}
			}
		}
	}
}

/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2007.07.23

	기능 : 
			- 레이어 영역을 만들고 해당 영역에 아이템을 등록할 수 있도록 구성한다.
			- 가로 방향이나 세로 방향으로 처리가 된다.(둘중에 1개 방향으로만 처리)
			- 드래그 및 오브젝트 이동 가능
			- 세로 형의 경우 가로 크기는 영역에 맞추고 세로크기를 자동으로 늘어나게 한다.
			- 가로 형의 경우 세로 크기는 영역에 맞추고 가로크기를 자동으로 늘어나게 한다.
			- 아이템의 기본구조가 DIV로 구성되므로 가로형의 경우 가로의 길이를 지정해야 한다.
	참고사항 : 
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){						jutil					= {};					}
if(typeof(jutil.widget) != "object"){				jutil.widget			= {};					}
if(typeof(jutil.widget.arrange2) != "object"){		jutil.widget.arrange2	= new ARRANGE2;			}



function ARRANGE2(){

	this.info			= {}			// 아이템 및 환경 설정 정보
	this.drag_start_x	= null;			// 드래그 시작 좌표 정보
	this.drag_start_y	= null;
	this.drag_item		= null;			// 드래그 되고 있는 아이템
	this.drag_info		= null;			// 드래그 되고 있는 아이템의 전체 설정정보
	this.change_area	= null;			// 현재 드래그 되고 있는 아이템과 변경할 아이템이 존재하는 영역의 아이디
	this.change_item	= null;			// 현재 드래그 되고 있는 아이템과 변경할 아이템 정보
	this.change_item_p	= null;			// 현재 드래그 되고 있는 아이템과 변경할 이전에 체크된 아이템 정보
	this.is_guide_move	= false;		// 가이드 라인이 이동상태인지를 체크한다.
	this.guide			= null;			// 가이드 라인 오브젝트




	this.addArea = addArea;
	function addArea(area_id, direction, spacing){
		/*	영역을 등록한다.
				id_area		: 영역의 아이디
				direction	: 영역의 방향
					width	: 가로방향
					height	: 세로방향
		*/
		try{
			if(typeof(this.info[area_id]) != "object"){
				this.info[area_id] = {
					"area"		: jutil.e(area_id), 
					"direction"	: direction, 
					"spacing"	: spacing, 
					"items"		: []
				}

				// 영역정보 오브젝트 구성 => 1번만 생성한다.
				if(this.guide == null){
					this.guide = document.createElement("DIV");
					this.guide.id				= "jutil_widget_arrange2_layout_guide";
					this.guide.style.position	= "absolute";
					this.guide.style.border		= "2pt dashed blue";		// solid, double, dotted, dashed, groove, ridge, inset, outset
					this.guide.style.left		= -1000;
					this.guide.style.top		= -1000;
					this.guide.style.zIndex		= 1;
					document.body.appendChild(this.guide);
				}
			}
		}catch(ex){		jutil.error("jutil.widget.arrange2.addArea", ex);	}
	}


	this.addItem = addItem;
	function addItem(area_id, item_id, drag_area_id, sortno, extend, width, height, is_move){
		/*	아이템을 등록한다.
				area_id			: 아이템을 등록할 영역의 아이디
				item_id			: 실제 아이템 영역의 아이디
				drag_area_id	: 드래그를 체크할 영역의 아이디
				sortno			: 정렬순서, 미지정인 경우 자동으로 마지막 순서를 지정한다. 0부터 시작한다.
				extend			: 확장 가능한 영역 정보 => 배열로 처리한다.
				width			: 아이템의 가로 크기
				height			: 아이템의 세로 크기 => 세로크기는 현재 적용하지 않는다.
				is_move			: 최초 적용 위치에서 이동되는 시각 효과 처리. 중간에 적용할 경우에사용한다. => 처음에는 끊김현상이 발생하므로 사용을 자제한다.
		*/
		try{
			// 정보 설정
			if(typeof(this.info[area_id]) != "object"){	this.addArea(area_id, "height", 10);	}
			var item = this.createItem(area_id, item_id, drag_area_id, sortno, extend, width, height);
			this.info[area_id]["items"].push(item);
			this.itemSortnoRebuild(area_id, item, sortno);


			// 드래그 기능 확장 처리
			jutil.dhtml.mouseDragAbleExt(item["objDrag"], item["objItem"], this.dragStart, this.dragMove, this.dragEnd);


			// 시각효과처리
			if(is_move){
				item["objItem"].style.position	= "absolute";
				item["objItem"].style.left		= item["left"];
				item["objItem"].style.top		= item["top"];
				this.refresh(area_id, true);
			}else{	this.refresh(area_id, false);	}
		}catch(ex){		jutil.error("jutil.widget.arrange2.addItem", ex);	}
	}


	this.removeItem = removeItem;
	function removeItem(area_id, item_id){
		/*	해당 영역에서 지정한 아이템을 삭제한다.
				- 오브젝트를 삭제하지는 않고 정보만 삭제한다.
				- 자체적으로 구성한 div 오브젝트는 삭제한다.
				- 아이템 정보를 리턴시켜준다. => 추가 활용을 위해서...
		*/
		// 정보 재구성
		var item		= this.get_item_info(jutil.e(item_id));
		var items		= this.info[area_id]["items"];
		var item_idx	= 0;
		for(var i=0 ; i < items.length ; i++){
			if(items[i]["sortno"] == item["sortno"]){	item_idx = i;			}
			if(items[i]["sortno"] > item["sortno"]){	items[i]["sortno"]--;	}
		}
		this.info[area_id]["items"] = jutil.array.removeAt(items, item_idx);


		// html 오브젝트 재조정 => 실제 아이템 오브젝트는 삭제하지않고 다시 body에 붙여 놓는다.
		// 동적 효과를 주기 위해서 실제 아이템 오브젝트들을 absolute로 위치를 고정시킨다.
		// 삭제할 아이템을 실제로 삭제하면 위치가 자동으로 조정된다.
		var items = this.info[area_id]["items"];
		for(var i=0 ; i < items.length ; i++){
			items[i]["objItem"].style.position	= "absolute";
			items[i]["objItem"].style.left		= jutil.dhtml.getOffsetLeft(items[i]["objDiv"]) + this.info[area_id]["spacing"];
			items[i]["objItem"].style.top		= jutil.dhtml.getOffsetTop(items[i]["objDiv"]) + this.info[area_id]["spacing"];
		}


		// 이벤트 제거
		jutil.dhtml.mouseDragAbleExtRemove(item["objDrag"], item["objItem"], this.dragStart, this.dragMove, this.dragEnd);


		document.body.appendChild(item["objItem"]);
		item["objDiv"].parentNode.removeChild(item["objDiv"]);
		this.refresh(area_id, true);
		return item;
	}



	this.createItem = createItem;
	function createItem(area_id, item_id, drag_area_id, sortno, extend, width, height){
		/*	아이템 정보를 구성해서 반환하고, 실제 인터페이스에도 등록을 한다.
		*/
		var item = {};
		item["area"]	= jutil.e(area_id);
		item["objItem"]	= jutil.e(item_id);
		item["objDrag"]	= jutil.e(drag_area_id);
		item["extend"]	= typeof(extend) == "object" ? extend : [];
		item["width"]	= width ? width : item["objItem"].offsetWidth;
		item["height"]	= height ? height : item["objItem"].offsetHeight;
		item["left"]	= jutil.dhtml.getOffsetLeft(item["objItem"]);
		item["top"]		= jutil.dhtml.getOffsetTop(item["objItem"]);

		item["objDiv"]	= document.createElement("DIV");
		item["objDiv"].style.display	= (this.info[area_id]["direction"] == "width") ? "inline" : "block";
		item["objDiv"].style.padding	= this.info[area_id]["spacing"];
		//item["objDiv"].style.border		= "1pt solid";
		item["objItem"].style.width		= "100%";
		item["objItem"].style.height	= "100%";
		item["objItem"].style.zIndex	= 0;

		// 실제 등록 처리
		item["area"].appendChild(item["objDiv"]);
		item["objDiv"].appendChild(item["objItem"]);
		item["objDiv"].style.width	= (this.info[area_id]["direction"] == "width") ? item["width"] : item["objDiv"].offsetWidth;
		item["objDiv"].style.height	= item["objDiv"].offsetHeight;
		return item;
	}



	this.itemSortnoRebuild = itemSortnoRebuild;
	function itemSortnoRebuild(area_id, item, sortno){
		/*	아이템의 정렬순서를 재조정한다.
				- 아이템을 특정 위치로 추가하는 경우에 필요
		*/
		var items = this.info[area_id]["items"];
		if(typeof(sortno) != "number"){	item["sortno"] = items.length - 1;	return;	}
		if(sortno >= items.length){		item["sortno"] = items.length - 1;	return;	}
		for(var i=0 ; i < items.length ; i++){
			if(items[i]["sortno"] >= sortno){	items[i]["sortno"]++;	}
		}
		item["sortno"] = sortno;
	}



	this.dragStart = dragStart;
	function dragStart(obj, obj_x, obj_y, mouse_x, mouse_y){
		/*	드래그 시작 함수
				이벤트 핸들이기 때문에 this 키워드를 사용할 수 없다.
		*/
		// DIV 영역의 크기 재설정
		var item = jutil.widget.arrange2.get_item_info(obj);
		item["objDiv"].style.width	= item["objDiv"].offsetWidth;
		item["objDiv"].style.height	= item["objDiv"].offsetHeight;

		// 정보 설정
		obj.style.zIndex					= 2;
		jutil.widget.arrange2.drag_info		= jutil.widget.arrange2.get_drag_info(obj);
		jutil.widget.arrange2.drag_item		= obj;
		jutil.widget.arrange2.drag_start_x	= obj_x;
		jutil.widget.arrange2.drag_start_y	= obj_y;
	}


	this.dragMove = dragMove;
	function dragMove(obj, obj_x, obj_y, mouse_x, mouse_y){
		/*	드래그 이동중에 실행하는 함수
				- 해당 아이템이 다른 이동 영역 위에 있는지를 체크한다.
		*/

		// 가이드 라인이 이동하고 있는 경우에는 가이드 라인 표시를 하지 않는다.
		if(!jutil.widget.arrange2.is_guide_move){
			var items	= jutil.widget.arrange2.drag_info["items"];
			var item	= jutil.widget.arrange2.get_change_item(obj, mouse_x, mouse_y);

			jutil.widget.arrange2.change_item = item;
			jutil.widget.arrange2.display_guide_area();
		}
	}



	this.dragEnd = dragEnd;
	function dragEnd(obj, obj_x, obj_y, mouse_x, mouse_y){
		/*	드래그 종료 함수
		*/
		var item		= jutil.widget.arrange2.get_item_info(obj);
		var change_item	= jutil.widget.arrange2.change_item;
		var change_area	= jutil.widget.arrange2.change_area;

		if(change_item == null || change_item["objItem"] == obj){
			if(change_area == null || item["area"].id == change_area){		// 원위치
				jutil.dhtml.move(obj, jutil.widget.arrange2.drag_start_x, jutil.widget.arrange2.drag_start_y, 40, 1, false, "jutil.widget.arrange2.repair('" + obj.id + "')");
			}else{															// 다른 영역으로 이동
				jutil.widget.arrange2.removeItem(jutil.widget.arrange2.drag_info["area"].id, item["objItem"].id);
				jutil.widget.arrange2.addItem(change_area, item["objItem"].id, item["objDrag"].id, null, item["extend"], item["width"], item["height"], true);
			}
		}else{
			if(item["area"] == change_item["area"]){	// 동일영역에서 변경할 때
				var items		= jutil.widget.arrange2.drag_info["items"];
				var sortno_org	= item["sortno"];
				var sortno_chg	= change_item["sortno"];

				for(var i=0 ; i < items.length ; i++){
					if(change_item["sortno"] < item["sortno"]){
						if(items[i]["sortno"] >= sortno_chg && items[i]["sortno"] < sortno_org){	items[i]["sortno"]++;	}
					}else{
						if(items[i]["sortno"] <= sortno_chg && items[i]["sortno"] > sortno_org){	items[i]["sortno"]--;	}
					}
				}
				item["sortno"] = sortno_chg;

				/*
				var s = "";
				for(var i=0 ; i < items.length ; i++){	s += items[i]["objItem"].id + " : " + items[i]["sortno"] + "\n";	}
				alert(s);
				*/

				jutil.widget.arrange2.refresh(item["area"].id, true);
			}else{										// 다른영역으로 변경할 때
				jutil.widget.arrange2.removeItem(jutil.widget.arrange2.drag_info["area"].id, item["objItem"].id);
				jutil.widget.arrange2.addItem(change_area, item["objItem"].id, item["objDrag"].id, change_item["sortno"], item["extend"], item["width"], item["height"], true);
			}
		}
	}



	this.refresh = refresh;
	function refresh(area_id, is_move){
		/*	갱신된 정보를 기준으로 디스플레이를 갱신한다.
		*/
		var info = this.info[area_id];
		var is_move	= typeof(is_move) == "boolean" ? is_move : true;

		// 기존에 등록된 항목 제거
		for(var i=0 ; i < info["items"].length ; i++){	document.body.appendChild(info["items"][i]["objDiv"]);		}


		// 새로운 순서에 맞추어서 항목 재배치
		for(var i=0 ; i < info["items"].length ; i++){
			var item	= get_item_by_sortno(info["items"], i);
			info["area"].appendChild(item["objDiv"]);

			if(is_move){	jutil.dhtml.move(item["objItem"], jutil.dhtml.getOffsetLeft(item["objDiv"]) + info["spacing"], jutil.dhtml.getOffsetTop(item["objDiv"]) + info["spacing"], 20, 1, false, "jutil.widget.arrange2.repair('" + item["objItem"].id + "')");	}
			else{			this.repair(item["objItem"].id);	}
		}


		/*	해당 아이템 목록중에서 지정된 정렬 번호를 가지고 있는 아이템을 반환한다.
		*/
		function get_item_by_sortno(items, sortno){
			for(var i=0 ; i < items.length ; i++){
				if(items[i]["sortno"] == sortno){	return items[i];	}
			}
		}
	}


	this.repair = repair;
	function repair(id){
		/*	아이템을 복구 시킨다.
		*/
		var itemInfo = this.get_item_info(jutil.e(id));
		itemInfo["objItem"].style.position	= "";
		itemInfo["objItem"].style.zIndex	= 0;
		itemInfo["objDiv"].appendChild(itemInfo["objItem"]);

		this.change_item						= null;
		this.change_item_p						= null;

		this.guide.style.left		= -1000;
		this.guide.style.top		= -1000;
	}


	this.display_guide_area = display_guide_area;
	function display_guide_area(){
		/*	아이템이 변경될 영역의 정보를 디스플레이 해준다.
		*/
		if(this.change_item != this.change_item_p || this.change_area != null){
			if(this.change_item_p == null && this.change_item != null){		// 가이드라인을 생성하는 경우
				this.guide.style.left		= jutil.dhtml.getOffsetLeft(this.change_item["objDiv"]);
				this.guide.style.top		= jutil.dhtml.getOffsetTop(this.change_item["objDiv"]);
				this.guide.style.width		= this.change_item["objDiv"].offsetWidth;
				this.guide.style.height		= this.change_item["objDiv"].offsetHeight;
			}
			
			if(this.change_item_p != null && this.change_item != null){		// 가이드라인을 이동하는 경우 - 이동시에도 그냥 출력한다.
				this.guide.style.left		= jutil.dhtml.getOffsetLeft(this.change_item["objDiv"]);
				this.guide.style.top		= jutil.dhtml.getOffsetTop(this.change_item["objDiv"]);
				this.guide.style.width		= this.change_item["objDiv"].offsetWidth;
				this.guide.style.height		= this.change_item["objDiv"].offsetHeight;
				/*
				jutil.widget.arrange2.is_guide_move = true;
				jutil.dhtml.move(this.guide, jutil.dhtml.getOffsetLeft(this.change_item["objDiv"]), jutil.dhtml.getOffsetTop(this.change_item["objDiv"]), 40, 1, false, "jutil.widget.arrange2.is_guide_move = false;");
				jutil.dhtml.resize(this.guide, this.change_item["objDiv"].offsetWidth, this.change_item["objDiv"].offsetHeight, 40, 1);
				*/

				/*	일반 resize로 처리한다. => 단방향으로 처리할 경우에는 다른 영역으로 이동했을때 처리가 안된다.
				if(this.drag_info["direction"] == "height"){	jutil.dhtml.resize_direction(this.guide, this.change_item["objDiv"].offsetHeight, "height", 40, 1);		}
				else{											jutil.dhtml.resize_direction(this.guide, this.change_item["objDiv"].offsetWidth, "width", 40, 1);		}
				*/
			}

			if(this.change_item == null){		// 가이드라인을 제거하거나 다른 영역을 지시하는 경우
				if(this.change_area == null || this.drag_info["area"].id == this.change_area){		// 이동할 영역이 존재하지 않는 경우 가이드 라인을 제거한다.
					this.guide.style.left		= -1000;
					this.guide.style.top		= -1000;
				}else{								// 이동할 영역이 존재하는 경우 해당 영역으로 가이드 라인을 이동한다.
					var area = this.info[this.change_area]["area"];

					this.guide.style.left		= jutil.dhtml.getOffsetLeft(area);
					this.guide.style.top		= jutil.dhtml.getOffsetTop(area);
					this.guide.style.width		= area.offsetWidth;
					this.guide.style.height		= area.offsetHeight;
					/*
					jutil.dhtml.move(this.guide, jutil.dhtml.getOffsetLeft(area), jutil.dhtml.getOffsetTop(area), 40, 1, false, "jutil.widget.arrange2.is_guide_move = false;");
					jutil.dhtml.resize(this.guide, area.offsetWidth, area.offsetHeight, 40, 1);
					*/
				}
			}

			this.change_item_p = this.change_item;
		}
	}


	this.get_change_item = get_change_item;
	function get_change_item(obj, mouse_x, mouse_y){
		/*	아이템이 이동중에 변경해야 할 div 영역을 체크한다.
		*/

		// 현재 드래그 되고 있는 아이템이 속한 영역에서 변경해야 할 영역을 체크한다.
		var items = this.drag_info["items"];
		for(var i=0 ; i < items.length ; i++){
			var x			= jutil.dhtml.getOffsetLeft(items[i]["objDiv"]);
			var y			= jutil.dhtml.getOffsetTop(items[i]["objDiv"]);
			var width		= items[i]["objDiv"].offsetWidth;
			var height		= items[i]["objDiv"].offsetHeight;
			var scrollTop	= document.body.scrollTop;
			var scrollLeft	= document.body.scrollLeft;

			if(	scrollLeft + mouse_x > x && scrollLeft + mouse_x < x + width && 
				scrollTop + mouse_y > y && scrollTop + mouse_y < y + height){
					this.change_area = items[i]["area"].id;
					return items[i];
			}
		}


		// 위에서 영역을 찾지 못했다면 확장영역을 체크한다.
		var item = this.get_item_info(obj);
		if(item["extend"] == null){	return null;	}
		else{
			for(var i=0 ; i < item["extend"].length ; i++){
				var info	= this.info[item["extend"][i]];
				if(typeof(info) != "object"){	continue;	}
				var items	= info["items"];

				for(var j=0 ; j < items.length ; j++){
					var x			= jutil.dhtml.getOffsetLeft(items[j]["objDiv"]);
					var y			= jutil.dhtml.getOffsetTop(items[j]["objDiv"]);
					var width		= items[j]["objDiv"].offsetWidth;
					var height		= items[j]["objDiv"].offsetHeight;
					var scrollTop	= document.body.scrollTop;
					var scrollLeft	= document.body.scrollLeft;

					if(	scrollLeft + mouse_x > x && scrollLeft + mouse_x < x + width && 
						scrollTop + mouse_y > y && scrollTop + mouse_y < y + height){
							this.change_area = items[j]["area"].id;
							return items[j];
					}
				}

				// 확장 영역의 아이템 위에는 존재하지 않고 영역안에는 존재하는 경우를 찾는다.
				var x			= jutil.dhtml.getOffsetLeft(info["area"]);
				var y			= jutil.dhtml.getOffsetTop(info["area"]);
				var width		= info["area"].offsetWidth;
				var height		= info["area"].offsetHeight;
				var scrollTop	= document.body.scrollTop;
				var scrollLeft	= document.body.scrollLeft;

				if(	scrollLeft + mouse_x > x && scrollLeft + mouse_x < x + width && 
					scrollTop + mouse_y > y && scrollTop + mouse_y < y + height){
						this.change_area = info["area"].id;
						return null;
				}
			}
		}

		this.change_area = null;
		return null;
	}


	this.get_drag_info = get_drag_info;
	function get_drag_info(obj){
		/*	현재 드래그 하고 있는 아이템이 속한 영역 오브젝트를 반환한다.
		*/
		for(var area_id in this.info){
			var items = this.info[area_id]["items"]

			for(var i=0 ; i < items.length ; i++){
				if(items[i]["objItem"] == obj){
					return this.info[area_id];
				}
			}
		}
	}


	this.get_item_info = get_item_info;
	function get_item_info(obj){
		/*	해당 아이템의 정보를 반환한다.
		*/
		for(var area_id in this.info){
			var items = this.info[area_id]["items"]

			for(var i=0 ; i < items.length ; i++){
				if(items[i]["objItem"] == obj){
					return items[i];
				}
			}
		}
	}
}

/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2007.07.19

	기능 : 
			- 레이어를 가로형으로 배치해주는 클래스

	참고사항 : 
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){						jutil					= {};					}
if(typeof(jutil.widget) != "object"){				jutil.widget			= {};					}
if(typeof(jutil.widget.arrange_h1) != "object"){	jutil.widget.arrange_h1	= new ARRANGE_H1;		}



function ARRANGE_H1(){

	this.info			= {}			// 아이템 및 환경 설정 정보
	this.drag_start_x	= null;			// 드래그 시작 좌표 정보
	this.drag_start_y	= null;
	this.drag_item		= null;			// 드래그 되고 있는 아이템
	this.drag_info		= null;			// 드래그 되고 있는 아이템의 전체 설정정보
	this.change_item	= null;			// 현재 드래그 되고 있는 아이템과 변경할 아이템 정보
	this.change_item_p	= null;			// 현재 드래그 되고 있는 아이템과 변경할 이전에 체크된 아이템 정보



	/*	아이템을 등록한다.
	*/
	this.add = add;
	function add(area_id, item_id, drag_area_id){
		try{
			if(typeof(this.info[area_id]) != "object"){
				this.info[area_id] = {
					"area"	: jutil.e(area_id), 
					"items"	: []
				}
			}
			this.info[area_id]["items"].push({
				"area"		: jutil.e(area_id), 
				"objItem"	: jutil.e(item_id), 
				"objDrag"	: jutil.e(drag_area_id) 
			});
		}catch(ex){		jutil.error("jutil.widget.arrange_h1.add", ex);	}
	}


	/*	영역을 생성한다.
	*/
	this.make = make;
	function make(area_id, padding){
		try{
			var objArea		= this.info[area_id]["area"];
			var items		= this.info[area_id]["items"];


			// 영역정보 오브젝트 구성
			var guide = document.createElement("DIV");
			guide.id				= "jutil_widget_arrange_h1_layout_guide_" + area_id;
			guide.style.position	= "absolute";
			guide.style.border		= "1pt dashed white";
			guide.style.left		= -1000;
			guide.style.top			= -1000;
			objArea.appendChild(guide);
			this.info[area_id]["guide"] = guide;

		
			// 실제 레이아웃 구성
			var objTable	= jutil.dhtml.getTableObject("jutil_widget_arrange_h1_layout_table_" + area_id, 1, items.length);
			objArea.appendChild(objTable);

			var objTds		= objTable.getElementsByTagName("TD");
			for(var i=0 ; i < items.length ; i++){
				items[i]["width"]	= items[i]["objItem"].offsetWidth;
				items[i]["height"]	= items[i]["objItem"].offsetHeight;
				items[i]["td"]		= objTds[i];
				objTds[i].style.padding	= padding ? padding : "10";
				objTds[i].vAlign		= "top";
				objTds[i].width			= items[i]["width"] + parseInt(objTds[i].style.paddingLeft) + parseInt(objTds[i].style.paddingRight);
				objTds[i].height		= items[i]["height"];
				jutil.dhtml.mouseDragAbleExt(items[i]["objDrag"], items[i]["objItem"], this.dragStart, this.dragMove, this.dragEnd);

				eval("var objTds" + i + " = objTds[" + i + "];");
			}

			for(var i=0 ; i < items.length ; i++){
				eval("objTds" + i + ".appendChild(items[" + i + "]['objItem']);");
			}

			objTable.border			= 0;
			objTable.cellPadding	= 0;
			objTable.cellSpacing	= 0;
		}catch(ex){		jutil.error("jutil.widget.arrange_h1.make", ex);	}
	}


	this.dragStart = dragStart;
	function dragStart(obj, obj_x, obj_y, mouse_x, mouse_y){
		/*	드래그 시작 함수
				이벤트 핸들이기 때문에 this 키워드를 사용할 수 없다.
		*/
		jutil.widget.arrange_h1.drag_info		= jutil.widget.arrange_h1.get_drag_info(obj);
		jutil.widget.arrange_h1.drag_item		= obj;
		jutil.widget.arrange_h1.drag_start_x	= obj_x;
		jutil.widget.arrange_h1.drag_start_y	= obj_y;
	}


	this.dragMove = dragMove;
	function dragMove(obj, obj_x, obj_y, mouse_x, mouse_y){
		/*	드래그 이동중에 실행하는 함수
				- 해당 아이템이 다른 이동 영역 위에 있는지를 체크한다.
		*/
		var items	= jutil.widget.arrange_h1.drag_info["items"];
		var item	= jutil.widget.arrange_h1.get_change_item(obj, mouse_x, mouse_y);

		if(item != jutil.widget.arrange_h1.change_item){
			jutil.widget.arrange_h1.change_item = item;
			jutil.widget.arrange_h1.display_guide_area();
		}
	}



	this.dragEnd = dragEnd;
	function dragEnd(obj, obj_x, obj_y, mouse_x, mouse_y){
		/*	드래그 종료 함수
		*/
		if(jutil.widget.arrange_h1.change_item == null || jutil.widget.arrange_h1.change_item["objItem"] == obj){
			jutil.dhtml.move(obj, jutil.widget.arrange_h1.drag_start_x, jutil.widget.arrange_h1.drag_start_y, 40, 1, false, "jutil.widget.arrange_h1.repair('" + obj.id + "')");
		}else{
			jutil.widget.arrange_h1.change_info(obj);
			jutil.widget.arrange_h1.refresh(jutil.widget.arrange_h1.drag_info["area"].id);
		}
	}


	this.change_info = change_info;
	function change_info(drag_obj){
		/*	드래그된 아이템을 기준으로 정보를 갱신한다.
		*/
		var dragItem	= this.get_item_info(drag_obj);
		var changeTd	= this.change_item["td"];
		var dragTd		= dragItem["td"];

		for(var i=0 ; i < this.drag_info["items"].length ; i++){
			if(this.drag_info["items"][i] == this.change_item){	this.drag_info["items"][i]["td"] = dragTd;		}
			if(this.drag_info["items"][i] == dragItem){			this.drag_info["items"][i]["td"] = changeTd;	}
		}
	}


	this.refresh = refresh;
	function refresh(area_id){
		/*	갱신된 정보를 기준으로 디스플레이를 갱신한다.
		*/
		var info = this.info[area_id];

		for(var i=0 ; i < info["items"].length ; i++){
			if(info["items"][i]["objItem"].parentNode != info["items"][i]["td"]){
				info["items"][i]["td"].width	= info["items"][i]["objItem"].offsetWidth;
				info["items"][i]["td"].height	= info["items"][i]["objItem"].offsetHeight;
				jutil.dhtml.move(info["items"][i]["objItem"], jutil.dhtml.getOffsetLeft(info["items"][i]["td"]), jutil.dhtml.getOffsetTop(info["items"][i]["td"]), 40, 1, false, "jutil.widget.arrange_h1.repair('" + info["items"][i]["objItem"].id + "')");
			}
		}
	}


	this.repair = repair;
	function repair(id){
		/*	아이템을 복구 시킨다.
		*/
		var itemInfo = this.get_item_info(jutil.e(id));
		itemInfo["objItem"].style.position	= "";
		itemInfo["td"].appendChild(itemInfo["objItem"]);

		this.drag_info["guide"].style.left		= -1000;
		this.drag_info["guide"].style.top		= -1000;
		this.change_item						= null;
		this.change_item_p						= null;
	}


	this.display_guide_area = display_guide_area;
	function display_guide_area(){
		/*	아이템이 변경될 영역의 정보를 디스플레이 해준다.
		*/
		if(this.change_item != this.change_item_p){
			if(this.change_item_p == null && this.change_item != null){		// 가이드라인을 생성하는 경우
				this.drag_info["guide"].style.left		= jutil.dhtml.getOffsetLeft(this.change_item["td"]);
				this.drag_info["guide"].style.top		= jutil.dhtml.getOffsetTop(this.change_item["td"]);
				this.drag_info["guide"].style.width		= this.change_item["td"].offsetWidth;
				this.drag_info["guide"].style.height	= this.change_item["td"].offsetHeight;
			}
			
			if(this.change_item_p != null && this.change_item != null){		// 가이드라인을 이동하는 경우 => 이동효과를 주면 버벅댄다.
				//jutil.dhtml.move(this.drag_info["guide"], jutil.dhtml.getOffsetLeft(this.change_item["td"]), jutil.dhtml.getOffsetTop(this.change_item["td"]), 100, 1, false);
				//jutil.dhtml.resize_direction(this.drag_info["guide"], this.change_item["td"].offsetWidth, "width", 100, 1);
				this.drag_info["guide"].style.left		= jutil.dhtml.getOffsetLeft(this.change_item["td"]);
				this.drag_info["guide"].style.top		= jutil.dhtml.getOffsetTop(this.change_item["td"]);
				this.drag_info["guide"].style.width		= this.change_item["td"].offsetWidth;
				this.drag_info["guide"].style.height	= this.change_item["td"].offsetHeight;
			}

			if(this.change_item == null){		// 가이드라인을 제거하는 경우
				this.drag_info["guide"].style.left		= -1000;
				this.drag_info["guide"].style.top		= -1000;
			}

			this.change_item_p = this.change_item;
		}
	}


	this.get_change_item = get_change_item;
	function get_change_item(obj, mouse_x, mouse_y){
		/*	아이템이 이동중에 변경해야 할 td 영역을 체크한다.
		*/
		var items = this.drag_info["items"];

		for(var i=0 ; i < items.length ; i++){
			var x		= jutil.dhtml.getOffsetLeft(items[i]["td"]);
			var y		= jutil.dhtml.getOffsetTop(items[i]["td"]);
			var width	= items[i]["td"].offsetWidth;
			var height	= items[i]["td"].offsetHeight;

			if(	mouse_x > x && mouse_x < x+width && 
				mouse_y > y && mouse_y < y+height){
					return items[i];
			}
		}

		return null;
	}


	this.get_drag_info = get_drag_info;
	function get_drag_info(obj){
		/*	현재 드래그 하고 있는 아이템이 속한 영역 오브젝트를 반환한다.
		*/
		for(var area_id in this.info){
			var items = this.info[area_id]["items"]

			for(var i=0 ; i < items.length ; i++){
				if(items[i]["objItem"] == obj){
					return this.info[area_id];
				}
			}
		}
	}


	this.get_item_info = get_item_info;
	function get_item_info(obj){
		/*	해당 아이템의 정보를 반환한다.
		*/
		for(var area_id in this.info){
			var items = this.info[area_id]["items"]

			for(var i=0 ; i < items.length ; i++){
				if(items[i]["objItem"] == obj){
					return items[i];
				}
			}
		}
	}
}

/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2007.07.20

	기능 : 
			- 해당 오브젝트를 항상 동일한 위치에 오게 한다.
			- 스크롤 바에 대해서 동일한 위치를 유지할 경우에 사용한다.

	참고사항 : 
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){						jutil						= {};					}
if(typeof(jutil.widget) != "object"){				jutil.widget				= {};					}
if(typeof(jutil.widget.sky_location) != "object"){	jutil.widget.sky_location	= new SKY_LOCATION;		}



function SKY_LOCATION(){

	this.info		= {}		// 아이템 및 환경 설정 정보
	this.is_apply	= false;	// 이벤트 핸들 적용여부 - 한번만 적용하도록 플래그를 설정한다.
	this.is_timer	= false;	// 타이머 구동 여부
	this.scrollTop	= 0;
	this.scrollLeft	= 0;
	this.timer		= null;


	this.make_absolute = make_absolute;
	function make_absolute(sky_id, x, y){
		/*	절대 좌표로 지정되는 아이템 생성
		*/
		this.info[sky_id] = { "obj" : jutil.e(sky_id), "x" : x, "y" : y, "position" : "absolute" }
		var obj = this.info[sky_id]["obj"];
		obj.style.position	= "absolute";
		obj.style.left		= x;
		obj.style.top		= y;
	}


	this.make_relative = make_relative;
	function make_relative(base_id, sky_id, relative, x, y){
		/*	상대 좌표로 지정되는 아이템 생성
		*/
		this.info[sky_id] = { "obj" : jutil.e(sky_id), "objBase" : jutil.e(base_id), "position" : "relative", "relative" : relative, "x" : x, "y" : y }
		var obj		= this.info[sky_id]["obj"];
		var objBase	= this.info[sky_id]["objBase"];

		obj.style.position	= "absolute";

		switch(this.info[sky_id]["relative"]){
			case "right" :
				obj.style.left		= jutil.dhtml.getOffsetLeft(objBase) + objBase.offsetWidth + x;
				obj.style.top		= y;
				break;
			default :
				jutil.error("jutil.widget.sky_location.make_relative : " + this.info[sky_id]["relative"] + "에 대한 기능이 정의되지 않았습니다.");
				break;
		}
	}

	this.apply = apply;
	function apply(){
		/*	실제 필요한 이벤트를 적용한다.
		*/
		if(!this.is_apply){
			jutil.eventAdd(jutil.global, "onscroll", this.eventHandle);
			jutil.eventAdd(jutil.global, "onresize", this.eventHandle);
		}
	}


	this.eventHandle = eventHandle;
	function eventHandle(){
		/*	스크롤에 대한 이벤트 핸들
		*/
		if(!jutil.widget.sky_location.is_timer){
			jutil.widget.sky_location.is_timer = true;
			jutil.widget.sky_location.timerScroll();
		}
	}


	this.timerScroll = timerScroll;
	function timerScroll(){
		/*	스크롤바의 상태를 체크하기 위한 타이머
		*/
		if(this.scrollTop == jutil.global.document.body.scrollTop){
			this.is_timer = false;
			clearTimeout(this.timer);

			for(var sky_id in jutil.widget.sky_location.info){
				var info = this.info[sky_id];

				switch(info["position"]){
					case "absolute" :
						this.move_absolute(info);
						break;
					case "relative" :
						this.move_relative(info);
						break;
					default :
						jutil.error("jutil.widget.sky_location.timerScroll : " + info["position"] + "에 대한 기능이 정의되지 않았습니다.");
						break;
				}
			}
		}else{
			this.scrollTop	= jutil.global.document.body.scrollTop;
			this.scrollLeft	= jutil.global.document.body.scrollLeft;
			this.timer = setTimeout("jutil.widget.sky_location.timerScroll()", 100);
		}
	}

	
	this.move_absolute = move_absolute;
	function move_absolute(info){
		/*	절대좌표로 이동 시킨다.
		*/
		//info["obj"].style.top	= info["y"] + jutil.global.document.body.scrollTop;
		var x = info["x"] + jutil.global.document.body.scrollLeft;
		var y = info["y"] + jutil.global.document.body.scrollTop;
		jutil.dhtml.move(info["obj"], x, y, 20, 1);
	}


	this.move_relative = move_relative;
	function move_relative(info){
		/*	상대좌표로 이동 시킨다.
		*/
		switch(info["relative"]){
			case "right" :
				var x = jutil.dhtml.getOffsetLeft(info["objBase"]) + info["objBase"].offsetWidth + info["x"] + jutil.global.document.body.scrollLeft;
				var y = info["y"] + jutil.global.document.body.scrollTop;
				jutil.dhtml.move(info["obj"], x, y, 20, 1);
				break;
			default :
				jutil.error("jutil.widget.sky_location.make_relative : " + this.info[sky_id]["relative"] + "에 대한 기능이 정의되지 않았습니다.");
				break;
		}
	}
}




/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2007.08.20

	기능 : 
			- 팝업 인터페이스를 제공하는 클래스

	참고사항 : 
			- 동일한 이름의 팝업을 구성하게 되면 기존의 팝업을 띄우는 방식으로 처리한다.
			- 새로운 팝업을 구성하기 위해서는 항상 name값을 새로이 할당해야 한다.
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){				jutil				= {};			}
if(typeof(jutil.widget) != "object"){		jutil.widget		= {};			}
if(typeof(jutil.widget.popup) != "object"){	jutil.widget.popup	= new POPUP;	}




function POPUP(){
	// 맴버 변수 등록
	this.infos			= new Array();
	this.current_info	= null;


	this.make = make;
	function make(info){
		/*	팝업 인터페이스를 제작한다.
		*/
		if(!this.view(info)){
			info				= this.get_info(info);
			info.table_header	= this.get_table_header_obj(info);
			info.table_layout	= this.get_table_layout_obj(info);
			info.div_content	= this.get_div_content_obj(info);
			info.table_border	= this.get_table_border_obj(info);
			info.div_border		= this.get_div_border_obj(info);

			this.set_layout(info);
			this.set_position(info);
			this.set_dragable(info);
			this.infos.push(info);
		}
	}



	this.view = view;
	function view(info){
		/*	해당 정보를 받아서 동일한 정보가 존재한다면 해당 팝업을 디스플레이 한다.
		*/
		var info = this.get_current_info(info.name);
		if(info != null){
			info.div_border.style.display	= "";
			info.div_content.style.width	= info.width - info.border_left - info.border_right;
			info.div_content.style.height	= info.height - info.border_top - info.border_bottom - jutil.e(info.subject_id).offsetHeight - info.border_center;
			this.set_position(info);
			return true;
		}else{
			return false;
		}
	}



	this.set_dragable = set_dragable;
	function set_dragable(info){
		/*	해당 팝업이 드래그 가능하도록 조정한다.
		*/
		jutil.dhtml.mouseDragAbleExt(info.table_header, info.div_border, jutil.widget.popup.set_drag_start);
	}



	this.set_drag_start = set_drag_start;
	function set_drag_start(obj, obj_x, obj_y, x, y){
		/*	팝업항목의 드래그 시작시 호출되는 함수
		*/
		jutil.widget.popup.set_zIndex_rebuild(obj.jutil_widget_popup_info_name);
	}


	this.set_zIndex_rebuild = set_zIndex_rebuild;
	function set_zIndex_rebuild(name){
		/*	여러개의 팝업이 사용될 경우의 zindex의 값을 재조정하는 함수
		*/
		for(var i=0; i < this.infos.length ; i++){
			if(this.infos[i].name == name){
				this.infos[i].div_border.style.zIndex = 1;
			}else{
				this.infos[i].div_border.style.zIndex = 0;
			}
		}
	}



	this.get_table_header_obj = get_table_header_obj;
	function get_table_header_obj(info){
		/*	상단 인터페이스를 구성하는 테이블 오브젝트를 반환한다.
		*/
		var objTable	= jutil.dhtml.getTableObject("jutil_widget_popup_layout_header_" + info.name, 1, 2);
		var objTds		= objTable.getElementsByTagName("TD");
		var objTds0		= objTds[0];
		var objTds1		= objTds[1];

		objTable.style.width			= "100%";
		objTable.style.backgroundColor	= "#D4D0C8";
		objTable.border					= 0;
		objTable.cellPadding			= 0;
		objTable.cellSpacing			= 0;

		// 닫기 이미지 등록
		var imgClose							= this.get_img_obj(info.btn_close);
		imgClose.jutil_widget_popup_info_name	= info.name;
		jutil.eventAdd(imgClose, "onclick", jutil.widget.popup.btnCloseClick);

		objTds1.width			= 1;
		objTds1.noWrap			= true;
		objTds1.vAlign			= "top";
		objTds1.style.padding	= "3";
		objTds1.appendChild(imgClose);

		return objTable;
	}


	this.btnCloseClick = btnCloseClick;
	function btnCloseClick(evt){
		/*	팝업 닫기 버튼 이벤트 처리
		*/
		var objSrc	= jutil.eventSrc(evt);
		jutil.widget.popup.close(objSrc.jutil_widget_popup_info_name);
	}


	this.close = close;
	function close(name){
		/*	실제 팝업 닫기 기능 처리
		*/
		var info	= jutil.widget.popup.get_current_info(name);
		info.div_border.style.display	= "none";
	}




	this.get_img_obj = get_img_obj;
	function get_img_obj(src){
		/*	이미지 오브젝트를 반환한다.
		*/
		var objImg	= document.createElement("IMG");
		objImg.src	= src;
		return objImg;
	}


	this.get_table_layout_obj = get_table_layout_obj;
	function get_table_layout_obj(info){
		/*	내부 인터페이스를 구성하는 테이블 오브젝트를 반환한다.
		*/
		var objTable	= jutil.dhtml.getTableObject("jutil_widget_popup_layout_sub_" + info.name, 3, 1);
		var objTds		= objTable.getElementsByTagName("TD");
		var objTds0		= objTds[0];
		var objTds1		= objTds[1];
		var objTds2		= objTds[2];

		objTable.border			= 0;
		objTable.cellPadding	= 0;
		objTable.cellSpacing	= 0;

		objTds1.height			= info.border_center;
		objTds1.style.backgroundImage = "url(" + info.line_center + ")";

		return objTable;
	}



	this.get_div_content_obj = get_div_content_obj;
	function get_div_content_obj(info){
		/*	안쪽 DIV 영역 오브젝트를 반환한다.
		*/
		var objDiv						= jutil.global.document.createElement("DIV");
		objDiv.style.width				= info.width - info.border_left - info.border_right;
		objDiv.style.height				= info.height - info.border_top - info.border_bottom - jutil.e(info.subject_id).offsetHeight - info.border_center;
		objDiv.style.overflow			= "auto";
		objDiv.style.backgroundColor	= "#FFFFFF";
		return objDiv;
	}


	this.set_position = set_position;
	function set_position(info){
		/*	팝업 오브젝트를 지정한 위치에 노출 시킨다.
		*/
		var body = jutil.global.document.body;
		jutil.global.document.body.appendChild(info.div_border);

		switch(info.position){
			case "absolute" :
				info.div_border.style.left	= info.left;
				info.div_border.style.top	= info.top;
				break;
			case "center" :
				info.div_border.style.left	= body.offsetWidth / 2 - info.div_border.offsetWidth / 2;
				info.div_border.style.top	= body.offsetHeight / 2 - info.div_border.offsetHeight / 2;
				break;
			case "left" :
				info.div_border.style.left	= info.margin;
				info.div_border.style.top	= body.offsetHeight / 2 - info.div_border.offsetHeight / 2;
				break;
			case "right" :
				info.div_border.style.left	= body.offsetWidth - info.div_border.offsetWidth - info.margin;
				info.div_border.style.top	= body.offsetHeight / 2 - info.div_border.offsetHeight / 2;
				break;
			case "top" :
				info.div_border.style.left	= body.offsetWidth / 2 - info.div_border.offsetWidth / 2;
				info.div_border.style.top	= info.margin;
				break;
			case "bottom" :
				info.div_border.style.left	= body.offsetWidth / 2 - info.div_border.offsetWidth / 2;
				info.div_border.style.top	= body.offsetHeight - info.div_border.offsetHeight - info.margin;
				break;
		}
	}


	this.set_layout = set_layout;
	function set_layout(info){
		/*	전체 레이아웃 인터페이스를 구성한다.
		*/
		var objTds				= info.table_layout.getElementsByTagName("TD");
		var objTds_header		= objTds[0];
		var objTds_bottom		= objTds[2];
		var objTds				= info.table_border.getElementsByTagName("TD");
		var objTds_main			= objTds[4];
		var objTds				= info.table_header.getElementsByTagName("TD");
		var objTds_header_left	= objTds[0];
		var objTds_header_right	= objTds[1];

		
		objTds_header_left.appendChild(jutil.e(info.subject_id));
		objTds_header.appendChild(info.table_header);
		info.div_content.appendChild(jutil.e(info.content_id));
		objTds_bottom.appendChild(info.div_content);
		objTds_main.appendChild(info.table_layout);
	}


	this.get_info = get_info;
	function get_info(info){
		/*	팝업정보를 구성하는 기본 정보중에서 기본값을 설정하는 항목의 값을 채워넣는다.
		*/
		if(typeof(info.width) != "string"){			info.width			= "200";	}
		if(typeof(info.height) != "string"){		info.height			= "200";	}
		if(typeof(info.borderColor) != "string"){	info.borderColor	= "blue";	}
		if(typeof(info.position) != "string"){		info.position		= "center";	}
		if(typeof(info.left) != "string"){			info.left			= "0";		}
		if(typeof(info.top) != "string"){			info.top			= "0";		}
		if(typeof(info.margin) != "string"){		info.margin			= "50";		}
		if(typeof(info.is_resize) != "string"){		info.is_resize		= "yes";	}


		if(typeof(info.line_left_top) != "string"){		info.line_left_top		= jutil.getBaseUrl() + "images/popup/line_left_top.jpg";		}
		if(typeof(info.line_top) != "string"){			info.line_top			= jutil.getBaseUrl() + "images/popup/line_top.jpg";				}
		if(typeof(info.line_right_top) != "string"){	info.line_right_top		= jutil.getBaseUrl() + "images/popup/line_right_top.jpg";		}
		if(typeof(info.line_left) != "string"){			info.line_left			= jutil.getBaseUrl() + "images/popup/line_left.jpg";			}
		if(typeof(info.line_right) != "string"){		info.line_right			= jutil.getBaseUrl() + "images/popup/line_right.jpg";			}
		if(typeof(info.line_left_bottom) != "string"){	info.line_left_bottom	= jutil.getBaseUrl() + "images/popup/line_left_bottom.jpg";		}
		if(typeof(info.line_bottom) != "string"){		info.line_bottom		= jutil.getBaseUrl() + "images/popup/line_bottom.jpg";			}
		if(typeof(info.line_right_bottom) != "string"){	info.line_right_bottom	= jutil.getBaseUrl() + "images/popup/line_right_bottom.jpg";	}
		if(typeof(info.line_center) != "string"){		info.line_center		= jutil.getBaseUrl() + "images/popup/line_center.jpg";			}


		if(typeof(info.btn_close) != "string"){		info.btn_close		= jutil.getBaseUrl() + "images/popup/btn_close.jpg";			}


		if(typeof(info.border_top) != "string"){	info.border_top		= "5";	}
		if(typeof(info.border_left) != "string"){	info.border_left	= "6";	}
		if(typeof(info.border_right) != "string"){	info.border_right	= "6";	}
		if(typeof(info.border_bottom) != "string"){	info.border_bottom	= "5";	}
		if(typeof(info.border_center) != "string"){	info.border_center	= "6";	}



		return info;
	}


	this.get_div_border_obj = get_div_border_obj;
	function get_div_border_obj(info){
		/*	팝업 인터페이스를 구성하는 DIV 오브젝트를 반환한다.
		*/
		var objDiv = document.createElement("DIV");
		
		objDiv.appendChild(info.table_border);
		objDiv.jutil_widget_popup_info_name	= info.name
		objDiv.style.position	= "absolute";
		objDiv.style.left		= 0;
		objDiv.style.top		= 0;

		return objDiv;
	}


	this.get_table_border_obj = get_table_border_obj;
	function get_table_border_obj(info){
		/*	팝업 인터페이스를 구성하는 테이블 오브젝트를 반환한다.
		*/
		var objTable	= jutil.dhtml.getTableObject("jutil_widget_popup_layout_" + info.name, 3, 3);
		var objTds		= objTable.getElementsByTagName("TD");
		var objTds0		= objTds[0];
		var objTds1		= objTds[1];
		var objTds2		= objTds[2];
		var objTds3		= objTds[3];
		var objTds4		= objTds[4];
		var objTds5		= objTds[5];
		var objTds6		= objTds[6];
		var objTds7		= objTds[7];
		var objTds8		= objTds[8];

		objTable.border			= 0;
		objTable.cellSpacing	= 0;
		objTable.cellPadding	= 0;
		//objTable.style.width	= "100%";
		//objTable.style.height	= "100%";

		objTds0.width	= info.border_left;
		objTds2.width	= info.border_right;
		objTds3.width	= info.border_left;
		objTds5.width	= info.border_right;
		objTds6.width	= info.border_left;
		objTds8.width	= info.border_right;

		objTds0.height	= info.border_top;
		objTds1.height	= info.border_top;
		objTds2.height	= info.border_top;
		objTds6.height	= info.border_bottom;
		objTds7.height	= info.border_bottom;
		objTds8.height	= info.border_bottom;

		objTds0.style.backgroundImage = "url(" + info.line_left_top + ")";
		objTds1.style.backgroundImage = "url(" + info.line_top + ")";
		objTds2.style.backgroundImage = "url(" + info.line_right_top + ")";
		objTds3.style.backgroundImage = "url(" + info.line_left + ")";
		objTds4.bgColor	= "#FFFFFF";
		objTds5.style.backgroundImage = "url(" + info.line_right + ")";
		objTds6.style.backgroundImage = "url(" + info.line_left_bottom + ")";
		objTds7.style.backgroundImage = "url(" + info.line_bottom + ")";
		objTds8.style.backgroundImage = "url(" + info.line_right_bottom + ")";


		objTds3.appendChild(this.get_img_obj(info.line_left));
		objTds5.appendChild(this.get_img_obj(info.line_right));



		objTds4.vAlign	= "top";

		// 크기 재조정 이벤트 핸들 처리
		if(info.is_resize == "yes"){
			// td 오브젝트에 info 정보 설정
			objTds0.jutil_widget_popup_info_name	= info.name;
			objTds1.jutil_widget_popup_info_name	= info.name;
			objTds2.jutil_widget_popup_info_name	= info.name;
			objTds3.jutil_widget_popup_info_name	= info.name;
			objTds5.jutil_widget_popup_info_name	= info.name;
			objTds6.jutil_widget_popup_info_name	= info.name;
			objTds7.jutil_widget_popup_info_name	= info.name;
			objTds8.jutil_widget_popup_info_name	= info.name;

			// 아이템의 테두리에 마우스가 올라왔을 경우의 커서 모양 지정
			objTds0.style.cursor			= "NW-resize";
			objTds1.style.cursor			= "N-resize";
			objTds2.style.cursor			= "NE-resize";
			objTds3.style.cursor			= "E-resize";
			objTds5.style.cursor			= "E-resize";
			objTds6.style.cursor			= "SW-resize";
			objTds7.style.cursor			= "N-resize";
			objTds8.style.cursor			= "SE-resize";

			// 이벤트 설정
			jutil.eventAdd(objTds0, "onmousedown", jutil.widget.popup.resize_start);
			jutil.eventAdd(objTds1, "onmousedown", jutil.widget.popup.resize_start);
			jutil.eventAdd(objTds2, "onmousedown", jutil.widget.popup.resize_start);
			jutil.eventAdd(objTds3, "onmousedown", jutil.widget.popup.resize_start);
			jutil.eventAdd(objTds5, "onmousedown", jutil.widget.popup.resize_start);
			jutil.eventAdd(objTds6, "onmousedown", jutil.widget.popup.resize_start);
			jutil.eventAdd(objTds7, "onmousedown", jutil.widget.popup.resize_start);
			jutil.eventAdd(objTds8, "onmousedown", jutil.widget.popup.resize_start);
		}

		return objTable;
	}


	this.resize_start = resize_start;
	function resize_start(evt){
		/*	팝업 인터페이스의 크기 조정 이벤트 시작 함수
		*/
		var objSrc						= jutil.eventSrc(evt);
		jutil.widget.popup.current_info	= jutil.widget.popup.get_current_info(objSrc.jutil_widget_popup_info_name);
		var border_idx					= objSrc.id.substring(objSrc.id.indexOf("_td_") + 4, objSrc.id.length);
		var info						= jutil.widget.popup.current_info;
		var body						= jutil.global.document.body;

		// 팝업 오브젝트간의 zIndex 재조정
		jutil.widget.popup.set_zIndex_rebuild(objSrc.jutil_widget_popup_info_name);


		// 아이템에 이벤트의 시작 위치 정보 저장
		jutil.widget.popup.current_info.event_x				= evt.pageX ? evt.pageX : event.x;
		jutil.widget.popup.current_info.event_y				= evt.pageY ? evt.pageY : event.y;
		jutil.widget.popup.current_info.origin_left			= info.div_border.offsetLeft;
		jutil.widget.popup.current_info.origin_top			= info.div_border.offsetTop;
		jutil.widget.popup.current_info.origin_width		= info.div_content.offsetWidth;
		jutil.widget.popup.current_info.origin_height		= info.div_content.offsetHeight;
		jutil.widget.popup.current_info.resize_direction	= border_idx;


		// 해당 아이템을 조정할 이벤트 핸들 등록 - body 항목에 이벤트를 등록한다. => 마우스의 위치를 추적할 경우 빠르게 벗어나는 이벤트를 감당하기 위해서...
		jutil.dhtml.mouseMoveAdd(jutil.widget.popup.resize_handle);
		jutil.eventAdd(body, "onmouseup", jutil.widget.popup.resize_end);

		if(jutil.BWInfo().name == "MSIE"){
			body.onselectstart = function(){	return false;	}
		}else{
			// IE 외에는 어떤 방법이 있는지?
		}
	}


	this.resize_end = resize_end;
	function resize_end(evt){
		/*	크기조정 이벤트 종료 처리
		*/
		var body	= jutil.global.document.body;
		jutil.dhtml.mouseMoveRemove(jutil.widget.popup.resize_handle);
		jutil.widget.popup.current_info	= null;

		if(jutil.BWInfo().name == "MSIE"){
			body.onselectstart = function(){	return true;	}
		}else{
			// IE 외에는 어떤 방법이 있는지?
		}
	}



	this.resize_handle = resize_handle;
	function resize_handle(x, y){
		/*	팝업 인터페이스의 크기를 조정하는 함수
		*/
		var info = jutil.widget.popup.current_info;


		// 각 이동 방향에 맞추어서 이동 처리
		var min_width	= 150;
		var min_height	= 80;
		var length_x	= 0;
		var length_y	= 0;
		var pos_x		= info.origin_left;
		var pos_y		= info.origin_top;
		var move_x		= (info.div_border.offsetLeft >= 0 ? x : 0) - info.event_x;
		var move_y		= (info.div_border.offsetTop >= 0 ? y : 0) - info.event_y;

		switch(info.resize_direction){
			case "0_0" :	// 왼쪽 위
				length_x	= info.origin_width - move_x;
				length_y	= info.origin_height - move_y;
				pos_x		= (length_x > min_width) ? info.origin_left + move_x : info.origin_left + info.origin_width - min_width;
				pos_y		= (length_y > min_height) ? info.origin_top + move_y : info.origin_top + info.origin_height - min_height;
				break;
			case "0_1" :	// 위
				length_x	= info.origin_width;
				length_y	= info.origin_height - move_y;
				pos_x		= info.origin_left;
				pos_y		= (length_y > min_height) ? info.origin_top + move_y : info.origin_top + info.origin_height - min_height;
				break;
			case "0_2" :	// 오른쪽 위
				length_x	= info.origin_width + move_x;
				length_y	= info.origin_height - move_y;
				pos_x		= info.origin_left;
				pos_y		= (length_y > min_height) ? info.origin_top + move_y : info.origin_top + info.origin_height - min_height;
				break;
			case "1_0" :	// 왼쪽
				length_x	= info.origin_width - move_x;
				length_y	= info.origin_height;
				pos_x		= (length_x > min_width) ? info.origin_left + move_x : info.origin_left + info.origin_width - min_width;
				pos_y		= info.origin_top;
				break;
			case "1_2" :	// 오른쪽
				length_x	= info.origin_width + move_x;
				length_y	= info.origin_height;
				pos_x		= info.origin_left;
				pos_y		= info.origin_top;
				break;
			case "2_0" :	// 왼쪽 아래
				length_x	= info.origin_width - move_x;
				length_y	= info.origin_height + move_y;
				pos_x		= (length_x > min_width) ? info.origin_left + move_x : info.origin_left + info.origin_width - min_width;
				pos_y		= info.origin_top;
				break;
			case "2_1" :	// 아래
				length_x	= info.origin_width;
				length_y	= info.origin_height + move_y;
				pos_x		= info.origin_left;
				pos_y		= info.origin_top;
				break;
			case "2_2" :	// 오른쪽 아래
				length_x	= info.origin_width + move_x;
				length_y	= info.origin_height + move_y;
				pos_x		= info.origin_left;
				pos_y		= info.origin_top;
				break;
		}

		info.div_border.style.left				= pos_x < 0 ? 0 : pos_x;
		info.div_border.style.top				= pos_y < 0 ? 0 : pos_y;
		info.div_content.style.width	= length_x > min_width ? length_x : min_width;
		info.div_content.style.height	= length_y > min_height ? length_y : min_height;
	}


	this.get_current_info = get_current_info;
	function get_current_info(name){
		/*	해당 이름의 info를 반환한다.
		*/
		for(var i=0 ; i < this.infos.length ; i++){
			if(this.infos[i].name == name){	return this.infos[i];	}
		}
		return null;
	}
}



/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2007.05.14

	기능 : 
			- 달력 기능을 처리하기 위한 클래스

	참고사항 : 

**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(jutil) != "object"){					jutil					= {};				}
if(typeof(jutil.widget) != "object"){			jutil.widget			= {};				}
if(typeof(jutil.widget.calendar) != "object"){	jutil.widget.calendar	= new CALENDAR;		}


/*	클래스 시작
*/
function CALENDAR(){
	/*	클래스 전역 변수 정의부분
	*/
	this.info			= {}					// 설정정보

	this.year			= null;					// 선택한 연도
	this.month			= null;					// 선택한 월
	this.days			= null;					// 선택한 연월의 날짜의 개수
	this.id_area		= null;					// 달력을 구현할 영역의 아이디
	this.obj_area		= null;					// 달력을 구현할 영역
	this.date_current	= null;					// 현재 디스플레이 되는 년월의 date 오브젝트
	this.date_next		= null;					// 다음달 년월의 date 오브젝트
	this.date_prev		= null;					// 이전달 년월의 date 오브젝트
	this.week_first		= null;					// 선택한 연월의 첫번째 요일정보
	this.week_end		= null;					// 선택한 연월의 마지막 요일정보
	this.week_name		= Array("일", "월", "화", "수", "목", "금", "토");		// 각 요일의 이름
	this.year_month_str	= "YYYY년 MM월";		// 상단 월 선택버튼 출력 양식
	this.holiday_solar	= null;					// 양력 휴일정보
	this.holiday_lunar	= null;					// 음력 휴일정보
	this.memorial_day	= null;					// 기념일 정보
	this.output_holiday			= "yes";		// 공휴일 출력 옵션
	this.output_memorial_day	= "yes";		// 기념일 출력 옵션
	this.output_lunar			= "yes";		// 음력 출력 옵션

	this.cell_width			= 100;				// 1개 셀의 가로 크기
	this.cell_height		= 100;				// 1개 셀의 세로 크기
	this.cell_align			= "left";			// 1개 셀의 날짜 가로 정렬
	this.cell_valign		= "top";			// 1개 셀의 날짜 세로 정렬
	this.cell_color			= "#FFFFFF";		// 셀의 기본 색상
	this.cell_onmouseover	= null;				// 셀의 onmouseover 이벤트 설정
	this.cell_onmouseout	= null;				// 셀의 onmouseout 이벤트 설정
	this.cell_onclick		= null;				// 셀의 onclick 이벤트 설정



	/*	달력에 내용을 등록한다.
	*/
	this.add = add;
	function add(id_area, date, data){
		this.id_area	= id_area;
		this.obj_area	= jutil.e(id_area);

		// 기존 정보 로드
		var calendar_data	= this.obj_area.getAttribute("calendar_data");
		if(calendar_data == null){	calendar_data = new Array();	}


		// 정보 설정
		calendar_data.push({"date" : date.replace(/\./gi, ""), "data" : data});
		this.obj_area.setAttribute("calendar_data", calendar_data);
	}



	/*	해당 날짜에 등록된 데이터 정보를 반환한다.
	*/
	this.get_data = get_data;
	function get_data(date){
		var rv = new Array();

		// 정보 로드
		var calendar_data	= this.obj_area.getAttribute("calendar_data");
		if(calendar_data == null){	return rv;	}


		// 해당 날짜의 양식 구성
		var date_str = date.getYear();
		date_str += (date.getMonth()+1 < 10) ? "0" + (date.getMonth()+1) : "" + (date.getMonth()+1);
		date_str += (date.getDate() < 10) ? "0" + date.getDate() : "" + date.getDate();


		// 반환값 구성
		for(var i=0 ; i < calendar_data.length ; i++){
			if(calendar_data[i]["date"] == date_str){	rv.push(calendar_data[i]["data"]);	}
		}

		// 반환
		return rv;
	}



	/*	해당 날짜에 등록된 휴일 정보를 반환한다.
	*/
	this.get_holiday = get_holiday;
	function get_holiday(month, day, lunar_info){
		var rv = new Array();

		// 양력 휴일 정보 구성
		if(typeof(this.holiday_solar[month][day]) == "string"){								rv.push(this.holiday_solar[month][day]);								}

		// 음력 휴일 정보 구성
		if(typeof(this.holiday_lunar[lunar_info["month"]][lunar_info["day"]]) == "string"){	rv.push(this.holiday_lunar[lunar_info["month"]][lunar_info["day"]]);	}

		return rv;
	}


	/*	해당 날짜에 등록된 기념일 정보를 반환
	*/
	this.get_memorial = get_memorial;
	function get_memorial(month, day){
		var rv = new Array();
		if(typeof(this.memorial_day[month][day]) == "string"){	rv.push(this.memorial_day[month][day]);	}
		return rv;
	}


	/*	음력 날짜 정보 문자열을 반환한다.
	*/
	///
	this.get_lunar_str = get_lunar_str;
	function get_lunar_str(lunar_info){
		return (lunar_info["day"] == "1" || lunar_info["day"] == "15") ? (lunar_info["is_yun"] ? "윤)" : "") + lunar_info["month"] + "." + lunar_info["day"] + "" : "";
		//return "" + lunar_info["month"] + "." + lunar_info["day"] + "";
	}


	this.select			= select;
	this.selectLayer	= null;
	this.selectCallFunc	= null;
	function select(args){
		/*	날짜를 선택하는 인터페이스를 구성한다.
				추가 확장 기능
				달력을 구성하는 영역없이 이곳에서 영역을 만들고 그 영역에 달력을 생성한다.
				이벤트 발생위치를 잡아내기 위해서 event 객체를 반드시 받아야 한다.(크로스브라우징)
		*/
		// 영역구성하기
		var objLayer	= document.createElement("SPAN");
		objLayer.id		= Math.random();

		jutil.widget.calendar.selectLayer		= objLayer;
		jutil.widget.calendar.selectCallFunc	= args["callFunc"];
		document.body.appendChild(jutil.widget.calendar.selectLayer);



		// 달력구성

		jutil.widget.calendar.make({
			"id_area"				: objLayer.id, 
			"cell_width"			: "25", 
			"cell_height"			: "25", 
			"cell_align"			: "center", 
			"cell_valign"			: "middle", 
			"cell_onmouseover"		: "jutil.widget.calendar.select_onmouseover", 
			"cell_onmouseout"		: "jutil.widget.calendar.select_onmouseout", 
			"cell_onclick"			: "jutil.widget.calendar.select_onclick", 
			"cell_color"			: "white", 

			"year_month_str"		: "MM월",

			"output_holiday"		: "no", 
			"output_memorial_day"	: "no", 
			"output_lunar"			: "no"
		});
		objLayer.style.position				= "absolute";
		objLayer.style.left					= (args.event.x) ? args.event.x - 10 : args.event.pageX;
		objLayer.style.top					= (args.event.y) ? args.event.y - 10 : args.event.pageY;

		// 마우스 move 이벤트 추가
		jutil.dhtml.mouseMoveAdd(jutil.widget.calendar.selectMouseTrace);
	}


	this.selectMouseTrace = selectMouseTrace;
	function selectMouseTrace(x, y){
		/*	select의 마우스 트레이스 함수
				마우스가 달력의 영역을 벗어난 경우에 달력을 없앤다.
		*/
		var objLayer = jutil.widget.calendar.selectLayer;
		if(
			objLayer.offsetLeft - document.body.scrollLeft > x ||
			objLayer.offsetLeft - document.body.scrollLeft + objLayer.offsetWidth < x || 
			objLayer.offsetTop - document.body.scrollTop > y || 
			objLayer.offsetTop - document.body.scrollTop + objLayer.offsetHeight < y  
		){
			jutil.dhtml.mouseMoveRemove(jutil.widget.calendar.selectMouseTrace);
			jutil.widget.calendar.selectClose();
		}
	}


	this.selectClose = selectClose;
	function selectClose(){
		/*	날짜 선택 인터페이스를 숨긴다.
		*/
		var objLayer = jutil.widget.calendar.selectLayer;
		document.body.removeChild(objLayer);
	}


	this.select_onmouseover = select_onmouseover;
	function select_onmouseover(obj, year, month, day){
		obj.style.cursor	= "pointer";
		jutil.dhtml.cb(obj, "#EEEEEE");
	}


	this.select_onmouseout = select_onmouseout;
	function select_onmouseout(obj, year, month, day){
		obj.style.cursor	= "normal";
		jutil.dhtml.cb(obj, "#FFFFFF");
	}


	this.select_onclick = select_onclick;
	function select_onclick(obj, year, month, day){
		jutil.dhtml.mouseMoveRemove(jutil.widget.calendar.selectMouseTrace);
		jutil.widget.calendar.selectClose();
		jutil.widget.calendar.selectCallFunc(new Date(year, month - 1, day));
	}



	/*	달력을 생성한다.
	*/
	this.make = make;
	function make(args){
		// 달력을 생성하는데 필요한 기본값들을 체크
		if(args.info_load == "yes"){
			this.info[args.id_area].year	= args.year;
			this.info[args.id_area].month	= args.month;
			args							= this.info[args.id_area];
		}else{
			this.info[args.id_area] = args;
		}
		var is_make = this.make_args_check(args);
		if(!is_make){	return;	}



		// 휴일 및 기념일 정보 로드
		this.holiday_solar	= this.get_holiday_solar();
		this.holiday_lunar	= this.get_holiday_lunar();
		this.memorial_day	= this.get_memorial_day();


		// 인터페이스 문자열 구성
		var html	= Array();
			html.push("<table cellpadding=0 cellspacing=0 border=0 width='" + (this.cell_width * 7) + "' bgcolor=#FFFFFF>");

			html.push("<tr>");
			html.push("<td>");

				// 상단에 현재 연월정보 및 버튼 구성
				html.push("<table cellpadding=0 cellspacing=0 border=0 width=100% height=100%>");
				html.push("<tr>");
				html.push("<td align=center style='font-size:9pt;'>");
				html.push("<span style='font-weight:normal; cursor:hand;' onclick=\"jutil.widget.calendar.make({'id_area' : '" + this.id_area + "', 'year' : '" + this.date_prev.getYear() + "', 'month' : '" + (this.date_prev.getMonth()+1) + "', 'info_load' : 'yes'})\">" + this.year_month_str.replace(/YYYY/gi, this.date_prev.getYear()).replace(/MM/gi, (this.date_prev.getMonth()+1)) + "</span>");
				html.push(" / ");
				html.push("<span style='font-weight:bold;'>" + this.year_month_str.replace(/YYYY/gi, this.year).replace(/MM/gi, this.month) + "</span>");
				html.push(" / ");
				html.push("<span style='font-weight:normal; cursor:hand;' onclick=\"jutil.widget.calendar.make({'id_area' : '" + this.id_area + "', 'year' : '" + this.date_next.getYear() + "', 'month' : '" + (this.date_next.getMonth()+1) + "', 'info_load' : 'yes'})\">" + this.year_month_str.replace(/YYYY/gi, this.date_next.getYear()).replace(/MM/gi, (this.date_next.getMonth()+1)) + "</span>");
				html.push("</td>");
				html.push("</tr>");
				html.push("</table>");

			html.push("</td>");
			html.push("</tr>");


			html.push("<tr>");
			html.push("<td>");


				// 달력 구성
				html.push("<table cellpadding=2 cellspacing=1 border=0 bgcolor='#999999'>");

				// 요일명 구성
				html.push("<tr bgcolor='#EEEEEE'>");
				for(var i=0 ; i < this.week_name.length ; i++){
					html.push("<td width='" + this.cell_width + "' align=center style='font-size:9pt;'>" + this.week_name[i] + "</td>");
				}
				html.push("</tr>");


				// 날짜 앞부분 공백 구성
				if(this.week_first != 0){
					html.push("<tr height='" + this.cell_height + "'>");
					for(var i=0 ; i < this.week_first ; i++){
						html.push("<td width='" + this.cell_width + "' bgcolor='" + this.cell_color + "'></td>");
					}
				}


				// 날짜 구성
				var lunar_first	= null;		// 음력 1일이 시작하는 날짜 정보 - 음력처리의 성능을 향상시키기 위해서 작업
				var lunar_info	= null;		// 해당 날짜의 음력 정보


				for(var i=1 ; i <= this.days ; i++){
					// 현재 날짜 정보 구성
					var current_date	= new Date(this.year, this.month - 1, i);		// 현재 날짜
					var week_num		= current_date.getDay();						// 현재 요일

					
					// 음력 날짜 정보 구성	=> 속도 개선을 위해서 시작 날짜를 기준으로 직접 음력을 계산한다.
					if(i == 1){
						var lunar_info	= jutil.datetime.solar_to_lunar(this.year, this.month, i);
						var lunar_days	= jutil.datetime.lunar_days_month(lunar_info["year"], lunar_info["month"], lunar_info["is_yun"]);
						lunar_first		= lunar_days - lunar_info["day"] + 2;
					}
					if(i == lunar_first){			var lunar_info	= jutil.datetime.solar_to_lunar(this.year, this.month, i);	}
					if(i != 1 && i != lunar_first){	lunar_info["day"]++;													}

					
					// 해당 날짜에 등록된 데이터 정보 로드
					var data = this.get_data(current_date);


					// 해당 날짜에 등록된 휴일 및 기념일 정보 로드
					var holiday			= this.get_holiday(this.month, i, lunar_info);
					var memorial_day	= this.get_memorial(this.month, i);


					// 색상정보 구성
					var day_num_color	= (week_num == 0 || holiday.length > 0) ? "red" : "#333333";


					// 시작 tr 구성
					if(week_num == 0){										html.push("<tr height='" + this.cell_height + "'>");	}

					// 실제 날짜 cell 구성 - 날짜셀 안에는 1개의 테이블을 추가해서 인터페이스를 구성한다.
					var cell_onmouseover	= (this.cell_onmouseover != null) ? " onmouseover=\"" + this.cell_onmouseover + "(this, " + this.year + ", " + this.month + ", " + i + ")\" " : "";
					var cell_onmouseout		= (this.cell_onmouseout != null) ? " onmouseout=\"" + this.cell_onmouseout + "(this, " + this.year + ", " + this.month + ", " + i + ")\" " : "";
					var cell_onclick		= (this.cell_onclick != null) ? " onclick=\"" + this.cell_onclick + "(this, " + this.year + ", " + this.month + ", " + i + ")\" " : "";
					html.push("<td valign=top width='" + this.cell_width + "' bgcolor='" + this.cell_color + "' " + cell_onmouseover + cell_onmouseout + cell_onclick + ">");

						html.push("<table cellpadding=2 cellspacing=1 border=0 width=100% height=100%>");
						html.push("<tr><td align=" + this.cell_align + " valign=" + this.cell_valign + ">");
						html.push("<span style='color:" + day_num_color + "; font-size:8pt;'>" + i + "</span>");
						if(holiday.length > 0 && this.output_holiday == "yes"){				html.push("<span style='color:" + day_num_color + "; padding-left:5; font-size:8pt;'>" + holiday.join(",") + "</span>");	}
						if(memorial_day.length > 0 && this.output_memorial_day == "yes"){	html.push("<span style='padding-left:5; font-size:8pt;'>" + memorial_day.join(",") + "</span>");							}
						html.push("</td></tr>");
						html.push("<tr><td valign=top>");
						html.push(data.join("<br>"));
						html.push("</td></tr>");
						if(this.output_lunar == "yes"){
							html.push("<tr height=1><td align=right style='font-size:8pt;'>");
							html.push(this.get_lunar_str(lunar_info));
							html.push("</td></tr>");
						}
						html.push("</table>");

					html.push("</td>");

					// 종료 tr 구성
					if(current_date.getDay() % 6 == 0 && current_date.getDay() != 0){	html.push("</tr>");							}
				}


				// 날짜 뒷부분 공백 구성
				for(var i=this.week_end ; i < 6 ; i++){
					html.push("<td width='" + this.cell_width + "' bgcolor='" + this.cell_color + "'></td>");
				}


				html.push("</tr>");
				html.push("</table>");
			
			html.push("</td>");
			html.push("</tr>");
			html.push("</table>");



		// 등록
		this.obj_area.innerHTML = html.join("");
	}



	/*	달력 생성시 넘어오는 args값을 체크하고 기본값들을 설정한다.
	*/
	this.make_args_check = make_args_check;
	function make_args_check(args){
		// 영역 정보 설정
		if(typeof(args["id_area"]) == "string"){
			this.id_area	= args["id_area"];
			this.obj_area	= jutil.e(args["id_area"]);
		}

		
		// 날짜 정보 설정
		this.year	= (typeof(args["year"])	== "string") ? parseInt(args["year"]) : null;
		this.month	= (typeof(args["month"]) == "string") ? parseInt(args["month"]) : null;


		// 달력을 구성할 날짜 체크
		if(this.year == null){
			var today	= new Date();
			this.year	= today.getYear();
		}

		if(this.month == null){
			var today	= new Date();
			this.month	= today.getMonth() + 1;
		}


		// 영역 정보 체크
		if(this.obj_area == null){
			this.msgbox("달력을 구성할 영역이 존재하지 않습니다.");
			return false;
		}


		// 1개 셀의 크기 및 날짜 위치 정보, 이벤트 설정값 체크
		this.cell_width			= (typeof(args["cell_width"]) == "string") ? parseInt(args["cell_width"]) : 100;
		this.cell_height		= (typeof(args["cell_height"]) == "string") ? parseInt(args["cell_height"]) : 100;
		this.cell_align			= (typeof(args["cell_align"]) == "string") ? args["cell_align"] : "left";
		this.cell_valign		= (typeof(args["cell_valign"]) == "string") ? args["cell_valign"] : "top";
		this.cell_color			= (typeof(args["cell_color"]) == "string") ? args["cell_color"] : "#FFFFFF";
		this.cell_onmouseover	= (typeof(args["cell_onmouseover"]) == "string") ? args["cell_onmouseover"] : null;
		this.cell_onmouseout	= (typeof(args["cell_onmouseout"]) == "string") ? args["cell_onmouseout"] : null;
		this.cell_onclick		= (typeof(args["cell_onclick"]) == "string") ? args["cell_onclick"] : null;


		// 상단 날짜 출력 양식 지정
		this.year_month_str	= (typeof(args["year_month_str"]) == "string") ? args["year_month_str"] : "YYYY년 MM월";


		// 공휴일 및 기념일, 음력 출력 옵션 체크
		if(typeof(args["output_holiday"])		== "string"){	this.output_holiday			= args["output_holiday"];		}
		if(typeof(args["output_memorial_day"])	== "string"){	this.output_memorial_day	= args["output_memorial_day"];	}
		if(typeof(args["output_lunar"])	== "string"){			this.output_lunar			= args["output_lunar"];			}


		// 해당 연,월의 날짜의 수 계산
		this.days = jutil.datetime.solar_days_month(this.year, this.month);


		// 시작 요일과 종료 요일 정보
		this.week_first	= (new Date(this.year, this.month-1, 1)).getDay();
		this.week_end	= (new Date(this.year, this.month-1, this.days)).getDay();


		// 필요한 date 객체 정보 구성
		this.date_current	= new Date(this.year, this.month-1, 1);
		this.date_next		= new Date(this.year, this.month, 1);
		this.date_prev		= new Date(this.year, this.month-2, 1);


		// 최종 결과 리턴
		return true;
	}






	/*	일반적인 휴일 정보를 반환한다.
			- 어린이날, 크리스마스 등...
	*/
	this.get_holiday_solar = get_holiday_solar;
	function get_holiday_solar(){
		var holiday =	{
							"1" :	{
										"1"		: "신정"
									}, 
							"2" :	{}, 
							"3" :	{
										"1"		: "삼일절"
									}, 
							"4" :	{}, 
							"5" :	{
										"5"		: "어린이날"
									}, 
							"6" :	{
										"6"		: "현충일"
									}, 
							"7" :	{
										"17"	: "제헌절"
									}, 
							"8" :	{
										"15"	: "광복절"
									}, 
							"9" :	{}, 
							"10" :	{
										"3"		: "개천절"
									}, 
							"11" :	{}, 
							"12" :	{
										"25"	: "크리스마스"
									} 
						}
		return holiday;
	}



	/*	음력 휴일 정보를 반환한다.
	*/
	this.get_holiday_lunar = get_holiday_lunar;
	function get_holiday_lunar(){
		var holiday =	{
							"1" :	{
										"1"		: "설날",
										"2"		: ""
									}, 
							"2" :	{}, 
							"3" :	{}, 
							"4" :	{
										"8"		: "석가탄신일"
									}, 
							"5" :	{}, 
							"6" :	{}, 
							"7" :	{}, 
							"8" :	{
										"14"	: "", 
										"15"	: "추석", 
										"16"	: "" 
									}, 
							"9" :	{}, 
							"10" :	{}, 
							"11" :	{}, 
							"12" :	{
										"30"	: ""
									} 
						}
		return holiday;
	}



	/*	휴일이 아닌 기념일 정보를 반환한다.
	*/
	this.get_memorial_day = get_memorial_day;
	function get_memorial_day(){
		var day =	{
						"1" :	{}, 
						"2" :	{}, 
						"3" :	{}, 
						"4" :	{}, 
						"5" :	{
									"1"	: "근로자의날"
								}, 
						"6" :	{}, 
						"7" :	{}, 
						"8" :	{}, 
						"9" :	{}, 
						"10" :	{}, 
						"11" :	{}, 
						"12" :	{} 
					}
		return day;
	}



	/*	해당 메세지를 출력한다.
	*/
	this.msgbox = msgbox;
	function msgbox(msg){
		alert(msg);
	}
}

/**********************************************************************************************************************************************************************************
	작성자 : 김기석
	작성일 : 2008.05.20

	기능 :
		- 반디북 관련 스크립트

	참고사항 :
		- 
**********************************************************************************************************************************************************************************/
if(typeof(jutil.bandi) != "object"){	jutil.bandi	= {};	}



/******************************************************************************************
	블로그 데이터 전송 관련 스크립트
******************************************************************************************/
jutil.bandi.blogAddMyLibrary = function(prod_id, callBack){
	/*	내서재 담기
			callBack은 선택사항임.
	*/
	if(jutil.bandi.isLogin()){
		ajaxRequest("addMyLibrary", {"prod_id" : prod_id}, function(data){
			if(data == "0"){
				alert("내 서재에 담기에 장애가 발생했습니다.");
			}else{
				if(data == -2){
					alert("이미 등록된 책입니다.");
				}else{
					alert("내 서재에 정상적으로 등록되었습니다.");
				}
			}
			
			if(typeof(callBack) == "function"){
				callBack(data);
			}
		});
	}else{
		//alert("로그인후 사용이 가능합니다.");		
		goLoginPopUp();
	}
}



jutil.bandi.blogSendPaper = function(mem_id){
	/*	쪽지 보내기
	*/
	if(jutil.bandi.isLogin()){
		window.open(blogUrl + "/bandi_blog/blog/popMemoSendSingle.do?from=main&mbr_id=" + mem_id, "popBlogSendPaper", "width=400, height=300"); 
	}else{
		alert("로그인후 사용이 가능합니다.");
	}
}


jutil.bandi.blogGo = function(mem_id){
	/*	서재 바로가기
	*/
	window.open(blogUrl + "/bandi_blog/" + mem_id, "", ""); 
}


/*
jutil.bandi.blogAddMyLibrary = function(prod_id, callBack){
	/*	내서재 담기
			callBack은 사용안함
	/
	if(jutil.bandi.isLogin()){
		jutil.bandi.blogSendAlert({
			"url"		: blogUrl + "/bandi_blog/extention/prodAddMyLibrary.do",
			"prod_id"	: prod_id, 
			"rtnTyp"	: "Y"  
		});

		
		//var url = blogUrl + "/bandi_blog/extention/prodAddMyLibrary.do?prod_id" + prod_id
		//jutil.xmlhttp.request_url(url, false);
	}else{
		alert("로그인후 사용이 가능합니다.");
	}
}
*/

jutil.bandi.blogSendInfo = null;
jutil.bandi.blogSendAlert = function(info){
	/*	블로그쪽에 데이터를 전송시키는 일반형 함수	=> 사용안함.
	*/
	if(!info){			alert("jutil.bandi.blogSend : info 		정보가 구성되지 않았습니다.");	return;	}
	if(!info.url){		alert("jutil.bandi.blogSend : info.url	정보가 구성되지 않았습니다.");	return;	}
	
	var iframe = jutil.bandi.blogFrameMake();
	
	jutil.bandi.blogSendInfo	= info;
	iframe.src		= "/blog/blogSend.do";
}


jutil.bandi.blogFrameMake = function(){
	/*	블로그 전송용 iframe을 생성한다. => 사용안함.
	*/
	var iframe	= jutil.e("blogCommunicationFrame");
	
	if(!iframe){
		iframe			= document.createElement("IFRAME");
		iframe.name		= "blogCommunicationFrame";
		iframe.id		= "blogCommunicationFrame";
		iframe.width	= 0;
		iframe.height	= 0;  
		document.body.appendChild(iframe);
	}
	
	return iframe;
}



jutil.bandi.blogNewMemo = function(){
	/*	블로그에 신규 쪽지를 체크한다.
			사용안함
	*/
	if(jutil.bandi.isLogin()){
		Blog.getNewMemo(function(data){
			if(data != ""){
				jutil.e("message1").style.display			= "block";
				jutil.e("wiseCartNewMemoInfo").innerHTML	= data + "님으로부터 새로운 쪽지가 도착했습니다.";
			}else{
				jutil.e("message1").style.display			= "block";
				jutil.e("wiseCartNewMemoInfo").innerHTML	= "새로 도착한 쪽지가 없습니다.";
				
			}
		});
	}else{
		//jutil.e("message1").style.display	= "none";
	}
}


jutil.bandi.blogSetMemo = function(data){
	/*	블로그 신규 쪽지 정보를 구성한다.
	*/
	jutil.e("wiseCartNewMemoInfo").innerHTML	= data + "님으로부터 새로운 쪽지가 도착했습니다.";
}


jutil.bandi.blogSetMemoView = function(){
	/*	블로그 신규 쪽지 정보를 구성한다.
	*/
	jutil.e("message1").style.display			= "block";
}


jutil.bandi.newOrderSet = function(prodName){
	/*	신규 주문 정보를 설정한다.
	*/
	jutil.e("wiseCartNewOrderInfo").innerHTML	= prodName + "의 주문이 접수 되었습니다.";
}


jutil.bandi.newOrderView = function(){
	/*	블로그 신규 쪽지 정보를 구성한다.
	*/
	jutil.e("message2").style.display			= "block";
}

/******************************************************************************************
	와이즈 카트 로드 스크립트
******************************************************************************************/
jutil.bandi.wisecartMake = function(part){
	var obj = jutil.e("iframeBox");
	if(obj.tagName){
		jutil.e("iframeBox").contentWindow.location.replace("/front/wisecart/iframe.do");
	}
}




/******************************************************************************************
	와이즈카트 새로고침 처리 스크립트
******************************************************************************************/
jutil.bandi.reloadWiseCart = function(part){
	if(jutil.e("iframeBox").contentWindow){
		if(part){
			jutil.e("iframeBox").contentWindow.location.href = "/front/wisecart/iframe.do?part="+part;
		}else{
			jutil.e("iframeBox").contentWindow.location.href = "/front/wisecart/iframe.do";
		}
	}
}



/******************************************************************************************
	select box 처리 - 바이널 제공 스크립트
******************************************************************************************/
jutil.bandi.setSelect = function(){
	var obj_selDiv	= document.getElementById("selCSS2");

	if (obj_selDiv)
	{
		var obj_selEA	= obj_selDiv.getElementsByTagName("select")
		for	(i=0; i<obj_selEA.length; i++ )	{
			new Selectbox(obj_selEA[i]);
		}
	}
}





/******************************************************************************************
	이미지 보정 처리
******************************************************************************************/
jutil.bandi.prodImgCheck = function(){
	var objImgs	= document.getElementsByTagName("IMG");

	for(var i=0 ; i < objImgs.length ; i++){
		var isLoad	= false;
		var BWName	= jutil.BWInfo().name;
	
		switch(BWName){
			case "MSIE" : 
				isLoad = objImgs[i].readyState == "uninitialized" ? false : true;
				break;
			case "GECKO" :
				//isLoad = (objImgs[i]["width"] == 0 && objImgs[i]["height"] == 0) ? false : true;
				isLoad = (objImgs[i]["width"] == 0) ? false : true;
				isLoad = (objImgs[i]["height"] == 0) ? false : true;
				break;
		}

	
		if(!isLoad){
			if((objImgs[i].src).indexOf("/product/") > -1){
				switch(objImgs[i].width){
					case 200 :
						objImgs[i].width	= 200;
						objImgs[i].height	= 284;						
						objImgs[i].src	= "/images/common/noimg_type01.gif";
						break;
					case 137 :
						objImgs[i].width	= 137;
						objImgs[i].height	= 193;						
						objImgs[i].src	= "/images/common/noimg_type02.gif";
						break;
					case 123 :
						objImgs[i].width	= 123;
						objImgs[i].height	= 173;						
						objImgs[i].src	= "/images/common/noimg_type03.gif";
						break;
					case 95 :
						objImgs[i].width	= 95;
						objImgs[i].height	= 135;
						objImgs[i].src	= "/images/common/noimg_type04.gif";
						break;
					case 90 :
						objImgs[i].width	= 90;
						objImgs[i].height	= 128;						
						objImgs[i].src	= "/images/common/noimg_type05.gif";
						break;
					case 71 :
						objImgs[i].width	= 71;
						objImgs[i].height	= 100;						
						objImgs[i].src	= "/images/common/noimg_type06.gif";
						break;
					case 60 :
						objImgs[i].width	= 60;
						objImgs[i].height	= 85;						
						objImgs[i].src	= "/images/common/noimg_type07.gif";
						break;
					case 58 :
						objImgs[i].width	= 58;
						objImgs[i].height	= 83;						
						objImgs[i].src	= "/images/common/noimg_type10.gif";
						break;
					case 50 :
						objImgs[i].width	= 50;
						objImgs[i].height	= 71;						
						objImgs[i].src	= "/images/common/noimg_type08.gif";
						break;
					case 33 :
						objImgs[i].width	= 33;
						objImgs[i].height	= 48;						
						objImgs[i].src	= "/images/common/noimg_type09.gif";
						break;
					default :
						objImgs[i].src	= "/images/common/noimg_type03.gif";
						break;
				}
			}
		}
	}
}



/******************************************************************************************
	동영상 플레이어 로드
******************************************************************************************/
jutil.bandi.vodPlayer = function(path){
	window.open("/common/vodPlayer.do?path=" + path, "vodPlayer", "width=400, height=375"); 
}



/******************************************************************************************
	일반 메세지 처리 레이어 컨트롤
******************************************************************************************/
jutil.bandi.layerPop1 = function(evtSrc, display, width, x, y, subject, comments, date){
	/*	테마북에서 사용되는 레이어 팝업 컨트롤러
	*/
	// 레이어 인터페이스 삭제
	var Cont = jutil.e("layerPop1Cont");
	if(Cont && Cont.parentNode){	Cont.parentNode.removeChild(Cont);	}
	
	if(display == "block"){
		// 레이어 인터페이스 구성
		var strArr = Array();
		strArr.push("<div class='laypop' id='layerPop1Cont' style='position:absolute; display:block; left:0; top:0; width:" + width + ";' >");
		strArr.push("	<h3 class='mLine' style='padding-left:20px;'>" + subject + "</h3>");
		strArr.push("	<div class='laypopCon'>");
		strArr.push("		<p>" + comments + "</p>");
		if(date){	strArr.push("		<p class='al_right t_11'>" + date + "</p>");	}
		strArr.push("	</div>");
		strArr.push("</div>");
		
		document.body.insertAdjacentHTML("beforeEnd", strArr.join(""));
		//document.body.innerHTML(strArr.join);
		
		// 위치 정보 획득
		var posX	= jutil.dhtml.getOffsetLeft(evtSrc);
		var posY	= jutil.dhtml.getOffsetTop(evtSrc);
		var o		= jutil.o("layerPop1Cont");
		
		
		// 위치 조정
		o.layerPop1Cont.style.display	= "block";
		o.layerPop1Cont.style.left		= posX + x;
		o.layerPop1Cont.style.top		= document.documentElement.scrollTop + posY - o.layerPop1Cont.offsetHeight + y;
	}
} 




/******************************************************************************************
	상품 간단히 보기에서 상품이미지에 마우스 오버시 이미지 상단부부에 노출되는 레이어 컨트롤
******************************************************************************************/
jutil.bandi.prodQuickCommentView = function(objImg, str, display){
	/*	코멘트 노출 처리
	*/
	jutil.bandi.prodQuickCommentMake();

	var o	= jutil.o("prodQuickCommentCont", "prodQuickCommentStr");


	switch(display){
		case "block" :
			// 내용 채우기
			o.prodQuickCommentStr.innerHTML	= str;
		
			// 위치 정보 획득
			var posX	= jutil.dhtml.getOffsetLeft(objImg);
			var posY	= jutil.dhtml.getOffsetTop(objImg);
			
			// 위치 조정
			o.prodQuickCommentCont.style.display	= "block";
			o.prodQuickCommentCont.style.left		= posX - 24;
			o.prodQuickCommentCont.style.top		= document.documentElement.scrollTop + posY - o.prodQuickCommentCont.offsetHeight;

			break;
		case "none" :
			o.prodQuickCommentCont.style.display			= "none";
			break;
	}
}


jutil.bandi.prodQuickCommentIsMake	= false;
jutil.bandi.prodQuickCommentMake = function(){
	/*	상품 코멘트 레이어를 생성한다.
	*/
	if(!jutil.bandi.prodQuickCommentIsMake){
		jutil.bandi.prodQuickCommentIsMake	= true;
		
		var strArr = Array();
		strArr.push("<div id='prodQuickCommentCont' style='display:block; position:absolute; bottom:133px; left:28px; width:150px; padding-bottom:5px;'>");
		strArr.push("	<div style='position:relative; width:124px; background:#FFFFFF; border:3px solid #A38942; padding:10px; font-size:11px; color:#7B5A2B;'>");
		strArr.push("		<div id='prodQuickCommentStr'></div>");
		strArr.push("		<div style='position:absolute; bottom:-13px; left:70px;'><img src='/images/common/ico_alt.gif' alt=''></div>");
		strArr.push("	</div>");
		strArr.push("</div>");
		
		document.body.insertAdjacentHTML("beforeEnd", strArr.join(""));
	}else{
		// 코멘트 레이어는 매번 레이어를 새로 생성해야 height 값이 갱신된다.
		var Cont = jutil.e("prodQuickCommentCont");
		Cont.parentNode.removeChild(Cont);
		jutil.bandi.prodQuickCommentIsMake = false;
		jutil.bandi.prodQuickCommentMake();
	}
}





/******************************************************************************************
	상품 간단히 보기에서 상품이미지에 마우스 오버시 이미지 하단부에 노출되는 레이어 컨트롤
******************************************************************************************/
jutil.bandi.prodQuickIconViewProdId		= null;
jutil.bandi.prodQuickIconViewProdType	= "new";	// 일반도서상품, 중고책 상품, 일반상품 구문 코드 (new/old/normal 로 구분)
jutil.bandi.prodQuickIconView = function(objImg, prodId, display, prodType, prodOldId){
	/*	상품 아이콘 노출 처리
	*/
	jutil.bandi.prodQuickIconMake();
	
	var Cont = (prodType == "normal") ? jutil.e("prodQuickIconContNormal") : jutil.e("prodQuickIconCont");

	switch(display){
		case "block" :
			// 전역변수 설정
			jutil.bandi.prodQuickIconViewProdId			= prodId;
			jutil.bandi.prodQuickIconViewProdType		= prodType;
			
			
			// 위치 정보 획득
			var posX	= jutil.dhtml.getOffsetLeft(objImg);
			var posY	= jutil.dhtml.getOffsetTop(objImg);
			
			// 위치 조정
			Cont.style.display	= "block";
			Cont.style.left		= posX + 6 + "px";
			Cont.style.top		= document.body.scrollTop + posY + objImg.offsetHeight - Cont.offsetHeight + "px";		
			break;
		case "none" :
			Cont.style.display			= "none";
			break;
	}
}





jutil.bandi.prodQuickIconIsMake	= false;
jutil.bandi.prodQuickIconMake = function(){
	/*	상품 아이콘 레이어를 생성한다.
			- 1번만 생성한다.
	*/
	if(!jutil.bandi.prodQuickIconIsMake){
		jutil.bandi.prodQuickIconIsMake	= true;
		
		var strArr = Array();
		strArr.push("<div id='prodQuickIconCont' onmouseover=\"jutil.dhtml.display('prodQuickIconCont', 'block');\" onmouseout=\"jutil.dhtml.display('prodQuickIconCont', 'none');\" class='go_ico' style='position:absolute; display:none;'>");
		strArr.push("	<div id='prodQuickIconContAlt01' class='layerNone'><img src='/images/common/alt_myLibrary.gif' alt=''></div>");
		strArr.push("	<div id='prodQuickIconContAlt02' class='layerNone'><img src='/images/common/alt_wishList.gif' alt=''></div>");
		strArr.push("	<div id='prodQuickIconContAlt03' class='layerNone'><img src='/images/common/alt_bookCart.gif' alt=''></div>");
		strArr.push("	<div id='prodQuickIconContAlt04' class='layerNone'><img src='/images/common/alt_buy.gif' alt=''></div>");
		strArr.push("	<div class='icoLay'>");
		strArr.push("		<p><img src='/images/common/ico_myLibrary.gif' onmouseover=\"jutil.dhtml.display('prodQuickIconContAlt01', 'block')\" onmouseout=\"jutil.dhtml.display('prodQuickIconContAlt01', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.prodQuickIconEventHandle('getProdMyLibrary')\"></p>");
		strArr.push("		<p><img src='/images/common/ico_wishList.gif' onmouseover=\"jutil.dhtml.display('prodQuickIconContAlt02', 'block')\" onmouseout=\"jutil.dhtml.display('prodQuickIconContAlt02', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.prodQuickIconEventHandle('getWishList')\"></p>");
		strArr.push("		<p><img src='/images/common/ico_bookCart.gif' onmouseover=\"jutil.dhtml.display('prodQuickIconContAlt03', 'block')\" onmouseout=\"jutil.dhtml.display('prodQuickIconContAlt03', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.prodQuickIconEventHandle('getCart')\"></p>");
		strArr.push("		<p><img src='/images/common/ico_buy.gif' onmouseover=\"jutil.dhtml.display('prodQuickIconContAlt04', 'block')\" onmouseout=\"jutil.dhtml.display('prodQuickIconContAlt04', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.prodQuickIconEventHandle('getOrder')\"></p>");
		strArr.push("	</div>");
		strArr.push("</div>");


		strArr.push("<div id='prodQuickIconContNormal' onmouseover=\"jutil.dhtml.display('prodQuickIconContNormal', 'block');\" onmouseout=\"jutil.dhtml.display('prodQuickIconContNormal', 'none');\" class='go_ico' style='position:absolute; display:none; border:0pt solid; width:63px; padding-left:10px;'>");
		strArr.push("	<div id='prodQuickIconContNormalAlt02' class='layerNone' style='padding-left:10px;'><img src='/images/common/alt_wishList_small.gif' alt=''></div>");
		strArr.push("	<div id='prodQuickIconContNormalAlt03' class='layerNone' style='padding-left:10px;'><img src='/images/common/alt_bookCart_small.gif' alt=''></div>");
		strArr.push("	<div id='prodQuickIconContNormalAlt04' class='layerNone' style='padding-left:10px;'><img src='/images/common/alt_buy_small.gif' alt=''></div>");
		strArr.push("	<div class='icoLay' style='border:0pt solid; width:63px;'>");
		strArr.push("		<p><img src='/images/common/ico_wishList.gif' onmouseover=\"jutil.dhtml.display('prodQuickIconContNormalAlt02', 'block')\" onmouseout=\"jutil.dhtml.display('prodQuickIconContNormalAlt02', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.prodQuickIconEventHandle('getWishList')\"></p>");
		strArr.push("		<p><img src='/images/common/ico_bookCart.gif' onmouseover=\"jutil.dhtml.display('prodQuickIconContNormalAlt03', 'block')\" onmouseout=\"jutil.dhtml.display('prodQuickIconContNormalAlt03', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.prodQuickIconEventHandle('getCart')\"></p>");
		strArr.push("		<p><img src='/images/common/ico_buy.gif' onmouseover=\"jutil.dhtml.display('prodQuickIconContNormalAlt04', 'block')\" onmouseout=\"jutil.dhtml.display('prodQuickIconContNormalAlt04', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.prodQuickIconEventHandle('getOrder')\"></p>");
		strArr.push("	</div>");
		strArr.push("</div>");


		document.body.insertAdjacentHTML("beforeEnd", strArr.join(""));
	}
}


jutil.bandi.prodQuickIconEventHandle = function(eventName){
	/*	상품 아이콘 레이어 이벤트 핸들
			- 서재담기, 위시리스트, 쇼핑카트, 바로구매 기능 처리
	*/

	switch(eventName){
		case "getProdMyLibrary" :
			//jutil.bandi.getProdMyLibrary(jutil.bandi.prodQuickIconViewProdId);
			jutil.bandi.blogAddMyLibrary(jutil.bandi.prodQuickIconViewProdId);
			break;
		case "getWishList" :		// 위시리스트 담기
			switch(jutil.bandi.prodQuickIconViewProdType){
				case "new" :
				case "normal" :
					//add_wish(jutil.bandi.prodQuickIconViewProdId);
					add_wish_array_common(jutil.bandi.prodQuickIconViewProdId, true);
					break;
				case "old" :
					add_wish_array_common(jutil.bandi.prodQuickIconViewProdId, true);
					break;
			}
			break;
		case "getCart" :
			switch(jutil.bandi.prodQuickIconViewProdType){
				case "new" :
				case "normal" :
					add_basket(jutil.bandi.prodQuickIconViewProdId, 1);
					break;
			}

			break;
		case "getOrder" :
			//add_order_common(jutil.bandi.prodQuickIconViewProdId, 1);
			goBuy(jutil.bandi.prodQuickIconViewProdId);
			break;
		default : 
			alert("jutil.bandi.prodQuickIconEventHandle : " + eventName + "에 대한 이벤트가 정의되지 않았습니다.");
			break;
	}
}


/******************************************************************************************
	상품 간단히 보기에서 상품이미지에 마우스 오버시 이미지 하단부에 노출되는 레이어 컨트롤 for iFrame
 ******************************************************************************************/
jutil.bandi.iFrameProdQuickIconViewProdId		= null;
jutil.bandi.iFrameProdQuickIconViewProdType	= "new";	// 일반도서상품, 중고책 상품, 일반상품 구문 코드 (new/old/normal 로 구분)
jutil.bandi.iFrameProdQuickIconView = function(objImg, prodId, display, prodType, prodOldId){
	/*	상품 아이콘 노출 처리
	 */
	jutil.bandi.iFrameProdQuickIconMake();
	
	var Cont = (prodType == "normal") ? jutil.e("iFrameProdQuickIconContNormal") : jutil.e("iFrameProdQuickIconCont");
	
	switch(display){
	case "block" :
		// 전역변수 설정
		jutil.bandi.iFrameProdQuickIconViewProdId			= prodId;
		jutil.bandi.iFrameProdQuickIconViewProdType		= prodType;
		
		
		// 위치 정보 획득
		var posX	= jutil.dhtml.getOffsetLeft(objImg);
		var posY	= jutil.dhtml.getOffsetTop(objImg);
		
		
		// 위치 조정
		Cont.style.display	= "block";
		Cont.style.left		= posX + 6 + "px";
		Cont.style.top		= document.documentElement.scrollTop + posY + objImg.offsetHeight - Cont.offsetHeight + "px";		
		break;
	case "none" :
		Cont.style.display			= "none";
		break;
	}
}





jutil.bandi.iFrameProdQuickIconIsMake	= false;
jutil.bandi.iFrameProdQuickIconMake = function(){
	/*	상품 아이콘 레이어를 생성한다.
			- 1번만 생성한다.
	 */
	if(!jutil.bandi.iFrameProdQuickIconIsMake){
		jutil.bandi.iFrameProdQuickIconIsMake	= true;
		
		var strArr = Array();
		strArr.push("<div id='iFrameProdQuickIconCont' onmouseover=\"jutil.dhtml.display('iFrameProdQuickIconCont', 'block');\" onmouseout=\"jutil.dhtml.display('iFrameProdQuickIconCont', 'none');\" class='go_ico' style='position:absolute; display:none;'>");
		strArr.push("	<div id='iFrameProdQuickIconContAlt01' class='layerNone'><img src='/images/common/alt_myLibrary.gif' alt=''></div>");
		strArr.push("	<div id='iFrameProdQuickIconContAlt02' class='layerNone'><img src='/images/common/alt_wishList.gif' alt=''></div>");
		strArr.push("	<div id='iFrameProdQuickIconContAlt03' class='layerNone'><img src='/images/common/alt_bookCart.gif' alt=''></div>");
		strArr.push("	<div id='iFrameProdQuickIconContAlt04' class='layerNone'><img src='/images/common/alt_buy.gif' alt=''></div>");
		strArr.push("	<div class='icoLay'>");
		strArr.push("		<p><img src='/images/common/ico_myLibrary.gif' onmouseover=\"jutil.dhtml.display('iFrameProdQuickIconContAlt01', 'block')\" onmouseout=\"jutil.dhtml.display('iFrameProdQuickIconContAlt01', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.iFrameProdQuickIconEventHandle('getProdMyLibrary')\"></p>");
		strArr.push("		<p><img src='/images/common/ico_wishList.gif' onmouseover=\"jutil.dhtml.display('iFrameProdQuickIconContAlt02', 'block')\" onmouseout=\"jutil.dhtml.display('iFrameProdQuickIconContAlt02', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.iFrameProdQuickIconEventHandle('getWishList')\"></p>");
		strArr.push("		<p><img src='/images/common/ico_bookCart.gif' onmouseover=\"jutil.dhtml.display('iFrameProdQuickIconContAlt03', 'block')\" onmouseout=\"jutil.dhtml.display('iFrameProdQuickIconContAlt03', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.iFrameProdQuickIconEventHandle('getCart')\"></p>");
		strArr.push("		<p><img src='/images/common/ico_buy.gif' onmouseover=\"jutil.dhtml.display('iFrameProdQuickIconContAlt04', 'block')\" onmouseout=\"jutil.dhtml.display('iFrameProdQuickIconContAlt04', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.iFrameProdQuickIconEventHandle('getOrder')\"></p>");
		strArr.push("	</div>");
		strArr.push("</div>");
		
		
		strArr.push("<div id='iFrameProdQuickIconContNormal' onmouseover=\"jutil.dhtml.display('iFrameProdQuickIconContNormal', 'block');\" onmouseout=\"jutil.dhtml.display('iFrameProdQuickIconContNormal', 'none');\" class='go_ico' style='position:absolute; display:none; border:0pt solid; width:63px; padding-left:10px;'>");
		strArr.push("	<div id='iFrameProdQuickIconContNormalAlt02' class='layerNone' style='padding-left:10px;'><img src='/images/common/alt_wishList_small.gif' alt=''></div>");
		strArr.push("	<div id='iFrameProdQuickIconContNormalAlt03' class='layerNone' style='padding-left:10px;'><img src='/images/common/alt_bookCart_small.gif' alt=''></div>");
		strArr.push("	<div id='iFrameProdQuickIconContNormalAlt04' class='layerNone' style='padding-left:10px;'><img src='/images/common/alt_buy_small.gif' alt=''></div>");
		strArr.push("	<div class='icoLay' style='border:0pt solid; width:63px;'>");
		strArr.push("		<p><img src='/images/common/ico_wishList.gif' onmouseover=\"jutil.dhtml.display('iFrameProdQuickIconContNormalAlt02', 'block')\" onmouseout=\"jutil.dhtml.display('iFrameProdQuickIconContNormalAlt02', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.iFrameProdQuickIconEventHandle('getWishList')\"></p>");
		strArr.push("		<p><img src='/images/common/ico_bookCart.gif' onmouseover=\"jutil.dhtml.display('iFrameProdQuickIconContNormalAlt03', 'block')\" onmouseout=\"jutil.dhtml.display('iFrameProdQuickIconContNormalAlt03', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.iFrameProdQuickIconEventHandle('getCart')\"></p>");
		strArr.push("		<p><img src='/images/common/ico_buy.gif' onmouseover=\"jutil.dhtml.display('iFrameProdQuickIconContNormalAlt04', 'block')\" onmouseout=\"jutil.dhtml.display('iFrameProdQuickIconContNormalAlt04', 'none')\" alt='' style='cursor:pointer;' onclick=\"jutil.bandi.iFrameProdQuickIconEventHandle('getOrder')\"></p>");
		strArr.push("	</div>");
		strArr.push("</div>");
		
		
		document.body.insertAdjacentHTML("beforeEnd", strArr.join(""));
	}
}


jutil.bandi.iFrameProdQuickIconEventHandle = function(eventName){
	/*	상품 아이콘 레이어 이벤트 핸들
			- 서재담기, 위시리스트, 쇼핑카트, 바로구매 기능 처리
	 */
	
	switch(eventName){
	case "getProdMyLibrary" :
		//jutil.bandi.getProdMyLibrary(jutil.bandi.iFrameProdQuickIconViewProdId);
		parent.jutil.bandi.blogAddMyLibrary(jutil.bandi.iFrameProdQuickIconViewProdId);
		break;
	case "getWishList" :		// 위시리스트 담기
		switch(jutil.bandi.iFrameProdQuickIconViewProdType){
		case "new" :
		case "normal" :
			//add_wish(jutil.bandi.iFrameProdQuickIconViewProdId);
			parent.add_wish_array_common(jutil.bandi.iFrameProdQuickIconViewProdId, true);
			break;
		case "old" :
			parent.add_wish_array_common(jutil.bandi.iFrameProdQuickIconViewProdId, true);
			break;
		}
		break;
	case "getCart" :
		switch(jutil.bandi.iFrameProdQuickIconViewProdType){
		case "new" :
		case "normal" :
			parent.add_basket(jutil.bandi.iFrameProdQuickIconViewProdId, 1);
			break;
		}
		
		break;
	case "getOrder" :
		//add_order_common(jutil.bandi.iFrameProdQuickIconViewProdId, 1);
		parent.goBuy(jutil.bandi.iFrameProdQuickIconViewProdId);
		break;
	default : 
		alert("jutil.bandi.iFrameProdQuickIconEventHandle : " + eventName + "에 대한 이벤트가 정의되지 않았습니다.");
	break;
	}
}



/******************************************************************************************
	RSS
******************************************************************************************/
jutil.bandi.rssPopup = function(){
	/*	RSS 주소 복사하기 팝업을 띄운다.
			common.js 참조
	*/
	openPopup("618", "600", "/front/rss/rssSelect.do", "Y");
}




/******************************************************************************************
	북마크
******************************************************************************************/
jutil.bandi.setMemBookMark = function(){
	/*	현재 사용자가 접근하고 있는 페이지를 북마크 처리한다.
			- 로그인된 사용자는 시스템 자체 즐겨찾기를 지원하고, 비로그인 회원은 기본적인 즐겨찾기를 지원한다.
	*/
	if(jutil.bandi.isLogin()){
		ajaxRequest("setMemBookMark", {
			"url"		: location.href, 
			"subject"	: navi.pathStr
		}, function(data){
			if(data) {
				alert("등록되었습니다.");
				jutil.bandi.reloadWiseCart("bookmark");
			} else {
				alert("이미 즐겨찾기로 설정되어 있습니다.");
				jutil.bandi.reloadWiseCart("bookmark");
			}
			//window.external.AddFavorite(location.href, document.title);
		});
	}else{
		//window.external.AddFavorite(location.href, document.title);
		// alert("로그인후 이용이 가능합니다.");
		goLoginPopUp();
	}
}


/******************************************************************************************
	최근본상품
******************************************************************************************/
jutil.bandi.setRecentProd = function(prodId,prodName){
	jutil.cookie.set_cookie("lastProd", prodName);
	/*	현재사용자가 최근 본 상품 정보를 저장한다.
			- 로그인한 회원과 로그인을 하지 않은 회원을 구분한다.
	*/
	if(jutil.bandi.isLogin()){
		// 로그인한 회원인 경우
		ajaxRequest("setMemProdView", {"isbn" : isbn}, function(){	jutil.bandi.reloadWiseCart();	});
	}else{
		// 로그인 하지 않은 회원인 경우
 		var recentProds = jutil.bandi.getRecentProd();

		if(!jutil.array.in_array(recentProds, isbn)){
			if(recentProds.length > 7){		// 최근본 상품이 7개를 초과한 경우에는 마지막에 있는 정보를 삭제한다.
				recentProds = jutil.array.removeLast(recentProds, 1);
			}

			// 최근순으로 노출 시키기 위해서 첫번째 자리에 추가한다.
			recentProds = jutil.array.insertAt(recentProds, 0, isbn);
		}
		jutil.bandi.setCookieInfo("recentProd", recentProds.join(","));
		jutil.bandi.reloadWiseCart();
	}
}

jutil.bandi.getRecentProd = function(info){
	/*	현재 사용자가 최근 본 상품 정보를 Array로 반환한다.
	*/
	var rv = Array();

	if(jutil.bandi.isLogin()){
		// 로그인 한 회원의 경우
		ajaxRequest("getMemProdViews", {}, function(data){
			for(var i=0 ; i < data.length ; i++){	rv.push(data[i].prod_id);	}
			if(info && info.callBack){
				if(info.rvType){
					if(info.rvType == "dwr"){
						info.callBack(data);
					}else{
						info.callBack(rv);
					}
				}else{
					info.callBack(rv);
				}
			}
		});
	}else{
		// 로그인 하지 않은 회원인 경우
		var recentProd = jutil.bandi.getCookieInfo("recentProd");
		if(recentProd != null){
			rv = recentProd.split(",");
		}

		if(info && info.callBack){	info.callBack(rv);		}
		return rv;
	}
}

jutil.bandi.setTodayProd = function(prodId,prodImg){
	// 로그인 하지 않은 회원인 경우
	var todayProdIds = jutil.bandi.getTodayProdId();
	var todayProdImgs = jutil.bandi.getTodayProdImg();

	if(!jutil.array.in_array(todayProdIds, prodId)){
		if(todayProdIds.length > 20){		// 오늘본 상품이 20개를 초과한 경우에는 마지막에 있는 정보를 삭제한다.
			todayProdIds = jutil.array.removeLast(todayProdIds, 1);
		}

		// 최근순으로 노출 시키기 위해서 첫번째 자리에 추가한다.
		todayProdIds = jutil.array.insertAt(todayProdIds, 0, prodId);
	}
	
	if(!jutil.array.in_array(todayProdImgs, prodImg)){
		if(todayProdImgs.length > 20){		// 오늘본 상품이 20개를 초과한 경우에는 마지막에 있는 정보를 삭제한다.
			todayProdImgs = jutil.array.removeLast(todayProdImgs, 1);
		}
		
		// 최근순으로 노출 시키기 위해서 첫번째 자리에 추가한다.
		todayProdImgs = jutil.array.insertAt(todayProdImgs, 0, prodImg);
	}
	
	jutil.bandi.setCookieTodayProdId("todayProdId", todayProdIds.join(","));
	jutil.bandi.setCookieTodayProdImg("todayProdImg", todayProdImgs.join(","));
	jutil.bandi.reloadWiseCart();
}

jutil.bandi.getTodayProdId = function(info){
	var rv = Array();

	var todayProdId = jutil.bandi.getCookieTodayProdId("todayProdId");
	if(todayProdId != null){
		rv = todayProdId.split(",");
	}

	if(info && info.callBack){	info.callBack(rv);		}
	return rv;
}

jutil.bandi.getTodayProdImg = function(info){
	var rv = Array();
	
	var todayProdImg = jutil.bandi.getCookieTodayProdImg("todayProdImg");
	if(todayProdImg != null){
		rv = todayProdImg.split(",");
	}
	
	if(info && info.callBack){	info.callBack(rv);		}
	return rv;
}

jutil.bandi.cookieTodayProdId = null;
jutil.bandi.setCookieTodayProdId = function(key, value){
	/*	현재 사용자의 쿠키에 해당 값을 설정한다.
	*/
	var info	= (jutil.bandi.cookieTodayProdId == null) ? jutil.cookie.get_cookie("todayProdId") : jutil.bandi.cookieTodayProdId;
	var infoArr	= Array();
	var isAdd	= false;

	if(info == ""){
		infoArr.push(key + "|" + value);
	}else{
		infos = info.split("`");
		for(var i=0 ; i < infos.length ; i++){
			var arr = infos[i].split("|");
			if(arr[0] == key){
				infoArr.push(key + "|" + value);
				isAdd = true;
			}else{
				infoArr.push(arr[0] + "|" + arr[1]);
			}
		}
		
		if(!isAdd){
			infoArr.push(key + "|" + value);
		}
	}

	jutil.bandi.cookieTodayProdId = infoArr.join("`");
	jutil.cookie.set_cookie("todayProdId", jutil.bandi.cookieTodayProdId, 60*60*24*2);
}


jutil.bandi.getCookieTodayProdId = function(key){
	/*	현재 사용자의 쿠키에 설정된 info 값을 반환한다.
	*/
	var infos	= jutil.cookie.get_cookie("todayProdId").split("`");
	for(var i=0 ; i < infos.length ; i++){
		var arr = infos[i].split("|");
		if(arr[0] == key){	return arr[1];	}
	}
	return null;
}

jutil.bandi.cookieTodayProdImg = null;
jutil.bandi.setCookieTodayProdImg = function(key, value){
	/*	현재 사용자의 쿠키에 해당 값을 설정한다.
	 */
	var info	= (jutil.bandi.cookieTodayProdImg == null) ? jutil.cookie.get_cookie("todayProdImg") : jutil.bandi.cookieTodayProdImg;
	var infoArr	= Array();
	var isAdd	= false;
	
	if(info == ""){
		infoArr.push(key + "|" + value);
	}else{
		infos = info.split("`");
		for(var i=0 ; i < infos.length ; i++){
			var arr = infos[i].split("|");
			if(arr[0] == key){
				infoArr.push(key + "|" + value);
				isAdd = true;
			}else{
				infoArr.push(arr[0] + "|" + arr[1]);
			}
		}
		
		if(!isAdd){
			infoArr.push(key + "|" + value);
		}
	}
	
	jutil.bandi.cookieTodayProdImg = infoArr.join("`");
	jutil.cookie.set_cookie("todayProdImg", jutil.bandi.cookieTodayProdImg, 60*60*24*2);
}


jutil.bandi.getCookieTodayProdImg = function(key){
	/*	현재 사용자의 쿠키에 설정된 info 값을 반환한다.
	 */
	var infos	= jutil.cookie.get_cookie("todayProdImg").split("`");
	for(var i=0 ; i < infos.length ; i++){
		var arr = infos[i].split("|");
		if(arr[0] == key){	return arr[1];	}
	}
	return null;
}

/******************************************************************************************
	사용자 쿠키
******************************************************************************************/
jutil.bandi.cookieInfo = null;
jutil.bandi.setCookieInfo = function(key, value){
	/*	현재 사용자의 쿠키에 해당 값을 설정한다.
	*/
	var info	= (jutil.bandi.cookieInfo == null) ? jutil.cookie.get_cookie("info") : jutil.bandi.cookieInfo;
	var infoArr	= Array();
	var isAdd	= false;

	if(info == ""){
		infoArr.push(key + "|" + value);
	}else{
		infos = info.split("`");
		for(var i=0 ; i < infos.length ; i++){
			var arr = infos[i].split("|");
			if(arr[0] == key){
				infoArr.push(key + "|" + value);
				isAdd = true;
			}else{
				infoArr.push(arr[0] + "|" + arr[1]);
			}
		}
		
		if(!isAdd){
			infoArr.push(key + "|" + value);
		}
	}

	jutil.bandi.cookieInfo = infoArr.join("`");
	jutil.cookie.set_cookie("info", jutil.bandi.cookieInfo);
}


jutil.bandi.getCookieInfo = function(key){
	/*	현재 사용자의 쿠키에 설정된 info 값을 반환한다.
	*/
	var infos	= jutil.cookie.get_cookie("info").split("`");
	for(var i=0 ; i < infos.length ; i++){
		var arr = infos[i].split("|");
		if(arr[0] == key){	return arr[1];	}
	}
	return null;
}


jutil.bandi.getMemId = function(){
	/*	현재 사용자의 고유번호를 반환한다.
	*/
	return jutil.cookie.get_cookie("MEM_ID");
}

jutil.bandi.getMemSeq = function(){
	/*	현재 사용자의 고유번호를 반환한다.
	*/
	if(typeof(sMemSeq) == 'undefined') {
		return "";
	}else {
		return sMemSeq;
	}
} 


jutil.bandi.isLogin = function(){
	/*	현재 사용자가 로그인 된 상태인지를 반환한다.
	*/
	if(typeof(sMemSeq) == 'undefined') {
		return false;
	}else {
		if(parseInt(sMemSeq)>0) {
			return true;
		} else {
			return false;
		}
	}
}


jutil.bandi.isGroup = function(){
	/*	현재 사용자가 해당 그룹에 속하는지여부를 반환한다.
	*/
	var group = jutil.cookie.get_cookie("MEM_GROUP").split(",");
	if(arguments){
		for(var i=0 ; i < arguments.length ; i++){
			if(jutil.array.in_array(group, arguments[i])){
				return true;
			}
		}
	}
	
	return false;
}


/******************************************************************************************
	* 화면의 동적 뷰를 위한 스크립트
	- a_dataArea에 모든 데이터를 뿌려놓고 a_displayArea에 필요한 부분만 display 하는 구조.
	- 참?고 url : /front/main.do

	- ex) 총데이터는 9개인데 3개만 보여 주고 나머지는 next, prev 버튼에 의한 제어.
		
		<a href="javascript:jutil.bandi.dynamicView('a', 'prev');">????</a>
		<a href="javascript:jutil.bandi.dynamicView('a', 'next');">????</a>

		<div>
			<ul id="a_dataArea" dynamicCurrent="0" dynamicMoveCount="3" style="display:none">
				<li>0</li>
				<li>1</li>
				<li>2</li>
				<li>3</li>
				<li>4</li>
				<li>5</li>
				<li>6</li>
				<li>7</li>
				<li>8</li>
				<li>9</li>
			</ul>
			<ul id="a_displayArea">
			</ul>
		</div>

		<script>
			jutil.bandi.dynamicView('a', '');
		</script>

******************************************************************************************/
jutil.bandi.dynamicView = function(objName, action) {

	var dataObj = document.getElementById(objName + "_dataArea");
	var viewObject = document.getElementById(objName + "_displayArea");
	
	var dynamicCurrent = parseInt(dataObj.getAttribute('dynamicCurrent'));
	var dynamicMoveCount = parseInt(dataObj.getAttribute('dynamicMoveCount'));
	var subDataObj = dataObj.getElementsByTagName("li");
	
	var dataLength = subDataObj.length;
	
	//alert("in : current = " + dynamicCurrent + ", moveCount = " + dynamicMoveCount + ", dataLength = " + dataLength);
	
	// display 갯수보다 data 의 갯수가 적을 경우 display 를 data 갯수로 줄여 객체 복사 방지.
	if(dataLength < dynamicMoveCount) {	
		dynamicMoveCount = dataLength;
	}
				
	// 1. prev, next 에 따른 최종 current값을 구한다.
	if(action == 'next') {
		dynamicCurrent = (dynamicCurrent + dynamicMoveCount) % (dataLength);
	} else if (action == 'prev') {
		dynamicCurrent = (dynamicCurrent - dynamicMoveCount);

		if(dynamicCurrent < 0) {
			dynamicCurrent = (dataLength) + dynamicCurrent;
		} else {
			dynamicCurrent = dynamicCurrent % (dataLength);
		}
	}
			
	dataObj.setAttribute('dynamicCurrent', parseInt(dynamicCurrent));
	
	// 2. current 값에 따라 dynamicMoveCount 갯수만큼 displayArea 에 뿌려준다.
	viewObject.innerHTML = "";
	for(i=0; i < dynamicMoveCount; i++) { 
		var temp = (dynamicCurrent + i) % (dataLength);
		viewObject.appendChild(subDataObj[temp].cloneNode(true));
	}
}

jutil.bandi.dynamicRoll = function(action, objName, dispCnt) {

	var objView 		= document.getElementsByName(objName);
	var objTotalCnt		= 0;
	var dispAreaVal		= 0;
	
	// 현재 선택되있는 영역검색
	for(var i=0; i<dispCnt; i++){
		if(objView[i] != undefined){
			objTotalCnt = objTotalCnt + 1;
			
			if(objView[i].style.display == "block"){
				dispAreaVal = i;
			}
		}
	}
	
	if(action == 'pre'){	// 이전
	
		if(dispAreaVal == 0){
			objView[dispAreaVal].style.display 		= "none";
			objView[objTotalCnt-1].style.display 	= "block";
		}else{
			objView[dispAreaVal].style.display 		= "none";
			objView[dispAreaVal -1].style.display 	= "block";
		}
	}
	else				// 다음
	{
		if(dispAreaVal == objTotalCnt-1){
			objView[dispAreaVal].style.display 		= "none";
			objView[0].style.display 				= "block";
		}else{
			objView[dispAreaVal].style.display 		= "none";
			objView[dispAreaVal +1].style.display 	= "block";
		}
	}
}


/**********************************************************************************************************************************************************************************
	작성자 : 김기석
	작성일 : 2007.06.21

	목적 :
		- 웹 기반의 자바스크립트 유틸 모음
		- JUTIL에서 사용되는 기본 환경 설정 정보

	참고사항 :
		- 여기에서는 기능 구현히 아니라 기본 환경 설정을 구성한다.
**********************************************************************************************************************************************************************************/


//var siteUrl	= SiteConf["url"]["site"] + "/";
siteUrl			= "127.0.0.1:8080/webproject/";
blogUrl			= "127.0.0.1:8080/webproject/";			// 블로그 서비스 경로
bandiUrl		= "127.0.0.1:8080/webproject/";
bandiSslUrl		= "127.0.0.1:8080/webproject/";

// 클라이언트측에서 직접 사용하는 XML 파일들을 모아 놓은 정보 => jutil.xml.getXmlInfoBase 에서 사용하는 기본 경로값
jutil.xml.getXmlInfoBasePath	= siteUrl + "manager/info/";


// jutil.include 에서 사용하는 js 파일들의 기본 경로값
jutil.include_path				= jutil.getBaseUrl()


// jutil.load에서 사용하는 경로의 기본값
jutil.load_path					= siteUrl + "manager/controls/";



// jutil.xmlhttp.requestCommon 에서 사용하는 기본 경로
jutil.xmlhttp.baseUrl			= siteUrl + "manager/service/xmlhttp.php"



//	트리에서 사용하는 이미지 관련된 정보
jutil.widget.tree.imgInfo.path	= siteUrl + "script/JUTIL/images/tree/";
jutil.widget.tree.imgInfo.close	= "plus.gif";
jutil.widget.tree.imgInfo.open	= "minus.gif";
jutil.widget.tree.imgInfo.base	= "none.gif";


// jutil.widget.help.make_02 에서 사용하는 기본 레이아웃 정보 설정 0번째는 기본소스에 포함되어 있다. 여기에서는 1번째부터 적용을 하게 된다.
jutil.widget.help.make_02_layout.push("<div style='border:1pt solid blue; width:200; height:100; padding:5; background-color:#EEEEEE;'>[msg]</div>");
