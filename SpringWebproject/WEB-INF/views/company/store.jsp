<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="<%=cp%>/resources/css/store.css" type="text/css"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script charset="UTF-8" class="daum_roughmap_loader_script" src="http://dmaps.daum.net/map_js_init/roughmapLoader.js"></script>
<link rel="shortcut icon" href="http://image.bandinlunis.com/favicon.ico" type="image/x-icon">
<title>반디앤루니스 인터넷서점</title>

<script type="text/javascript">
	
	
	$(function() {
		//메뉴 활성화 색깔
		$(".bnl_slist li").click(function() {
			$(".bnl_slist .on").removeClass('on');
			$(this).addClass('on');
		});
		
		//지점메뉴 활성화 색깔
		$(".storeMenu li a").click(function() {
			$(".storeMenu li a.on").removeClass('on');
			$(this).addClass('on');
		});
		
		if(${warehouseId}=='0'){
			//지점 자동 로드
			storeInfo(3);
			$("#child_3").addClass('on');
		}else{
			storeInfo(${warehouseId});
			$("#child_"+${warehouseId}).addClass('on');
		}
		
		
	});
	
	//지점별 정보 불러오기
	function storeInfo(params) {
		var url = "<%=cp%>/storeinfo.action";

		$.post(url,{params:params},function(args){
			$("#storeInfo").html(args);
		});
	}
	
</script>

</head>
<body style="margin: 0;">
<jsp:include page="../common/header.jsp" flush="false"/>

<div class="content_title">
	<div class="content_wrap">
		<div class="content_wrap2">
			<ul class="c_location">
				<li>
					<a href="<%=cp%>/main.action">홈</a>
				</li>
				<li>
					<a href="<%=cp%>/company.action">회사소개</a>
				</li>
				<li>
					매장소개
				</li>
			</ul>
		</div>
		<div class="smenu_wrap">
			<div class="menuL">
				<div class="menuImg">
					<div class="menuImg_b">
						<ul class="bnl_list">
							<li>
								반디앤루니스 소개
								<ul class="bnl_slist">
									<li>
										<a href="<%=cp%>/company.action">
										회사소개
										</a>										
									</li>
									<li>
										<a href="<%=cp%>/bi.action">
										BI소개
										</a>										
									</li>
									<li>
										<a href="<%=cp%>/history.action">
										연혁
										</a>										
									</li>
									<li>
										<a href="<%=cp%>/contrb.action">
										사회공헌
										</a>										
									</li>
									<li>
										<a href="<%=cp%>/store.action">
										매장소개
										</a>										
									</li>
								</ul>
							</li>
						</ul>
					</div>					
				</div>
			</div>
			<div class="body_content">
				<div class="b_title">
					<h2 class="noLine">
						<img src="<%=cp %>/resources/image/main/h2_findmap.gif">
					</h2>
				</div>
				<ul class="storeMenu">
					<li>
						<a href="#" onclick="storeInfo(1);return false;" id="child_1">
							신세계강남점
						</a>
					</li>
					<li>
						<a href="#" onclick="storeInfo(2);return false;" id="child_2">
							신세계센텀시티점
						</a>
					</li>
					<li>
						<a href="#" onclick="storeInfo(3);return false;" id="child_3">
							롯데월드몰점
						</a>
					</li>
					<li>
						<a href="#" onclick="storeInfo(4);return false;" id="child_4">
							여의도신영증권점
						</a>
					</li>
					<li>
						<a href="#" onclick="storeInfo(5);return false;" id="child_5">
							대구신세계점
						</a>
					</li>
					<li>
						<a href="#" onclick="storeInfo(6);return false;" id="child_6">
							롯데몰수원점
						</a>
					</li>
					<li>
						<a href="#" onclick="storeInfo(7);return false;" id="child_7">
							신세계김해점
						</a>
					</li>
					<li>
						<a href="#" onclick="storeInfo(8);return false;" id="child_8">
							롯데스타시티점
						</a>
					</li>
					<li>
						<a href="#" onclick="storeInfo(9);return false;" id="child_9">
							신림역점
						</a>
					</li>
					<li>
						<a href="#" onclick="storeInfo(10);return false;" id="child_10">
							사당역점
						</a>
					</li>
					<li>
						<a href="#" onclick="storeInfo(11);return false;" id="child_11">
							목동점
						</a>
					</li>
					<li>
						<a href="#" onclick="storeInfo(12);return false;" id="child_12">
							롯데피트인산본점
						</a>
					</li>
					<li>
						<a href="#" onclick="storeInfo(13);return false;" id="child_13">
							롯데울산점
						</a>
					</li>
				</ul>
				<div class="storeContent">
					<div class="storeInfo">
						<div id="storeInfo"></div>
					</div>
				</div>
			</div>
		</div>	
	</div>
</div>



<jsp:include page="../common/footer.jsp" flush="false"/>


</body>
</html>