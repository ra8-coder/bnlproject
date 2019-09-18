<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<c:if test="${!empty lists }">
<table>
	<tr>
		<th>상담일자</th>
		<th>상담종류</th>
		<th style="width: 467px;">제목</th>		
		<th>답변여부</th>
	</tr>
	<c:forEach var="dto" items="${lists }">
	<tr>
		<td>${dto.consultationDate }</td>
		<td>${dto.typeId }</td>
		<td style="text-align: left; padding-left: 10px;"><a href="<%=cp%>/myShopping/counselArticle.action?consultId=${dto.consultId}">${dto.subject }</a></td>
		<td>
			<c:if test="${!empty dto.answerCheck }">답변완료</c:if>
			<c:if test="${empty dto.answerCheck }">답변대기</c:if>	
		</td>
	</tr>
	</c:forEach>
</table>
<div style="text-align: center; margin-top: 10px;">
	<p>
		<c:if test="${totalDataCount!=0 }">
			${pageIndexList }
		</c:if>
		<c:if test="${totalDataCount==0 }">
		</c:if>
	</p>
</div>

</c:if>

<c:if test="${empty lists }">
<table>
	<tr>
		<th>상담일자</th>
		<th>상담종류</th>
		<th style="width: 467px;">제목</th>		
		<th>답변여부</th>
	</tr>
	<tr>
		<td colspan="4" style="height: 100px;">최근 문의 내역이 없습니다.</td>
	</tr>
</table>
</c:if>