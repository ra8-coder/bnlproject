/**********************************************************************************************************************************
	작성자 : 김기석, kisukim94@naver.com
	작성일 : 2008.05.16

	기능 : 
			- 본문 상단에 노출되는 네비게이션을 구성

	참고사항 : 
**********************************************************************************************************************************/


/*	인스턴스 생성
*/
if(typeof(navi) != "object"){				navi					= {};		}


navi.pathStr	= "";	// 로케이션에 대한 경로 문자열 정보. 북마크에서 사용한다.
navi.rss		= true;


navi.make = function(){
	/*	네비게이션을 생성한다.
	*/
	var strArr	= Array();


	// 일반 경로 정보 구성
	if(navi.type == "path"){
		var idx		= navi.path;
	
		// 해당 인덱스 존재 여부 체크
		if(!navi.info[idx]){		alert("navi : " + idx + " 경로정보가 존재하지 않습니다.");		return;	}

		// 좌측 이미지 정보 구성
		//strArr.push(navi.getImgInfo(idx));
		
		// 경로 정보 구성
		strArr.push(navi.getPathInfo(idx));
	
	
		// 즐겨찾기/RSS 정보 구성
		//strArr.push(navi.getFavoriteInfo(idx));
		
		// 블로거 검색 정보 구성
		if(idx >= 300 && idx < 400) {
			strArr.push(navi.getBlogSearch());
		}
		// 적용
		navi.makeApply(strArr);
	}


	// 카테고리 경로 정보 구성
	if(navi.type == "category"){
		navi.makeCategory();
	}
}


navi.makeApply = function(strArr){
	/*	구성된 정보를 적용한다.
	*/
	var cont = jutil.e(navi.container);
	if(cont != null){	cont.innerHTML = strArr.join("");								}
	else{				alert("navi : " + navi.container + " 영역이 존재하지 않습니다.");		}
}


navi.makeCategory = function(){
	/*	카테고리 기준의 네비게이션을 생성한다.
	*/
	//Category.getCategoryNaviList({"cateId" : navi.category, "storeId" : 1, "cateType" : "01"}, navi.makeCategoryCallBack);
	ajaxRequest("getCategoryNaviList", {"cateId" : navi.category, "storeId" : 1, "cateType" : "01"}, navi.makeCategoryCallBack); 
}


navi.makeCategoryCallBack = function(data){
	/*	네비게이션 정보를 받아서 인터페이스를 구성한다.
	*/
	var strArr = Array();
	

	// 이미지 정보 적용
	//strArr.push(navi.getImgCategory(data));	

	// 경로정보 적용
	strArr.push(navi.getPathCategory(data));

	// 즐겨찾기/RSS 정보 구성
	//strArr.push(navi.getFavoriteCategory(data));


	// 검색 정보 구성
	//strArr.push(navi.getSearchCategory(data));


	
	// 적용
	navi.makeApply(strArr);
}


navi.getPathCategoryFinalDepth	= 0;
navi.getPathCategoryFinalCateId	= 0;
navi.getPathCategory = function(data){
	/*	해당 카테고리 정보를 받아서 경로 정보를 구성해서 반환한다.
	*/
	var rv = Array();
	var pathStrArr	= Array();
	var url	= "/front/product/bookCategoryMain.do";

	// 홈
	rv.push("<li class='home'>");
	rv.push("<a href='/'>홈</a>");
	//rv.push(navi.division);
	rv.push("</li>");
	pathStrArr.push("홈");


	if(navi.categoryType == "used_prod"){
		
		// 중고상품
		rv.push("<li class='home_1dep'>");
		rv.push("<a href='/front/product/usedProdMain.do'>중고샵</a>");
		//rv.push(navi.division);
		rv.push("</li>");
		pathStrArr.push("중고샵");
	}
	// 도서
	if(navi.categoryType == "book" && data[0].cate_id != "5000"){
		
		rv.push("<li class='home_1dep'>");
		rv.push("<a href='/front/main.do'>도서</a>");
		//rv.push(navi.division);
		rv.push("</li>");
		pathStrArr.push(navi.categoryType.toUpperCase());
	}
	
	//수험서
	if(data[0].cate_id == "5000"){
		
		rv.push("<li class='home_1dep'>");
		rv.push("<a href='/front/exm/main.do'>수험서홈</a>");
		//rv.push(navi.division);
		rv.push("</li>");
		pathStrArr.push(navi.categoryType.toUpperCase());
	}
	
	// kids
	if(navi.categoryType == "kids"){
		
		rv.push("<li class='home_1dep'>");
		rv.push("<a href='/front/kids/kidsMain.do'>키즈샵</a>");
		//rv.push(navi.division);
		rv.push("</li>");
		pathStrArr.push(navi.categoryType.toUpperCase());
	}
	
	// 일반상품 (DVD/GIFT 인 경우)
	if(navi.categoryType == "gift"){
		
		rv.push("<li class='home_1dep'>");
		rv.push("<a href='/front/product/" + navi.categoryType + "CategoryMain.do'>GIFT</a>");
		//rv.push(navi.division);
		rv.push("</li>");
		pathStrArr.push(navi.categoryType.toUpperCase());
	}
	//뷰티
	if(navi.categoryType == "cosmetic"){
		
		rv.push("<li class='home_1dep'>");
		rv.push("<a href='/front/product/cosmeticMain.do'>뷰티</a>");
		//rv.push(navi.division);
		rv.push("</li>");
		pathStrArr.push(navi.categoryType.toUpperCase());
	} 

	// 음반
	if(navi.categoryType == "dvd"){
		
		rv.push("<li class='home_1dep'>");
		rv.push("<a href='/front/product/musicMain.do'>음반</a>");
		//rv.push(navi.division);
		rv.push("</li>");
		pathStrArr.push(navi.categoryType.toUpperCase());
	}

	// e-Book
	if(navi.categoryType == "eBook"){
		
		rv.push("<li class='home_1dep'>");
		rv.push("<a href='/front/product/eBookMain.do'>e-Book</a>");
		//rv.push(navi.division);
		rv.push("</li>");
		pathStrArr.push(navi.categoryType.toUpperCase());
	}

	if(data.length == 0 && navi.categoryType != "book_old"){
		rv.push("<li class='home_1dep'>");
		rv.push("<a href='" + url + "?cateId='> ");
		rv.push("도서")
		rv.push("</a>");
		//rv.push(navi.division);
		rv.push("</li>");
	}
	// DVD
	if(navi.categoryType == "realDvd"){
		
		rv.push("<li class='home_1dep'>");
		rv.push("<a href='/front/product/dvdMain.do'>DVD</a>");
		//rv.push(navi.division);
		rv.push("</li>");
		pathStrArr.push(navi.categoryType.toUpperCase());
	}
	// 오피스문구
	if(navi.categoryType == "Stationery"){
		
		rv.push("<li class='home_1dep'>");
		rv.push("<a href='/front/product/" + navi.categoryType + "CategoryMain.do'>오피스문구</a>");
		//rv.push(navi.division);
		rv.push("</li>");
		pathStrArr.push(navi.categoryType.toUpperCase());
	}

	if(data.length > 0){
		switch(data[0].cate_id){
			case "1" :	// 도서의 경우 일반도서와 중고도서를 구분한다.
				url = "/front/product/bookCategoryMain.do";
				break;
			case "3135" :
				url = "/front/kids/kidsCategoryMain.do";
				break;
			case "4089" :
				url = "/front/product/musicCategoryMainNew.do";
				break;
			case "4130" :
				url = "/front/product/giftCategoryMain.do";
				break;
			case "5000" :
				url = "/front/product/bookCategoryMain.do";
				break;
			case "5712" :
				url = "/front/product/eBookCategoryMain.do";
				break;
			case "6339" :
				url = "/front/product/dvdCategoryMainNew.do";
				break;	
			case "7257" :
			case "7307" :
				url = "/front/product/usedProdMain.do";
				break;	
			case "7363" :
				url = "/front/product/cosmeticMain.do";
				break;	 
			case "7504" :
				url = "/front/product/StationeryCategoryMain.do";
				break;	
 
		}
	}

	// 경로 (최상위 레벨은 제외 됨)
	for(var i=1 ; i < data.length ; i++){
	
		navi.makeSubLayer(data[i].cate_id);
		
		rv.push("<li>");
		
		if(navi.categoryType == "book_old"){
			rv.push("<a href='" + url + "?selectedBunyaId=" + data[i].cate_id + "&selectedBunyaName=" + data[i].cate_name + "' " + 
					" onMouseOver='navi.subLayerView(" + data[i].prnt_cate_id + ", this);' " + 
					" onMouseOut='navi.subLayerHide(" + data[i].prnt_cate_id + ");' " + 
					">");
		}else if(navi.categoryType == "used_prod"){
			if(data[i].prnt_cate_id == 7257 || data[i].prnt_cate_id == 7307){
				url = "/front/product/usedProdCateList.do";
			}
			rv.push("<a href='" + url + "?cateId=" + data[i].cate_id + "&fullCateId=" + data[i].full_cate_id + "' " + 
					" onMouseOver='navi.subLayerView(" + data[i].prnt_cate_id + ", this);' " + 
					" onMouseOut='navi.subLayerHide(" + data[i].prnt_cate_id + ");' " + 
					">");
		}else if(navi.categoryType == "cosmetic"){
			if(data[i].prnt_cate_id == 7363){
				url = "/front/product/cosmeticCateList.do";
			}
			rv.push("<a href='" + url + "?cateId=" + data[i].cate_id + "' " + 
					" onMouseOver='navi.subLayerView(" + data[i].prnt_cate_id + ", this);' " + 
					" onMouseOut='navi.subLayerHide(" + data[i].prnt_cate_id + ");' " + 
					">");
		}else if(navi.categoryType == "Stationery"){
			if(data[i].prnt_cate_id == 7504){
				url = "/front/product/StationeryCategoryMain.do";
			}
			rv.push("<a href='" + url + "?cateId=" + data[i].cate_id + "' " + 
					" onMouseOver='navi.subLayerView(" + data[i].prnt_cate_id + ", this);' " + 
					" onMouseOut='navi.subLayerHide(" + data[i].prnt_cate_id + ");' " + 
					">");
		}else{
			if(data[i].prnt_cate_id == 1){
				url = "/front/product/bookCategoryMain.do";
			}
			rv.push("<a href='" + url + "?cateId=" + data[i].cate_id + "&fullCateId=" + data[i].full_cate_id + "' " + 
					" onMouseOver='navi.subLayerView(" + data[i].prnt_cate_id + ", this);' " + 
					" onMouseOut='navi.subLayerHide(" + data[i].prnt_cate_id + ");' " + 
					">");
		}
		rv.push("<u>" + data[i].cate_name + "</u>");
		rv.push("</a>");
		rv.push(navi.division);
		rv.push("</li>");
		pathStrArr.push(data[i].cate_name);
		
		navi.getPathCategoryFinalCateId	= data[i].cate_id;
		navi.getPathCategoryFinalDepth	= i - 1;
	}
	

	if(rv.length > 0){
		rv = jutil.array.removeAt(rv, rv.length - 2);
		rv[rv.length - 3] = "<b>" + rv[rv.length - 3] + "</b>";
	}

	navi.pathStr = pathStrArr.join(" > ");
	return rv.join("");	
}


navi.subLayerView = function(prnt_cate_id, evtSrc){
	/*	해당 항목의 하위 레이어를 노출 시킨다.
	*/
	var oLayer = jutil.e("naviSubLayer" + prnt_cate_id);


	if(evtSrc && oLayer.style){
		oLayer.style.left		= jutil.dhtml.getOffsetLeft(evtSrc) - 1 + "px";
		oLayer.style.top		= document.body.scrollTop + jutil.dhtml.getOffsetTop(evtSrc) + evtSrc.offsetHeight - 2 + "px";
	}
	
	if(oLayer.style){
		oLayer.style.display	= "block";
		oLayer.style.zIndex		= "99";
	}
}

navi.subLayerHide = function(prnt_cate_id){
	/*	해당 항목의 하위 레이어를 숨긴다.
	*/
	var oLayer = jutil.e("naviSubLayer" + prnt_cate_id);
	oLayer.style.display	= "none";	
}



navi.makeSubLayer = function(cateId){
	/*	해당 카테고리의 하위 레이어를 생성한다.
	*/
	ajaxRequest("getCategorySameList", {"cateType" : "01", "cateId" : cateId, "storeId" : 1}, navi.makeSubLayerCallBack);
}



navi.makeSubLayerCallBack = function(data){
	/*	해당 카테고리의 하위 레이어를 생성한다.
			레이어에 배경색을 줘야지만 하위 오브젝트와 이벤트가 충돌되지 않는다.
	*/
	var strArr = Array();
	var url = "/front/product/bookCategoryMain.do";


	switch(data[0].master_cate_id){
		case "1" :
			url = "/front/product/bookCategoryMain.do";
			break;
		case "3135" :
			url = "/front/kids/kidsCategoryMain.do";
			break;
		case "4089" :
			url = "/front/product/musicCategoryMainNew.do";
			break;
		case "4130" :
			url = "/front/product/giftCategoryMain.do";
			break;
		case "5000" :
			url = "/front/product/bookCategoryMain.do";
			break;
		case "5712" :
			url = "/front/product/eBookCategoryMain.do";
			break;
		case "6339" :
			url = "/front/product/dvdCategoryMainNew.do";
			break;	
		case "7257" :
		case "7307" :
			url = "/front/product/usedProdCateList.do";
			break;	
		case "7363" :
			url = "/front/product/cosmeticCateList.do";
			break;
		case "7504" :
			url = "/front/product/StationeryCategoryMain.do";
			break; 
			
	}


	
	strArr.push("<div id='naviSubLayer" + data[0].prnt_cate_id + "' ");
	strArr.push(" style='position:absolute; display:none; left:0; top:0; border:1px solid #6f6f6f; background:#FFFFFF; padding:6px 0 6px 0;' ");
	strArr.push(" onMouseOver='navi.subLayerView(" + data[0].prnt_cate_id + ");' ");
	strArr.push(" onMouseOut='navi.subLayerHide(" + data[0].prnt_cate_id + ");' ");
	strArr.push(" class='sublay' ");
	strArr.push(">");

	if(data.length < 10){
		strArr.push("	<ul style='float:left; padding-right:20px; border-right:1px solid #E8E4DB;' class='alt'>");
		for(var i=0 ; i < data.length ; i++){
			if(navi.categoryType == "book_old"){
				strArr.push("<li style='float:none; margin-top:0px; padding:0 0 3px 10px; letter-spacing:-0.05em;'><a href='" + url + "?selectedBunyaId=" + data[i].cate_id + "&selectedBunyaName=" + data[i].cate_name + "' style='font:normal 11px 돋움;color:#888'>" + data[i].cate_name + "</a></li>");
			}else if(navi.categoryType == "used_prod"){
				if(data[i].prnt_cate_id == 7257 || data[i].prnt_cate_id == 7307){
					url = "/front/product/usedProdCateList.do";
				}
				strArr.push("<li style='float:none; margin-top:0px; padding:0 0 3px 10px; letter-spacing:-0.05em;'><a href='" + url + "?cateId=" + data[i].cate_id + "&fullCateId=" + data[i].full_cate_id + "' style='font:normal 11px 돋움;color:#888'>" + data[i].cate_name + "</a></li>");
			}else{
				if(data[i].prnt_cate_id == 1){
					url = "/front/product/bookCategoryMain.do";
				}
				strArr.push("<li style='float:none; margin-top:0px; padding:0 0 3px 10px; letter-spacing:-0.05em;'><a href='" + url + "?cateId=" + data[i].cate_id + "&fullCateId=" + data[i].full_cate_id + "' style='font:normal 11px 돋움;color:#888'>" + data[i].cate_name + "</a></li>");
			}
		}
		strArr.push("	</ul>");
	}else{
		strArr.push("	<ul style='float:left; padding-right:20px; border-right:1px solid #E8E4DB;' class='alt'>");
		for(var i=0 ; i < data.length ; i++){
			if(navi.categoryType == "book_old"){
				strArr.push("<li style='float:none; margin-top:0px; padding:0 0 3px 10px; letter-spacing:-0.05em;'><a href='" + url + "?selectedBunyaId=" + data[i].cate_id + "&selectedBunyaName=" + data[i].cate_name + "' style='font:normal 11px 돋움;color:#888'>" + data[i].cate_name + "</a></li>");
			}else if(navi.categoryType == "used_prod"){
				if(data[i].prnt_cate_id == 7257 || data[i].prnt_cate_id == 7307){
					url = "/front/product/usedProdCateList.do";
				}
				strArr.push("<li style='float:none; margin-top:0px; padding:0 0 3px 10px; letter-spacing:-0.05em;'><a href='" + url + "?cateId=" + data[i].cate_id + "&fullCateId=" + data[i].full_cate_id + "' style='font:normal 11px 돋움;color:#888'>" + data[i].cate_name + "</a></li>");
			}else if(navi.categoryType == "cosmetic"){
				if(data[i].prnt_cate_id == 7367){
					url = "/front/product/cosmeticCateList.do";
				}
				strArr.push("<li style='float:none; margin-top:0px; padding:0 0 3px 10px; letter-spacing:-0.05em;'><a href='" + url + "?cateId=" + data[i].cate_id + "' style='font:normal 11px 돋움;color:#888'>" + data[i].cate_name + "</a></li>");
			}else{
				if(data[i].prnt_cate_id == 1){
					url = "/front/product/bookCategoryMain.do";
				}
				strArr.push("<li style='float:none; margin-top:0px; padding:0 0 3px 10px; letter-spacing:-0.05em;'><a href='" + url + "?cateId=" + data[i].cate_id + "&fullCateId=" + data[i].full_cate_id + "' style='font:normal 11px 돋움;color:#888'>" + data[i].cate_name + "</a></li>");
			}

			if(parseInt(data.length/2)-1 == i){
				strArr.push("</ul><ul style='float:left; padding-right:20px; border-right:1px solid #E8E4DB;' class='alt'>");
			}
		}
		strArr.push("	</ul>");
	}

	strArr.push("</div>	");

	// 적용
	if(jutil.BWInfo().name == "MSIE"){
		document.body.insertAdjacentHTML("beforeEnd", strArr.join(""));
	}else{
		document.body.appendChild(jutil.parseHTML(strArr.join("")));
	}
} 




navi.getImgInfo = function(idx){
	/*	해당 인덱스의 좌측 이미지 정보를 구성해서 반환한다.
	*/
	return (navi.info[idx].img && navi.info[idx].img.length > 0) ? "<h1><img src='" + navi.info[idx].img + "'></h1>" : "";
}


navi.getImgCategory = function(data){
	/*	해당 인덱스의 좌측 이미지 정보를 구성해서 반환한다.
	*/
	
	if(data.length > 0){
		switch(data[0].cate_id){
			case "1" :
				switch(navi.categoryType){
					case "book" :
						return "<h1><img src='/images/locationTitle/tit_book.gif'></h1>";
						break;
					case "book_old" :
						return "<h1><img src='/images/locationTitle/tit_usedBook.gif'></h1>";
						break;
					default : 
						return "";
						break;
				}
	
				break;
				
			case "4089" :
				return "<h1><img src='/images/locationTitle/tit_dvd.gif'></h1>";
				break;
				
			case "4130" :
				return "<h1><img src='/images/locationTitle/tit_gift.gif'></h1>";
				break;
				
			case "5712" :
				return "<h1><img src='/images/locationTitle/tit_ebook.gif'></h1>";
				break;
				
			case "6339" :
				return "<h1><img src='/images/locationTitle/tit_dvd.gif'></h1>";
				break;	

			default : 
				return "<h1><img src='/images/locationTitle/tit_book.gif'></h1>";
				break;
		}
	}else{
		switch(navi.categoryType){
			case "book" :
				return "<h1><img src='/images/locationTitle/tit_book.gif'></h1>";
				break;
			case "book_old" :
				return "<h1><img src='/images/locationTitle/tit_usedBook.gif'></h1>";
				break;
			default : 
				return "";
				break;
		}
	}
}



navi.getPathInfo = function(idx){
	/*	해당 인덱스의 경로 정보를 구성해서 반환한다.
	*/
	var rv			= Array();
	var pathStrArr	= Array();

	for(var key in navi.info[idx].path){
		// 경로정보 구성
		rv.push("<li>");
		if(navi.info[idx].path[key].url && navi.info[idx].path[key].url.length > 0){
			rv.push("<a href='" + navi.info[idx].path[key].url + "'>" + key + "</a>");
		}else{
			rv.push(key);
		}
		rv.push(navi.division);
		rv.push("</li>");
		
		// 문자열 구성
		pathStrArr.push(key);
	}

	if(rv.length > 0){
		rv = jutil.array.removeAt(rv, rv.length - 2);
		rv[rv.length - 2] = "<b>" + rv[rv.length - 2] + "</b>";
	}

	navi.pathStr = pathStrArr.join(" > ");
	
	return rv.join("");
}


navi.getFavoriteCategory = function(data){
	/*	해당 카테고리의 즐겨찾기/RSS 인터페이스를 구성한다.
	*/
	var rv = Array();
	rv.push("<div class='ico01'><a href='javascript:jutil.bandi.setMemBookMark();'><img src='/images/common/ico_bookmark.gif' alt='즐겨찾기'></a></div>");
/*
	if(navi.rss && navi.categoryType != "dvd" && navi.categoryType != "gift"){
		rv.push("<div class='ico02'><img src='/images/common/ico_rss.gif' alt='RSS' style='cursor:pointer;' onclick='jutil.bandi.rssPopup()'></div>");
	}*/
	return rv.join("");	
}

navi.getFavoriteInfo = function(idx){
	/*	해당 인덱스의 즐겨찾기/RSS 인터페이스를 구성한다.
	*/
	var rv = Array();
	rv.push("<div class='ico01'><a href='javascript:jutil.bandi.setMemBookMark();'><img src='/images/common/ico_bookmark.gif' alt='즐겨찾기'></a></div>");
/*
	//중고책일 경우 RSS 출력안함
	if(!jutil.array.in_array(navi.rssSkipIdx, idx) && navi.rss){
		rv.push("<div class='ico02'><img src='/images/common/ico_rss.gif' alt='RSS' style='cursor:pointer;' onclick='jutil.bandi.rssPopup()'></div>");
	}*/
	return rv.join("");	
}



navi.getSearchCategory = function(data){
	/*	해당 카테고리의 검색 인터페이스를 구성한다.
	*/
	var rv = Array();
	rv.push("<div class='search'>");
	if(navi.categoryType == "book"){
		rv.push("	<p class='tit'><img src='/images/common/tit_locationSearch.gif' alt='분야별검색'></p>");
	}
	if(navi.categoryType == "book_old"){
		rv.push("	<p class='tit'><img src='/images/common/tit_usedBookSearch.gif' alt='분야별검색'></p>");
	}
	rv.push("	<p class='inputL'></p>");
	rv.push("	<p><input type='text' name='naviSearchSubject' onkeydown=\"event.keyCode == 13 ? navi.goSearch() : '';\"></p>");
	rv.push("	<p class='inputR'><a href='javascript:navi.goSearch();'><img src='/images/common/btn_searchInput.gif'></a></p>");
	rv.push("</div>");
	
	return rv.join("");	
}

navi.getBlogSearch = function(){
	/*	해당 카테고리의 검색 인터페이스를 구성한다.
	*/
	var rv = Array();
	rv.push("<div class='search'>");
	rv.push("	<p class='tit'><img src='/images/common/tit_blogSearch.gif' alt='블로거검색'></p>");
	rv.push("	<p class='inputL'></p>");
	rv.push("	<p><input type='text' name='naviSearchPeople' value='ID 또는 이름 입력' onclick=\"javascript:this.value='';\" onkeydown=\"event.keyCode == 13 ? navi.goBlogSearch() : '';\"></p>");
	rv.push("	<p class='inputR'><a href='javascript:navi.goBlogSearch();'><img src='/images/common/btn_searchInput.gif'></a></p>");
	rv.push("</div>");
	
	return rv.join("");	
}


navi.getSearchInfo = function(idx){
	/*	해당 인덱스의 검색 인터페이스를 구성한다.
	*/
	
	// 이벤트(120~127) 는 검색 인터페이스를 노출하지 않는다. 
	if(idx >= 120 && idx <= 127) {		return null;  }
	
	// 대량주문(101~108) 는 검색 인터페이스를 노출하지 않는다. 
	if(idx >= 101 && idx <= 108) {		return null;  }
	

	var rv = Array();
	rv.push("<div class='search'>");
	if(navi.categoryType == "book"){
		rv.push("	<p class='tit'><img src='/images/common/tit_locationSearch.gif' alt='분야별검색'></p>");
	}
	if(navi.categoryType == "book_old"){
		rv.push("	<p class='tit'><img src='/images/common/tit_usedBookSearch.gif' alt='분야별검색'></p>");
	}
	rv.push("	<p class='inputL'></p>");
	rv.push("	<p><input type='text' name='naviSearchSubject' onkeydown=\"event.keyCode == 13 ? navi.goSearch() : '';\"></p>");
	rv.push("	<p class='inputR'><a href='javascript:navi.goSearch();'><img src='/images/common/btn_searchInput.gif'></a></p>");
	rv.push("</div>");
	
	return rv.join("");	
}

navi.goBlogSearch = function(){
	var obj	= jutil.e("naviSearchPeople");
	
	if(obj.value == ""){
		alert("검색할 블로거 아이디 또는 이름을 입력하세요.");
		obj.focus();
		return;
	}else{
		location.href	= "/front/thema/bookPeopleSearch.do?naviSearchPeople=" + obj.value;
	}	
}

navi.goSearch = function(){
	/*	분야내 검색 이벤트 처리
	*/
	//navi.getPathCategoryFinalCateId
	//navi.getPathCategoryFinalDepth
	var obj	= jutil.e("naviSearchSubject");
	
	if(obj.value == ""){
		alert("검색어를 입력해 주십시오");
		obj.focus();
		return;
	}else{
		var depthStr	= (navi.getPathCategoryFinalDepth == 0) ? "" : navi.getPathCategoryFinalDepth + 1;

		switch(navi.categoryType){
			case "book" :
				location.href	= "/search/SearchBook.do?tabCode=NEWBOOK&detailFlag=true&subject=" + obj.value + "&maker=" + obj.value + "&categoryName" + depthStr + "=" + navi.getPathCategoryFinalCateId;
				break;
			case "book_old" :
				//location.href	= "/search/SearchOldbook.do?detailFlag=true&subject=" + obj.value + "&categoryName" + (depthStr == 0 ? "" : depthStr) + "=" + navi.getPathCategoryFinalCateId;
				location.href	= "/search/SearchOldbook.do?tabCode=OLDBOOK&detailFlag=true&subject=" + obj.value;
				break;
			case "gift" :
				location.href	= "/search/SearchGift.do?tabCode=GIFT&detailFlag=true&subject=" + obj.value + "&categoryName" + depthStr + "=" + navi.getPathCategoryFinalCateId;
				break;
			case "dvd" :
				location.href	= "/search/SearchDvd.do?tabCode=DVD&detailFlag=true&subject=" + obj.value + "&categoryName" + depthStr + "=" + navi.getPathCategoryFinalCateId;
				break;
		}
	}	
}



/**************************************************************************************************
	네비게이션 생성 정보들...
**************************************************************************************************/
navi.info			= Array();
//navi.division		= "&nbsp;<img src='/images/common/2014/navi_next_aw.gif'>&nbsp;";	// 경로 구분자 정보
navi.type			= "path";													// 패스정보 구성 방식. path : 일반 경로 정보, category : 카테고리 전시 방식
navi.path			= 0;														// 출력할 패스 정보. 외부에서 값을 지정한다.
navi.categoryType	= "book";												// 전시 카테고리를 이용할 경우의 메인 카테고리 정보
navi.category		= "";														// 출력할 카테고리 정보
navi.container		= "locationArea";											// 경로정보를 구성할 컨테이너 아이디값



// RSS를 노출하지 않는 인덱스들...
navi.rssSkipIdx = [
	// 대량주문
	101, 102, 103, 104, 105, 106, 107, 108, 

	// 중고책
	200, 201, 202, 203, 204,
	
	// 나의쇼핑정보
	501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520,
	521, 522, 523, 524, 525, 5216, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543,
	
	// 주문
	7001, 7002, 7003, 7004,
	
	//고객 센터
	901, 902 ,903, 904 ,905, 906, 907, 908, 909, 913,
	
	// 일반상품
	1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1111, 1112, 1113, 1114, 1115, 1123,
	 
	
];



/**************************************************************************************************
	사용자 관련  - 2008-05-27 김남정, (1~)
**************************************************************************************************/
navi.info[1] = {
	"img"	: "/images/locationTitle/tit_login.gif",		// 좌측 상단 이미지 정보
	"path"	: {
		"홈"		: {"url" : "/", "layer" : ""}, 
		"로그인"	: {"url" : "", "layer" : ""}
	}
}

navi.info[2] = {
	"img"	: "/images/locationTitle/tit_member.gif",
	"path"	: {
		"홈"			: {"url" : "/", "layer" : ""}, 
		"회원가입"	: {"url" : "", "layer" : ""}
	}
}



// 대량주문 관련 항목들...
navi.info[101] = {
	"img"	: "/images/locationTitle/tit_bulkorder.gif",
	"path"	: {
		"홈"			: {"url" : "", "layer" : ""}, 
		"대량주문"	: {"url" : "/front/estimate/intro.do", "layer" : ""}, 
		"대량주문안내"	: {"url" : "", "layer" : ""} 
	}
}

navi.info[102] = {
	"img"	: "/images/locationTitle/tit_bulkorder.gif",
	"path"	: {
		"홈"				: {"url" : "", "layer" : ""}, 
		"대량주문"		: {"url" : "/front/estimate/intro.do", "layer" : ""}, 
		"견적서 만들기"	: {"url" : "/front/estimate/estimateMakeSearch.do", "layer" : ""}, 
		"검색하여 만들기"	: {"url" : "", "layer" : ""} 
	}
}


navi.info[103] = {
	"img"	: "/images/locationTitle/tit_bulkorder.gif",
	"path"	: {
		"홈"				: {"url" : "", "layer" : ""}, 
		"대량주문"		: {"url" : "/front/estimate/intro.do", "layer" : ""}, 
		"견적서 만들기"	: {"url" : "/front/estimate/estimateMakeSearch.do", "layer" : ""}, 
		"예산으로 만들기"	: {"url" : "", "layer" : ""} 
	}
}


navi.info[104] = {
	"img"	: "/images/locationTitle/tit_bulkorder.gif",
	"path"	: {
		"홈"					: {"url" : "", "layer" : ""}, 
		"대량주문"			: {"url" : "/front/estimate/intro.do", "layer" : ""}, 
		"견적서 만들기"		: {"url" : "/front/estimate/estimateMakeSearch.do", "layer" : ""}, 
		"견적파일 업로드 하기"	: {"url" : "", "layer" : ""} 
	}
}


navi.info[105] = {
	"img"	: "/images/locationTitle/tit_bulkorder.gif",
	"path"	: {
		"홈"				: {"url" : "", "layer" : ""}, 
		"대량주문"		: {"url" : "/front/estimate/intro.do", "layer" : ""}, 
		"견적서 확인"		: {"url" : "", "layer" : ""} 
	}
}

navi.info[106] = {
	"img"	: "/images/locationTitle/tit_bulkorder.gif",
	"path"	: {
		"홈"				: {"url" : "", "layer" : ""}, 
		"대량주문"		: {"url" : "/front/estimate/intro.do", "layer" : ""}, 
		"견적상담"		: {"url" : "", "layer" : ""} 
	}
}

navi.info[107] = {
	"img"	: "/images/locationTitle/tit_bulkorder.gif",
	"path"	: {
		"홈"				: {"url" : "", "layer" : ""}, 
		"대량주문"		: {"url" : "/front/estimate/intro.do", "layer" : ""}, 
		"견적상담내역"		: {"url" : "", "layer" : ""} 
	}
}

navi.info[108] = {
	"img"	: "/images/locationTitle/tit_bulkorder.gif",
	"path"	: {
		"홈"				: {"url" : "", "layer" : ""}, 
		"대량주문"		: {"url" : "/front/estimate/intro.do", "layer" : ""}, 
		"견적상담내역"		: {"url" : "", "layer" : ""} 
	}
}


// Event 관련 항목들 - 2008-05-23 jerryju, Crewmate
navi.info[120] = {
	"img"	: "/images/locationTitle/tit_event.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"이벤트"			: {"url" : "/front/event/processingEvent.do", "layer" : ""}
	}
}
navi.info[121] = {
	"img"	: "/images/locationTitle/tit_event.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"이벤트"			: {"url" : "/front/event/processingEvent.do", "layer" : ""}, 
		"진행중이벤트"	: {"url" : "", "layer" : ""} 
	}
}
navi.info[122] = {
	"img"	: "/images/locationTitle/tit_event.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"이벤트"			: {"url" : "/front/event/processingEvent.do", "layer" : ""}, 
		"지난이벤트"		: {"url" : "", "layer" : ""} 
	}
}
navi.info[123] = {
	"img"	: "/images/locationTitle/tit_event.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"이벤트"			: {"url" : "/front/event/processingEvent.do", "layer" : ""}, 
		"당첨자 발표"		: {"url" : "", "layer" : ""} 
	}
}
navi.info[124] = {
	"img"	: "/images/locationTitle/tit_event.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"이벤트"			: {"url" : "/front/event/processingEvent.do", "layer" : ""}, 
		"쿠폰"			: {"url" : "", "layer" : ""} 
	}
}
navi.info[125] = {
	"img"	: "/images/locationTitle/tit_event.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"이벤트"			: {"url" : "/front/event/processingEvent.do", "layer" : ""}, 
		"이벤트 보기"		: {"url" : "", "layer" : ""} 
	}
}
navi.info[126] = {
	"img"	: "/images/locationTitle/tit_event.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"이벤트"			: {"url" : "/front/event/processingEvent.do", "layer" : ""}, 
		"기획전 보기"	: {"url" : "", "layer" : ""} 
	}
}
navi.info[127] = {
	"img"	: "/images/locationTitle/tit_event.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"이벤트"			: {"url" : "/front/event/processingEvent.do", "layer" : ""}, 
		"당첨자 발표"		: {"url" : "/front/event/resultEvent.do", "layer" : ""}, 
		"당첨자 내역보기"	: {"url" : "", "layer" : ""} 
	}
}


/**************************************************************************************************
	중고책  관련  - 2008-05-23 김은미, (200~)
**************************************************************************************************/
navi.info[205] = { 
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"중고샵"			: {"url" : "/front/product/usedProdMain.do", "layer" : ""},
		"베스트셀러"	: {"url" : "", "layer" : ""}
	}
}

navi.info[206] = { 
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"중고샵"			: {"url" : "/front/product/usedProdMain.do", "layer" : ""},
		"신규 등록 도서"	: {"url" : "", "layer" : ""}
	}
}

navi.info[207] = { 
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"중고샵"			: {"url" : "/front/product/usedProdMain.do", "layer" : ""},
		"금액대별 도서"	: {"url" : "", "layer" : ""}
	}
}


/**************************************************************************************************
	책과사람  관련  - 2008-05-23 김은미, (300~)
**************************************************************************************************/
navi.info[300] = {
	"img"	: "/images/locationTitle/tit_bookPeople.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"책과사람"		: {"url" : "/front/thema/bookPeopleMain.do", "layer" : ""},
		"메인"			: {"url" : "", "layer" : ""}
	}
}

navi.info[301] = {
	"img"	: "/images/locationTitle/tit_bookPeople.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"책과사람"		: {"url" : "/front/thema/bookPeopleMain.do", "layer" : ""},
		"베스트서재"		: {"url" : "", "layer" : ""}
	}
}

navi.info[302] = {
	"img"	: "/images/locationTitle/tit_bookPeople.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"책과사람"		: {"url" : "/front/thema/bookPeopleMain.do", "layer" : ""},
		"베스트리뷰"		: {"url" : "", "layer" : ""}
	}
}

navi.info[303] = {
	"img"	: "/images/locationTitle/tit_bookPeople.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"책과사람"		: {"url" : "/front/thema/bookPeopleMain.do", "layer" : ""},
		"반디어워드"		: {"url" : "", "layer" : ""}
	}
}

navi.info[304] = {
	"img"	: "/images/locationTitle/tit_bookPeople.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"책과사람"		: {"url" : "/front/thema/bookPeopleMain.do", "layer" : ""},
		"테마북"			: {"url" : "", "layer" : ""}
	}
}

navi.info[305] = {
	"img"	: "/images/locationTitle/tit_bookPeople.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"책과사람"		: {"url" : "/front/thema/bookPeopleMain.do", "layer" : ""},
		"내인생의책"		: {"url" : "", "layer" : ""}
	}
}

navi.info[306] = {
	"img"	: "/images/locationTitle/tit_bookPeople.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"책과사람"		: {"url" : "/front/thema/bookPeopleMain.do", "layer" : ""},
		"북테스터"		: {"url" : "", "layer" : ""}
	}
}

/**************************************************************************************************
	베스트셀러  관련  - 2008-05-23 김성완, (401~)
**************************************************************************************************/
navi.info[401] = {
	"img"	: "/images/locationTitle/tit_bestSeller.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"베스트셀러"		: {"url" : "", "layer" : ""},
		//"온라인 베스트셀러"		: {"url" : "", "layer" : ""}
	}
}

navi.info[402] = {
	"img"	: "/images/locationTitle/tit_bestSeller.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"베스트셀러"				: {"url" : "/front/display/listBest.do", "layer" : ""},
		"성별/연령별 베스트셀러"		: {"url" : "", "layer" : ""}
	}
}

navi.info[403] = {
	"img"	: "/images/locationTitle/tit_bestSeller.gif",
	"path"	: {
		"홈"					: {"url" : "/", "layer" : ""}, 
		"베스트셀러"			: {"url" : "/front/display/listBest.do", "layer" : ""},
		"오프라인 베스트셀러"	: {"url" : "", "layer" : ""}
	}
}

navi.info[404] = {
	"img"	: "/images/locationTitle/tit_bestSeller.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"베스트셀러"		: {"url" : "/front/display/listBest.do", "layer" : ""},
		"마이크로 트렌드"		: {"url" : "", "layer" : ""}
	}
}

navi.info[405] = {
	"img"	: "/images/locationTitle/tit_bestSeller.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"베스트셀러"		: {"url" : "/front/display/listBest.do", "layer" : ""},
		"명예의 전당"		: {"url" : "", "layer" : ""}
	}
}

navi.info[406] = {
	"img"	: "/images/locationTitle/tit_bestSeller.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"주간 탑클릭"		: {"url" : "", "layer" : ""},
	}
}

/**************************************************************************************************
	나의쇼핑  관련  - 2008-05-28 이주연, (501~)
**************************************************************************************************/
navi.info[501] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"	: {"url" : "", "layer" : ""}
	}
}
navi.info[502] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"	: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"주문/배송조회"	: {"url" : "", "layer" : ""}
	}
}
navi.info[503] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"	: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"주문/배송조회"	: {"url" : "/front/myshopping/myOrderList.do", "layer" : ""},
		"주문내역상세"		: {"url" : "", "layer" : ""}
	}
}
navi.info[504] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"	: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"주문/배송조회"	: {"url" : "/front/myshopping/myOrderList.do", "layer" : ""},
		"구매 평가"		: {"url" : "", "layer" : ""}
	}
}
navi.info[505] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"취소/반품/교환내역"		: {"url" : "", "layer" : ""}
	}
}
navi.info[506] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"주문/배송조회"			: {"url" : "/front/myshopping/myOrderList.do", "layer" : ""},
		"취소/반품/교환 내역"		: {"url" : "/front/myshopping/myOrderRetList.do", "layer" : ""},
		"주문취소신청"				: {"url" : "", "layer" : ""}
	}
}
navi.info[507] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"주문/배송조회"			: {"url" : "/front/myshopping/myOrderList.do", "layer" : ""},
		"취소/반품/교환 내역"		: {"url" : "/front/myshopping/myOrderRetList.do", "layer" : ""},
		"반품신청"				: {"url" : "", "layer" : ""}
	}
}
navi.info[508] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"주문/배송조회"			: {"url" : "/front/myshopping/myOrderList.do", "layer" : ""},
		"취소/반품/교환 내역"		: {"url" : "/front/myshopping/myOrderRetList.do", "layer" : ""},
		"교환신청"				: {"url" : "", "layer" : ""}
	}
}
navi.info[509] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"주문/배송조회"			: {"url" : "/front/myshopping/myOrderList.do", "layer" : ""},
		"취소/반품/교환 내역"		: {"url" : "/front/myshopping/myOrderRetList.do", "layer" : ""},
		"주문취소상세내역"			: {"url" : "", "layer" : ""}
	}
}
navi.info[510] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"주문/배송조회"			: {"url" : "/front/myshopping/myOrderList.do", "layer" : ""},
		"취소/반품/교환 내역"		: {"url" : "/front/myshopping/myOrderRetList.do", "layer" : ""},
		"반품상세내역"				: {"url" : "", "layer" : ""}
	}
}
navi.info[511] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"주문/배송조회"			: {"url" : "/front/myshopping/myOrderList.do", "layer" : ""},
		"취소/반품/교환 내역"		: {"url" : "/front/myshopping/myOrderRetList.do", "layer" : ""},
		"교환상세내역"				: {"url" : "", "layer" : ""}
	}
}
navi.info[512] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"증빙서류발급"				: {"url" : "", "layer" : ""}
	}
}
navi.info[513] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"증빙서류발급"				: {"url" : "/front/myshopping/myOrderTaxBillTargetList.do", "layer" : ""},
		"현금영수증"				: {"url" : "", "layer" : ""}
	}
}
navi.info[514] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"증빙서류발급"				: {"url" : "/front/myshopping/myOrderTaxBillTargetList.do", "layer" : ""},
		"신용카드영수증"			: {"url" : "", "layer" : ""}
	}
}
navi.info[515] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"증빙서류발급"				: {"url" : "/front/myshopping/myOrderTaxBillTargetList.do", "layer" : ""},
		"세금계산서"				: {"url" : "", "layer" : ""}
	}
}
navi.info[515] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""},
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"포인트와 혜택"				: {"url" : "", "layer" : ""}, 
		"예치금"					: {"url" : "", "layer" : ""}
	}
}
navi.info[516] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"포인트와 혜택"				: {"url" : "", "layer" : ""},
		"예치금"					: {"url" : "/front/myshopping/myPointHist.do?pointType=02", "layer" : ""},
		"인출내역"				: {"url" : "", "layer" : ""}
	}
}
navi.info[517] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"포인트와 혜택"				: {"url" : "", "layer" : ""},
		"예치금"					: {"url" : "/front/myshopping/myPointHist.do?pointType=02", "layer" : ""},
		"인출신청"				: {"url" : "", "layer" : ""}
	}
}
navi.info[518] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"포인트와 혜택"				: {"url" : "", "layer" : ""},
		"적립금"					: {"url" : "", "layer" : ""}
	}
}
navi.info[519] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"관심 리스트"				: {"url" : "", "layer" : ""},
		"최근 본 상품"				: {"url" : "", "layer" : ""}
	}
}
navi.info[520] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"관심 리스트"				: {"url" : "", "layer" : ""},
		"위시리스트"				: {"url" : "", "layer" : ""}
	}
}
navi.info[521] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"나의 이벤트"				: {"url" : "", "layer" : ""},
		"나의 이벤트정보"			: {"url" : "", "layer" : ""}
	}
}
navi.info[522] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"나의 상담"			: {"url" : "/front/myshopping/myCounselHist.do", "layer" : ""},
		"1:1상담내역"		: {"url" : "", "layer" : ""}
	}
}
navi.info[523] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"나의 문의내역"			: {"url" : "/front/myshopping/myCounselHist.do", "layer" : ""},
		"중고책 문의내역"			: {"url" : "", "layer" : ""}
	}
}
navi.info[524] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"나의 중고책 판매"			: {"url" : "", "layer" : ""},
		"판매현황조회"				: {"url" : "", "layer" : ""}
	}
}
navi.info[525] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"나의 중고책 판매"			: {"url" : "", "layer" : ""},
		"판매대금정산내역"			: {"url" : "", "layer" : ""}
	}
}
navi.info[526] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"나의 중고책 판매"			: {"url" : "", "layer" : ""},
		"중고책관리"				: {"url" : "", "layer" : ""}
	}
}
navi.info[527] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"나의 중고책 판매"			: {"url" : "", "layer" : ""},
		"평가관리"				: {"url" : "", "layer" : ""}
	}
}
navi.info[528] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"나의 중고책 판매"			: {"url" : "", "layer" : ""},
		"Q&A관리"				: {"url" : "", "layer" : ""}
	}
}
navi.info[529] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"나의 중고책 판매"			: {"url" : "", "layer" : ""},
		"중고책신규등록"			: {"url" : "", "layer" : ""}
	}
}
navi.info[530] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"회원정보"			: {"url" : "", "layer" : ""},
		"회원정보수정"				: {"url" : "", "layer" : ""}
	}
}
navi.info[531] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"회원정보"			: {"url" : "", "layer" : ""},
		"배송지관리"				: {"url" : "", "layer" : ""}
	}
}
navi.info[532] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"회원정보"			: {"url" : "", "layer" : ""},
		"회원전환"				: {"url" : "", "layer" : ""}
	}
}
navi.info[533] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"회원정보"			: {"url" : "", "layer" : ""},
		"회원 탈퇴"				: {"url" : "", "layer" : ""}
	}
}
navi.info[534] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"포인트와 혜택"				: {"url" : "", "layer" : ""},
		"쿠폰/상품권"					: {"url" : "", "layer" : ""}
	}
}
navi.info[535] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"포인트와 혜택"				: {"url" : "", "layer" : ""},
		"전환금"					: {"url" : "", "layer" : ""}
	}
}
navi.info[536] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"포인트와 혜택"				: {"url" : "", "layer" : ""},
		"복리후생금"				: {"url" : "", "layer" : ""}
	}
}
navi.info[537] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"나의 회원정보"			: {"url" : "", "layer" : ""},
		"온/오프 회원통합"			: {"url" : "", "layer" : ""}
	}
}
navi.info[538] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"eBook관리"				: {"url" : "", "layer" : ""},
		"주문/결제조회"			: {"url" : "", "layer" : ""}
	}
}
navi.info[539] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"eBook관리"				: {"url" : "", "layer" : ""},
		"취소내역"				: {"url" : "", "layer" : ""}
	}
}
navi.info[540] = {
	"img"	: "/images/locationTitle/tit_myCart.gif",
	"path"	: {
		"홈"						: {"url" : "/", "layer" : ""}, 
		"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
		"eBook관리"				: {"url" : "", "layer" : ""},
		"eBook이용안내"			: {"url" : "", "layer" : ""}
	}
}
navi.info[541] = {
		"img"	: "/images/locationTitle/tit_myCart.gif",
		"path"	: {
			"홈"						: {"url" : "/", "layer" : ""}, 
			"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
			"포인트와 혜택"				: {"url" : "", "layer" : ""},
			"반딧불"					: {"url" : "", "layer" : ""}
		}
	}
navi.info[542] = {
		"img"	: "/images/locationTitle/tit_myCart.gif",
		"path"	: {
			"홈"						: {"url" : "/", "layer" : ""}, 
			"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""},
			"여행상품"				: {"url" : "", "layer" : ""},
			"예약/취소 조회"					: {"url" : "", "layer" : ""}
		}
	}

navi.info[543] = {
		"img"	: "/images/locationTitle/tit_myCart.gif",
		"path"	: {
			"홈"						: {"url" : "/", "layer" : ""}, 
			"나의쇼핑"			: {"url" : "/front/myshopping/myShoppingMain.do", "layer" : ""}, 
			"구매히스토리"			: {"url" : "", "layer" : ""}
		}
	}

/**************************************************************************************************
	신간책   관련  - 2008-05-28 이주연, (601~)
**************************************************************************************************/
navi.info[601] = {
	"img"	: "/images/locationTitle/tit_newBook.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"새로나온 책"		: {"url" : "", "layer" : ""}
	}
}


/**************************************************************************************************
	추천책  관련  - 2008-05-28 이주연, (701~)
**************************************************************************************************/
navi.info[701] = {
	"img"	: "/images/locationTitle/tit_recmdBook.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"추천책"			: {"url" : "/front/display/recommendToday.do", "layer" : ""},
		"오늘의  책/음반"		: {"url" : "", "layer" : ""}
	}
}
navi.info[702] = {
	"img"	: "/images/locationTitle/tit_recmdBook.gif",
	"path"	: {
		"홈"					: {"url" : "/", "layer" : ""}, 
		"추천책"				: {"url" : "/front/display/recommendToday.do", "layer" : ""},
		"미디어&기관 추천책"	: {"url" : "", "layer" : ""}
	}
}
navi.info[703] = {
	"img"	: "/images/locationTitle/tit_recmdBook.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"추천책"			: {"url" : "/front/display/recommendToday.do", "layer" : ""},
		"문학상 수상작"	: {"url" : "", "layer" : ""}
	}
}
navi.info[704] = {
	"img"	: "/images/locationTitle/tit_recmdBook.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"추천책"			: {"url" : "/front/display/recommendToday.do", "layer" : ""},
		"이럴때 이런책"	: {"url" : "", "layer" : ""}
	}
}
navi.info[705] = {
	"img"	: "/images/locationTitle/tit_recmdBook.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"추천책"			: {"url" : "/front/display/recommendToday.do", "layer" : ""},
		"이달의 추천책"	: {"url" : "", "layer" : ""}
	}
}


/**************************************************************************************************
	특가책  관련  - 2008-05-28 이주연, (801~)
**************************************************************************************************/
navi.info[801] = {
	"img"	: "/images/locationTitle/tit_specialBook.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"정가인하도서"			: {"url" : "/front/display/discountBookList.do", "layer" : ""},
		"정가인하도서"	: {"url" : "", "layer" : ""}
	}
}
navi.info[802] = {
	"img"	: "/images/locationTitle/tit_specialBook.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"특가책"			: {"url" : "/front/display/discountBookList.do", "layer" : ""},
		"출판사별 특가책"	: {"url" : "", "layer" : ""}
	}
}
navi.info[803] = {
	"img"	: "/images/locationTitle/tit_specialBook.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"특가책"			: {"url" : "/front/display/discountBookList.do", "layer" : ""},
		"오늘의 반값"	: {"url" : "", "layer" : ""}
	}
}
navi.info[804] = {
	"img"	: "/images/locationTitle/tit_specialBook.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"특가책"			: {"url" : "/front/display/discountBookList.do", "layer" : ""},
		"쿠폰·추가적립"	: {"url" : "", "layer" : ""}
	}
}
navi.info[805] = {
	"img"	: "/images/locationTitle/tit_specialBook.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"특가책"			: {"url" : "/front/display/discountBookList.do", "layer" : ""},
		"반디 서프라이즈"			: {"url" : "", "layer" : ""}
	}
}
navi.info[806] = {
		"img"	: "/images/locationTitle/tit_specialBook.gif",
		"path"	: {
			"홈"				: {"url" : "/", "layer" : ""}, 
			"특가책"			: {"url" : "/front/display/discountBookList.do", "layer" : ""},
			"북짝"				: {"url" : "", "layer" : ""}
		}
	}

/**************************************************************************************************
	고객센터  - 2008-05-28 고객센터, (901~)
**************************************************************************************************/
navi.info[901] = {
	"img"	: "/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""}
	}
}
navi.info[902] = {
	"img"	: "/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"1:1상담"	    : {"url" : "", "layer" : ""}
	}
}
navi.info[903] = {
	"img"	: "/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"자주찾는 질문"	: {"url" : "", "layer" : ""}
	}
}
navi.info[904] = {
	"img"	: "/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"공지사항"      	: {"url" : "", "layer" : ""}
	}
}
navi.info[905] = {
	"img"	: "/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"구매가이드"	    : {"url" : "", "layer" : ""}
	}
}
navi.info[906] = {
	"img"	: "/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"중고책 판매가이드"	: {"url" : "", "layer" : ""}
	}
}
navi.info[907] = {
	"img"	:"/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"최저가 보상제도"	: {"url" : "", "layer" : ""}
	}
}
navi.info[908] = {
	"img"	:"/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"배송품질 보상제도"	: {"url" : "", "layer" : ""}
	}
}
navi.info[909] = {
	"img"	:"/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"무료배송"	: {"url" : "", "layer" : ""}
	}
}
navi.info[910] = {
	"img"	:"/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"복리후생 서비스"	: {"url" : "", "layer" : ""}
	}
}
navi.info[911] = {
	"img"	:"/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"쇼핑원 서비스"	: {"url" : "", "layer" : ""}
	}
}
navi.info[912] = {
	"img"	:"/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"온라인 멤버십"	: {"url" : "", "layer" : ""}
	}
}
navi.info[913] = {
	"img"	:"/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"테마북 홍보 서비스"	: {"url" : "", "layer" : ""}
	}
}
navi.info[914] = {
	"img"	:"/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"제휴카드"		: {"url" : "", "layer" : ""}
	}
}
navi.info[915] = {
	"img"	:"/images/locationTitle/tit_center.gif",
	"path"	: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"고객센터"		: {"url" : "/front/help/helpMain.do", "layer" : ""},
		"회원가입 혜택"		: {"url" : "", "layer" : ""}
	}
}

/**************************************************************************************************
	회사소개   - 2008-06-09 김준만 ,(1001~)
*************************************************************************************************/
navi.info[1001] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
		"반디앤루니스 소개"	: {"url" : "/", "layer" : ""}
	}
}
navi.info[1002] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
		"CI/캐릭터"	    : {"url" : "/", "layer" : ""}
	}
}
navi.info[1003] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
		"연혁"	    	: {"url" : "/", "layer" : ""}
	}
}
navi.info[1004] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
		"사회공헌"	    : {"url" : "/", "layer" : ""}
	}
}
navi.info[1005] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
		"PR센터"	    	: {"url" : "/", "layer" : ""}
	}
}
navi.info[1006] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
		"매장소개"		: {"url" : "/", "layer" : ""}
	}
}
navi.info[1007] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
		"제휴안내"		: {"url" : "/", "layer" : ""}
	}
}
navi.info[1008] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
		"출판사를 위한 안내": {"url" : "/", "layer" : ""}
	}
}
navi.info[1009] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
		"인사제도"		: {"url" : "/", "layer" : ""}
	}
}
navi.info[1010] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
		"지원결과확인"		: {"url" : "/", "layer" : ""}
	}
}
navi.info[1011] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"이용약관"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""}
	}
}
navi.info[1012] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"개인정보 처리방침"		: {"url" : "/front/aboutBandi/aboutBandiMain.do?key=140", "layer" : ""}
	}
}
navi.info[1013] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
		"입사지원서작성"	: {"url" : "/", "layer" : ""}
	}
}

navi.info[1014] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"사이트맵"		: {"url" : "/front/aboutBandi/aboutBandiMain.do?key=160", "layer" : ""}
	}
}
navi.info[1015] = {
	"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
		"출판사를 위한 광고안내": {"url" : "/", "layer" : ""}
	}
}
navi.info[1018] = {
		"img"				:"/images/locationTitle/tit_bandiNrunis.gif",
		"path"				: {
			"홈"				: {"url" : "/", "layer" : ""}, 
			"회사소개"		: {"url" : "/front/aboutBandi/aboutBandiMain.do", "layer" : ""},
			"eBook 유통 및 서비스안내": {"url" : "/front/aboutBandi/aboutBandiMain.do?key=180", "layer" : ""}
		}
	}
/**************************************************************************************************
	일반상품 카테고리   - 2008-06-09 김성완 ,(1101~)
*************************************************************************************************/
navi.info[1101] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""}
	}
}
navi.info[1102] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""},
		"예약판매 음반"	: {"url" : "/front/product/musicCategoryMainNew.do?listType=reserve", "layer" : ""}
	}
}
navi.info[1103] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""},
		"베스트셀러 음반" 	: {"url" : "/front/product/musicCategoryMainNew.do?listType=best", "layer" : ""}
	}
}
navi.info[1104] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""},
		"새로나온 음반"    : {"url" : "/front/product/musicCategoryMainNew.do?listType=new", "layer" : ""}
	}
}
navi.info[1105] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""},
		"특가 음반"    	: {"url" : "/front/product/musicCategoryMainNew.do?listType=sprice", "layer" : ""}
	}
}
navi.info[1106] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""},
		"음반 이벤트"		: {"url" : "/", "layer" : ""}
	}
}

navi.info[1107] = {
	"img"				:"/images/locationTitle/tit_gift.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"GIFT"			: {"url" : "/front/product/giftCategoryMain.do", "layer" : ""}
	}
}
navi.info[1108] = {
	"img"				:"/images/locationTitle/tit_gift.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"GIFT"			: {"url" : "/front/product/giftCategoryMain.do", "layer" : ""},
		"예약판매 GIFT"	: {"url" : "/", "layer" : ""}
	}
}
navi.info[1109] = {
	"img"				:"/images/locationTitle/tit_gift.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"GIFT"			: {"url" : "/front/product/giftCategoryMain.do", "layer" : ""},
		"베스트셀러 GIFT" 	: {"url" : "/front/product/giftCategoryMain.do?listType=best", "layer" : ""}
	}
}
navi.info[1110] = {
	"img"				:"/images/locationTitle/tit_gift.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"GIFT"			: {"url" : "/front/product/giftCategoryMain.do", "layer" : ""},
		"새로나온 GIFT"    : {"url" : "/front/product/giftCategoryMain.do?listType=new", "layer" : ""}
	}
}
navi.info[1111] = {
	"img"				:"/images/locationTitle/tit_gift.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"GIFT"			: {"url" : "/front/product/giftCategoryMain.do", "layer" : ""},
		"특가 GIFT"    	: {"url" : "/front/product/giftCategoryMain.do?listType=sprice", "layer" : ""}
	}
}
navi.info[1112] = {
	"img"				:"/images/locationTitle/tit_gift.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"GIFT"			: {"url" : "/front/product/giftCategoryMain.do", "layer" : ""},
		"GIFT 이벤트"		: {"url" : "/", "layer" : ""}
	}
}
navi.info[1101] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""}
	}
}
navi.info[1102] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""},
		"예약판매 음반"	: {"url" : "/front/product/musicCategoryMainNew.do?listType=reserve", "layer" : ""}
	}
}
navi.info[1103] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""},
		"베스트셀러 음반" 	: {"url" : "/front/product/musicCategoryMainNew.do?listType=best", "layer" : ""}
	}
}
navi.info[1104] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""},
		"새로나온 음반"    : {"url" : "/front/product/musicCategoryMainNew.do?listType=new", "layer" : ""}
	}
}
navi.info[1105] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""},
		"특가 음반"    	: {"url" : "/front/product/musicCategoryMainNew.do?listType=sprice", "layer" : ""}
	}
}
navi.info[1113] = {
	"img"				:"/images/locationTitle/tit_ebook.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"e-Book"		: {"url" : "/front/product/eBookMain.do", "layer" : ""},
		"새로나온 e-Book"	: {"url" : "", "layer" : ""}
	}
}
navi.info[1114] = {
	"img"				:"/images/locationTitle/tit_ebook.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"e-Book"		: {"url" : "/front/product/eBookMain.do", "layer" : ""},
		"베스트셀러"	 	: {"url" : "", "layer" : ""}
	}
}
navi.info[1115] = {
	"img"				:"/images/locationTitle/tit_ebook.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"e-Book"		: {"url" : "/front/product/eBookMain.do", "layer" : ""},
		"추천 e-Book"		: {"url" : "", "layer" : ""}
	}
}
navi.info[1116] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""},
		"一冊多音"    	: {"url" : "/front/product/musicOneBook.do", "layer" : ""}
	}
}
navi.info[1117] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"DVD"			: {"url" : "/front/product/dvdMain.do", "layer" : ""}
	}
}
navi.info[1118] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"DVD"			: {"url" : "/front/product/dvdMain.do", "layer" : ""},
		"예약판매 DVD"	: {"url" : "/front/product/dvdCategoryMainNew.do?listType=reserve", "layer" : ""}
	}
}
navi.info[1119] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"DVD"			: {"url" : "/front/product/dvdMain.do", "layer" : ""},
		"베스트셀러 DVD" 	: {"url" : "/front/product/dvdCategoryMainNew.do?listType=best", "layer" : ""}
	}
}
navi.info[1120] = {
	"img"				:"/images/locationTitle/tit_dvd.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"DVD"			: {"url" : "/front/product/dvdMain.do", "layer" : ""},
		"새로나온 DVD"    : {"url" : "/front/product/dvdCategoryMainNew.do?listType=new", "layer" : ""}
	}
}
navi.info[1121] = {
		"img"				:"/images/locationTitle/tit_dvd.gif",
		"path"				: {
			"홈"				: {"url" : "/", "layer" : ""}, 
			"DVD"			: {"url" : "/front/product/dvdMain.do", "layer" : ""},
			"특가DVD"    : {"url" : "/front/product/dvdCategoryMainNew.do?listType=sprice", "layer" : ""}
		}
	}
navi.info[1122] = {
		"img"				:"/images/locationTitle/tit_dvd.gif",
		"path"				: {
			"홈"				: {"url" : "/", "layer" : ""}, 
			"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""},
			"음반 수상작"		: {"url" : "", "layer" : ""}
		}
	}
navi.info[1123] = {
		"img"				:"/images/locationTitle/tit_dvd.gif",
		"path"				: {
			"홈"				: {"url" : "/", "layer" : ""}, 
			"음반"			: {"url" : "/front/product/musicMain.do", "layer" : ""},
			"인디고 차트"		: {"url" : "/front/product/indiegoChartView.do", "layer" : ""}
		}
}
/**************************************************************************************************
	주문   - 2008-06-09 karlos ,(7001~)
*************************************************************************************************/
navi.info[7001] = {
	"img"				:"/images/locationTitle/tit_bookCart.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"북카트"			: {"url" : "", "layer" : ""}
	}
}
navi.info[7002] = {
	"img"				:"/images/locationTitle/tit_payment.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"주문/결제"		: {"url" : "", "layer" : ""}
	}
}
navi.info[7003] = {
	"img"				:"/images/locationTitle/tit_payment.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"주문 완료"			: {"url" : "", "layer" : ""}
	}
}
navi.info[7004] = {
	"img"				:"/images/locationTitle/tit_payment.gif",
	"path"				: {
		"홈"				: {"url" : "/", "layer" : ""}, 
		"주문/결제 성공"			: {"url" : "", "layer" : ""}
	}
}
