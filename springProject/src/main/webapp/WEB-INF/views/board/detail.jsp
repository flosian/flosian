<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<div class="container">
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
			</li>
			</c:forEach>
		</ul>
	</div>
	
	<a href="/board/modify?bno=${bvo.bno}"><button type="button" class="btn btn-dark">수정</button></a>
	<a href="/board/remove?bno=${bvo.bno}"><button type="button" class="btn btn-outline-danger">삭제</button></a>
	<br><br>

</div>
	<!-- 댓글라인 -->
	<div class="container">
		<div class="input-group mb-3">
		
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal.mvo.email" var="authEmail"/>
				<span class="input-group-text" id="cmtWriter">${authEmail}</span>	
			</sec:authorize>
			<sec:authorize access="isAnonymous()">
				<span class="input-group-text" id="cmtWriter">Writer</span>		
			</sec:authorize>
				<input type="text" class="form-control" placeholder="Comment Content" id="cmtTxt">
				<button type="button" class="btn btn-success" id="cmtPostBtn">Post</button>
		</div>	

		<!-- 댓글 표시 라인 -->
		<ul class="list-group list-group-flush" id="cmtListArea">
			<li class="list-group-item">
				<div class="mb-3">
					<div class="fw-bold">Writer</div>Content
					<span class="badge rounded-pill text-bg-dark">modAt</span>
				</div>
				<button type="button" class="modBtn">%</button>
				<button type="button" class="delBtn">X</button>
			</li>
		</ul>
		
		<!-- 댓글 페이징 라인 -->
		<div>
			<div>
				<button type="button" id="moreBtn" data-page="1"
				 class="btn btn-outline-dark" style="visibility:hidden;">MORE+</button>
			</div>
		</div>
		
		<div class="modal" id="myModal" tabindex="-1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title">Writer</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      
		      <div class="modal-body">
		        <div class="input-group mb-3">
		        	<input type="text" class="form-control" placeholder="Comment Content" id="cmtTxtMod">
					<button type="button" class="btn btn-success" id="cmtModBtn">Post</button>
		        </div>
		      </div>
		      
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Save changes</button>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
<script>
const isMod = `<c:out value="${isMod}" />`;
if(parseInt(isMod)>0){
	alert('수정되었습니다');
}

let bnoVal = `<c:out value="${bvo.bno}" />`;
console.log(bnoVal);

</script>
<script type="text/javascript" src="/resources/js/boardComment.js"></script>
<script>
getCommentList(bnoVal);
</script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>