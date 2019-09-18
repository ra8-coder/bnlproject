<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<table>
	<tr>
		<th>적립일/사용일</th>
		<th>주문번호</th>
		<th style="width: 380px;">내역</th>	
		<th>구분</th>
		<th>금액</th>
	</tr>
	<c:if test="${empty lists }">
	<tr height="100px;">
		<td colspan="5">내역이 없습니다.</td>
	</tr>
	</c:if>
	
	<c:forEach var="dto" items="${lists }">
	<tr>
		<td>${dto.savingDate }</td>
		<td>
			<c:if test="${dto.orderId==0 }"></c:if>
			<c:if test="${dto.orderId!=0 }">${dto.orderId }</c:if>
		</td>
		<td style="text-align: left;">${dto.pointItem }</td>
		<td>
			<c:if test="${dto.value>0 }">적립</c:if>
			<c:if test="${dto.value<0 }"><span class="point_red">차감</span></c:if>
		</td>	
		<td>
			<c:if test="${dto.value>0 }">
				<fmt:formatNumber value="${dto.value }" pattern="#,###"/>원
				</c:if>
			<c:if test="${dto.value<0 }">
				<span class="point_red">
					<fmt:formatNumber value="${dto.value }" pattern="#,###"/>원
				</span>
			</c:if>
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