<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>

<c:if test="${!empty lists }">
	<div class="sentence_list_box">
		<c:forEach var="dto" items="${lists }">
		<ul>
			<li>
				<div class="sentence_head">
					<a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"><img alt="" src="<%=cp%>/resources/image/book/${dto.bookImage}"></a>
				</div>
				<div class="sentence_body">
					<b><a href="<%=cp%>/book_info.action?isbn=${dto.isbn}">${dto.bookTitle }</a></b><span>(${dto.created})</span>
					<br/>
					${dto.authorName } | ${dto.publisher } | ${dto.publishDate }<span><a href="<%=cp%>/myShopping/updateSentence.action?reviewId=${dto.reviewId}">수정</a> | <a href="javascript:deleteSentence('${dto.reviewId }');">삭제</a></span>
					<br/><br/>
					${dto.sentence }
				</div>
			</li>
		</ul>
		</c:forEach>	
	</div>
	<div style="text-align: center; clear: both; margin-top: 10px;">
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
<div style="text-align: center; height: 150px; font-size: 12pt; line-height: 15;">
	등록된 간단평이 없습니다.
</div>
</c:if>