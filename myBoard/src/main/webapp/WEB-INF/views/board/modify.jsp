<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
	<title>chuls 게시판</title>
	
	<!-- 제이쿼리 -->
	<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
	
	<!-- Bootstrap CDN -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	
</head>
<body>

<div id="root" class="container">
	<header>
		<%@include file="include/header.jsp" %>
	</header>

	<%@include file="include/nav.jsp" %>

	<section id="container">
	   
		<form role="form" method="post" action="/board/modifyPOST" autocomplete="off">
	    	
	    	<input type="hidden" id="page" name="page" value="${scri.page}" readonly="readonly"/>
	    	<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}" readonly="readonly"/>
	    	<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}" readonly="readonly"/>
	    	<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}" readonly="readonly"/>
	    
			<div class="form-group">
				<label for="bno" class="control-label">글 번호</label>
				<input type="text" id="bno" name="bno" class="form-control" value="${modify.bno}" readonly="readonly" />
			</div>
		     
			<div class="form-group">
				<label for="title" class="control-label">글 제목</label>
				<input type="text" id="title" name="title" class="form-control" value="${modify.title}" />
			</div>
			<div class="form-group">
				<label for="content" class="control-label">글 내용</label>
				<textarea id="content" name="content" class="form-control">${modify.content}</textarea>
			</div>
			<div class="form-group">
				<label for="writer" class="control-label">작성자</label>
				<input type="text" id="writer" name="writer" class="form-control" value="${modify.writer}" readonly="readonly" /><br />
				<label class="control-label">작성 날짜</label>
				<fmt:formatDate value="${modify.regDate}" pattern="yyyy-MM-dd" /> 
			</div>	
			<div class="form-group">
				<button type="submit" class="btn btn-warning">수정</button>
				<button type="button" id="cancel_btn" class="btn btn-danger">취소</button>
				
				<script>
				// 폼을 변수에 저장
				var formObj = $("form[role='form']"); 
				
				// 취소 버튼 클릭
				$("#cancel_btn").click(function(){   
					self.location = "/board/read?bno=${modify.bno}"
						   + "&page=${scri.page}"
						   + "&perPageNum=${scri.perPageNum}"
						   + "&searchType=${scri.searchType}"
						   + "&keyword=${scri.keyword}";
				});
				</script>
			</div>
	
		</form>
	</section>

	<footer>
		<%@include file="include/footer.jsp" %>
	</footer>

</div>

</body>
</html>