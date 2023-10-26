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
<form action="/board/modify" method="post" enctype="multipart/form-data">
	<table class="table table-hover">
		<tr>
			<th>#</th>
			<td><input type="hidden" name="bno" value="${bvo.bno }">${bvo.bno }</td>
		</tr>
		<tr>
			<th>Reg_Date</th>
			<td><input type="text" name="reg_at" value="${bvo.regAt }" readonly="readonly"></td>
		</tr>
		<tr>
			<th>Mod_Date</th>
			<td><input type="text" name="mod_at" value="${bvo.modAt }" readonly="readonly"></td>
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
			<td><textarea name="content" rows="3">${bvo.content }</textarea></td>
		</tr>
	</table>
	<div class="mb-3">
	  <input type="file" class="form-control" name="files" id="files" style="display:none;" multiple="multiple">
	  <!-- input button trigger 용도의 button -->
	  <button type="button" id="trigger" class="btn btn-outline-primary">File Upload</button>
	</div>
	<div class="mb-3" id="fileZone">
	<!-- 첨부파일 표시될 구역 -->
	</div>
	<!-- 파일 표시 라인 -->
	<div>
	file
		<ul class="list-group">
		
			<c:forEach items="${file }" var="fvo">
  			<li class="list-group-item d-flex justify-content-between align-items-center">
				<c:choose>
					<c:when test="${fvo.fileType > 0 }">
						<img alt="그림 없음" src="/upload/${fn: replace(fvo.saveDir, '\\', '/')}/${fvo.uuid}_th_${fvo.fileName}">
					
						<div class="ms-2 me-auto">
							<div class="fw-bold">${fvo.fileName}</div>
				    		<span class="badge bg-primary rounded-pill">${fvo.fileSize }Byte</span>
				    	</div>
					</c:when>
					<c:otherwise>
						<div>
							<!-- file 아이콘 모양 -->
						</div>
					</c:otherwise>
				</c:choose>
		    	<button type="button" class="fileDelBtn" data-uuid="${fvo.uuid }">X</button>
			</li>
			</c:forEach>
		</ul>
	</div>
	<button type="submit" id="regBtn">수정</button>
</form>
<script type="text/javascript" src="/resources/js/boardRegister.js"></script>
<script type="text/javascript" src="/resources/js/fileDelete.js"></script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>