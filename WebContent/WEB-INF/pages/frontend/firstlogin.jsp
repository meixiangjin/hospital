<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
<head>
	<link href="<c:url value="/resources/style.css" />" rel="stylesheet">
</head>
<title>Frontend First Login</title>
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
		<c:if test="${pageContext.request.userPrincipal.name != null}">
		<h2>
			Welcome : ${pageContext.request.userPrincipal.name} | <a
				href="javascript:formLogoutSubmit()"> Logout</a>
		</h2>
		</c:if>
	</div>
	</br>
	<c:if test="${pageContext.request.userPrincipal.name != null}">
		<br/>
		<h3>Welcome your first login. Please answer the following questions:</h3>
		<c:url var="submitUrl" value="/frontend/firstlogin"/>
		<form name='firstLoginForm' modelAttribute="listData"
			action="${submitUrl}" method='POST'>
			<table border="0">
			   	<c:forEach var="element" items="${listData}">
			       <tr>
			       		<td><font color="white">Question ${element.order} :</font></td>
			       		<td><font color="white">${element.content}</font></td>
			       </tr>
			       <tr>
			       		<td><font color="white">Answer :</font></td>
			       		<td><input type="text" name="name${element.id}" id="name${element.id}"/></td>
			       </tr>
			       <tr><td></td><td></td></tr>
			    </c:forEach>
			    <tr>
			       		<td></td>
			       		<td></td>
			       </tr>
			    <tr>
			    	<td></td>
					<td><input name="submit" type="submit"
						value="submit" /></td>
				</tr>
			</table>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		<form>
		
	</c:if>
	<c:if test="${pageContext.request.userPrincipal.name == null}">
		<h2>
			You are not authorized. Please <a
				href="${pageContext.request.contextPath}/login" type="submit"> Login </a> again .
		</h2>
	</c:if>
	</div>
	<jsp:include page="/WEB-INF/pages/footer.jsp"/>
</body>
</html>