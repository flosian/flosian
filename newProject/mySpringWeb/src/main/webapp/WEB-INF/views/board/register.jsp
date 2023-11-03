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
<h2 class="container"> Board Register </h2>
<form class="container" action="/board/register" method="post" enctype="multipart/form-data">
	<div class="input-group mb-3">
	  <span class="input-group-text" id="basic-addon1">Title</span>
	  <input type="text" class="form-control" name="title" placeholder="Title">
	</div>
	<div class="input-group mb-3">
	  <span class="input-group-text" id="basic-addon1">Writer</span>
	  <input type="text" class="form-control" name="writer" placeholder="Writer">
	</div>
	<div class="input-group">
	  <span class="input-group-text">Content</span>
	  <textarea class="form-control" name="content"></textarea>
	</div><br>
	<div class="d-grid gap-2 col-6 mx-auto">
		<input type="file" id="file" style="display:none;" multiple="multiple">
		<button class="btn btn-outline-secondary" type="button" id="trigger">File Upload</button>
		<button type="submit" class="btn btn-primary">등록</button>
	</div>
</form>
<script type="text/javascript" src="/resources/js/boardRegister.js"></script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>