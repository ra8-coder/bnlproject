<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<!DOCTYPE html>
<html>
<head>
<title>반디앤루니스 인터넷서점</title>

	<link rel="stylesheet" href="<%=cp%>/resources/css/main.css" type="text/css">
	<link rel="stylesheet" href="<%=cp%>/resources/css/myShopping.css" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="<%=cp%>/resources/js/myShopping.js"></script>
	
	<script type="text/javascript">	
	$(document).ready(function(){
		
		//초기 리스트 자동 불러오기
		$.ajax({			
			url:"getReviewList.action",
			type:"POST",
			success:function(data){
				$('#myReviewList').html(data);	
			},
			error:function(e){
				alert(e.responseText);
			}
		});

	});	
	</script>
	
</head>
<body style="padding: 0; margin: 0;">

<!-- header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<!-- 전체 div -->
<div style="margin: 0 auto; width: 960px;">

<div style="margin-top: 12px;">
	<a href="<%=cp %>/main.action">홈</a> > <a href="<%=cp %>/myShoppingMain.action">나의쇼핑</a> > 나의 리뷰 > <b>리뷰가 있는 책</b>
</div>
<!-- navigation -->
<jsp:include page="./topNavi.jsp" flush="false"/>
<jsp:include page="./sideNavi.jsp" flush="false"/>

<div class="contents">
	<div style="font-size: 13pt; font-weight: bold; padding-bottom: 10px;">리뷰가 있는 책 | <span style="font-size: 10pt; font-weight: normal;">(총 ${reviewCount }권의 책이 담겨 있습니다.)</span></div>
	<div id="myReviewList">

	</div>

</div>




</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>

</body>
</html>