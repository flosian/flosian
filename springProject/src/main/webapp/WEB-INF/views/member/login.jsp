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
<!-- email, pwd, nick_name -->
<form action="/member/login" method="post">
	<div>
		<h4 class="mb-3">Custom Login Page</h4>
		<div class="mb-3">
		  <label for="e" class="form-label">Email</label>
		  <input type="email" class="form-control" name="email" id="e" placeholder="email" required="required">
		</div>
		<div class="mb-3">
		  <label for="p" class="form-label">Pwd</label>
		  <input type="password" class="form-control" name="pwd" id="p" placeholder="pwd" required="required">
		</div>
		<c:if test="${not empty param.errMsg}">
			<div class="text-danger mb-3">
				<c:choose>
					<c:when test="${param.errMsg eq 'Bad credentials'}">
						<c:set var="errText" value="아이디 혹은 비밀번호가 일치하지 않습니다." />
					</c:when>
					<c:otherwise>
						<c:set var="errText" value="비밀번호를 확인해주세요." />
					</c:otherwise>
				</c:choose>
				
				${errText}
			</div>
		</c:if>
		<div class="center">
			<button type="submit" class="btn btn-dark">Login</button>
		</div>
	</div>
</form>
<jsp:include page="../common/footer.jsp" />
</body>
</html>