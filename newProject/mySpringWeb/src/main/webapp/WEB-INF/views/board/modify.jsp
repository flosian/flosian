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
<h2 class="container"> Board Modify </h2>
<form class="container" action="/board/modify" method="post">
	<table class="table table-hover">
		<tr>
			<th>#</th>
			<td><input type="hidden" name="bno" value="${bvo.bno }">${bvo.bno }</td>
		</tr>
		<tr>
			<th>Reg Date</th>
			<td><input type="hidden" name="regAt" value="${bvo.regAt }">${bvo.regAt }</td>
		</tr>
		<tr>
			<th>Mod Date</th>
			<td><input type="hidden" name="modAt" value="${bvo.modAt }">${bvo.modAt }</td>
		</tr>
		<tr>
			<th>Title</th>
			<td><input type="text" name="title" value="${bvo.title }"></td>
		</tr>
		<tr>
			<th>Writer</th>
			<td><input type="text" name="writer" value="${bvo.writer }"></td>
		</tr>
		<tr>
			<th>Content</th>
			<td><textarea class="form-control" name="content">${bvo.content }</textarea></td>
		</tr>
	</table>
	<button type="submit" class="btn btn-primary">수정</button>
</form>
<jsp:include page="../common/footer.jsp" />

</body>
</html>