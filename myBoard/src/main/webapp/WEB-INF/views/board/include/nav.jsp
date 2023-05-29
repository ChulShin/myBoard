<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<ul class="nav nav-pills">
	<c:if test="${member == null}">
		<li><a href="/" class="btn btn-dark" style="margin: 5px;">로그인</a></li>
	</c:if>
	<%-- <li><a href="/board/list">글 목록</a></li>
	<li><a href="/board/listPage">글 목록+페이지</a></li> --%>
	<li><a href="/board/listSearch" class="btn btn-dark" style="margin: 5px;">글 목록</a></li>
	<c:if test="${member != null}">
		<li><a href="/board/write" class="btn btn-dark" style="margin: 5px;">글 작성</a></li>
		<li><a href="/member/logout" class="btn btn-dark" style="margin: 5px">로그아웃</a></li>
	</c:if>
	<c:if test="${member == null}">
		
	</c:if>
</ul>