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

</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<h2 style="border-bottom-style: solid;">작가/번역가 등록</h2>
			</div>

			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body form-horizontal goods-form">
						<form action="<%=cp%>/admin_author_ok.action" method="post"
							enctype="multipart/form-data">
							<div class="col-lg-6 form-group">
								<label class="col-lg-2 control-label">아이디 :</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" name="id">
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="col-lg-3 control-label">네임 :</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" name="name">
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="col-lg-2 control-label">국가 :</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" name="nationality">
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label class="col-lg-3 control-label">카테고리 :</label>
								<div class="col-lg-9">
									<input type="text" class="form-control" name="category">
								</div>
							</div>
							<div class="col-lg-12 form-group">
								<label class="col-lg-1 control-label">소개 :</label>
								<div class="col-lg-6">
									<textarea class="form-control" name="introduction" rows="10"></textarea>
								</div>
							</div>


							<div class="col-lg-6 form-group">
								<label class="col-lg-2 control-label">이미지 :</label>
								<div class="col-lg-10">
									<input type="file" class="form-control" name="file">
								</div>
							</div>
							<div class="col-lg-6 form-group">
								<label for="categoryId" class="col-lg-3 control-label">작가/번역가:</label>
								<div class="col-lg-3 category">
									<select class="form-control category" name="select">
										<option value="author">작가</option>
										<option value="translator">번역가</option>
									</select>
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
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body form-horizontal goods-form">
						<form action="<%=cp%>/admin_author.action" method="get">
							<div class="search_container" style="margin: 20px auto;">
								<div class="row">
									<div class="col-xs-8 col-xs-offset-2">
										<div class="input-group">
											<input type="text" class="form-control" name="searchValue"
												placeholder="작가 이름을 검색하세요"> <span
												class="input-group-btn">
												<button class="btn btn-default" type="submit">
													<span class="glyphicon glyphicon-search"></span>
												</button>
											</span>
										</div>
									</div>
								</div>
							</div>
						</form>

						<div class="author_table">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>no</th>
										<th>아이디</th>
										<th>이름</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="author" items="${authorList }"
										varStatus="status">
										<tr>
											<td>${(status.index + pageMaker.cri.numPerPage * (pageMaker.cri.page-1))+1 }</td>
											<td>${author.authorId }</td>
											<td>${author.authorName }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<div style="display: table; margin: 0 auto;">
							<ul class="pagination">
								<c:if test="${pageMaker.pre }">
									<li><a
										href="<%=cp %>/admin_author.action?page=${pageMaker.startPage-1}">&lt;</a></li>
								</c:if>
								<c:forEach begin="${pageMaker.startPage }"
									end="${pageMaker.endPage }" var="idx">
									<li><a
										href="<%=cp %>/admin_author.action?page=${idx}&searchValue=${pageMaker.cri.searchValue}">${idx }</a></li>
								</c:forEach>
								<c:if test="${pageMaker.nex }">
									<li><a
										href="<%=cp %>/admin_author.action?page=${pageMaker.endPage+1}&searchValue=${pageMaker.cri.searchValue}">&gt;</a></li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



</body>
</html>