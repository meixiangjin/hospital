<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
	<title>Frontend Homepage</title>
<body>
	<jsp:include page="/WEB-INF/pages/header.jsp"/>
	
	<c:if test="${pageContext.request.userPrincipal.name != null}">
		<h2>
			${pageContext.request.userPrincipal.name} 
		</h2>
	</c:if>
	
	<jsp:include page="/WEB-INF/pages/footer.jsp"/>
</body>
</html>