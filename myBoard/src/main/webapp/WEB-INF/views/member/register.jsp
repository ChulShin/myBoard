<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<html lang="ko">
<head>
	<title>chuls 게시판</title>
	
	<!-- 제이쿼리 -->
	<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<!-- Bootstrap CDN -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

	<style>
	.row {
		margin-bottom: 5px;
	}
	</style>

</head>
<body>
<div class="container">
	<header>
		<%@include file="../board/include/header.jsp" %>
	</header>
	<nav>
		<%@include file="../board/include/nav.jsp" %>
	</nav>
	<form role="form" method="post" enctype="multipart/form-data" autocomplete="off">
		<div class="row">
			<div class="col-sm-2">
				<label for="userId" class="form-label">아이디</label>
			</div>
			<div class="col-sm-6">
				<div class="input-group">
					<div class="col-sm-6">
						<input type="text" id="userId" name="userId" class="form-control" required/>
					</div>
					<button type="button" class="idCheck btn btn-primary">아이디 확인</button>
				</div>
			</div>
		</div>
		<p class="result">
			<span id="idChk_msg">아이디를 확인해주십시오.</span>
		</p>
		<div class="row">
			<div class="col-sm-2">
				<label for="userPass" class="form-label">패스워드</label> 
			</div>
			<div class="col-sm-3">
				<input type="password" id="userPass" name="userPass" class="form-control" required />
			</div>
		</div>
		<div class="row">
			<div class="col-sm-2">
				<label for="userName" class="form-label">닉네임</label>
			</div>
			<div class="col-sm-6">
				<div class="input-group">
					<div class="col-sm-6">
						<input type="text" id="userName" name="userName" class="form-control" required>
					</div>
					<button type="button" class="userNameCheck btn btn-primary">닉네임 확인</button>
				</div>
			</div>
		</div>
		<p class="result">
			<span id="userNameChk_msg">닉네임을 확인해주십시오.</span>
		</p>
		<div class="row">
			<div class="col-sm-2">
				<label for="phoneNum" class="form-label">전화번호</label>
			</div>
			<div class="col-sm-3">
				<input type="text" id="phoneNum" name="phoneNum" class="form-control" required />
			</div>
		</div>
		<div class="row">
			<div class="col-sm-2">
				<label for="address" class="form-label">주소</label>
			</div>
			<div class="col-sm-3">
				<input type="text" id="address" name="address" class="form-control" required />
			</div>
		</div>
		<div class="row">
			<div class="col-sm-2">
				<label for="address_detail" class="form-label">상세 주소</label>
			</div>
			<div class="col-sm-3">
				<input type="text" id="address_detail" name="address_detail" class="form-control" required />
			</div>
		</div>
		<div class="row">
			<div class="col-sm-2">
				<label for="intro" class="form-label">자기소개</label>
			</div>
			<div class="col-sm-3">
				<textarea id="intro" name="intro" class="form-control" required></textarea>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-2">
				<label for="photo" class="form-label">프로필 사진</label>
			</div>
			<div class="col-sm-3">
				<input type="file" id="photo" name="photo" class="form-control" required/>
			</div>
		</div>
		<div class="form-group col-sm-5 d-flex justify-content-between">
			<button type="submit" id="submit" class="btn btn-primary" disabled="disabled">가입</button>
			<button type="button" id="to-home" class="btn btn-primary">처음으로</button>
		</div>
	</form>
	<div>
		<span id="idChk" style="display: none;">0</span>
		<span id="userNameChk" style="display: none;">0</span>
	</div>
</div>
<script>
$("#to-home").click(function(){
	self.location = "/"
});

function checkValidation(data, jsonName, url, resultId, statusId) {
	var query = {};
	query[jsonName] = data;
	if (query[jsonName].length) {
        $.ajax({
            url: url,
            type: "post",
            data: query,
            success: function(data) {
                if (data == 1) {
                    $(resultId).text("사용 불가");
                    $(resultId).attr("style", "color:#f00");
                    $("#submit").attr("disabled", "disabled");
                    $(statusId).text("disabled");
                } else {
                    $(resultId).text("사용 가능");
                    $(resultId).attr("style", "color:#00f");
                    $(statusId).text("enabled");
                    if ($("#idChk").text() == "enabled" && $("#userNameChk").text() == "enabled") {
                        $("#submit").removeAttr("disabled");
                    }
                }
            }
        });
    }
}

$(".idCheck").click(function() {
    var data = $("#userId").val().trim();
    checkValidation(data, "userId", "/member/idCheck", ".result #idChk_msg", "#idChk");
});

$(".userNameCheck").click(function() {
    var data = $("#userName").val().trim();
    checkValidation(data, "userName", "/member/userNameCheck", ".result #userNameChk_msg", "#userNameChk");
});

$("#userId").keyup(function() {
	$(".result #idChk_msg").text("아이디를 확인해주십시오.");
	$(".result #idChk_msg").attr("style", "color:#000");

	$("#submit").attr("disabled", "disabled");
	$("#idChk").text("disabled");
});

$("#userName").keyup(function() {
	$(".result #userNameChk_msg").text("닉네임을 확인해주십시오.");
	$(".result #userNameChk_msg").attr("style", "color:#000");

	$("#submit").attr("disabled", "disabled");
	$("#userNameChk").text("disabled");
});

window.onload = function(){
    document.getElementById("address").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address").value = data.address; // 주소 넣기
                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>