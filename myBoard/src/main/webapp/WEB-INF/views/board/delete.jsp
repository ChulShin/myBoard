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
	   
		<form role="form" method="post" autocomplete="off">
	    
			<div class="form-group">
				<label for="bno" class="control-label">글 번호</label>
				<div class="col-sm-2">
					<input type="text" id="bno" name="bno" class="form-control" value="${delete}" readonly="readonly" />
				</div>
			</div>
			<br>
			<p>정말로 삭제하시겠습니까?</p>
			
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-danger">예, 삭제합니다.</button>
					<button type="button" id="cancel_btn" class="btn btn-warning">아니오, 삭제하지 않습니다.</button>
				</div>
				
				<script>
				
				// 폼을 변수에 저장
				var formObj = $("form[role='form']"); 
				
				// 취소 버튼 클릭
				$("#cancel_btn").click(function(){
					self.location = "/board/read?bno=${delete}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}";
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