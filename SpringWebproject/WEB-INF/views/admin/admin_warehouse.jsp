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
		urltemp += "warehouseList";
		urltemp += "_ok.action";
	
		var params = jQuery("#warehouseForm").serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.	
		

		jQuery.ajax({
			url : urltemp,
			type : 'POST',
			data : params,
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			dataType : 'html',
			success : function(data, status) {
				$(".warehouselist").html(data);
			}
		});
	}

	function paging(url) {

		$(".warehouselist").load(url);

	}

</script>


</head>
<body>


	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<h2 style="border-bottom-style: solid;">지점 등록</h2>
			</div>

			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body form-horizontal goods-form">
						<form action="<%=cp%>/admin_warehouse_ok.action" method="post"
							enctype="multipart/form-data">
							<div class="col-lg-6 form-group">
								<label class="col-lg-3 control-label">지점 아이디 :</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" name="warehouseId">
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="col-lg-3 control-label">지점 이름 :</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" name="warehouseName">
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="col-lg-3 control-label">타임스탬프 :</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" name="timestamp">
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="col-lg-3 control-label">키 :</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" name="key">
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="col-lg-3 control-label">주소 :</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" name="addr">
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="col-lg-3 control-label">영업시간 :</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" name="time">
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="col-lg-3 control-label">전화번호 :</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" name="tel">
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="col-lg-3 control-label">버스경로 :</label>
								<div class="col-lg-9">
									<textarea class="form-control" name="waybus" rows="5"></textarea>
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="col-lg-3 control-label">지하철경로 :</label>
								<div class="col-lg-9">
									<textarea class="form-control" name="waysub" rows="5"></textarea>
								</div>
							</div>

							<div class="col-lg-6 form-group">
								<label class="col-lg-3 control-label">소개 :</label>
								<div class="col-lg-9">
									<textarea class="form-control" name="intro" rows="5"></textarea>
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
				<h2 style="border-bottom-style: solid;">지점 목록</h2>
			</div>

			<div class="panel panel-default">
				<div class="panel-body warehouselist">
					<form id="warehouseForm">
						<div class="col-lg-12 form-group">
							<div class="col-lg-8">
								<input type="hidden" name="searchKey" value="warehouseName">
								<input type="text" class="form-control" placeholder="지점을 입력하세요"
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
									<th scope="col">지점아이디</th>
									<th scope="col">지점이름</th>
									<th scope="col">지점주소</th>
									<th scope="col">전화번호</th>
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