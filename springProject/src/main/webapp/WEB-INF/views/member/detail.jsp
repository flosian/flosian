<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
<form action="/member/modify" method="post">
	<table class="table table-hover">
		<tr>
			<th>Email</th>
			<td><input type="hidden" name="email" value="${mvo.email}">${mvo.email }</td>
		</tr>
		<tr>
			<th>PWD</th>
			<td><input type="text" name="pwd"></td>
		</tr>
		<tr>
			<th>NickName</th>
			<td><input type="text" name="nickName" value="${mvo.nickName }"></td>
		</tr>
		<tr>
			<th>Reg_Date</th>
			<td>${mvo.regAt }</td>
		</tr>
		<tr>
			<th>Last_Login</th>
			<td>${mvo.lastLogin }</td>
		</tr>
	</table>
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.mvo.email" var="authEmail"/>
		<c:if test="${authEmail eq mvo.email}">
			<button type="submit">수정</button>
			<a href="/member/remove?email=${authEmail}"><button type="button">회원탈퇴</button></a>
		</c:if>
	</sec:authorize>
</form>
<jsp:include page="../common/footer.jsp" />
</body>
</html>