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
			<th>Read Count</th>
			<td>${bvo.readCount }</td>
		</tr>
		<tr>
			<th>Comments Count</th>
			<td>${bvo.cmtQty }</td>
			<th>File Count</th>
			<td>${bvo.hasFile }</td>
		</tr>
		<tr>
			<th>Reg Date</th>
			<td>${bvo.regAt }</td>
			<th>Mod Date</th>
			<td>${bvo.modAt }</td>
		</tr>
		<tr>
			<th>Title</th>
			<td colspan="3">${bvo.title }</td>
		</tr>
		<tr>
			<th>Writer</th>
			<td colspan="3">${bvo.writer }</td>
		</tr>
		<tr>
			<th>Content</th>
			<td colspan="3">${bvo.content }</td>
		</tr>
	</table>
	<a href="/board/modify?bno=${bvo.bno }"><button type="button" class="btn btn-primary">수정</button></a>
	<a href="/board/remove?bno=${bvo.bno }"><button type="button" class="btn btn-outline-primary">삭제</button></a>
	<a href="/board/list"><button type="button" class="btn btn-outline-primary">리스트로</button></a>
	<br><br><br>
	
	<!-- 앳글 입력 -->
	<div class="input-group mb-3">
		<span class="input-group-text" id="writer">Unknown</span>
		<input type="text" class="form-control" placeholder="comment" id="comment">
		<button class="btn btn-outline-secondary" type="button" id="cmtBtn">Button</button>
	</div>
	
	<!-- 댓글 목록 -->
	<ul class="list-group list-group-flush" id="cmtUl">
		<li class="list-group-item">
			<div class="ms-2 me-auto">
				Writer
				<span class="badge bg-primary rounded-pill">Reg_date</span>
				<p>Comment</p>
			</div>
		</li>
	</ul>
	
	<!-- 댓글 수정 모달창 -->
	<div class="modal fade" id="exampleModal" tabindex="-1">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title fs-5" id="exampleModalLabel">Writer</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <input type="text" id="modCmtInput" placeholder="Comment Content">
	        <button type="button" id="modBtn" class="btn btn-primary">완료</button>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
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
let bnoVal = `<c:out value="${bvo.bno}" />`;
</script>
<script type="text/javascript" src="/resources/js/boardComment.js"></script>
<script type="text/javascript">
spreadComment(bnoVal);
</script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>