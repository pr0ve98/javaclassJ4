<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>개인 블로그</title>
    <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
	<%@ include file="/include/bs4.jsp"%>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
	<style>
		@font-face {
		    font-family: 'Pretendard-Thin';
		    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Thin.woff') format('woff');
		    font-weight: 100;
		    font-style: normal;
		}
		@font-face {
		    font-family: 'Pretendard-ExtraLight';
		    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-ExtraLight.woff') format('woff');
		    font-weight: 200;
		    font-style: normal;
		}
		@font-face {
		    font-family: 'Pretendard-Light';
		    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Light.woff') format('woff');
		    font-weight: 300;
		    font-style: normal;
		}
		@font-face {
		    font-family: 'Pretendard-Regular';
		    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
		    font-weight: 400;
		    font-style: normal;
		}
		@font-face {
		    font-family: 'Pretendard-Medium';
		    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Medium.woff') format('woff');
		    font-weight: 500;
		    font-style: normal;
		}
		@font-face {
		    font-family: 'Pretendard-SemiBold';
		    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-SemiBold.woff') format('woff');
		    font-weight: 600;
		    font-style: normal;
		}
		@font-face {
		    font-family: 'Pretendard-Bold';
		    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Bold.woff') format('woff');
		    font-weight: 700;
		    font-style: normal;
		}
		@font-face {
		    font-family: 'Pretendard-ExtraBold';
		    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-ExtraBold.woff') format('woff');
		    font-weight: 800;
		    font-style: normal;
		}
		@font-face {
		    font-family: 'Pretendard-Black';
		    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Black.woff') format('woff');
		    font-weight: 900;
		    font-style: normal;
		}
		body {
		    font-family: 'Pretendard-Medium';
		    background-color: #f9f9f9;
		}
		
		header {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    padding: 20px;
		    background-color: #fff;
		    border-bottom: 1px solid #ddd;
		}
		
		header h1 {
		    margin: 0;
		}
		
		header input {
		    padding: 5px;
		    margin-right: 10px;
		}
		
		header button {
		    background: none;
		    border: none;
		    cursor: pointer;
		}
		
		main {
		    display: flex;
		    padding: 20px;
		}
		
		.posts {
		    flex: 2;
		    margin-right: 20px;
		}
		
		.post {
		    display: flex;
		    background: #fff;
		    margin-bottom: 20px;
		    padding: 20px;
		    border: 1px solid #ddd;
		    border-radius: 5px;
		}
		
		.post-date {
		    flex: 1;
		    font-size: 14px;
		    color: #999;
		}
		
		.post-content {
		    flex: 3;
		}
		
		.post-content h2 {
		    margin: 0;
		    font-size: 18px;
		    color: #333;
		}
		
		.post-content p {
		    margin: 10px 0;
		    color: #666;
		}
		
		.post-content span {
		    font-size: 12px;
		    color: #999;
		}
		
		.post-thumbnail {
		   	width: 200px;
			height: 108px;
		}
		.post-thumbnail img {
		    width: 100%;
        	height: 100%;
		    border-radius: 5px;
			object-fit: cover;
		}
		
		.pagination {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    margin: 20px 0;
		}
		
		.pagination a {
			width: 35px;
			height: 35px;
		    margin: 0 5px;
		    padding: 5px;
		    background: #fff;
		    border: 1px solid #ddd;
		    border-radius: 50%;
		    color: #333;
		    text-decoration: none;
		    text-align: center;
		    font-size: 12px;
		    align-content: center;
		    font-family: 'Pretendard-Light';
		}
		
		.pagination a:hover {
		    background: #f0f0f0;
		}
		
		.pagination a.active {
		    background: #333;
		    color: #fff;
		    border-color: #333;
		    font-family: 'Pretendard-Medium';
		}
		
		aside {
		    flex: 1;
		}
		
		.profile,
		.categories,
		.tags,
		.recent-comments,
		.social-links,
		.archives,
		.calendar,
		.counter {
		    background: #fff;
		    padding: 20px;
		    margin-bottom: 20px;
		    border: 1px solid #ddd;
		    border-radius: 5px;
		}
		
		.profile img {
		    width: 100px;
		    height: 100px;
		    border-radius: 50%;
		    display: block;
		    margin: 0 auto;
		}
		
		.categories ul,
		.archives ul {
		    list-style: none;
		    padding: 0;
		}
		
		.categories ul li,
		.archives ul li {
		    margin: 5px 0;
		}
		
		footer {
		    text-align: center;
		    padding: 20px;
		    background: #fff;
		    border-top: 1px solid #ddd;
		}

	</style>
</head>
<body>
    <header>
        <div class="header-left">
            <h1>개인 블로그</h1>
        </div>
        <div class="header-right">
            <input type="text" placeholder="Search...">
            <button type="button"><i class="fas fa-search"></i></button>
        </div>
    </header>
    <main class="container">
        <section class="posts">
            <div class="post">
                <div class="post-date">23.03.22</div>
                <div class="post-content">
                    <h2>오늘은 별로 안 바빴다</h2>
                    <p>오늘은 별로 안 바빴다... (본문 내용)</p>
                    <span>일기 · 2023.03.22</span>
                </div>
                <div class="post-thumbnail">
                    <img src="images/test2.jpg" alt="thumbnail">
                </div>
            </div>
            <!-- 다른 게시물들 추가 -->
            <div class="pagination">
                <a href="#">&laquo;</a>
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">&raquo;</a>
            </div>
        </section>
        <aside>
            <div class="profile">
                <img src="images/user.jpg" alt="profile">
                <h3>기록용 블로그</h3>
            </div>
            <div class="categories">
                <h3>분류 전체보기 (27)</h3>
                <ul>
                    <li>일기 (22)</li>
                    <li>리뷰 (5)</li>
                </ul>
            </div>
            <div class="tags">
                <h3>Tag</h3>
                <!-- 태그 목록 추가 -->
            </div>
            <div class="recent-comments">
                <h3>최근댓글</h3>
                <!-- 댓글 목록 추가 -->
            </div>
            <div class="archives">
                <h3>Archives</h3>
                <ul>
                    <li>2023/03</li>
                    <li>2023/02</li>
                    <li>2023/01</li>
                </ul>
            </div>
            <div class="counter">
                <h3>Total</h3>
                <p>407</p>
                <p>Today: 0</p>
                <p>Yesterday: 0</p>
            </div>
        </aside>
    </main>
    <footer>
        <p>&copy; H-Blog</p>
    </footer>
</body>
</html>
