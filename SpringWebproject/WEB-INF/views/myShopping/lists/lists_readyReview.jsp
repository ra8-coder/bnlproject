<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<c:if test="${!empty lists }">

<div class="ready_review_list">
<c:forEach var="dto" items="${lists }">
<ul>
	<li>
		<!-- 상단 -->
		<!-- 이미지 -->
		<div class="ready_review_up">
			<div class="ready_review_img">
				<a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"><img alt="" src="<%=cp%>/resources/image/book/${dto.bookImage }"></a>
			</div>
		</div>
		<!-- 하단 -->
		<div>
			<dl>
				<dt><a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"><b>${dto.bookTitle }</b></a></dt>
				<dd>
					<c:if test="${empty dto.reviewTitle }">
						<input type="button" value="리뷰쓰기" class="review_btn" onclick="javascript:location.href='<%=cp%>/book_review_created.action?isbn=${dto.isbn }';">
					</c:if>	
				</dd>
				<dd style="margin-left: 5px;">
					<c:if test="${empty dto.sentence }">
					<input type="button" value="간단평 쓰기" class="review_btn" onclick="javascript:location.href='<%=cp%>/myShopping/createSentence.action?isbn=${dto.isbn }';">
					</c:if>
				</dd>
			</dl>
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
	<div style="font-size: 12pt; text-align: center; height: 100px; line-height: 10;">
		리뷰를 기다리는 책이 없습니다.
	</div>
</c:if>