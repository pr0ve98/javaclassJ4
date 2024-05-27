<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${bVo.blogTitle}</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/bs4.jsp"%>
<%@ include file="/include/blogcss.jsp"%>
</head>
<body>
<header>
    <div class="header-container">
        <div class="header-left">
            <div class="header-title" onclick="location.href='${ctp}/blog/${uVo.mid}';">${bVo.blogTitle}</div>
        </div>
        <div class="header-right">
            <input type="text" placeholder="Search...">
            <button type="button"><i class="fas fa-search"></i></button>
        </div>
    </div>
</header>
<main class="container">
    <section class="posts">
    	<b>전체 글 <span style="color:#ff7200">27</span></b>
    	<hr/>
        <div class="post">
            <div class="post-content">
                <h2>오늘은 별로 안 바빴다</h2>
                <p>오늘은 별로 안 바빴다... (본문 내용)</p>
                <span>일기 · 2023.03.22</span>
            </div>
            <div class="post-thumbnail">
                <img src="${ctp}/images/test2.jpg" alt="thumbnail">
            </div>
        </div>
        <!-- 다른 게시물들 추가 -->
    </section>
    <aside>
        <div class="profile">
            <img src="${ctp}/images/user/${uVo.userImg}" alt="profile">
            <div class="nickName">${uVo.nickName}</div>
            <div class="blog-intro">${bVo.blogIntro}</div>
            <hr/>
	        <div class="actions">
		        <a href="#" class="action-link"><i class="fas fa-pencil-alt"></i> 글쓰기</a>
		        <a href="#" class="action-link"><i class="fas fa-cogs"></i> 블로그 관리</a>
	    	</div>
        </div>
        <div class="categories">
            <ul>
            	<li>전체보기 (27)</li>
            	<c:forEach var="cVo" items="${cVos}" varStatus="st">
                <li>${cVo.category}</li>
            	</c:forEach>
            </ul>
        </div>
        <hr/>
        <div class="tags">
            <h3>Tag</h3>
            <!-- 태그 목록 추가 -->
        </div>
        <div class="recent-comments">
            <h3>최근댓글</h3>
            <!-- 댓글 목록 추가 -->
        </div>
        <hr/>
        <div class="counter">
            <div>Total</div>
            <div class="totalVisit">${bVo.totalVisit}</div>
            <div class="todayVisit">Today ${todayVisit}</div>
        </div>
    </aside>
</main>
<!-- 홈 버튼 -->
<div class="home-button" onclick="location.href='${ctp}/Main';">
    <i class="fas fa-home"></i>
</div>
</body>
</html>
