<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="ko">
<head>
	<title>chuls 게시판</title>
	
	<!-- 제이쿼리 -->
	<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
	
	<!-- Bootstrap CDN -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/home.css">
</head>
<body>
<div class="container">
	<header>
		<%@include file="../board/include/header.jsp" %>
	</header>
	<form role="form" method="post" autocomplete="off">
		<div class="input-form-box">
			<label for="userId" class="col-sm-2 col-form-label">아이디</label>
			<div class="col-sm-3">
				<input type="text" id="userId" name="userId" value="${member.userId}" class="form-control" readonly="readonly" />
			</div>
		</div>
		<div class="input-form-box">
			<label for="userPass" class="col-sm-2 col-form-label">새로운 패스워드</label>
			<div class="col-sm-3">
				<input type="password" id="userPass" name="userPass" class="form-control" required="required"/>
			</div>
		</div>
		<div class="form-group col-sm-5 d-flex justify-content-between">
			<button type="submit" class="btn btn-primary">회원정보 수정</button>
			<a href="/" class="btn btn-primary">처음으로</a>
		</div>
	</form>
</div>
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<c:if test="${msg == 'modifyPOST_error'}">
	<script>
		alert('새로운 패스워드가 적절하지 않습니다(공백 불가).');
	</script>
</c:if>
</body>
</html>