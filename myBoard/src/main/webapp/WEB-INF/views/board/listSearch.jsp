<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="ko">
<head>
	<title>chuls 게시판</title>
	
	<!-- 제이쿼리 -->
	<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
	
	<!-- Bootstrap CDN -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	
</head>
<body>

<!-- <div id="root"> -->
<div class="container">
	<header>
		<%@include file="include/header.jsp" %>
	</header>
	
	<%@include file="include/nav.jsp" %>
	
	<section id="container">
		<h2>글 목록</h2>
		    
		<table class="table table-hover">
			<thead>
				<tr>
					<th>글 번호</th>
					<th>글 제목</th>
					<th>작성자</th>
					<th>작성일자</th>
				</tr>
	     	</thead>
	     	<tbody>
				<!-- 목록 시작 -->
				<c:forEach items="${list}" var="item">
					<tr>
						<td>${item.bno}</td>
						<td>
							<a href="/board/read?bno=${item.bno}&
												page=${scri.page}&
												perPageNum=${scri.perPageNum}&
												searchType=${scri.searchType}&
												keyword=${scri.keyword}">
								${item.title}
							</a>
						</td>
						<td>${item.writer}</td>
						<td><fmt:formatDate value="${item.regDate}" pattern="yyyy-MM-dd" /></td>
					</tr>
				</c:forEach>
				<!-- 목록 끝 -->
     		</tbody>
		</table>

		<div class="search row my-2">
			<div class="col-sm-2">
				<select name="searchType" class="form-select">
					<option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
					<option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
					<option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
					<option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
					<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
				</select>
			</div>
			
			<div class="col-sm-10">
				<div class="input-group">
					<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control"/>
					<button id="searchBtn" class="btn btn-primary">검색</button>
				</div>
			</div>

			<script>
				$('#searchBtn').click(function() {
					search();
				});
				
				$('#keywordInput').keyup(function(e){
					if(e.keyCode == 13){
						search();
					}
				});
				
				function search() {
					if($("select option:selected").val() == 'n'){
						alert('검색 옵션을 선택해주세요.')
					} else {
						self.location = "listSearch" + '${pageMaker.makeQuery(1)}'
						+ "&searchType=" + $("select option:selected").val()
						+ "&keyword=" + encodeURIComponent($('#keywordInput').val());
					}
				}
			</script>
		</div>
		
		<div class="row my-2">
			<div class="col col-md-offset-3 d-flex justify-content-center">
				<!-- Pagination -->
		      	<nav aria-label="Page navigation">
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="page-item">
								<a class="page-link" href="listSearch${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a>
							</li>
						</c:if> 
					
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<li class="page-item ${pageMaker.cri.page == idx ? 'active' : ''}">
							<a class="page-link" href="listSearch${pageMaker.makeSearch(idx)}">${idx}</a></li>
						</c:forEach>
					
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li class="page-item">
								<a class="page-link" href="listSearch${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a>
							</li>
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
	</section>

	<c:if test="${msg == 'modify_error' or msg == 'delete_error'}">
		<script>
			alert('비정상적인 접근입니다.');
		</script>
	</c:if>
<!-- 	<footer> -->
<%-- 		<%@include file="include/footer.jsp" %> --%>
<!-- 	</footer> -->

</div>
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>