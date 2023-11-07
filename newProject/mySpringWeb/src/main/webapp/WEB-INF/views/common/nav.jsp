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
<nav>
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="/">Main</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="/board/list">Board List</a>
  </li>
  <sec:authorize access="isAuthenticated()">
  <sec:authentication property="principal.mvo.email" var="authEmail"/>
  <sec:authentication property="principal.mvo.nickName" var="authNick"/>
  <sec:authentication property="principal.mvo.authList" var="auths"/>
  <c:choose>
  	<c:when test="${auths.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get()}">
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
    <a class="nav-link" href="/board/register">Board Register</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="/board/logout">Logout</a>
  </li>
  </sec:authorize>
  <sec:authorize access="isAnonymous()">
  <li class="nav-item">
    <a class="nav-link" href="/member/register">Join</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="/member/login">Login</a>
  </li>
  </sec:authorize>
</ul>
</nav>
</body>
</html>