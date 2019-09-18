<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<script type="text/javascript">
	
	$(document).ready(function(){

		$('.wish_book_img').on('mouseover',function(){
			$(this).children('.wish_book_popup').addClass('on');
		});
		$('.wish_book_img').on('mouseleave',function(){
			$(this).children('.wish_book_popup').removeClass('on');
		});
		
	});
	
	</script>

<c:if test="${!empty lists }">
<div class="Lates_list_content">
	<c:forEach var="dto" items="${lists }">
	<ul>
		<li>
			<!-- 상단 -->
			<div>
				<!-- 체크박스 -->
				<div style="float: left;">
					<input type="checkbox" class="checkbox" name="seq" value="${dto.isbn }">
				</div>
				<!-- 이미지 -->
				<div class="wish_book_up">
					<div class="wish_book_img">
						<a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"><img alt="" src="<%=cp%>/resources/image/book/${dto.bookImage}"></a>
						<a href="<%=cp%>/book_info.action?isbn=${dto.isbn}" target="_blank" class="wish_book_popup">
							<span>새창열기</span>
						</a>
					</div>
					<div style="margin-top: 5px; text-align: center;">
						<a href="javascript:popPreview(${dto.isbn });"><img alt="미리보기" src="<%=cp%>/resources/img/myShopping/btn_comm_2.png"> </a>
					</div>
				</div>
			</div>
			<!-- 하단 -->
			<div style="margin-left: 15px;">
				<dl>
					<dt><a href="<%=cp%>/book_info.action?isbn=${dto.isbn}"><b>${dto.bookTitle }</b></a></dt>
					<dd>${dto.authorName } | ${dto.publisher }</dd>
					<dd>	
						<p>
							<span class="point_red"><b><fmt:formatNumber value="${dto.discountedPrice }" pattern="#,###"/>원</b> (${dto.discountRate }%↓+5%P)</span>
						</p>
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
<div style="text-align: center; padding-top: 100px; font-size: 12pt;">${emptyMsg }</div>
</c:if>
