<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<!DOCTYPE html>
<html>
<head>
<title>alert</title>
<script type="text/javascript">
		alert('${alertMsg}');
		location.href='<%=cp%>/${nextUrl}';
		${windowClose}
</script>
</head>
<body>

</body>
</html>