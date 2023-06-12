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
	
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/read.css">
</head>
<body>

<div class="container">
	<header>
		<%@include file="include/header.jsp" %>
	</header>
	
	<%@include file="include/nav.jsp" %>

	<section id="container">
	
		<div style = "border : solid 1px #dedede; background-color: #f5f5f5; padding: 5px; margin-bottom: 10px;">	   
			<form role="form" method="post" autocomplete="off" style="margin: 0;">
		    	
		    	<input type="hidden" id="page" name="page" value="${scri.page}" readonly="readonly"/>
		    	<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}" readonly="readonly"/>
		    	<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}" readonly="readonly"/>
		    	<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}" readonly="readonly"/>
		    	
		    	
				<div class="form-group">
					<label for="bno" class="control-label">글 번호</label>
					<input type="text" id="bno" name="bno" class="form-control" value="${read.bno}" readonly="readonly" />
				</div>
				
			</form>
			     
				<div class="form-group">
					<label for="title" class="control-label">글 제목</label>
					<input type="text" id="title" name="title" class="form-control" value="${read.title}" readonly="readonly" />
				</div>
				<div class="form-group">
					<label for="content" class="control-label">글 내용</label>
					<textarea id="content" name="content" class="form-control" readonly="readonly" >${read.content}</textarea>
				</div>
				<div class="form-group">
					<label for="writer" class="control-label">작성자</label>
					<input type="text" id="writer" name="writer" class="form-control" value="${read.writer}" readonly="readonly" /><br />
				</div>	
				<div class="form-group">
					<label class="control-label">작성 날짜</label>
					<span><fmt:formatDate value="${read.regDate}" pattern="yyyy-MM-dd" /></span> 
				</div>
				<div class="form-group">
					<button type="button" id="list_btn" class="btn btn-primary">목록</button>
					<c:if test="${msg != 'hide_modify_delete_btn'}">
						<button type="button" id="modity_btn" class="btn btn-warning">수정</button>
						<button type="button" id="delete_btn" class="btn btn-danger">삭제</button>
					</c:if>
					
					<script>
		   
					// 폼을 변수에 저장
					var formObj = $("form[role='form']");
					
					// 목록 버튼 클릭
					$("#list_btn").click(function(){
						self.location = "/board/listSearch?"
								+ "page=${scri.page}&perPageNum=${scri.perPageNum}"
								+ "&searchType=${scri.searchType}&keyword=${scri.keyword}";
					});
					
					// 수정 버튼 클릭
					$("#modity_btn").click(function(){
					
						formObj.attr("action", "/board/modify");
						formObj.attr("method", "get");    
						formObj.submit();       
						
					});
					
					// 삭제 버튼 클릭
					$("#delete_btn").click(function(){
		
						formObj.attr("action", "/board/delete");
						formObj.attr("method", "get");    
						formObj.submit();
		
					});
					</script>
					
				</div>
			</div>
			
			<!-- 게시물 끝 -->
			<div id="reply">
				<div style="border : solid 1px #dedede; background-color: #f5f5f5; padding: 5px;">
					댓글
				</div>
				<div class="replyList">
					<c:forEach items="${repList}" var="repList">
						<div style="border : solid 1px #dedede; background-color: #f5f5f5; padding: 5px;">
							<p>
							<span class="glyphicon glyphicon-user"></span>
								작성자: ${repList.writer}
								(<fmt:formatDate value="${repList.regDate}" pattern="yyyy-MM-dd" />)
							</p>
							
							<p>내용: ${repList.content}</p>
							
							<div class="form-group">
								<button type="button" class="replyUpdate btn btn-warning btn-xs" data-rno="${repList.rno}">수정</button>
								<button type="button" class="replyDelete btn btn-danger btn-xs" data-rno="${repList.rno}">삭제</button>
								
								<script>
									$(".replyUpdate").click(function(){
										self.location = "/board/replyUpdate?bno=${read.bno}"
											+ "&page=${scri.page}"
											+ "&perPageNum=${scri.perPageNum}"
											+ "&searchType=${scri.searchType}"
											+ "&keyword=${scri.keyword}"
											+ "&rno=" + $(this).attr("data-rno");          
									});
									
									$(".replyDelete").click(function(){
										self.location = "/board/replyDelete?bno=${read.bno}"
											+ "&page=${scri.page}"
											+ "&perPageNum=${scri.perPageNum}"
											+ "&searchType=${scri.searchType}"
											+ "&keyword=${scri.keyword}"
											+ "&rno=" + $(this).attr("data-rno");   
									});         
								</script>
							</div>
						</div>
					</c:forEach>   
				</div>
				
				<section class="replyForm">
				<form role="form" method="post" action="replyWrite" autocomplete="off" class="form-horizontal">
				
					<input type="hidden" id="bno" name="bno" value="${read.bno}" readonly="readonly" />
					<input type="hidden" id="page" name="page" value="${scri.page}" readonly="readonly" />
					<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}" readonly="readonly" />
					<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}" readonly="readonly" />
					<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}" readonly="readonly" />
				
					<div class="form-group write-comment">
						<label for="writer" class="col-sm-2 control-label">작성자</label>
						<div class="col-sm-10">
							<input type="text" id="writer" name="writer" class="form-control" required="required"/>
						</div>
					</div>
					
					<div class="form-group write-comment">
						<label for="content" class="col-sm-2 control-label">댓글 내용</label>
						<div class="col-sm-10">
							<textarea id="content" name="content" class="form-control" required="required"></textarea>
						</div>
					</div>
					
					<div class="form-group write-comment">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="repSubmit btn btn-success">작성</button>
						</div>
				   </div>
				</form>
				</section>
			</div>
	
	</section>

	<footer>
		<%@include file="include/footer.jsp" %>
	</footer>

</div>
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<c:if test="${param.msg == 'replyWrite_error'}">	
	<script>
		alert('댓글 작성자와 댓글 내용을 입력해주세요.');
	</script>
</c:if>
<c:if test="${param.msg == 'replyUpdate_error'}">
	<script>
		alert('댓글 내용을 입력해주세요.');
	</script>
</c:if>
</body>
</html>