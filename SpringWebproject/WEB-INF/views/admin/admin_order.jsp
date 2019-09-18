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
	
function formSubmit(type) {
	
	var urltemp = "<%=cp%>/admin_";
		urltemp += type;
		urltemp += "_ok.action";

		if (type == 'order') {
			var params = jQuery("#orderForm").serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.
		} else if (type == 'shipments') {
			var params = jQuery("#shipmentsForm").serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.
		}

		jQuery.ajax({
			url : urltemp,
			type : 'POST',
			data : params,
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			dataType : 'html',
			success : function(data, status) {
				if (type == 'order') {
					$(".orderlist").html(data);
				} else if (type == 'shipments') {
					$(".shipmentslist").html(data);
				}
			}
		});
	}

	function orderPaging(url) {

		$(".orderlist").load(url);

	}

	function shipmentsPaging(url) {

		$(".shipmentslist").load(url);

	}
</script>

</head>
<body>
	<div class="container">
		<h2>주문 현황</h2>
		<div class="panel-group">
			<div class="panel panel-default">
				<div class="panel-heading">주문 조회</div>
				<div class="panel-body orderlist">
					<form id="orderForm">
						<div class="col-lg-6 form-group">
							<div class="col-lg-6">
								<input type="date" class="form-control" name="fromDate">
							</div>

							<div class="col-lg-6">
								<input type="date" class="form-control" name="toDate">
							</div>
						</div>
						<div class="col-lg-6 form-group">
							<div class="col-lg-8">
								<input type="hidden" name="searchKey" value="userId"> <input
									type="text" class="form-control" placeholder="사용자 아이디"
									name="searchValue">
							</div>
							<div class="col-lg-4">
								<button type="button" class="btn btn-default"
									onclick="formSubmit('order');">검색</button>
							</div>
						</div>
					</form>

					<div class="table">
						<form name="userList" method="post" action="">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th scope="col">no</th>
										<th scope="col">주문번호</th>
										<th scope="col">사용자아이디</th>
										<th scope="col">주문현황</th>
										<th scope="col">처리날짜</th>
										<th scope="col">주문금액</th>
										<th scope="col">주소</th>
										<th scope="col">상세내역</th>
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
			<div class="panel panel-default">
				<div class="panel-heading">배송 조회</div>
				<div class="panel-body shipmentslist">
					<form id="shipmentsForm">
						<div class="col-lg-6 form-group">
							<div class="col-lg-8">
								<input type="hidden" name="searchKey" value="userId"> <input
									type="text" class="form-control" placeholder="사용자 아이디"
									name="searchValue">
							</div>
							<div class="col-lg-4">
								<button type="button" class="btn btn-default"
									onclick="formSubmit('shipments');">검색</button>
							</div>
						</div>
					</form>
					<div class="table">
						<form name="userList" method="post" action="">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th scope="col">no</th>
										<th scope="col">주문번호</th>
										<th scope="col">배송번호</th>
										<th scope="col">사용자아이디</th>
										<th scope="col">배송현황</th>
										<th scope="col">수령예상일</th>
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