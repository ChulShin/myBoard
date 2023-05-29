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
	<nav>
		<%@include file="include/nav.jsp" %>
	</nav>
	<section id="container">
	   
		<form role="form" method="post" autocomplete="off">
			<input type="hidden" id="bno" name="bno" value="${readReply.bno}" readonly="readonly" />
			<input type="hidden" id="rno" name="rno" value="${readReply.rno}" readonly="readonly" /> 
			
			<input type="hidden" id="page" name="page" value="${scri.page}" readonly="readonly" />
			<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}" readonly="readonly" />
<%-- 			<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}" readonly="readonly" /> --%>
<%-- 			<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}" readonly="readonly" /> --%>
		   
			<div class="form-group">
				<label for="content" class="col-sm-2 control-label">글 내용</label>
				<div class="col-sm-10">
					<textarea id="content" name="content" class="form-control">${readReply.content}</textarea>
				</div>
			</div>
		   
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-warning">수정</button>
					<button type="button" id="cancel_btn" class="btn btn-danger">취소</button>
		    	</div>
		    	
				<script>
				// 취소 버튼 클릭
				$("#cancel_btn").click(function(){
					self.location = "/board/read?bno=${readReply.bno}"
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
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>