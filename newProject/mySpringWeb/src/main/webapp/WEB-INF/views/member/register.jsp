<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<h2 class="container"> Member Register </h2>
<form class="container" action="/member/register" method="post">
	<div class="input-group mb-3">
	  <span class="input-group-text">email</span>
	  <input type="email" class="form-control" name="email" placeholder="email" required="required">
	</div>
	<div class="input-group mb-3">
	  <span class="input-group-text">pwd</span>
	  <input type="password" class="form-control" name="pwd" placeholder="pwd" required="required">
	</div>
	<div class="input-group">
	  <span class="input-group-text">NickName</span>
	  <input type="text" class="form-control" name="nickName" placeholder="nickName" required="required">
	</div>
	<button type="submit" class="btn btn-primary" id="regBtn">등록</button>
</form>
<jsp:include page="../common/footer.jsp" />
</body>
</html>