<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
	<title>Admin Physician</title>
<body>
	<jsp:include page="/WEB-INF/pages/header_admin.jsp"/>
	
	<c:if test="${pageContext.request.userPrincipal.name != null}">
		<h3 style="text-align: center;">Physician Administration</h3>
		<br>
		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<div style="margin-left: auto; margin-right: auto; width: 40%" >
			<form name='physicianForm' action="<c:url value='/admin/physician_add' />" method='POST'>
				<table>
					<tr>
						<td style="color: white;">Firstname:</td>
						<td><input type='text' name='firstname' value="${firstname}"></td>
					</tr>
					<tr>
						<td style="color: white;">Lastname:</td>
						<td><input type='text' name='lastname' value="${lastname}"></td>
					</tr>
					<tr>
						<td style="color: white;">Address:</td>
						<td><input type='text' name='address' value="${address}"></td>
					</tr>
					<tr>
						<td style="color: white;">Phone number:</td>
						<td><input type='text' name='phone' value="${phone}"></td>
					</tr>
					<tr>
						<td style="color: white;">Email:</td>
						<td><input type='text' name='email' value="${email}"></td>
					</tr>
					<tr>
						<td style="color: white;">Spec ID:</td>
						<td><input type='text' name='specId' value="${specId}"></td>
					</tr>
					<tr>
						<td style="color: white;">Dept ID:</td>
						<td><input type='text' name='deptId' value="${deptId}"></td>
					</tr>
					<tr>
						<td style="color: white;">Username:</td>
						<td><input type='text' name='username' value="${username}"></td>
					</tr>
					<tr>
						<td style="color: white;">Password:</td>
						<td><input type='password' name='password' value="${password}"/></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td style="color: white;"></td>
						<td><input name="submit" type="submit"
							value="submit" /></td>
					</tr>
				</table>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				<input type="hidden" name="id" value="${id}"/>
			</form>
		</div>
	</c:if>
	<jsp:include page="/WEB-INF/pages/footer.jsp"/>
</body>
</html>