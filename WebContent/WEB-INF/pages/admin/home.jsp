<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
	<title>Admin Homepage</title>
<body>
	<jsp:include page="/WEB-INF/pages/header_admin.jsp"/>
	
	<c:if test="${pageContext.request.userPrincipal.name != null}">
		<h2 style="text-align: center;">
			${pageContext.request.userPrincipal.name} 
		</h2>
	</c:if>
	
	<jsp:include page="/WEB-INF/pages/footer.jsp"/>
</body>
</html>