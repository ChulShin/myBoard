<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
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
	
	<c:if test="${member != null}">
		<form role="form" method="post" autocomplete="off">
			<div class="row my-2">
				<div class="col-sm-2">
					<label for="title" class="form-label">글 제목</label>
				</div>
				<div class="col-sm-3">
					<input type="text" id="title" name="title" class="form-control" required />
				</div>
			</div>
			<div class="row my-2">
				<div class="col-sm-2">
					<label for="content" class="form-label">글 내용</label>
				</div>	
				<div class="col-sm-3">
					<textarea id="content" name="content" class="form-control" required></textarea>
				</div>
			</div>
			<div class="row my-2">
				<div class="col-sm-2">
					<label for="writer" class="form-label">작성자</label>
				</div>
				<div class="col-sm-3">
					<input type="text" id="writer" name="writer" class="form-control" value="${member.userName}" readonly="readonly"/>
				</div>
			</div>
			<div class="my-2">
				<div class="col-sm-5">
					<div class="d-flex justify-content-end">
						<button type="submit" class="btn btn-primary">작성</button>
					</div>
				</div>
			</div>    
		</form>
	</c:if>

	<c:if test="${member == null}">
		<p>로그인을 하셔야 글을 작성할 수 있습니다.</p>
		
		<p><a href="/" class="btn btn-primary">홈으로</a></p>
	</c:if>

	</section>

<!-- 	<footer> -->
<%-- 		<%@include file="include/footer.jsp" %> --%>
<!-- 	</footer> -->

</div>
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>