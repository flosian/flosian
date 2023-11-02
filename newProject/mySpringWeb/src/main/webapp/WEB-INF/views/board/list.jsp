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
	<h2> Board List </h2>
	<!-- 검색 -->
	<form action="/board/list" method="get">
	
		<div class="input-group mb-3">
			<c:set value="${ph.pgvo.type }" var="typed" />
		  	<select class="form-select w-15" name="type">
			  <option ${typed eq null ? 'selected':''}>Choose</option>
			  <option ${typed eq 't' ? 'selected':''} value="t">Title</option>
			  <option ${typed eq 'w' ? 'selected':''} value="w">Writer</option>
			  <option ${typed eq 'c' ? 'selected':''} value="c">Content</option>
			  <option ${typed eq 'tw' ? 'selected':''} value="tw">Title + Writer</option>
			  <option ${typed eq 'tc' ? 'selected':''} value="tc">Title + Content</option>
			  <option ${typed eq 'twc' ? 'selected':''} value="twc">Title + Writer + Content</option>
			</select>
			<input type="search" class="form-control w-50" name="keyword" value="${ph.pgvo.keyword }">
			<input type="hidden" name="pageNo" value="1">
			<input type="hidden" name="qty" value="${ph.pgvo.qty }">
			<button type="submit" class="btn btn-dark">
				Search
				<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
					${ph.totalCount }
				</span>
			</button>
			
		</div>
	</form>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th>#</th>
				<th>Title</th>
				<th>Writer</th>
				<th>Reg_Date</th>
				<th>Read_Count</th>
				<th>Comments</th>
				<th>Files</th>
			</tr>
		</thead>
		<tbody class="table-group-divider">
			<c:forEach items="${list }" var="list">
			<tr>
				<td><a href="/board/detail?bno=${list.bno }">${list.bno }</a></td>
				<td><a href="/board/detail?bno=${list.bno }">${list.title }</a></td>
				<td>${list.writer }</td>
				<td>${list.regAt }</td>
				<td>${list.readCount }</td>
				<td>${list.cmtQty }</td>
				<td>${list.hasFile }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 페이지네이션 -->
	<nav aria-label="Page navigation example">
	  <ul class="pagination">
	  <!-- 이전 페이지 -->
	    <li class="page-item ${ph.prev eq false ? 'disabled':'' }">
	      <a class="page-link" href="/board/list?pageNo=${ph.startPage-1}&qty=${ph.pgvo.qty}&keyword=${ph.pgvo.keyword}&type=${ph.pgvo.type}" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	    </li>
	    
	    <!-- 페이지번호 -->
	    <c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
	    	<li class="page-item ${ph.pgvo.pageNo eq i ? 'active':''}"><a class="page-link" href="/board/list?pageNo=${i}&qty=${ph.pgvo.qty}&keyword=${ph.pgvo.keyword}&type=${ph.pgvo.type}">${i }</a></li>
	    </c:forEach>
	    
	    <!-- 다음페이지 -->
	    <li class="page-item ${ph.next eq false ? 'disabled':'' }">
	      <a class="page-link" href="/board/list?pageNo=${ph.endPage+1}&qty=${ph.pgvo.qty}&keyword=${ph.pgvo.keyword}&type=${ph.pgvo.type}" aria-label="Next">
	        <span aria-hidden="true">&raquo;</span>
	      </a>
	    </li>
	  </ul>
	</nav>
</div>

<script type="text/javascript">
const isDel = `<c:out value="${isDel}" />`;
if(isDel > 0){
	Swal.fire({
		icon: 'success',
		text: '게시글이 삭제되었습니다.'
	})
}
</script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>