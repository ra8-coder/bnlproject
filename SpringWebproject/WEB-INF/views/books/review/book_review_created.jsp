<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도서 리뷰 작성</title>

<link rel="stylesheet" href="/webproject/resources/book_css/style.css"
	type="text/css" />
<link rel="stylesheet" href="/webproject/resources/book_css/created.css"
	type="text/css" />
<link rel="stylesheet"
	href="/webproject/resources/book_css/review_class.css" />
<script type="text/javascript" src="<%=cp%>/resources/js/util.js"></script>

<script type="text/javascript">

	function sendIt(){
		
		f = document.myForm;
		
		str = f.reviewTitle.value;
		str = str.trim();
		if(!str){
			alert("\n제목을 입력하세요.");
			f.reviewTitle.focus();
			return;
		}
		f.reviewTitle.value = str;
		
		
		str = f.contents.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.contents.focus();
			return;
		}
		f.contents.value = str;
		
		
// 		var rate = $("#usr_point option:selected").val();
		var rate = document.getElementById('usr_point').options[document.getElementById('usr_point').selectedIndex].value;
		if(!rate){
			alert("\n평점을 입력해주세요.");
			return;
		}
		
		f.action = "<%=cp%>/book_review_created_ok.action?rate="+rate;
		f.submit();

	}
	
	function goBack(){
		f =document.myForm;
		
		f.action = "<%=cp%>/book_info.action";
		f.submit;
	}
</script>

<style>
img:hover {
	box-shadow: 0 0 2px 1px rgba(0, 140, 186, 0.5);
}

/* 버튼 효과 1*/
.button1 {
	border-radius: 10px;
	background-color: #f4511e;
	border: none;
	color: #FFFFFF;
	text-align: center;
	font-size: 18px;
	padding: 10px;
	width: 120px;
	transition: all 0.5s;
	cursor: pointer;
	margin: 5px;
}

.button1 span {
	cursor: pointer;
	display: inline-block;
	position: relative;
	transition: 0.5s;
}

.button1 span:after {
	content: '\00bb';
	position: absolute;
	opacity: 0;
	top: 0;
	right: -20px;
	transition: 0.5s;
}

.button1:hover span {
	padding-right: 25px;
}

.button1:hover span:after {
	opacity: 1;
	right: 0;
}

/* 버튼 효과 2*/
.button2 {
	padding: 10px 15px;
	font-size: 18px;
	text-align: center;
	cursor: pointer;
	outline: none;
	color: #fff;
	background-color: #4CAF50;
	border: none;
	border-radius: 10px;
	margin: 5px;
}

.button2:hover {
	background-color: #3e8e41
}

.button2:active {
	background-color: #3e8e41;
	transform: translateY(4px);
}
/* 버튼 효과 3*/
.button3 {
	position: relative;
	background-color: #4CAF50;
	border: none;
	font-size: 18px;
	color: #FFFFFF;
	padding: 10px;
	width: 100px;
	text-align: center;
	-webkit-transition-duration: 0.4s; /* Safari */
	transition-duration: 0.4s;
	text-decoration: none;
	overflow: hidden;
	cursor: pointer;
	border-radius: 10px;
	margin: 5px;
}

.button3:after {
	content: "";
	background: #90EE90;
	display: block;
	position: absolute;
	padding-top: 300%;
	padding-left: 350%;
	margin-left: -20px !important;
	margin-top: -120%;
	opacity: 0;
	transition: all 1s
}

.button3:active:after {
	padding: 0;
	margin: 0;
	opacity: 1;
	transition: 1s
}
</style>


</head>
<body>

	<div id="bbs">
		<form action="" name="myForm" method="post">
			<div id="bbs_title">도서 리뷰</div>


			<div class="brBox3 pd10 mb15"
				style="overflow: auto; padding-top: 15px; padding-left: 15px; padding-bottom: 15px;">

				<div class="fl_clear searchBook">
					<div class="thumbNail_type01">
						<div class="photo">
					
							<a href="#"><img id="book_title_img" name="book_title_img"
								src="/webproject/resources/image/book/${book_image}" 
								width="70" alt="" class="d_imgLine"
								style="border: 1px solid #ddd; border-radius: 4px; padding: 5px; width: 150px;"></a>
						</div>
						<div class="info" style="margin-top: 3px;">
							<p class="booktit" style="margin-bottom: 20px;">
								<a href="#" id="book_title_txt"
									style="font-size: 15pt; font-style: italic; font-weight: bold;">${dto.bookTitle }</a>
							</p>

							<p class="t_11gr" id="book_etc" style="margin-bottom: 20px;">
								${dto.authorName }저자 | ${dto.publisher }출판사 | ${dto.publishDate }</p>
							<div id="scoreDiv" class="btmA" style="display: block;">
								<select id = "usr_point">
									<option value="">나의 평점 선택</option>
									<option value="10">10점</option>
									<option value="9">9점</option>
									<option value="8">8점</option>
									<option value="7">7점</option>
									<option value="6">6점</option>
									<option value="5">5점</option>
									<option value="4">4점</option>
									<option value="3">3점</option>
									<option value="2">2점</option>
									<option value="1">1점</option>
								</select>



							</div>
						</div>
						<div class="fl_clear"></div>
					</div>
				</div>


			</div>


			<br>


			<div id="bbsCreated">
				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>리뷰 제목</dt>
						<dd>
							<input type="text" name="reviewTitle" size="75" maxlength="100"
								class="boxTF" />
						</dd>
					</dl>
				</div>

				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>작 성 자</dt>
						<dd>${userName }</dd>
					</dl>
				</div>

				<div id="bbsCreated_content">
					<dl>
						<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
						<dd>
							<textarea rows="12" cols="74" name="contents" class="boxTA"></textarea>
						</dd>
					</dl>
				</div>

			</div>

			<div id="bbsCreated_footer">
				<input type="hidden" value = ${isbn } name ="isbn" >
				<button class="button2" onclick="sendIt();">등록하기</button>

				<button class="button3" onclick="document.myForm.reviewTitle.focus();"
					type="reset">
					<span>다시입력 </span>
				</button>
				<button class="button1"
					onclick="javascript:goBack();">
					<span>작성취소</span>
				</button>
			</div>

		</form>

	</div>

</body>
</html>



