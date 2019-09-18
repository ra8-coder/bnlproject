function FF_changeFlashSize(movieid, w, h)
{
	// movieid 해당 플래시무비의 높이값을 설정합니다
	
	var swfmovie=document.getElementById(movieid);
	
	if(swfmovie)
	{
		if(w != null)
			swfmovie.setAttribute("width", w);
		
		if(h != null)
			swfmovie.setAttribute("height", h);
	}
}

function FF_gotoMenu(menuName)
{
	// gnb 멘를 클릭 시 각 menuName을 파라미터로 호출됨
	// menuName 에 해당하는 페이지로 이동한다.
	
	// 각 메뉴코드
		// logo 			MAIN
		// Book Live		BOOKLIVE
		// 나의쇼핑정보		MYSHOPPING
		// 나의서재			MYLIBRARY

		// 베스트셀러		BESTSELLER
		// 추천책			RECMDBOOK
		// 새로운책			NEWBOOK
		// 할인책			SPECIALBOOK
		// 이벤트 			EVENT
		// 중고책			USEDBOOK
		// 책과사람			BOOKANDMAN
		// ..
		
	var scpDomain = "http://www.bandinlunis.com";

	switch(menuName){
		case "MAIN" :				// 메인 페이지 
			location.href = scpDomain;
			break;
		case "BESTSELLER" :			// 베스트셀러 
			location.href = scpDomain+"/front/display/listBest.do";
			break
		case "RECMDBOOK" :			// 추천책
			location.href = scpDomain+"/front/display/recommendToday.do";
			break;
		case "NEWBOOK" :			// 새로나온책
			location.href = scpDomain+"/front/display/newBookList.do";
			break;
		case "SPECIALBOOK" :		// 특가책
			location.href = scpDomain+"/front/display/discountBookList.do";
			break;
		case "EXM" :				// 수험서몰
			location.href = scpDomain+"/front/exm/main.do";
			break;	
		case "EBOOK" :			// e-Book
			location.href = scpDomain+"/front/product/eBookMain.do";
			break;	
		case "MUSIC" :		 	// 음반
			location.href = scpDomain+"/front/product/musicCategoryMain.do";
			break;	
		case "GIFT" :				// 커피
			location.href = scpDomain+"/front/product/giftCategoryMain.do";
			break;
		case "EVENT" :				// 이벤트
			location.href = scpDomain+"/front/event/processingEvent.do";
			break;
		case "BOOKANDMAN" :			// 책과사람
			location.href = scpDomain+"/front/bookPeople/main.do";
			break;
		
		
			
		case "BOOKLIVE" :			// 북라이브
			alert("현재 코딩 산출물 없음");
			break;
		case "MYLIBRARY" :			// 나의서재
			if(jutil.bandi.isLogin()){
				jutil.bandi.blogGo(jutil.bandi.getMemId());
			}else{
				goLoginPopUp();
			}
			break;
		case "ADVANCEDSEARCH":		//상세검색창
			FF_detailOnoff();
			break;

		
		case "TICKET":				// ticket
			window.open(scpDomain+"/front/cooperation.do?part=ticket");
			break;
		case "ELEARNING":			// elearning
			window.open(scpDomain+"/front/cooperation.do?part=elearning");
			break;
			
	}
		
	trace("FF_gotoMenu : " + menuName);
}


function FF_gotoPage(pageUrl, target)
{
	if (target == "_blank")
	{//새창에 띄움
		window.open(pageUrl);
	}
	else
	{//그외에는 현재창에서 이동
	
		location.href = pageUrl; 
		//trace("FF_gotoPage : " + pageUrl + " , " + target);
	}
}

/**************************
코난 상세검색창 띄우기 함수
***************************/
function FF_detailOnoff() {
	var obj1 = document.getElementById("layerPop_SRDBoxBg");
	var obj2 = document.getElementById("layerPop_SRDBoxCon");
	var obj3 = document.getElementById("layerPop_SRDBox");
	
	if ((obj1 == null) || (obj2 ==null) || (obj3 == null) )
	{
		alert("상세검색창 정보를 가져올수 없습니다");
	}
	if (obj1.style.display == "none" && obj2.style.display == "none")
	{
		obj1.style.display = "";
		obj2.style.display = "";
		obj3.style.display = "";
		
	}
	else
	{
		obj1.style.display = "none";
		obj2.style.display = "none";
		obj3.style.display = "none";
	}
}

function FF_showGnbCategory(showing)
{
	// gnb_flash 플래시무비의 showCategory 메소드에 showing(true/false) 파마리터로 호출합니다.

	var swf=document.getElementById("gnb_flash");
	if(swf)
	{
		if(swf.showCategory)
		{		
			swf.showCategory(showing);
		}
	}
}
	
function FF_addBookCart(pcode)
{
	// 플래시에서 '북카트' 버튼 클릭 시 호출됩니다.
	// pcode 	상품 index code
	//trace("FF_addBookCart : " + pcode);
	add_basket(pcode, 1);
}

function FF_addWishList(pcode)
{
	// 플래시에서 '위시리스트' 버튼 클릭 시 호출됩니다.
	// pcode 	상품 index code
	//trace("FF_addWishList : " + pcode);
	add_wish_common(pcode);
}

function FF_buynow(pcode)
{
	// 플래시에서 '바로구매' 버튼 클릭 시 호출됩니다.
	// pcode 	상품 index code
	// trace("FF_buynow : " + pcode);
	add_order_common(pcode, 1);
}

function FF_gotoBlogWriting()
{
	// 플래시에서 '블로그 첫 글쓰기' 버튼 클릭 시 호출되며 블로그 첫 글 쓰기로 이동합니다.
	trace("FF_gotoBlogWriting :");
}

function FF_addMyLibrary(pcode)
{
	// 플래시에서 '서재담기' 버튼 클릭 시 호출됩니다.
	// pcode 	상품 index code
	// trace("FF_addMyLibrary : " + pcode);
	jutil.bandi.blogAddMyLibrary(pcode);
}

function FF_closeMyLibrary()
{
// 내서재 플래시에서 '닫기'버튼 클릭 시 호출됩니다.
	trace("FF_closeMyLibrary");
}




function trace(obj)
{
	//alert(obj);
}


function FF_setGnbBanners() {
	var gnbflash=document.getElementById("gnb_flash");
	if(gnbflash != null) {
		if(gnbflash.setBanner != null) {
			if(window.imageBannerImageUrl != null && window.imageBannerImageUrl != "") {
				gnbflash.setBanner(window.imageBannerImageUrl, window.imageBannerPageUrl, window.imageBannerPageUrlTarget, window.textBannerImageUrl, window.textBannerPageUrl, window.textBannerPageUrlTarget);
			}
		}
	}
}