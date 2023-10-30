<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<body>
<header>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="#">Navbar</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
	      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
	        <li class="nav-item">
	          <a class="nav-link active" aria-current="page" href="/">Home</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/board/list">Board List</a>
	        </li>
	        <!-- 현재 인증한 사용자의 정보를 가져와서 해당 권한이 있는 케이스를 open -->
	        <!-- 사용자 정보는 principal -->
	        <sec:authorize access="isAuthenticated()">
	        <sec:authentication property="principal.mvo.email" var="authEmail"/>
	        <sec:authentication property="principal.mvo.nickName" var="authNick"/>
	        <sec:authentication property="principal.mvo.authList" var="auths"/>
	        
	        <c:choose>
	        	<c:when test="${auths.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get() }">
	        	<!-- admin 계정만 할 수 있는 일을 처리 -->
	        		<li class="nav-item">
	          			<a class="nav-link" href="/member/list">ADMIN > ${authNick}(${authEmail})</a>
	        		</li>
	        	</c:when>
	        	<c:otherwise>
	        		<li class="nav-item">
	          			<a class="nav-link" href="/member/detail?email=${authEmail}">${authNick}(${authEmail})</a>
	        		</li>
	        	</c:otherwise>
	        </c:choose>
	        
	        <li class="nav-item">
	        	<a class="nav-link" href="/board/register">Board Reg</a>
	        </li>
	        
	        <!-- 로그인 해야 open 되는 메뉴 -->
	        
		    <li class="nav-item">
		    	<a class="nav-link" href="" id="logoutLink">Logout</a>
		    </li>
		    <form action="/member/logout" method="post" id="logoutForm">
		    	<input type="hidden" name="email" value="${authEmail }">
		    </form>
	        </sec:authorize>
	        <!-- 아직 로그인 전 상태에서 open 되어야 할 메뉴 -->
	        <sec:authorize access="isAnonymous()">
	        <li class="nav-item">
	          <a class="nav-link" href="/member/register">SignUp</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/member/login">Login</a>
	        </li>
	        </sec:authorize>
	        
	      </ul>
	    </div>
	  </div>
	</nav>
</header>
<script type="text/javascript">
document.getElementById('logoutLink').addEventListener('click',(e)=>{
	e.preventDefault();
	document.getElementById('logoutForm').submit();
})
</script>
</body>
</html>