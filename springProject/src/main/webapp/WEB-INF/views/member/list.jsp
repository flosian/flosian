<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<table class="table table-hover container">
	<tr>
		<th>Email</th>
		<th>NickName</th>
		<th>Reg Date</th>
		<th>Last Login</th>
	</tr>
	<c:forEach items="${list }" var="mvo">
	<tr>
		<td>${mvo.email }</td>
		<td>${mvo.nickName }</td>
		<td>${mvo.regAt }</td>
		<td>${mvo.lastLogin }</td>
	</tr>
	</c:forEach>
</table>

<jsp:include page="../common/footer.jsp" />
</body>
</html>