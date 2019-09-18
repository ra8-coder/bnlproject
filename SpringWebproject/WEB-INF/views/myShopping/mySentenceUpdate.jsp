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
		
		var text = $('#sentence').val();
		$('#checkLength').text(text.length);
		
		$('#sentence').on('keyup',function(){
			
			var text = $(this).val();	
			$('#checkLength').text(text.length);
			
			if(text.length>200){
				if(event.keyCode !='8'){	//백스페이스 제외
					alert("한줄평은 200자까지 입력할 수 있습니다.");
				}
				$('#sentence').val(text.substring(0,200));
				
				text = $('#sentence').val();	
				$('#checkLength').text(text.length);
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
	<a href="<%=cp %>/main.action">홈</a> > <a href="<%=cp %>/myShoppingMain.action">나의쇼핑</a> > 나의 리뷰 > <b>간단평</b>
</div>
<!-- navigation -->
<jsp:include page="./topNavi.jsp" flush="false"/>
<jsp:include page="./sideNavi.jsp" flush="false"/>

<!-- 본문 -->
<div class="contents">
	<div style="font-size: 13pt; font-weight: bold; padding-bottom: 10px; border-bottom: 2px solid #e1e1e1;">간단평</div>
	<div class="review_article_box">
		<ul>
			<li style="padding: 0;">
				<div class="sentence_head">
					<a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"><img alt="" src="<%=cp%>/resources/image/book/${dto.bookImage}" height="100px;" width="70px;"></a>
				</div>
				<div class="sentence_body">
					<b><a href="<%=cp%>/book_info.action?isbn=${dto.isbn}">${dto.bookTitle }</a></b>
					<br/>
					${dto.authorName } | ${dto.publisher } | ${dto.publishDate }
				</div>
			</li>
		</ul>
	</div>
	<div class="sentence_contents" style="border: none;">
		<form action="" name="sentenceUpdateForm" method="post">
		<table>
			<tr>
				<th>간단평<br/>내용</th>
				<td height="135px;" style="padding-left: 20px;">
					<textarea rows="5" cols="100" name="sentence" id="sentence" style="border: 1px solid #d5d5d5; font-size: 10pt;">${dto.sentence }</textarea>
					<br/>
					<div style="float: right; padding-right: 32px;"><span id="checkLength"></span>/200</div>
				</td>
			</tr>
		</table>
		
		<div style="text-align: center; margin-top: 10px;">
			<input type="button" class="review_article_btn" value="수정하기" onclick="updateSentence('${dto.reviewId}')">
			<input type="button" class="review_article_btn" value="취소" onclick="javascript:location.href='<%=cp%>/myShopping/mySentenceList.action';">
		</div>	
		</form>
	</div>
</div>

</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>
</body>
</html>