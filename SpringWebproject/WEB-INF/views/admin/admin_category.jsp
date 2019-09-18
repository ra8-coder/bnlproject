<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		urltemp += "categorylist";
		urltemp += "_ok.action";
	
		var params = jQuery("#categoryForm").serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.	
		

		jQuery.ajax({
			url : urltemp,
			type : 'POST',
			data : params,
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			dataType : 'html',
			success : function(data, status) {
				$(".categorylist").html(data);
			}
		});
	}

	function categoryPaging(url) {

		$(".categorylist").load(url);

	}


$(function(){
	$('.category').mouseover(
		function(){
			
		if($(this).attr('name') == '1' || $(this).attr('name') == '2' || $(this).attr('name') == '4' ){
			var url = "<%=cp%>/admin_categoryList.action"
				
			$("select[name='"+$(this).attr('name')+"']").load(url);
			
		}else {
			
			var selected = $(this).attr('name');
			var pre = selected - 1;
			
			var id = $("select[name='"+pre+"']").val();
			
			var url = "<%=cp%>/admin_categoryList.action"

						$.post(url, {
							parentsId : id
						}, function(data, status) {
							$("select[name='" + selected + "']").html(data);
						});

					}

				});
	});

	$(function() {
		$("select[name='1']").change(function() {
			$("#parentsId1").val($(this).val());

		});
	});

	$(function() {
		$("select[name='3']").change(function() {
			$("#parentsId2").val($(this).val());

		});
	});
	$(function() {
		$("select[name='6']").change(function() {
			$("#categoryId").val($(this).val());

		});
	});
	
</script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<h2 style="border-bottom-style: solid;">카테고리 관리</h2>
			</div>
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body form-horizontal goods-form">

						<form action="admin_category_ok.action" method="post">
							<div class="col-lg-1 form-group">
								<label class="control-label" style="float: right;">1분류</label>
							</div>
							<div class="col-lg-5 form-group">
								<label class="col-lg-2 control-label"></label>
								<div class="col-lg-10">
									<input type="text" class="form-control" name="categoryId"
										placeholder="카테고리 아이디">
								</div>
							</div>
							<div class="col-lg-5 form-group">
								<label class="col-lg-2 control-label"> </label>
								<div class="col-lg-10">
									<input type="text" class="form-control" name="categoryName"
										placeholder="카테고리 네임">
								</div>
							</div>
							<div class="col-lg-2 form-group">
								<div class="col-lg-9">
									<button type="submit" class="btn">등록</button>
								</div>
							</div>
						</form>

						<form action="admin_category_ok.action" method="post">
							<div class="col-lg-1 form-group">
								<label class="control-label" style="float: right;">2분류</label>
							</div>
							<div class="col-lg-2 category">
								<select class="form-control category" name="1">
									<option>1분류</option>
								</select> <input type="hidden" id="parentsId1" name="parentsId" value="">
							</div>
							<div class="col-lg-4 form-group">
								<label class="col-lg-2 control-label"></label>
								<div class="col-lg-10">
									<input type="text" class="form-control" name="categoryId"
										placeholder="카테고리 아이디">
								</div>
							</div>
							<div class="col-lg-4 form-group">
								<label class="col-lg-2 control-label"> </label>
								<div class="col-lg-10">
									<input type="text" class="form-control" name="categoryName"
										placeholder="카테고리 네임">
								</div>
							</div>
							<div class="col-lg-2 form-group">
								<div class="col-lg-9">
									<button type="submit" class="btn">등록</button>
								</div>
							</div>
						</form>

						<form action="admin_category_ok.action" method="post">
							<div class="col-lg-1 form-group">
								<label class="control-label" style="float: right;">3분류</label>
							</div>
							<div class="col-lg-2 category">
								<select class="form-control category" name="2">
									<option>1분류</option>
								</select>
							</div>
							<div class="col-lg-2 category">
								<select class="form-control category" name="3">
									<option>2분류</option>
								</select> 
								<input type="hidden" id="parentsId2" name="parentsId" value="">
							</div>
							<div class="col-lg-3 form-group">
								<label class="col-lg-2 control-label"></label>
								<div class="col-lg-10">
									<input type="text" class="form-control" name="categoryId"
										placeholder="카테고리 아이디">
								</div>
							</div>
							<div class="col-lg-3 form-group">
								<label class="col-lg-2 control-label"> </label>
								<div class="col-lg-10">
									<input type="text" class="form-control" name="categoryName"
										placeholder="카테고리 네임">
								</div>
							</div>
							<div class="col-lg-1 form-group">
								<div class="col-lg-9">
									<button type="submit" class="btn">등록</button>
								</div>
							</div>
						</form>

					</div>
				</div>
			</div>

			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body form-horizontal goods-form">
						<form action="admin_category_ok.action" method="post">
							<div class="col-lg-12 form-group">
								<label for="categoryId" class="col-lg-2 control-label">도서 카테고리
									추가:</label>
								<div class="col-lg-2 category">
									<select class="form-control category" name="4">
										<option>1분류</option>
									</select>
								</div>
								<div class="col-lg-2">
									<select class="form-control category" name="5">
										<option>2분류</option>
									</select>
									
								</div>
								<div class="col-lg-2">
									<select class="form-control category" name="6">
										<option>3분류</option>
									</select> <input type="hidden" id="categoryId" name="categoryId"
										value="">
								</div>
								<div class="col-lg-2">
									<input class="form-control" type="text" name="isbn" placeholder="isbn">
								</div>
								<div class="col-lg-2"> 
									<button class="btn" type="submit">등록</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			
			<div class="col-lg-12">
				<h2 style="border-bottom-style: solid;">카테고리 목록</h2>
			</div>

			<div class="panel panel-default">
				<div class="panel-body categorylist">
					<form id="categoryForm">
						<div class="col-lg-12 form-group">
							<div class="col-lg-8">
								<input type="hidden" name="searchKey" value="categoryName">
								<input type="text" class="form-control" placeholder="카테고리를 입력하세요"
									name="searchValue">
							</div>
							<div class="col-lg-4">
								<button type="button" class="btn btn-default"
									onclick="formSubmit();">검색</button>
							</div>
						</div>
					</form>
					<div class="table">
						
							<table class="table table-bordered">
								<thead>
									<tr>
										<th scope="col">no</th>
										<th scope="col">카테고리 아이디</th>
										<th scope="col">카테고리 이름</th>
										<th scope="col">상위 카테고리 아이디</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						
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