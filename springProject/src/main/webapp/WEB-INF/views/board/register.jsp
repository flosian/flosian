<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<sec:authentication property="principal.mvo.email" var="authEmail"/>
<form action="/board/register" method="post" enctype="multipart/form-data">
	<div class="mb-3">
	  <label for="t" class="form-label">Title</label>
	  <input type="text" class="form-control" name="title" id="t" placeholder="title" required="required">
	  <span id="checkTitle"></span>
	</div>
	<div class="mb-3">
	  <label for="w" class="form-label">Writer</label>
	  <input type="text" class="form-control" name="writer" id="w" value="${authEmail}" readonly="readonly">
	</div>
	<div class="mb-3">
	  <label for="c" class="form-label">Content</label>
	  <textarea class="form-control" name="content" id="c content" rows="3" required="required"></textarea>
	  <span id="checkContent"></span>
	</div>
	<div class="mb-3">
	  <input type="file" class="form-control" name="files" id="files" style="display:none;" multiple="multiple">
	  <!-- input button trigger 용도의 button -->
	  <button type="button" id="trigger" class="btn btn-outline-primary">File Upload</button>
	</div>
	<div class="mb-3" id="fileZone">
	<!-- 첨부파일 표시될 구역 -->
	</div>
	<button type="submit" class="btn btn-dark" id="regBtn">등록</button>
</form>

<script type="text/javascript">
const checkEmpty = `<c:out value="${checkEmpty}" />`;
if(checkEmpty>0){
	alert('비었음');
}
</script>
<script type="text/javascript" src="/resources/js/boardRegister.js"></script>
<script type="text/javascript" src="/resources/js/emptyInput.js"></script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>