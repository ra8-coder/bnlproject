<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<c:if test="${!empty lists }">
<table>
	<tr>
		<th>적립일</th>
		<th style="width: 500px;">내역</th>
		<th>소멸예정금액</th>
		<th>소멸일자</th>
	</tr>
	<c:forEach var="dto" items="${lists }">
	<tr>	
		<td>${dto.savingDate }</td>
		<td>${dto.pointItem }</td>
		<td><fmt:formatNumber value="${dto.leftValue }" pattern="#,###"/>원</td>
		<td>${dto.expirationDate }</td>		
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
		<th>적립일</th>
		<th style="width: 500px;">내역</th>
		<th>소멸예정금액</th>
		<th>소멸일자</th>
	</tr>
	<tr>
		<td colspan="4" style="height: 100px; line-height: 10;"> 소멸 예정 적립금 내역이 없습니다. </td>
	</tr>
</table>
</c:if>