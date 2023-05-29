<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
				<input type="text" id="userId" name="userId" value="${member.userId}" class="form-control" readonly="readonly"/>
			</div>
		</div>
		<div class="input-form-box">
			<label for="userName" class="col-sm-2 col-form-label">닉네임</label>
			<div class="col-sm-3">
				<input type="text" id="userName" name="userName" value="${member.userName}" class="form-control" readonly="readonly"/>
			</div>
		</div>
		<div class="input-form-box">
			<label for="regDate" class="col-sm-2 col-form-label">가입일</label>
			<div class="col-sm-3">
				<input type="text" id="regDate" name="regDate" value="${regDate}" class="form-control" readonly="readonly"/>
			</div>
		</div>
		<div class="input-form-box">
			<label for="phoneNum" class="col-sm-2 col-form-label">전화번호</label>
			<div class="col-sm-3">
				<input type="text" id="phoneNum" name="phoneNum" value="${member.phoneNum}" class="form-control" readonly="readonly"/>
			</div>
		</div>
		<div class="input-form-box">
			<label for="address" class="col-sm-2 col-form-label">주소</label>
			<div class="col-sm-3">
				<input type="text" id="address" name="address" value="${member.address}" class="form-control" readonly="readonly"/>
			</div>
		</div>
		<div class="input-form-box">
			<label for="address_detail" class="col-sm-2 col-form-label">상세 주소</label>
			<div class="col-sm-3">
				<input type="text" id="address_detail" name="address_detail" value="${member.address_detail}" class="form-control" readonly="readonly"/>
			</div>
		</div>
		<div class="input-form-box">
			<label for="intro" class="col-sm-2 col-form-label">자기소개</label>
			<div class="col-sm-3">
				<textarea id="intro" name="intro" class="form-control" readonly="readonly">${member.intro}</textarea>
			</div>
		</div>
		<div class="input-form-box">
			<label for="photo" class="col-sm-2 col-form-label">프로필 사진</label>
			<img id="photo" src="http://localhost:8080/temp/${member.fileName}" class="img-fluid rounded" alt="My image" style="max-width: 50%; height: auto;"/>
		</div>
		<div class="form-group col-sm-5 d-flex justify-content-between">
			<%-- <button type="submit" class="btn btn-primary">회원정보 수정</button> --%>
			<a href="/" class="btn btn-primary">처음으로</a>
		</div>
	</form>
</div>
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>