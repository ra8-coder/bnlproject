<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:include page="./admin_header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	
	
	function formSubmit() {
	
	var urltemp = "<%=cp%>/admin_";
		urltemp += "books";
		urltemp += "_ok.action";
	
		var params = jQuery("#booksForm").serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.	
		

		jQuery.ajax({
			url : urltemp,
			type : 'POST',
			data : params,
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			dataType : 'html',
			success : function(data, status) {
				$(".booklist").html(data);
			}
		});
	}

	function bookPaging(url) {

		$(".booklist").load(url);

	}
	
	
	function popUp(obj) {
		url = "<%=cp%>/admin_search_";
		url += obj.value;
		url += ".action";
		window.open(url,'window','left=200,top=200,width=400,height=500');
	}
	

	$(function(){
		$('.category').mouseover(
			function(){
				
			if($(this).attr('name') == '1'){
				var url = "<%=cp%>/admin_categoryList.action"
					
				$("select[name='1']").load(url);
				
			}else if($(this).attr('name') == '2'){
								
				var id = $("select[name='1']").val();
				
				var url = "<%=cp%>/admin_categoryList.action"
				
				$.post(url,
					    {
					        parentsId : id
					    },
					    function(data, status){
					        $("select[name='2']").html(data);
					    });
				
			}else if($(this).attr('name') == '3'){
				
				var id = $("select[name='2']").val();
				
				var url = "<%=cp%>/admin_categoryList.action";

				$.post(url, {
					parentsId : id
				}, function(data, status) {
					$("select[name='3']").html(data);
				});

			}

		});
	});

	$(function() {
		$("select[name='3']").change(function() {
			$("#categoryId").val($(this).val());

		});
	});

	$(function() {
		$('.preview-add-button').click(function() {

		});
	});
</script>

</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<h2 style="border-bottom-style: solid;">도서등록</h2>
			</div>
			<!-- 상품등록 -->
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body form-horizontal goods-form">
						<form action="<%=cp%>/admin_goods_ok.action" method="post"
							enctype="multipart/form-data">
							<div class="col-lg-6 form-group">
								<label for="bookTitle" class="col-lg-3 control-label">책제목
									:</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" id="bookTitle"
										name="bookTitle">
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="subTitle" class="col-lg-4 control-label">부제목
									:</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="subTitle"
										name="subTitle">
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="authorId" class="col-lg-3 control-label">작가
									아이디 :</label>
								<div class="col-lg-7">
									<input type="text" class="form-control" id="authorId"
										disabled="disabled"> <input type="hidden"
										name="authorId" value="">
								</div>
								<div class="col-lg-2">
									<button type="button" class="btn btn-default authorId-search"
										value="author" onclick="popUp(this)">검색</button>
								</div>
							</div>

							<!-- <div class="col-lg-6 form-group">
								<label for="translatorId" class="col-lg-4 control-label">번역가
									아이디 :</label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="translatorId"
										disabled="disabled"> <input type="hidden"
										name="translatorId" value="">
								</div>
								<div class="col-lg-2">
									<button type="button"
										class="btn btn-default translatorId-search" value="translator"
										onclick="popUp(this)">검색</button>
								</div>
							</div> -->
							<div class="col-lg-6 form-group" style="height: 40px"></div>

							<div class="col-lg-6 form-group">
								<label for="publisher" class="col-lg-3 control-label">출판사
									:</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" id="publisher"
										name="publisher">
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="isbn" class="col-lg-4 control-label">isbn :</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="isbn" name="isbn">
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="categoryId" class="col-lg-3 control-label">카테고리:</label>
								<div class="col-lg-3 category">
									<select class="form-control category" name="1">
										<option>1분류</option>
									</select>
								</div>
								<div class="col-lg-3">
									<select class="form-control category" name="2">
										<option>2분류</option>
									</select>
								</div>
								<div class="col-lg-3">
									<select class="form-control category" name="3">
										<option>3분류</option>
									</select> <input type="hidden" id="categoryId" name="categoryId"
										value="">
								</div>

							</div>


							<div class="col-lg-6 form-group">
								<label for="publishdate" class="col-lg-4 control-label">출판일
									:</label>
								<div class="col-lg-8">
									<input type="date" class="form-control" id="publishDate"
										name="publishDate">
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="introduction" class="col-lg-3 control-label">책소개
									:</label>
								<div class="col-lg-9">
									<textarea class="form-control" id="introduction"
										name="introduction" rows="17"></textarea>
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="page" class="col-lg-4 control-label">페이지 :</label>
								<div class="col-lg-8">
									<input type="number" class="form-control" id="page" name="page">
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="bookSize" class="col-lg-4 control-label">책
									사이즈 :</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="bookSize"
										name="bookSize" placeholder="123x123(mm)" />
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="tableOfContents" class="col-lg-4 control-label">목차
									:</label>
								<div class="col-lg-8">
									<textarea class="form-control" id="tableOfContents"
										name="tableOfContents" rows="10"></textarea>
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="bookPrice" class="col-lg-4 control-label">정가
									:</label>
								<div class="col-lg-8">
									<input type="number" class="form-control" id="bookPrice"
										name="bookPrice">
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="discountRate" class="col-lg-3 control-label">할인률
									:</label>
								<div class="col-lg-9">
									<input type="number" class="form-control" id="discountRate"
										name="discountRate">
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="warehouseId" class="col-lg-4 control-label">매장
									아이디 :</label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="warehouseId"
										disabled="disabled"> <input type="hidden"
										name="warehouseId" value="">
								</div>
								<div class="col-lg-2">
									<button type="button" class="btn btn-default" value="warehouse"
										onclick="popUp(this);">검색</button>
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="quantity" class="col-lg-3 control-label">수량
									:</label>
								<div class="col-lg-9">
									<input type="number" class="form-control" id="quantity"
										name="quantity">
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label for="bookImage" class="col-lg-4 control-label">도서커버이미지
									:</label>
								<div class="col-lg-8">
									<input type="file" class="form-control" name="file">
								</div>
							</div>

							<div class="form-group">
								<div class="col-lg-11 text-right">
									<button type="submit"
										class="btn btn-default preview-add-button">
										<span class="glyphicon glyphicon-ok"></span> 등록
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-lg-12">
				<h2 style="border-bottom-style: solid;">도서 미리보기 이미지 등록</h2>
			</div>
			<div class="col-lg-12">

				<div class="panel panel-default">
					<div class="panel-body form-horizontal goods-form">
						<form action="admin_image.action" method="post"
							enctype="multipart/form-data">
							<div class="col-lg-12 form-group">
								<label for="bookImage" class="col-lg-4 control-label">도서
									미리보기 이미지 등록 :</label>
								<div class="col-lg-4">
									<input multiple="multiple" type="file" class="form-control"
										name="file">
								</div>
								<div class="col-lg-2">
									<input type="text" name="isbn" placeholder="isbn"
										class="form-control">
								</div>
								<div class="col-lg-2 text-right">
									<button type="submit"
										class="btn btn-default preview-add-button">
										<span class="glyphicon glyphicon-ok"></span> 등록
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-lg-12">
				<h2 style="border-bottom-style: solid;">도서 목록</h2>
			</div>

			<div class="panel panel-default">
				<div class="panel-body booklist">
					<form id="booksForm">
						<div class="col-lg-12 form-group">
							<div class="col-lg-2 form-group">
								<select class="form-control" name="searchKey">
									<option value=null>선택</option>
									<option value="isbn">isbn</option>
									<option value="bookTitle">책제목</option>
									<!-- <option value="author">작가</option> -->
								</select>
							</div>
							<div class="col-lg-6">
								<input type="text" class="form-control" placeholder="검색어를 입력하세요"
									name="searchValue">
							</div>
							<div class="col-lg-4">
								<button type="button" class="btn btn-default"
									onclick="formSubmit();">검색</button>
							</div>
						</div>
					</form>
					<div class="table">
						<form name="userList" method="post" action="">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th scope="col">no</th>
										<th scope="col">책제목</th>
										<th scope="col">작가</th>
										<th scope="col">출판사</th>
										<th scope="col">isbn</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</form>

					</div>
					<div style="display: table; margin: 0 auto;">
						<ul class="pagination">
							<li><a style="cursor: pointer">0</a></li>
						</ul>
					</div>

				</div>
			</div>


		</div>
	</div>



</body>
</html>