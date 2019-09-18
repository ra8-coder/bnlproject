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
				url = "admin_users.action?page=${pageMaker.cri.page}";
			}

		}
		
		return url;
		
	}

	$(document).ready(function(e) {

		$(".searchKey").click(function() {
			$("#search_concept").text($(this).text());

			if ($(this).val() == 1) {
				searchKey = "id";
			} else if ($(this).val() == 2) {
				searchKey = "name";
			} else if ($(this).val() == 3) {
				searchKey = "email";
			} else if ($(this).val() == 4) {
				searchKey = "nickname";
			}
		});

		$(".form-control").change(function() {
			searchValue = $(this).val();

			var url = "admin_users.action?page=${pageMaker.cri.page}";

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


	<div class="search_container" style="width: 700px; margin: 20px auto;">
		<div class="row">
			<div class="col-xs-8 col-xs-offset-2">
				<div class="input-group">
					<div class="input-group-btn search-panel">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown">
							<span id="search_concept">---</span> <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li style="cursor: pointer;" class="searchKey" value=1><a>아이디</a></li>
							<li style="cursor: pointer;" class="searchKey" value=2><a>이름</a></li>
							<li style="cursor: pointer;" class="searchKey" value=3><a>이메일</a></li>
							<li style="cursor: pointer;" class="searchKey" value=4><a>닉네임</a></li>
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


	<div class="user_table" style="width: 1200px; margin: 20px auto;">
		<form name="userList" method="post" action="">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th scope="col">no</th>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">닉네임</th>
						<th scope="col">등급</th>
						<th scope="col">포인트</th>
						<th scope="col">이메일</th>
						<th scope="col">전화번호</th>
						<th scope="col">주소</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach var="user" items="${userList}" varStatus="status">
						<tr>
							<td>${(status.index + pageMaker.cri.numPerPage * (pageMaker.cri.page-1))+1 }</td>
							<td>${user.userId }</td>
							<td>${user.userName }</td>
							<td>${user.nickName }</td>
							<td>${user.memberGrade }</td>
							<td>${user.point }</td>
							<td>${user.email}</td>
							<td>${user.phone }</td>
							<td>${user.zipCode}${user.address1 }${user.address2 }</td>
							<td>
								<button type="button" class="btn" id="del_btn"
									onclick="location.href='<%=cp %>/admin_users_delete.action?page=${pageMaker.cri.page}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}&userId=${user.userId }'">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>

	</div>


	<div style="display: table; margin: 0 auto;">
		<ul class="pagination">
			<c:if test="${pageMaker.pre }">
				<li><a
					href="<%=cp %>/admin_users.action?page=${pageMaker.startPage-1}">&lt;</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }" var="idx">
				<li><a
					href="<%=cp %>/admin_users.action?page=${idx}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}">${idx }</a></li>
			</c:forEach>
			<c:if test="${pageMaker.nex }">
				<li><a
					href="<%=cp %>/admin_users.action?page=${pageMaker.endPage+1}&searchKey=${pageMaker.cri.searchKey}&searchValue=${pageMaker.cri.searchValue}">&gt;</a></li>
			</c:if>
		</ul>
	</div>


</body>
</html>
































