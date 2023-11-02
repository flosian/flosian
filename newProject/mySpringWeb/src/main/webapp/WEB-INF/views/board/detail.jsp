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
<div class="container">
	<h2> Board Detail </h2>
	<table class="table table-hover">
		<tr>
			<th>#</th>
			<td>${bvo.bno }</td>
		</tr>
		<tr>
			<th>Read Count</th>
			<td>${bvo.readCount }</td>
		</tr>
		<tr>
			<th>Comments Count</th>
			<td>${bvo.cmtQty }</td>
		</tr>
		<tr>
			<th>File Count</th>
			<td>${bvo.hasFile }</td>
		</tr>
		<tr>
			<th>Reg Date</th>
			<td>${bvo.regAt }</td>
		</tr>
		<tr>
			<th>Mod Date</th>
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
	<a href="/board/modify?bno=${bvo.bno }"><button type="button" class="btn btn-primary">수정</button></a>
	<a href="/board/remove?bno=${bvo.bno }"><button type="button" class="btn btn-outline-primary">삭제</button></a>
	<a href="/board/list"><button type="button" class="btn btn-outline-primary">리스트로</button></a>
</div>
<script type="text/javascript">
const isMod = `<c:out value="${isMod}" />`;
console.log(isMod);
if(isMod > 0){
	Swal.fire({
		icon: 'success',
		text: '게시글이 수정되었습니다.'
	})
}
</script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>