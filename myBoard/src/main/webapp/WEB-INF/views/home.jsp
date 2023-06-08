<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<!-- <div id="root"> -->
<div class="container">
	<header>
		<%@include file="board/include/header.jsp" %>
	</header>
	
	<ul class="nav nav-pills">
		<%-- <li><a href="/board/list">글 목록</a></li>
		<li><a href="/board/listPage">글 목록+페이지</a></li> --%>
		<li><a href="/board/listSearch" class="btn btn-dark" style="margin: 5px">글 목록</a></li>
		<c:if test="${member != null}">
			<li><a href="/board/write" class="btn btn-dark" style="margin: 5px">글 작성</a></li>
			<li><a href="/member/logout" class="btn btn-dark" style="margin: 5px">로그아웃</a></li>
		</c:if>
	</ul>
	
	<c:if test="${member == null}">
	<form role="form" method="post" autocomplete="off" action="/member/login">
		<div class="input-form-box">
			<label for="userId" class="col-sm-2 col-form-label">아이디</label>
			<div class="col-sm-3">
				<input type="text" id="userId" name="userId" class="form-control" />
			</div>
		</div>
		<div class="input-form-box">
			<label for="userPass" class="col-sm-2 col-form-label">패스워드</label>
			<div class="col-sm-3">
				<input type="password" id="userPass" name="userPass" class="form-control" />
			</div>
		</div>
		<div class="form-group col-sm-5 d-flex justify-content-between">
		  <button type="submit" class="btn btn-primary">로그인</button>
		  <button type="button" id="register-button" class="btn btn-primary">회원가입</button>
		</div>
		<script>
			$('#register-button').click(function(){
				self.location = "/member/register"
			});
		</script>
	</form>
	</c:if>
	
	<c:if test="${msg == 'login_error'}">
		<p id="login_fail" style="color:#f00;">로그인에 실패했습니다. 아이디 또는 패스워드를 다시 입력해주세요.</p>
		<script>
			$("input#userId, input#userPass").keyup(function(e){
				$("p#login_fail").attr("style", "display: none");
			});
		</script>
	</c:if>
	
	<c:if test="${member != null}">
		
		<a href="/member/myPage" class="btn btn-primary" style="margin-left: 5px;">마이페이지</a>
		<a href="/member/modify" class="btn btn-primary" style="margin-left: 5px;">회원정보 수정</a>
		<a href="/member/withdrawal" class="btn btn-primary" style="margin-left: 5px;">회원탈퇴</a>
		
	</c:if>
</div>
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<c:if test="${msg == 'register_success'}">
	<script>
		alert('회원가입에 성공했습니다.');
	</script>
</c:if>
<c:if test="${msg == 'register_error'}">
	<script>
		alert('회원가입에 실패했습니다.');
	</script>
</c:if>
<c:if test="${msg == 'POST_write_error'}">
	<script>
		alert('비정상적인 접근입니다.');
	</script>
</c:if>
<c:if test="${msg == 'modifyPOST_success'}">
	<script>
		alert('회원정보 수정이 완료됐습니다.');
	</script>
</c:if>
<c:if test="${msg == 'withdrawalPOST_success'}">
	<script>
		alert('회원탈퇴가 완료됐습니다.');
	</script>
</c:if>
</body>
</html>