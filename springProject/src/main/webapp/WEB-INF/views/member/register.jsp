<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
form, .center{
	display: flex;
	justify-content: center;
}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<!-- email, pwd, nick_name -->
<form action="/member/register" method="post">
	<div>
		<h4 class="mb-3">Input Your Information</h4>
		<div class="mb-3">
		  <label for="e" class="form-label">Email</label>
		  <input type="email" class="form-control" name="email" id="e" placeholder="email" required="required">
		</div>
		<div class="mb-3">
		  <label for="p" class="form-label">Pwd</label>
		  <input type="password" class="form-control" name="pwd" id="p" placeholder="pwd" required="required">
		</div>
		<div class="mb-3">
		  <label for="n" class="form-label">Nick_Name</label>
		  <input type="text" class="form-control" name="nickName" id="n" placeholder="nickName" required="required">
		</div>
		<div class="center">
			<button type="submit" class="btn btn-dark" id="regBtn">Register</button>
		</div>
	</div>
</form>
<jsp:include page="../common/footer.jsp" />
</body>
</html>