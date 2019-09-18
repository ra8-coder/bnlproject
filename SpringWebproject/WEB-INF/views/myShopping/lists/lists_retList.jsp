<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<table>
	<tr>
		<th>주문번호</th>
		<th>처리일자</th>
		<th style="width: 380px;">상품명</th>	
		<th>취소/환불금액</th>
		<th>현황</th>
	</tr>
	<c:if test="${empty lists }">
	<tr height="100px;">
		<td colspan="5">취소/반품/교환 내역이 없습니다.</td>
	</tr>
	</c:if>
	
	<c:forEach var="dto" items="${lists }">
	<tr>
		<td>${dto.orderId }</td>
		<td>${dto.handlingDate }</td>
		<c:if test="${dto.quantity>1 }">
			<td style="text-align: left;"><a href="<%=cp%>/myShopping/myOrderDetail.action?orderId=${dto.orderId}">${dto.mainTitle } 외 ${dto.quantity-1 }개</a></td>
		</c:if>
		<c:if test="${dto.quantity==1 }">
			<td style="text-align: left;"><a href="<%=cp%>/myShopping/myOrderDetail.action?orderId=${dto.orderId}">${dto.mainTitle }</a></td>
		</c:if>	
		<td><fmt:formatNumber value="${dto.orderPrice }" pattern="#,###"/></td>
		<td>${dto.status }</td>	
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
