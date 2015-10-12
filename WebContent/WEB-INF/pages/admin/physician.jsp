<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
	<title>Admin Physician</title>
<body>
	<jsp:include page="/WEB-INF/pages/header_admin.jsp"/>
	
	<c:if test="${pageContext.request.userPrincipal.name != null}">
		<h3 style="text-align: center;">Physician Administration</h3>
		<br>
		<div style="align:center;width:100%" >
		 	<table border="1" align="center" style="color: white">
				<tr>
				<th>ID</th>
				<th>Firstname</th>
				<th>Lastname</th>
				<th>Address</th>
				<th>Phone</th>
				<th>Email</th>
				<th>Spec ID</th>
				<th>Dept ID</th>
				<th>Username</th>
				<th>First Login</th>
				<th>Active</th>
				<th></th>
				<th></th>
				</tr>
				<c:forEach var="element" items="${listData}">
			        <tr>
			        	<td>${element.id}</td>
			        	<td>${element.firstname}</td>
			        	<td>${element.lastname}</td>
			        	<td>${element.address}</td>
			        	<td>${element.phone}</td>
			        	<td>${element.email}</td>
			        	<td>${element.specId}</td>
			        	<td>${element.deptId}</td>
			        	<td>${element.username}</td>
			        	<td>${element.firstLogin}</td>
			        	<td>${element.active}</td>
			            <td><a href="${pageContext.request.contextPath}/admin/physician_add?id=${element.id}"><font color="FF00CC">Update</font></a></td> 
			            <td><a href="${pageContext.request.contextPath}/admin/physician?id=${element.id}"><font color="FF00CC">Delete</font></a></td>
			        </tr> 
			    </c:forEach>
			</table> 
		</div>
		<br/>
		<div style="text-align:center;width:100%" >
			<form name='addPhysicianForm'
					action="<c:url value='/admin/physician_add' />" method='GET'>
				<input name="submit" type="submit" value="Add Physician" />
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
	</c:if>
	
	<jsp:include page="/WEB-INF/pages/footer.jsp"/>
</body>
</html>