<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<form class="container" action="/board/modify" method="post" enctype="multipart/form-data">
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
		<tr>
			<th>File</th>
			<td colspan="3">
				<ul class="list-group">
				<c:forEach items="${flist }" var="fvo">
					<c:choose>
						<c:when test="${fvo.fileType > 0 }">
							<img alt="그림없음" src="/upload/${fn: replace(fvo.saveDir, '\\', '/')}/${fvo.uuid}_th_${fvo.fileName}">
							<div class="mb-3">
								<div class="fw-bold">${fvo.fileName }</div>
    							<span class="badge bg-primary rounded-pill">${fvo.fileSize }Byte</span>
							</div>
						</c:when>
						<c:otherwise>
							<div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</ul>
			</td>
		</tr>
	</table>
	<div class="mb-3" id="fileZone">
		<!-- 첨부파일 표시 구역 -->
	</div>
	<div class="d-grid gap-2 col-6 mx-auto">
		<input type="file" name="files" id="files" style="display:none;" multiple="multiple">
		<button class="btn btn-outline-secondary" type="button" id="trigger">File Upload</button>
		<button type="submit" class="btn btn-primary">수정</button>
	</div>
</form>
<script type="text/javascript" src="/resources/js/boardRegister.js"></script>
<jsp:include page="../common/footer.jsp" />

</body>
</html>