<%@ page contentType="text/xml; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<result>
  <data> 
  <c:forEach var="dto" items="${lists }">
  	 <userName>${dto.userName}</userName>
	 <sentence>${dto.sentence}</sentence>
	 <thumbUp>${dto.thumbUp}</thumbUp>
	 <reviewId>${dto.reviewId}</reviewId>
   </c:forEach>
  </data> 
</result>