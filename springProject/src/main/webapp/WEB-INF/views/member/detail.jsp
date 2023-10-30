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
	<table class="table table-hover">
		<tr>
			<th>#</th>
			<td>${bvo.bno }</td>
		</tr>
		<tr>
			<th>Read_Count</th>
			<td>${bvo.readCount }</td>
		</tr>
		<tr>
			<th>Reg_Date</th>
			<td>${bvo.regAt }</td>
		</tr>
		<tr>
			<th>Mod_Date</th>
			<td>${bvo.modAt }</td>
		</tr>
		<tr>
			<th>Title</th>
			<td>${bvo.title }</td>
		</tr>
		<tr>
			<th>Writer</th>
			<td>${bvo.writer }</td>
		</tr>
		<tr>
			<th>Content</th>
			<td>${bvo.content }</td>
		</tr>
	</table>
<jsp:include page="../common/footer.jsp" />
</body>
</html>