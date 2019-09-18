/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2008.04.23

	기능 : 
			- 반디북 시스템에서 DWR을 이용해서 처리되는 모든 스크립트 기능을 구현

	참고사항 : 
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(dwr) != "object"){				dwr					= {};		}


dwr.prodListMakeInfo = null;
dwr.prodListMakeData = null;
dwr.prodListMake = function(info){
	/*	상품 리스트를 구현한다.
			- 목록 구현에 문제가 있음. 테이블에 적용하기 어려움.
	*/
	dwr.prodListMakeInfo = info;
	ajaxRequest("getSearchProducts", info, dwr.prodListMakeCallBack);
}


dwr.prodListMakeCallBack = function(data){
	/*	상품 리스트를 구현한다.
	*/
	jutil.widget.list.make_dwr({
		"data"	: data, 
		"area"	: dwr.prodListMakeInfo.area 
	});

	// call back 함수가 존재하는 경우 해당 함수를 실행한다.
	if(dwr.prodListMakeInfo.callBackFn){
		dwr.prodListMakeInfo.callBackFn(data);
	}
}


dwr.categoryCheckboxMakeData = null;
dwr.categoryCheckboxMakeInfo = null;
dwr.categoryCheckboxMake = function(info){
	/*	카테고리 체크박스 인터페이스를 구성한다.
	*/
	dwr.categoryCheckboxMakeInfo = info;
	ajaxRequest("getCategories", info, dwr.categoryCheckboxMakeCallBack);
}


dwr.categoryCheckboxMakeCallBack = function(data){
	/*	카테고리 체크박스 인터페이스를 구성한다.
	*/
	dwr.categoryCheckboxMakeData = data;
	jutil.form.checkbox({
		"area_id"		: dwr.categoryCheckboxMakeInfo["area_id"],
		"data"			: data,
		"type"			: "dwr",  
		"field_value"	: "cate_id", 
		"field_text"	: "cate_name", 
		"object_id"		: dwr.categoryCheckboxMakeInfo["object_id"], 
		"cols"			: dwr.categoryCheckboxMakeInfo["cols"],
		"checkedValue"	: dwr.categoryCheckboxMakeInfo["checkedValue"],
		"attr"			: dwr.categoryCheckboxMakeInfo["attr"]     
	});

	if(typeof(dwr.categoryCheckboxMakeInfo["callBack"]) == "function"){
		dwr.categoryCheckboxMakeInfo["callBack"]();
	}
}


dwr.categorySelectSingleInfo	= null;
dwr.categorySelectSingleData	= null;
dwr.categorySelectSingle = function(info){
	/*	카테고리 select 인터페이스를 구성한다.
		하위카테고리는 구성하지 않고 1개 선택박스만 구성한다.
	*/
	dwr.categorySelectSingleInfo = info;
	ajaxRequest("getCategories", info, dwr.categorySelectSingleCallBack);
}

dwr.categorySelectSingleCallBack = function(data){
	/*	카테고리 select 인터페이스를 구성한다.
		하위카테고리는 구성하지 않고 1개 선택박스만 구성한다.
	*/
	dwr.categorySelectSingleData = data;

	jutil.form.select({
		"area_id"			: dwr.categorySelectSingleInfo["area_id"],
		"data"				: data,
		"type"				: "dwr",  
		"field_value"		: "cate_id", 
		"field_text"		: "cate_name", 
		"subject"			: dwr.categorySelectSingleInfo["subject"], 
		"object_id"			: dwr.categorySelectSingleInfo["object_id"], 
		"selected_value"	: dwr.categorySelectSingleInfo["selected_value"], 
		"fn_name_onchange"	: dwr.categorySelectSingleInfo["fn_name_onchange"]   
	});
	
	// 종료 함수 실행
	if(dwr.categorySelectSingleInfo["makeEndFn"]){
		eval(dwr.categorySelectSingleInfo["makeEndFn"] + "(data)");
	}
}





