<%@page import="com.spring.webproject.dao.QuestionDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">


<link rel="stylesheet" href="/bandi/resources/help_css/common.css?v=20180705" type="text/css">
<link rel="shortcut icon" href="http://bandinlunis.com/favicon.ico"	type="image/x-icon">
<link rel="stylesheet" href="/bandi/resources/help_css/class.css" type="text/css">
<link rel="stylesheet" href="http://bandinlunis.com/common/css/center.css" type="text/css">
<link rel="stylesheet" href="http://bandinlunis.com/common/css/common.css?v=20180705" type="text/css">





<title>반디앤루니스 인터넷서점</title>

<script type="text/javascript" src="https://wcs.naver.net/wcslog.js"></script>


<script type="text/javascript">
	function sendIt() {

		var f = document.searchForm1;

		f.action = "/webproject/help/helpIndex.action";
		f.submit();

	}
	
	function sendIt2(){
		
		var f = document.searchForm;
		var str;
						
		
		//이메일
        if(f.email.value.trim() == "" || f.emailDnsList.value.trim() == "") {
			alert("E-Mail을 입력해주세요.");
		
			if(f.email.value.trim() == "") {
		    	f.email.focus();
			} 
			else if(f.emailDnsList.value.trim() == "") {
		    	f.emailDnsList.focus();
			}        
			return;
         }
         else{
            if(f.emailDnsList.value.indexOf(".")== -1){
                alert("이메일입력란이 올바르지 않습니다.");
            
         	    f.emailDnsList.value       = "";
         		f.emailDnsList.focus();
         	
         		return;
            }         
           	//frm.email.value = frm.email.value + "@" +frm.emailDnsList.value;
         }		
		str = f.email.value;
		str = str.trim();
		f.email.value =str+'@';
		
		str = f.emailDnsList.value;
		str = str.trim();
		f.email.value = f.email.value + str;			
	
		
		var category	   = document.getElementById("category");	//1차분류 선택;
		var TopcateId 	   = category[category.selectedIndex].value;  //1차분류 선택 값;
		
		var category1	   = document.getElementById("category1");	//2차분류 선택;
		var cateId 		   = category1[category1.selectedIndex].value;  //2차분류 선택 값;			
          
	    //상담상세 유형
		if (TopcateId == "" || cateId == "") {
			alert("상담 상세 유형을 선택하세요");
			return;
		} 	    
		str = f.category.value;
		str = str.trim();
		f.category.value =str;		
		
		str = f.typeName.value;
		str = str.trim();			
		
		str = f.category1.value;
		str = str.trim();
		f.category1.value = str;		
		
		f.typeName.value =f.category.value+' > ' + f.category1.value;	
		
		
		
		if (f.subject.value.trim() == ''){
			alert('제목을 입력하세요');     
			f.subject.focus();
			return;
		}
		
		str = f.subject.value;
		str = str.trim();
		f.subject.value =str;
		
		if (f.contents.value.trim() == ''){
			alert('내용을 입력하세요');
			f.contents.focus();
			return;
		}	
		
		str = f.contents.value;
		str = str.trim();
		f.contents.value =str;
		
		
		f.action ="<%=cp%>/help/helpCounsel_ok.action";
		f.submit();

	}
</script>

<script type="text/javascript">
	navi.type = "path";
	navi.path = 902;
	jutil.eventAdd(window, "onload", navi.make);
	jutil.eventAdd(window, "onload", helpContactUsFormInit);

	// 주문 아이디가 미리 온 경우 	
	var a = false;
	var browserType = false;
	var osType = false;
	var b = 0;

	//  1차 분류 값 선택시 상담양식 변경
	function changeForm(obj) {

		var f = document.searchForm;
		var cateId = obj[obj.selectedIndex].value; // 1차 분류 선택 값

		f.action = "/webproject/help/helpCounsel.action?parentsTypeId=" + cateId;
		f.submit();
	}

	//2번째 카테고리 변화폼
	var compareBookshop = false;

	function changeForm1(obj) {

		var category = document.getElementById("category") //1차분류 선택;
		var cateId = obj[obj.selectedIndex].value; //2차분류 선택 값;

		if (cateId == "4047") { //최저가 보상 
			document.getElementById("2").style.display = "block";
			document.getElementById("3").style.display = "block";
			document.getElementById("4").style.display = "block";
			//jutil.e("compareBookshop").style.display = "block";
			document.getElementById("7").innerHTML = "<p class='fl_left mr5'><select name='compareBookshop'><option value=''>선택하세요</option><option value='01'>YES24</option><option value='02'>알라딘</option><option value='03'>교보</option><option value='04'>인터파크</option></select></p>"
					+ "<span class='t_11br3'>(비교하고자 하는 서점을 선택하세요.)</span>";
			document.searchForm.compareBookshop.style.width = "175";
			document.searchForm.compareBookshop.style.display = "block";
			document.getElementById("7").style.display = "block";

		} else if (cateId == "4048") {
			document.getElementById("2").style.display = "block";
			document.getElementById("3").style.display = "none";
			document.getElementById("4").style.display = "none";
			document.getElementById("7").style.display = "none";
		} else {
			if (category[category.selectedIndex].value != "4003"
					&& category[category.selectedIndex].value != "4004"
					&& category[category.selectedIndex].value != "4006"
					&& category[category.selectedIndex].value != "4007") {

				document.getElementById("2").style.display = "none"; //주문번호
			}

			document.getElementById("3").style.display = "none";
			document.getElementById("4").style.display = "none";
			document.getElementById("7").style.display = "none";
		}
		changeRecmdA(cateId, "a"); // 하단 FAq 변화   
		document.searchForm.bid.value = cateId;
	}

	// 로딩시 가격비교 란 폼	
	function change(cateId) {
		if (cateId == "4047") {
			document.getElementById("2").style.display = "block";
			document.getElementById("3").style.display = "block";
			document.getElementById("4").style.display = "block";

			document.getElementById("7").innerHTML = "<select name='compareBookshop'><option value=''>선택하세요</option><option value='01'>YES24</option><option value='02'>알라딘</option><option value='03'>교보</option><option value='04'>인터파크</option></select>";

			document.searchForm.compareBookshop.style.width = "175";
			document.searchForm.compareBookshop.style.display = "block";
			document.getElementById("7").style.display = "block";

		}
	}

	/*	시작 함수
	 */
	function helpContactUsFormInit() {

		dwr.engine.setAsync(false);
		makeCateIdSelect("cateIdSelectArea1", "changeForm", 0, "changeFormUI");

		dwr.engine.setAsync(true);

	}

	/*	폼 세부 인터페이스 변경 처리
	 */
	var k = false;

	function changeFormUI() {
		var frm = document.searchForm;
		var category = document.getElementById("category") //1차분류 선택;
		var topCateId = frm.topCateId.value;
		var cateId = frm.cateId.value;

		if (topCateId != "0") {
			changeForm(category);
			//change(cateId);      // 가격 비교 폼 선택
			if (0 == "4047" && k == false) {
				change(4047);
				k == true;
			}
		} else {
			setMakeUI();
		}
	}

	function setMakeUI1() {
		var category1 = document.getElementById("category1");
	}

	/* 카테고리  설정
	 */
	function makeCateIdSelect(areaId, changeFunction, selected_value,
			endFunction) {

		dwr.categorySelectSingle({
			"area_id" : areaId,
			"subject" : "1차 분류 선택",
			"cateType" : "03",
			"prntCateId" : "0",
			"storeId" : "1",
			"object_id" : "category",
			"fn_name_onchange" : changeFunction,
			"selected_value" : selected_value,
			"makeEndFn" : endFunction
		});
	}

	function makeCateIdSelect1(areaId, changeFunction, selected_value,
			endFunction) {
		dwr.categorySelectSingle({
			"area_id" : areaId,
			"subject" : "2차 분류 선택",
			"cateType" : "03",
			"prntCateId" : document.getElementById("category").value,
			"storeId" : "1",
			"object_id" : "category1",
			"fn_name_onchange" : changeFunction,
			"selected_value" : selected_value,
			"makeEndFn" : endFunction
		});
	}

	/*	자주 찾는 질문 으로 가기
	 */
	function goList(bbsIdx, bid) {
		var frm = document.searchForm;

		frm.bbsIdx.value = bbsIdx;
		frm.bid.value = bid;
		frm.key.value = "faq";
		frm.action = "/front/help/helpIndex.action";
		frm.submit();
	}

	//아래 추천 FAQ변화 
	function changeRecmdA(cateId, type) {

		var frmObj = document.frequentForm;
		var frequent = document.getElementById("frequent");
		var cNode = frequent.getElementsByTagName('li');

		var rowElementNode;
		var cellElementNode;
		var browser = navigator.appName
		var obj;

		if (browser == "Netscape") { //파이어 폭스   
			for (i = 0; i < frequent.childNodes.length; i++) {

				if (frequent.childNodes[i].nodeType == 1) {
					var lay = frequent.childNodes[i]

					if (lay) {
						frequent.removeChild(lay);
					}
				}
			}
		} else if (browser == "Microsoft Internet Explorer") { //익스플로어          								
			for (i = 0; i < cNode.length; i++) {
				var lay = frequent.childNodes[i]

				if (lay) {
					frequent.removeChild(lay);
				}
			}
		}
		if (type == "a") { //2차분류 선택                               
			var param = {
				bid : cateId,
				viewYN : "Y",
				listSize : "5",
				page : "1",
				sort : "viewCnt"
			};
		} else { //1차분류 선택                        
			var param = {
				bidUp : cateId,
				viewYN : "Y",
				listSize : "5",
				page : "1",
				sort : "viewCnt"
			};
		}

		Bbs.getBbsList(param, function(list) {

			if (list != null && typeof (list) == "object" && list.length > 0) {

				for (var i = 0; i < list.length; i++) {
					var faq = list[i];

					oTr = frequent.insertRow(-1);
					oTd1 = oTr.insertCell(-1);
					obj = '<li><a href=\"javascript:goList(' + faq.bbsidx + ','
							+ faq.bid + ');\">' + faq.subject + '</a></li>';
					oTd1.innerHTML = obj;

					if (i == 5) {
						break;
					}
				}
			} else {
				oTr = frequent.insertRow(-1);
				oTd1 = oTr.insertCell(-1);
				obj = '<li id="freq">등록된 질문이 없습니다.</li>';
				oTd1.innerHTML = obj;
			}
		});
	}

	/*
	 * 이메일 선택
	 */
	function selectMail() {
		with (document.searchForm) {
			if (emailGb[emailGb.selectedIndex].value != "직접입력") {
				emailDnsList.value = emailGb[emailGb.selectedIndex].value;
				emailDnsList.readOnly = true;
			} else {
				emailDnsList.value = "";
				emailDnsList.readOnly = false;
			}
		}
	}

	//저장 및 유효성 검사 
	function createContactUs() {

		var frm = document.searchForm;
		var selectedValue = frm.selectedCates1.value;
		var categoryObj = document.getElementsByName("category");

		/*
		if(selectedValue == "4002"){
			if(frm.prodName.value.trim() == ''){
			alert('상품명을 입력하세요');
			frm.prodName.focus();
			return;
			}
		}
		 */
		if (TopcateId == "4003" || TopcateId == "4004" || TopcateId == "4006"
				|| TopcateId == "4007" || cateId == "4048") {
			if (frm.ordId.value.trim() == '') {
				alert('주문번호를 입력해주세요');
				frm.ordId.focus();
				return;
			}
		}

		frm.action = "https://www.bandinlunis.com"
				+ "/front/help/helpContactUsCreate.action";
		frm.submit();

	}
	//파일 업로드 

	function uploadPopup(path, fileType, uploadType, returnField, valueField,
			formName) {

		var url = '/common/uploadFileForm.action?path=' + path + '&fileType='
				+ fileType + '&uploadType=' + uploadType + '&returnField='
				+ returnField + '&valueField=' + valueField + '&formName='
				+ formName;

		// 파일 업로드 폼 디자인 적용되면 팝업 크기도 바꿀 것!!!
		openPopup(420, 280, url, "Y");
	}

	/*************************************
	 * 일반 파일
	 *************************************/
	function uploadFileSize(path, returnField, valueField, formName) {
		uploadPopup(path, 'file', 'file', returnField, valueField, formName);
	}

	/*
	 * 숫자만 입력 가능 
	 */
	function isNum(obj) {
		obj.value = obj.value.replace(/[^0-9]/g, "");
	}

	function checkPrice(strSrc) {

		//document.searchForm.price.value = Add_MoneyComma( strSrc );
	}
</script>

<!-- ADSSOM 신규 버전 17-11-20 -->
<!-- ADSSOM 공통 SCRIPT -->
<script type="text/javascript" src="https://sc.11h11m.net/s/E799.js"></script>


<script type="text/javascript" charset="UTF-8" async=""
	src="http://s.n2s.co.kr/_n2s_ck_log.php"></script>
</head>

<body class="vsc-initialized">
<jsp:include page="../main/header.jsp" flush="false"/>

	<div id="wrap">

		<!-- body -->
		<div id="contentBody">
			<div id="contentWrap">

				<!-- location -->
				<div id="conLocation">
					<div class="location" id="locationArea">
						<li><a href="/">홈</a></li>
						<li><b><a href="/webproject/help/helpMain.action">고객센터</a></b></li>
					</div>
				</div>
				<!-- //location -->

				<div class="conWrap p_center" id="selCSS2">

					<div id="conSmall">
						<!-- sub navi -->
						<div class="subNavi">
							<div class="con">
								<ul class="sn2List">
									<li class=""><a
										href="/webproject/help/helpIndex.action?parentsTypeId=0">자주 찾는
											질문 FAQ</a>
										<ul class="sn3List">
											<c:forEach var="dto" items="${lists }">
												<li><a
													href="/webproject/help/helpIndex.action?parentsTypeId=${dto.parentsTypeId }">${dto.parentsTypeName }</a></li>
											</c:forEach>
										</ul></li>
									<li class="">1:1 상담
										<ul class="sn3List">
											<li>
											<c:if test="${userId==null }">
											<a href="/webproject/login.action">1:1 상담하기</a>
											</c:if>
											<c:if test="${userId!=null }">
											<a href="/webproject/help/helpCounsel.action">1:1 상담하기</a>
											</c:if>
											</li>
											<li><a href="/webproject/myShopping/myCounselHistory.action">1:1
													상담내역</a></li>
										</ul>
									</li>

									<li class="">이용안내
										<ul class="sn3List">
											<li><a href="/webproject/help/helpMyCounsel.action">구매가이드</a></li>
											<!-- <li><a href="/front/help/helpMain.action?key=20">중고책 판매가이드</a></li> -->
										</ul>
									</li>
								</ul>
							</div>
						</div>
						<!-- //sub navi -->

						<!-- promotion banner -->
						<ul class="promoBanner">
							<li><img
								src="http://image.bandinlunis.com/images/center/center_tel.gif"
								usemap="#center_tel"></li>
						</ul>
						<map name="center_tel">
							<area shape="rect" coords="54,217,145,241"
								href="/pages/front/service/serviceKakao.jsp" alt="">
						</map>
						<!-- //promotion banner -->
					</div>
					<!-- //left contents -->

					<!-- right contents -->


					<div id="conBig" style="width: 750px">

						<!-- FAQ검색 -->
						<c:if test="${key!=3}">
							<div class="boxShadowBr750 t_11gr" id="">
								<div class="con">
									<div class="searchTop">
										<div class="search2">
											<form name="searchForm1" action="/webproject/help/helpIndex.action"
												method="post" onsubmit="javascript:return false;">
												<p class="select">
													<select name="parentsTypeId" style="width: 124px;">
														<option value=0>FAQ 분류 선택</option>
														<c:forEach var="dto" items="${lists }">
															<option value="${dto.parentsTypeId }">${dto.parentsTypeName }</option>
														</c:forEach>
													</select>
												</p>

												<p>
													<input type="text" name="searchValue" style="width: 337px">
													<a href="javascript:sendIt()"> <img
														src="http://image.bandinlunis.com/images/common/btn_search06.gif"
														class="al_middle" alt="검색"></a>
												</p>
											</form>
										</div>

										<div class="keyword">
											<img
												src="http://image.bandinlunis.com/images/center/txt_faqKeyword.gif"
												class="al_middle" alt="fAQ 인기검색어"> <span
												class="t_11br3"><a
												href="javascript:goFaqSearch('회원')">회원</a></span> <span
												class="t_11br3"><a
												href="javascript:goFaqSearch('배송')">배송</a> | </span> <span
												class="t_11br3"><a
												href="javascript:goFaqSearch('구매')">구매</a>| </span> <span
												class="t_11br3"><a
												href="javascript:goFaqSearch('영수증')">영수증</a> | </span> <span
												class="t_11br3"><a
												href="javascript:goFaqSearch('적립금')">적립금</a> | </span> <span
												class="t_11br3"><a
												href="javascript:goFaqSearch('쿠폰')">쿠폰</a></span>
										</div>
									</div>
								</div>
							</div>
						</c:if>

						<!-- //searchTop -->
						<!-- //searchTop -->

						<!-- 고객센터 -->
						<c:if test="${parentsTypeId==null&&key==1}">
							<div class="conBig1">
								<div class="titInfo" style="width: 510px">
									<h3>
										<img
											src="http://image.bandinlunis.com/images/center/h3_faq.gif"
											alt="반디앤루니스 고객센터">
									</h3>
									<p>
										<img
											src="http://image.bandinlunis.com/images/center/txt_faq.gif"
											alt="고객님의 문의 사항이나 불편사항을 말씀해주세요. 정성을 다하겠습니다.">
									</p>
								</div>

								<script type="text/javascript">
									function tabView(idName, n) {
										obj_tab = document.getElementById(""
												+ idName + "");
										obj_tab = obj_tab
												.getElementsByTagName("li");

										for (var i = 1; i <= obj_tab.length; i++) {
											obj_con = document
													.getElementById("" + idName
															+ "_con" + i);

											if (i == n) {
												obj_con.style.display = "block";
												obj_tab[i - 1].className = "on";
											} else {
												obj_con.style.display = "none";
												obj_tab[i - 1].className = "";
											}
										}
									}
								</script>

								<!-- specialPrice tab 0529 -->
								<div class="tabWrap">
									<ul class="tab faqTab" id="tabID">
										<li class="on"><a href=""
											onclick="tabView('tabID',1); return false;"> <img
												src="http://image.bandinlunis.com/images/center/tab_faq01.gif"
												alt="FAQ TOP 10"> <img
												src="http://image.bandinlunis.com/images/center/tab_faq01on.gif"
												alt="FAQ TOP 10" class="rollover"></a></li>

										<li class=""><a href=""
											onclick="tabView('tabID',2); return false;"> <img
												src="http://image.bandinlunis.com/images/center/tab_faq02.gif"
												alt="최근 등록된 질문"> <img
												src="http://image.bandinlunis.com/images/center/tab_faq02on.gif"
												alt="최근 등록된 질문" class="rollover"></a></li>
									</ul>
								</div>

								<!-- //specialPrice tab 0529 -->
								<p class="fl_clear">
									<span class="mr10"><a
										href="/webproject/help/helpIndex.action?parentsTypeId=0"
										class="more">more</a></span>
								</p>

								<ol class="faqList" id="tabID_con1">
									<c:set var="i" value="1" />
									<c:forEach var="dto" items="${topLists }">
										<li>
											<p class="no">
												<img
													src="http://image.bandinlunis.com/images/common/ico_no${i }.gif"
													alt="${i }">
											</p>
											<p>
												<a
													href="/webproject/help/helpIndex.action?parentsTypeId=${dto.parentsTypeId }&questionId=${dto.questionId }&typeId=${dto.typeId}">
													${dto.subject }</a>
											</p>
										</li>
										<c:set var="i" value="${i+1 }" />
									</c:forEach>


								</ol>

								<ol class="faqList" id="tabID_con2" style="display: none">
									<c:set var="i" value="1" />
									<c:forEach var="dto" items="${topDate }">
										<li>
											<p class="no">
												<img
													src="http://image.bandinlunis.com/images/common/ico_no${i }.gif"
													alt="${i }">
											</p>
											<p>
												<a
													href="/webproject/help/helpIndex.action?parentsTypeId=${dto.parentsTypeId }&questionId=${dto.questionId }&typeId=${dto.typeId}">
													${dto.subject }</a>
											</p>
										</li>
										<c:set var="i" value="${i+1 }" />
									</c:forEach>
								</ol>
								<!-- FAQ category -->
								<div class="box_faqCate01">
									<h3>
										<img
											src="http://image.bandinlunis.com/images/center/h3_main_faqCategory.gif"
											alt="FAQ 카테고리">
									</h3>
									<img
										src="http://image.bandinlunis.com/images/center/img_categorybtn.gif"
										alt="" usemap="#map_faqCategory">
									<map name="map_faqCategory">
										<area shape="rect" alt="회원" coords="0,0,117,39" href="/webproject/help/helpIndex.action?parentsTypeId=1">
										<area shape="rect" alt="적립/보상" coords="0,45,117,84" href="/webproject/help/helpIndex.action?parentsTypeId=5">
										<area shape="rect" alt="중고책" coords="0,90,117,129" href="/webproject/help/helpIndex.action?parentsTypeId=9">
										<area shape="rect" alt="서비스/기타" coords="123,90,240,129" href="/webproject/help/helpIndex.action?parentsTypeId=10">
										<area shape="rect" alt="반품/교환/환불" coords="123,45,240,84" href="/webproject/help/helpIndex.action?parentsTypeId=6">
										<area shape="rect" alt="상품" coords="123,0,240,39" href="/webproject/help/helpIndex.action?parentsTypeId=2">
										<area shape="rect" alt="주문/결제" coords="246,0,363,39" href="/webproject/help/helpIndex.action?parentsTypeId=3">
										<area shape="rect" alt="사이트/시스템장애" coords="246,45,363,84" href="/webproject/help/helpIndex.action?parentsTypeId=7">
										<area shape="rect" alt="매장관련" coords="246,90,363,129" href="/webproject/help/helpIndex.action?parentsTypeId=11">
										<area shape="rect" alt="나의서재" coords="369,45,486,84" href="/webproject/help/helpIndex.action?parentsTypeId=8">
										<area shape="rect" alt="배송" coords="369,0,486,39" href="/webproject/help/helpIndex.action?parentsTypeId=4">
										<area shape="rect" alt="대량주문" coords="369,90,486,129" href="/webproject/help/helpIndex.action?parentsTypeId=12">
									</map>

								</div>
								<!-- //FAQ category -->
								<!--  
						<a href="javascript:goSearhComp(4);">업체검색</a>
						<a href="javascript:goSearhPub();">출판사검색</a>
						-->

							</div>

							<div class="conBig2">
								<ul class="promoBanner">
									<li><a href="/front/myshopping/myOrderList.action"> 
									<img src="http://image.bandinlunis.com/images/center/right_banner_01.gif" alt="반품/교환신청"></a></li>
									
									<li>
									<c:if test="${userId==null }">
									<a href="/webproject/login.action">
									<img src="http://image.bandinlunis.com/images/center/right_banner_02.gif" alt="미배송신고"></a>
									</c:if>
									<c:if test="${userId!=null }">
									<a href="/webproject/help/helpCounsel.action?parentsTypeId=4">
									<img src="http://image.bandinlunis.com/images/center/right_banner_02.gif" alt="미배송신고"></a>	
									</c:if>									
									</li>
									
									<li>
									<c:if test="${userId==null }">
									<a href="/webproject/login.action">
									<img src="http://image.bandinlunis.com/images/center/right_banner_03.gif" alt="입금신고"></a>
									</c:if>
									<c:if test="${userId!=null }">
									<a href="/webproject/help/helpCounsel.action?parentsTypeId=3"> 
									<img src="http://image.bandinlunis.com/images/center/right_banner_03.gif" alt="입금신고"></a>	
									</c:if>									
									</li>
																									
								</ul>

								<!-- book info contents list -->
								<div class="bookInfoCon">
									<div class="bookInfoConT">
										<div class="bookInfoConB">
											<ul>
												<li class="alt"><img
													src="http://image.bandinlunis.com/images/center/txt_main_mtomCounsel.gif"
													alt="1:1 상담">
													<p class="mt10">
														<c:if test="${userId == null }">
														<a href="/webproject/login.action"><img
															src="http://image.bandinlunis.com/images/common/btn_app_mtomCounseo.gif"
															alt="1:1상담신청하기">
														</a></c:if>
														
														<c:if test="${userId != null }">													
														<a href="/webproject/help/helpCounsel.action"> <img
															src="http://image.bandinlunis.com/images/common/btn_app_mtomCounseo.gif"
															alt="1:1상담신청하기">
														</a>
														</c:if>
														
														
													</p></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</c:if>

						<c:if test="${parentsTypeId!=null&&key==2}">
							<!-- 자주찾는 질문FAQ -->
							<div class="titInfo">
								<h3>
									<img
										src="http://image.bandinlunis.com/images/center/h3_favoriteFAQ.gif"
										alt="자주찾는질문 FAQ">
								</h3>
								<p>
									<img
										src="http://image.bandinlunis.com/images/center/txt_favoriteFAQ.gif"
										alt="고객님께서 자주 찾는 질문과 답변을 모았습니다.">
								</p>
							</div>

							<div class="grayBox2">
								<div class="faqsubList">

									<ul>
										<li>
											<p>
												<a href="/webproject/help/helpIndex.action?parentsTypeId=0">전체질문</a>
											</p>
										</li>
										<c:forEach var="dto" items="${lists }">
											<li>
												<p>
													<a
														href="/webproject/help/helpIndex.action?parentsTypeId=${dto.parentsTypeId }">${dto.parentsTypeName }</a>
												</p>
											</li>
										</c:forEach>
									</ul>
								</div>
							</div>
							<!-- 자주찾는 질문 -->

							<!-- 전체 | 회원가입/실명인증 | 회원정보확인/실명인증 -->
							<ul class="detailtab_sub">
								<li class="alt on"><a
									href="/webproject/help/helpIndex.action?parentsTypeId=${parentsTypeId }">전체</a></li>
								<c:forEach var="dto" items="${lists3 }">
									<li class=""><a
										href="/webproject/help/helpIndex.action?parentsTypeId=${parentsTypeId }&amp;typeId=${dto.typeId}">${dto.typeName}</a></li>
								</c:forEach>
							</ul>

							<form name="faqList" action="" method="get">
								<table width="745" border="0" cellpadding="0" cellspacing="0"
									class="boardList01 mt15">
									<colgroup>
										<col width="94">
										<col width="2">
										<col width="108">
										<col width="2">
										<col width="539">
									</colgroup>
									<thead>
										<tr>
											<th class="thS"><img
												src="http://image.bandinlunis.com/images/center/th_no.gif"
												alt="번호"></th>
											<th><img
												src="http://image.bandinlunis.com/images/common/boardTH01_line.gif"
												alt="|"></th>
											<th><img
												src="http://image.bandinlunis.com/images/center/th_QType.gif"
												alt="질문유형"></th>
											<th><img
												src="http://image.bandinlunis.com/images/common/boardTH01_line.gif"
												alt="|"></th>
											<th class="thE"><img
												src="http://image.bandinlunis.com/images/center/th_title.gif"
												alt="제목"></th>
										</tr>
									</thead>
									<tbody>
										<!-- loop -->
										<c:if test="${typeId==null&&parentsTypeId==0}">
											<c:forEach var="dto" items="${type0Lists }">

												<tr>
													<td colspan="2">${dto.questionId }</td>
													<td>${dto.parentsTypeName }&gt;${dto.typeName }</td>
													<td class="td_L20" colspan="2"><a
														href="/webproject/help/helpIndex.action?typeId=${dto.typeId }&questionId=${dto.questionId }&parentsTypeId=${dto.parentsTypeId}">${dto.subject }</a></td>
												</tr>
												<tr>
													<td colspan="5" class="line"></td>
												</tr>

												<c:if test="${questionId==dto.questionId}">
													<tr>
														<td colspan="5"
															style="width: 600px; padding: 11px 12px 12px 133px; border-bottom: 1px solid #E9E4DC; background: #F8F8F8 url(http://image.bandinlunis.com/images/common/ico_re.gif) no-repeat 83px 12px; color: #888; text-align: left;">
															내용: ${dto.content }</td>
													</tr>
												</c:if>

											</c:forEach>
										</c:if>


										<c:if test="${typeId==null&&parentsTypeId!=0}">
											<c:forEach var="dto" items="${typeLists }">

												<tr>
													<td colspan="2">${dto.questionId }</td>
													<td>${dto.parentsTypeName }&gt;${dto.typeName }</td>
													<td class="td_L20" colspan="2"><a
														href="/webproject/help/helpIndex.action?typeId=${dto.typeId }&questionId=${dto.questionId }&parentsTypeId=${dto.parentsTypeId}">${dto.subject }</a></td>
												</tr>
												<tr>
													<td colspan="5" class="line"></td>
												</tr>

												<c:if test="${questionId==dto.questionId}">
													<tr>
														<td colspan="5"
															style="width: 600px; padding: 11px 12px 12px 133px; border-bottom: 1px solid #E9E4DC; background: #F8F8F8 url(http://image.bandinlunis.com/images/common/ico_re.gif) no-repeat 83px 12px; color: #888; text-align: left;">
															내용: ${dto.content }</td>
													</tr>
												</c:if>

											</c:forEach>
										</c:if>

										<c:if test="${typeId!=null}">
											<c:forEach var="dto" items="${subTypeLists }">

												<tr>
													<td colspan="2">${dto.questionId }</td>
													<td>${dto.parentsTypeName }&gt;${dto.typeName }</td>
													<td class="td_L20" colspan="2"><a
														href="/webproject/help/helpIndex.action?typeId=${dto.typeId }&questionId=${dto.questionId }&parentsTypeId=${dto.parentsTypeId}">${dto.subject }</a></td>
												</tr>
												<tr>
													<td colspan="5" class="line"></td>
												</tr>

												<c:if test="${questionId==dto.questionId}">
													<tr>
														<td colspan="5"
															style="width: 600px; padding: 11px 12px 12px 133px; border-bottom: 1px solid #E9E4DC; background: #F8F8F8 url(http://image.bandinlunis.com/images/common/ico_re.gif) no-repeat 83px 12px; color: #888; text-align: left;">

															내용: ${dto.content }</td>
													</tr>
												</c:if>

											</c:forEach>

										</c:if>


										<!-- //loop -->

									</tbody>
								</table>
							</form>
							<div class="pageBG mt2m">
								<div class="page">
									<span class="prev-btn"> <!-- <img src="/images/common/btn_pagePrevG.gif" align="absmiddle" border="0"> -->

										<!-- <img src="/images/common/btn_pagePrev.gif" align="absmiddle" hspace="2" border="0"> -->
									</span> <span class="pageNum">
										<p>
											<c:if test="${dataCount!=0 }">
					${pageIndexList }
				</c:if>
											<c:if test="${dataCount==0 }">
					등록된게시물이 없습니다.
				</c:if>
										</p>

									</span> <span class="next-btn"> <!-- <img src="/images/common/btn_pageNext.gif" align="absmiddle" hspace="2" border="0"> -->

									</span>

								</div>
							</div>

							<div class="boxBrown745 mt20">
								<div class="con">
									<p class="counsel">
										찾으시는 질문이 없나요? <strong class="point_o"><u>
										<c:if test="${userId == null }">
										<a href="/webproject/login.action">1:1 상담</a></c:if>
										<c:if test="${userId !=null }">
										<a href="/webproject/help/helpCounsel.action">1:1 상담</a></c:if>
										
										</u></strong>에 문의해주세요.
										<c:if test="${userId == null }">
										<a href="/webproject/login.action"><img
											src="http://image.bandinlunis.com/images/common/btn_appCounsel.gif"
											class="al_middle" alt="1:1 상담"></a>
										</c:if>
										
										<c:if test="${userId !=null }">
										<a href="/webproject/help/helpCounsel.action"><img
											src="http://image.bandinlunis.com/images/common/btn_appCounsel.gif"
											class="al_middle" alt="1:1 상담"></a>
										</c:if>										
									
									</p>
								</div>
							</div>


						</c:if>

						<!-- 1:1상담 -->
						
						
						<c:if test="${key==3 && userId!=null}">
							<!-- 1:1상담~불편사항이나 -->
							<div class="titInfo titInfo_line">
								<h3>
									<img
										src="http://image.bandinlunis.com/images/center/h3_consult.gif"
										alt="1:1 상담">
								</h3>
								<p>
									<img
										src="http://image.bandinlunis.com/images/center/txt_consult2.gif"
										alt="불편 사항이나 문의 사항을 남겨주시면 신속하고 친절하게 안내해 드리겠습니다.">
								</p>
							</div>
							<p class="mt40 mb5 ml5 t_gr">상담하신 내용에 대한 답변은 기재하신 이메일 주소로
								전송되며, 순차적으로 최대한 빠른 시일 내에 답변해 드리겠습니다.</p>

							<!-- 이름/이메일/상담유형~ -->
							<div class="boardRegisterDiv">
								<form name="searchForm" action="" method="post">

									<table width="745" border="0" cellpadding="0" cellspacing="0"
										class="boardList07">

										<colgroup>
											<col width="96">
											<col width="">
										</colgroup>
										<tbody>
											<tr> 				
												<th><img src="http://image.bandinlunis.com/images/center/th05_id.gif" alt="ID"></th>
												<td class="td_L10">${userId }
												<input type="hidden" name="userId" value="${userId }">
												</td>
												
												<th><img src="http://image.bandinlunis.com/images/center/th05_name.gif" alt="이름"></th>
												<td class="td_L10 tdE">${userName }
												<input type="hidden" name="userName" value="${userName }">
												</td>
											</tr>
											

											<tr>
												<td colspan="4" class="td_line"></td>
											</tr>

											<tr>
												<th><img
													src="http://image.bandinlunis.com/images/center/th05_email.gif"
													alt="이메일"></th>
												<td colspan="3" class="td_L10 tdE">
													<p class="fl_left">
														<input type="text" name="email" style="width: 80px">
														@&nbsp; <input type="text" name="emailDnsList" value=""
															style="width: 80px">&nbsp;
													</p>
													<p class="fl_left mr5">
														<select name="emailGb"
															onchange="javascript:selectMail(this.selectedIndex);">
															<option value="직접입력">직접입력</option>
															<option value="gmail.com">구글(G메일)</option>
															<option value="nownuri.net">나우누리</option>
															<option value="naver.com">네이버</option>
															<option value="nate.com">네이트</option>
															<option value="dreamwiz.com">드림위즈</option>
															<option value="yahoo.com">야후</option>
															<option value="empal.com">엠팔</option>
															<option value="unitel.co.kr">유니텔</option>
															<option value="intizen.com">인티즌</option>
															<option value="chol.com">천리안</option>
															<option value="paran.com">파란닷컴</option>
															<option value="korea.com">코리아닷컴</option>
															<option value="freechal.com">프리첼</option>
															<option value="hanafos.com">하나포스</option>
															<option value="hanmail.net">다음</option>
															<option value="hanmir.com">한미르</option>
															<option value="hotmail.com">핫메일</option>
															<option value="msn.com">MSN</option>
														</select>
													</p> <!-- 
									<span class="t_11br3">(한메일이나 다음메일은 수신할 수 없습니다.)</span>
									 -->
												</td>
											</tr>

											<tr>
												<td colspan="4" class="td_line"></td>
											</tr>

											<tr>
												<th><img
													src="http://image.bandinlunis.com/images/center/th05_type.gif"
													alt="상담유형"></th>
												<td class="td_L10 tdE" colspan="3">
													<p id="cateIdSelectArea1" class="fl_left mr5">
														<input type="hidden" name="typeName" value=""> 
														<input type="hidden" name="parentsTypeId" value="${parentsTypeId }">
														<select id="category" name="category"
															onchange="changeForm(this);"
															style="border: 1pt solid #999999; font-size: 9pt; color: #333333;">
															<option value="">1차 분류 선택</option>
															<c:forEach var="dto" items="${lists }">
																<c:if test="${parentsTypeId!=dto.parentsTypeId}">
																	<option value="${dto.parentsTypeId }">${dto.parentsTypeName }</option>
																</c:if>
																<c:if test="${parentsTypeId==dto.parentsTypeId}">
																	<option value="${dto.parentsTypeName }" selected>${dto.parentsTypeName }</option>
																</c:if>

															</c:forEach>
														</select>
													</p>
													<p id="cateIdSelectArea2" class="fl_left mr5">
														<select id="category1" name="category1"
															style="border: 1pt solid #999999; font-size: 9pt; color: #333333;">
															<option value="">2차 분류 선택</option>
															<c:forEach var="dto" items="${lists3 }">
																<option value="${dto.typeName }">${dto.typeName }</option>
															</c:forEach>
														</select>
													</p>
												</td>
											</tr>
										</tbody>
									</table>

									<table class="boardList07" width="745" border="0"
										cellpadding="0" cellspacing="0">
										<colgroup>
											<col width="96">
											<col width="">
										</colgroup>
										<tbody>
											<tr>
												<td colspan="2" class="td_line"></td>
											</tr>
											<tr>
												<th><img
													src="http://image.bandinlunis.com/images/center/th05_theme.gif"
													alt="제목"></th>
												<td class="td_L10 tdE"><input type="text"
													name="subject" style="width: 610px;" maxlength="100">
													<p id="commentLength" class="al_right t_11gr"
														style="display: none";=""></p></td>
											</tr>
										</tbody>
									</table>

									<table class="boardList07" width="745" border="0"
										cellpadding="0" cellspacing="0">
										<colgroup>
											<col width="96">
											<col width="">
										</colgroup>
										<tbody>
											<tr>
												<td colspan="2" class="td_line"></td>
											</tr>
											<tr>
												<th><img
													src="http://image.bandinlunis.com/images/center/th05_contents.gif"
													alt="내용"></th>
												<td class="td_L10 tdE"><textarea
														style="width: 626px; height: 240px;" name="contents"></textarea>
												</td>
											</tr>
										</tbody>
									</table>

									
									<div>
										<div id="app" class="btnC mt25 mb25">
											<!-- <a href="javascript:createContactUs();"> -->
											<a href="javascript:sendIt2();"><img
												src="http://image.bandinlunis.com/images/common/btn_consult.gif"
												alt="상담신청"></a>
										</div>


									</div>
								</form>
							</div>

						
						</c:if>
						<!-- 1:1상담 -->

						<!-- 구매가이드 -->
						<c:if test="${key==4}">
							<div class="titInfo">
								<h3>
									<img
										src="http://image.bandinlunis.com/images/center/h3_shoppingG.gif"
										alt="구매가이드">
								</h3>
								<p>
									<img
										src="http://image.bandinlunis.com/images/center/txt_usedBookG.gif"
										alt="고객님의 안전한 거래를 위한 가이드를 제공해드리고 있습니다.">
								</p>
							</div>

							<script type="text/javascript">
								function tabView(idName, n) {
									obj_tab = document.getElementById(""
											+ idName + "");
									obj_tab = obj_tab
											.getElementsByTagName("li");

									for (var i = 1; i <= obj_tab.length; i++) {
										obj_con = document.getElementById(""
												+ idName + "_con" + i);

										if (i == n) {
											obj_con.style.display = "block";
											obj_tab[i - 1].className = "on";
										} else {
											obj_con.style.display = "none";
											obj_tab[i - 1].className = "";
										}
									}
								}
							</script>

							<ul class="detailtab usedBookTab" id="tabID">
								<li class="on">
									<p>
										<a href="javascript:tabView('tabID',1);"><img
											src="http://image.bandinlunis.com/images/center/tab_usedBook01.gif"
											alt="상품구매방법"> <img
											src="http://image.bandinlunis.com/images/center/tab_usedBook01on.gif"
											alt="상품구매방법" class="rollover"></a>
									</p>
								</li>

								<li>
									<p>
										<a href="javascript:tabView('tabID',2);"><img
											src="http://image.bandinlunis.com/images/center/tab_usedBook02.gif"
											alt="안전결제가이드"> <img
											src="http://image.bandinlunis.com/images/center/tab_usedBook02on.gif"
											alt="안전결제가이드" class="rollover"></a>
									</p>
								</li>

								<li>
									<p>
										<a href="javascript:tabView('tabID',3);"><img
											src="http://image.bandinlunis.com/images/center/tab_usedBook03.gif"
											alt="상품/컨텐츠 신고"> <img
											src="http://image.bandinlunis.com/images/center/tab_usedBook03on.gif"
											alt="상품/컨텐츠 신고" class="rollover"></a>
									</p>
								</li>
							</ul>

							<div class="conBox" id="tabID_con1">
								<h4>
									<img
										src="http://image.bandinlunis.com/images/center/h4_usedBookG_01.gif"
										alt="상품구매방법">
								</h4>
								<div class="conBoxB">
									<dl class="conTxt">
										<dt>
											<strong class="t_br1">상품 주문에 대하여</strong>
										</dt>
										<dd>
											저희 반디앤루니스에서는 회원 뿐만 아니라 비회원도 주문하실 수 있습니다.<br> 검색과 분야별 찾기,
											각종 이벤트 페이지를 통해 원하시는 도서를 '바로구매'를 통해 즉시 구매하실 수 있습니다.<br>
											또한 쇼핑카트 또는 위시리스트에 담은 후에도 '주문하기'를 클릭하시면 바로 구매하실 수 있습니다.
										</dd>
										<dt>
											<span class="bul1">상품 검색</span>
										</dt>
										<dd>
											[일반검색]과 [고급검색]를 통해 상품을 검색하실 수 있습니다.<br> [일반검색]에서는 도서명,
											중고책명, DVD, GIFT에 따라 각각 나누어서 검색할 수 있습니다.<br> [고급검색]에서는
											도서에 대한 ISBN,저자,출판일, 가격 등의 세분화된 검색조건을 설정하고 2개 항목 이상을 동시에
											입력함으로써 보다 자세한 검색결과를 얻으실 수 있습니다.
										</dd>
										<dt>
											<span class="bul1">찾으시는 도서가 없는 경우</span>
										</dt>
										<dd>
											<p class="bul2">
												도서명 중 핵심 단어만 넣어 검색해 보시기 바랍니다.<br>예) 그 많던 싱아는 어디로 갔을까
												=&gt; 싱아
											</p>
											<p class="bul2">
												느낌표, 물음표 등 특수문자를 빼고 검색해 보시기 바랍니다.<br>예) 너 그거 아니? =&gt;
												너 그거 아니
											</p>
											<p class="bul2">
												찾으시는 도서가 너무 많이 나오는 경우 :<br> '첫사랑' 처럼 도서명이 흔한 경우나 삼국지등
												동명의 제목이 많은 도서의 경우 검색 결과가 너무 많이 나와 원하시는 책을 쉽게 찾지 못하는 경우가
												있습니다.<br> 그럴 경우 검색결과 화면 우측에 '분야별 검색결과'를 이용하시면 쉽게 찾으실 수
												있습니다.
											</p>
											<p class="bul2">
												그래도 검색이 되는 않는 경우 :<br> 저희 서점에 없거나 판매 중지 된 도서일 수 있습니다.<br>
												고객센터&gt;1:1 상담을 이용하시거나 반디앤루니스 콜센터 : 1577-4030 으로 문의해주시면 친절하게
												안내해 드리겠습니다.
											</p>
										</dd>
										<dt>
											<strong class="t_br1">상품 예상 출고일 및 수령 가능일 안내</strong><br>
										</dt>
										<dd>
											예상출고일이란? 주문 후 결제(입금)가 확인된 날로부터 주문하신 도서의 발송준비완료 기간을 말합니다.<br>수령예상일이란?
											예상출고일 + 실제배송기간으로 고객님이 도서를 수령하기까지의 기간을 말합니다.
										</dd>
										<dt>
											<span class="bul1">도서 상품</span>
										</dt>
										<dd>
											<p class="bul2">
												예상출고일 : 24시간 이내 (수령예상일 : 주문일로부터 2~4일 이내)<br>반디앤 루니스 인터넷
												물류창고에 재고가 1권 이상 남아있다는 의미로, 통상 1일이내의 발송준비 과정을 포함하여 근무일 기준
												2~4일 이내로 고객님께 배송됩니다. 그러나 매장의 재고는 항상 고객의 구매에 따라 변동될 수 있으며, 간혹
												재고데이터가 맞지않는 경우도 발생할 수 있으니 이점 양해해주시기 바랍니다.
											</p>
											<p class="bul2">
												예상출고일 : 2~3일 이내 (수령예상일 : 주문일로부터 4~5일 이내)<br>반디앤 루니스 인터넷
												물류창고에는 재고가 없음나 코엑스점, 종로점에 재고가 3권 이상 남아있다는 의미로 이 경우 매장상황에 따라
												2~3일 정도의 발송준비 과정을 포함하여 근무일 기준 4~5일 이내로 고객님께 배송됩니다.
											</p>
											<p class="bul2">
												예상출고일 : 3~5일 이내 (수령예상일 : 5~7일 이내)<br>반디앤 루니스 인터넷 물류창고에는
												재고가 없으나 코엑스, 종로점에 재고가 1~2권 정도 남아있다는 의미로, 3~5일정도의 발송준비 과정을
												포함하여 근무일 기준 5~7일 이내로 고객님께 배송됩니다.
											</p>
											<p class="bul2">
												예상출고일 : 5~7일 이내(수령예상일 : 7일~9일 이내)<br>반디앤 루니스 인터넷 물류창고나
												코엑스, 종로점에 재고가 남아있지 않다는 의미로 이 경우 고객님께서 주문하시면 출판사에 매입의뢰를 하고,
												통상 2~3일(현매도서는 7일이상 소요)후 재입고되어 배송됩니다. 그러나 오래 전에 출간된 도서이거나 갑자기
												재고물량이 없는 도서의 경우 품절되거나 절판되었을 가능성이 많습니다. 그렇게 되면 부득이하게 주문을 취소하고
												결제하신 금액은 환불처리해 드리고 있습니다.
											</p>
											<p class="bul2">
												절판/품절<br>현재 출판사에 매입의뢰가 불가능하거나 재고물량이 없는 도서의 경우 절판/품절 표시가
												뜨며, 이 경우에는 해당 상품을 구매하실 수 없습니다. 그러나 이 중에는 일시적으로 품절처리가 되었으나 차후
												재입고되는 경우도 있사오니 품절/절판 도서에 대한 자세한 사항은 고객센터를 통해 문의 해 주십시오.
												(고객센터&gt;1:1 상담 또는 콜센터 : 1577-4030)
											</p>
										</dd>
										<dt>
											<span class="bul1">DVD / GIFT상품</span>
										</dt>
										<dd>&nbsp;&nbsp;&nbsp;DVD, GIFT상품은 반디앤루니스에 입점되어 있는 업체에서
											배송하는 관계로 통상 2~3일의 출고기간을 거치게 됩니다.</dd>
										<dt>
											<strong class="t_br1">주문 과정</strong>
										</dt>
										<dd>반디북의 주문과정은 주문하기 -&gt; 주문서작성 -&gt; 결제하기 -&gt; 주문완료의
											4단계로 이루어져 있습니다.</dd>
										<dt></dt>
										<dd>
											<p class="bul2">
												주문하기 :<br>쇼핑카트, 위시리스트에서 저장하신 도서를 선택하신 후 '주문하기' 버튼을
												누르시거나 상품 상세 페이지에서 '바로구매' 버튼을 누르시면 주문하기 페이지로 이동합니다.
											</p>
											<p class="bul2">
												주문서작성 :<br>주문자 정보, 배송지 정보, 배송시 요구사항, 선물포장 선택, 결제방법 선택 등
												주문에 필요한 정보를 입력하는 페이지 입니다. 페이지 상단에서는 현재 고객님께서 선택하신 상품의 총 수량과
												결제하실 금액을 한눈에 확인하실 수 있습니다. 쇼핑카트 또는 위시리스트를 통해 주문서를 작성하실 경우 상품
												갯수를 수정하실 수 있습니다.
											</p>
											<p class="bul2">
												결제하기 :<br>신용카드, 실시간 계좌이체, 가상계좌 입금, 휴대폰 소액결제, 적립금결제 ,
												예치금결제 등 각각의 결제방벙에 따라서 결제하시면 됩니다. 특히 신용카드, 실시간 계좌이체 결제의 경우
												본인인증서비스를 실시하고 있어 결제정보 유출에 대해서 걱정하지 않으셔도 됩니다.
											</p>
											<p class="bul2">
												주문완료 :<br>주문 과정의 마지막 단계로 주문상품, 결제종류, 결제 금액 등 완료된 주문사항을
												확인하실 수 있습니다. 이후, 주문건에 대한 배송조회 및 상세내역 조회는 메인페이지 우측 상단의
												'주문배송조회' 메뉴에서 자세히 확인하실 수 있습니다.
											</p>
										</dd>
										<dt>
											<strong class="t_br1">재정가도서</strong>
										</dt>
										<dd>출시된지 1년 6개월 이상된 도서만 적용되며, 한국출판물 문화 진흥원에 정가 수정 등록을 마친
											책에 한하여 기존보다 저렴한 가격으로 판매가 되는 도서를 말합니다.</dd>
										<dt></dt>
										<dt>
											<strong class="t_br1">구입시 유의사항</strong>
										</dt>
										<dt></dt>
										<dd>
											<p class="bul2">
												재정가 도서의 출고가 가능한 시점은 한국출판물 문화진흥원에 등록 된 일자로부터 2개월이 지난 시점부터 출고가
												<br>가능합니다.
											</p>
											<p class="bul2">재정가의 도서와 같이 있는 주문건의 출고기준은 재정가 도서의 출시일에
												출고가 되오니이용에 참고 하여 주시기 바랍니다.</p>
										</dd>
									</dl>
								</div>
							</div>

							<div class="conBox" id="tabID_con2" style="display: none;">
								<h4>
									<img
										src="http://image.bandinlunis.com/images/center/h4_usedBookG_02.gif"
										alt="안전결제가이드">
								</h4>
								<div class="conBoxB">
									<dl class="conTxt">
										<dt>
											<strong class="t_br1">공인인증서 안내</strong>
										</dt>
										<dd>
											카드 또는 실시간 계좌이체 등을 결제수단으로 이용하실 경우 '공인인증서'가 필요할 수 있습니다.<br>공인인증서란
											본인임을 확인하기 위해 사용하는 일종의 "사이버 거래용 인감증명서"라고 할 수 있으며, 인터넷뱅킹 및 증권
											거래시에 전자서명을 안전하고 원활하게 사용하기 위해서 사용하는 것으로, 전자서명법에 의해 지정된 신뢰할 수
											있는 제3의 기관인 공인인증기관에서 발급한 인증서입니다.<br>무료로 발급하고 있는 개인
											은행/신용카드/보험용 인증서를 발급 받기 위해서는 먼저 거래은행 창구를 방문하여 인터넷 뱅킹을 신청 하신 후
											가정이나 사무실의 PC를 이용하여 해당은행의 인터넷 뱅킹 홈페이지에 접속하셔서 안내에 따라 인증서를 발급
											받으시면 됩니다.
										</dd>
										<dt>
											<strong class="t_br1">인터넷 안전결제(ISP, 안심결제) 안내</strong>
										</dt>
										<dd>안전결제(ISP, 안심결제) 서비스란 온라인 전사상거래시 고객님의 개인신용정보유출을 원천적으로
											차단하는 신용카드 결제서비스로서 안전결제(ISP)서비스 비밀번호만 입력하여 결제하도록 하여 고객님께서 안전하고
											편리하게 전자상거래(인터넷 쇼핑)을 하실 수 있도록 하는 서비스입니다. 결제금액 30만원 이상의 경우
											공인인증서 의무화로 카드회원과 카드사용자의 일치여부를 다시 한번 확인함으로써 카드분실 및 도용으로 인한
											고액피해 발생에 따른 위험과 손실을 근본적으로 방지할 수 있는 서비스입니다.</dd>
										<dt>
											<strong class="t_br1">결제 관련 문의</strong>
										</dt>
										<dd>이중결제나 취소시 카드결제 대금 환불 등 신용카드 결제시 문제가 생긴 경우에는
											고객센터&gt;1:1 상담을 이용하시거나 반디앤루니스 고객센터 : 1577-4030 으로 문의해주십시오</dd>
									</dl>
								</div>
							</div>

							<div class="conBox" id="tabID_con3" style="display: none;">
								<h4>
									<img
										src="http://image.bandinlunis.com/images/center/h4_usedBookG_03.gif"
										alt="상품/컨텐츠 신고">
								</h4>
								<div class="conBoxB">
									<dl class="conTxt">
										<dt>
											<strong class="t_br1">상품 문의</strong>
										</dt>
										<dd>저희 서점에 없거나 판매가 중지된 도서를 구입하고자 하실 때에는 고객센터&gt;1:1 상담 또는
											반디앤루니스 고객센터 : 1577-4030 으로 문의해주십시오. 출판사쪽에 재고가 있거나 매입의뢰가 가능한
											도서일 경우 구매하시는데 도움을 드릴 수 있습니다.</dd>
										<dt>
											<strong class="t_br1">컨텐츠 수정요청 및 신고</strong>
										</dt>
										<dd>
											<p class="bul2">상품 상세 페이지에 저희가 등록한 상품정보(책소개, 카테고리 정보)가 간혹
												잘못 게제되어 있을 수 있습니다. 이 경우 해당 상품페이지의 '책정보' 탭 우측에 '책정보 수정 요청'
												메뉴를 통해 수정 신청을 해 주십시오. 실제로 잘못된 정보임이 확인 되었을 경우 가급적 신속하게 수정 처리
												하겠습니다.</p>
											<p class="bul2">타 고객이 등록한 게시물 (독자리뷰, 댓글 등)이 문제가 있다고 판단될
												경우 해당 글 우측에 신고아이콘( )을 클릭 해 신고 사유를 기입하신 후 보내주십시오. 실제로 문제가 있는
												게시물이라 판명되면 가급적 신속하게 처리하겠습니다.</p>
										</dd>
										<dt>
											<strong class="t_br1">부적합 게시물 등록회원에 대한 제재</strong>
										</dt>
										<dd>
											반디앤루니스에서는 자체 컨텐츠 및 게시판 등에 위법적인 내용 또는 적절치 못한 글이 게재된 경우 신고 접수
											등을 통해 관리자가 게시물에 대한 조치를 취하고 해당 회원에게 '패널티'를 가할 수 있게 되어 있습니다.
											쾌적한 사이트 이용환경을 제공하고자 하는 조치이오니 널리 양해를 부탁드립니다.
											<p class="bul2">
												패널티 내용<br>모든 게시글에는 신고기능이 적용되어있으며 이를 통해 접수된 내용은 관리자가 확인한
												후 신고 수락/반려 처리를 합니다. 신고가 타당하다고 판단된 되어 접수된 경우 해당 글은 삭제처리하며
												신고자에게는 적립금을 부여할 수 있습니다.<br>수락된 신고가 누적될 경우 해당 회원은 한달간
												글쓰기를 금지합니다.
											</p>
										</dd>
									</dl>
								</div>
							</div>

							<div class="boxBrown745 mt20">
								<div class="con">
									<p class="counsel">
										찾으시는 질문이 없나요? <strong class="point_o"><u>1:1 상담</u></strong>에
										문의해주세요. 
										<c:if test="${userId == null }">
										<a href="/webproject/login.action">
										<img src="http://image.bandinlunis.com/images/common/btn_appCounsel.gif" class="al_middle" alt="1:1 상담"></a>
										</c:if>
										<c:if test="${userId != null }">
										<a href="/webproject/help/helpCounsel.action">
										<img src="http://image.bandinlunis.com/images/common/btn_appCounsel.gif" class="al_middle" alt="1:1 상담"></a>
										</c:if>
										
										
									</p>
								</div>
							</div>

						</c:if>
						<!-- 구매가이드 -->
					</div>
					<!-- //right contents -->
				</div>
			</div>
		</div>
		<!-- //body -->
		<!-- footer -->


	</div>
	<jsp:include page="../main/footer.jsp" flush="false"/>


</body>
</html>