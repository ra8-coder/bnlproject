<%@page import="org.springframework.http.HttpRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	
%>

<jsp:include page="./admin_header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="<%=cp%>/resources/css/admin.css"
	type="text/css" />

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">

	
	var searchKey = "<%=searchKey%>";

	var searchValue = "<%=searchValue%>";
	
	function makeURL(url){
		
		if (searchKey!=null || searchKey != "null") {
			url += "&searchKey=" + searchKey;

			if (searchValue != "null") {
				url += "&searchValue=" + searchValue;
			} else {
				url = "admin_quantity.action?page=${pageMaker.cri.page}";
			}

		}
		
		return url;
		
	}
	

	$(document).ready(function(e) {

		$(".searchKey").click(function() {
			$("#search_concept").text($(this).text());

			if ($(this).val() == 1) {
				searchKey = "isbn";
			} else if ($(this).val() == 2) {
				searchKey = "booktitle";
			} 
		});

		$(".form-control").change(function() {
			searchValue = $(this).val();

			var url = "admin_quantity.action?page=${pageMaker.cri.page}";

			$(location).attr('href', makeURL(url));
		});

		$("button[name='but']").click(function() {
			/* alert("key: "+ searchKey + "\nvalue: " + searchValue); */

			$(location).attr('href', makeURL(url));

		});

	});
</script>

</head>



<body>


	<div class="search_container" style="width:700px; margin: 20px auto;">
		<div class="row">
			<div class="col-xs-8 col-xs-offset-2">
				<div class="input-group">
					<div class="input-group-btn search-panel">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown">
							<span id="search_concept">---</span> <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li style="cursor: pointer;" class="searchKey" value=1><a>isbn</a></li>
							<li style="cursor: pointer;" class="searchKey" value=2><a>책이름</a></li>
						</ul>
					</div>
					<input type="text" class="form-control" name="x"
						placeholder="입력하세요."> <span class="input-group-btn">
						<button class="btn btn-default" name="but" type="button">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</span>
				</div>
			</div>
		</div>
	</div>


	<div class="quantity_table" style="width: 1200px; margin: 20px auto;">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th scope="col">no</th>
						<th scope="col">책이름</th>
						<th scope="col">ISBN</th>
						<th scope="col">총수량</th>
						<th scope="col">신세계강남점</th>
						<th scope="col">신세계센텀시티점</th>
						<th scope="col">롯데월드몰점</th>
						<th scope="col">여의도신영증권점</th>
						<th scope="col">대구신세계점</th>
						<th scope="col">롯데몰수원점</th>
						<th scope="col">신세계김해점</th>
						<th scope="col">롯데스타시티점</th>
						<th scope="col">신림역점</th>
						<th scope="col">사당역점</th>
						<th scope="col">목동점</th>
						<th scope="col">롯데피트인산본점</th>
						<th scope="col">롯데울산점</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach var="quantity" items="${quantityList}" varStatus="status">
						<tr>
							<td>${(status.index + pageMaker.cri.numPerPage * (pageMaker.cri.page-1))+1 }</td>
							<td>${quantity.booktitle }</td>
							<td>${quantity.isbn }</td>
							<td>${quantity.total }</td>
							<td>${quantity.a }</td>
							<td>${quantity.b }</td>
							<td>${quantity.c }</td>
							<td>${quantity.d }</td>
							<td>${quantity.e }</td>
							<td>${quantity.f }</td>
							<td>${quantity.g }</td>
							<td>${quantity.h }</td>
							<td>${quantity.i }</td>
							<td>${quantity.j }</td>
							<td>${quantity.k }</td>
							<td>${quantity.l }</td>
							<td>${quantity.m }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
	</div>


	<div style="display: table; margin: 0 auto;">
		<ul class="pagination">
			<c:if test="${pageMaker.pre }">
				<li><a href="<%=cp %>/admin_quantity.action?page=${pageMaker.startPage-1}">&lt;</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }" var="idx">
				<li><a
					href="<%=cp %>/admin_quantity.action?page=${idx}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}">${idx }</a></li>
			</c:forEach>
			<c:if test="${pageMaker.nex }">
				<li><a
					href="<%=cp %>/admin_quantity.action?page=${pageMaker.endPage+1}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}">&gt;</a></li>
			</c:if>
		</ul>
	</div>


</body>
</html>
































