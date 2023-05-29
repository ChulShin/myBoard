<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="page-header">
	<h1>chuls 게시판</h1>
</div>
<div>
	<span class="welcome" style="font-weight: bold;">${member.userName}</span><span class="welcome">님 환영합니다.</span>
	<c:if test="${member == null}">
		<script>
			$('span.welcome').css("visibility", "hidden");
		</script>
	</c:if>	
	<c:if test="${member != null}">
		<script>
			$('span.welcome').css("visibility", "visible");
		</script>
	</c:if>
</div>