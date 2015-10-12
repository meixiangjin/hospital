<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<link href="<c:url value="/resources/style.css" />" rel="stylesheet">
</head>
<body>
	<c:url value="/j_spring_security_logout" var="logoutUrl" />
	<form action="${logoutUrl}" method="post" id="logoutForm">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
	</form>
	<script>
		function formLogoutSubmit() {
			document.getElementById("logoutForm").submit();
		}
	</script>
	
	<div id="container">
	<div id="header">
		<img src="<c:url value="/resources/images/header.jpg" />" alt="Hospital Management"/>	
		
	</div>
	<div id="nav">
	<c:if test="${pageContext.request.userPrincipal.name != null}">
		<ul>
			<li><a href="#">Home</a></li>
			<li><a href="#">Others</a></li>
			<li>
			<c:if test="${pageContext.request.userPrincipal.name != null}">
			<b>
				Welcome : ${pageContext.request.userPrincipal.name} | <a
					href="javascript:formLogoutSubmit()"> Logout</a>
			</b>
			</c:if>
			</li>
		</ul> 
	</c:if>
	<c:if test="${pageContext.request.userPrincipal.name == null}">
		<h2>
			You are not authorized. Please <a
				href="${pageContext.request.contextPath}/login" type="submit"> Login </a> again .
		</h2>
	</c:if>
	</div>
</body>