<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	    font-family: 'Pretendard-Light';
	    cursor: default;
	}
	header {
	    display: flex;
	    flex-direction: column;
	    border-bottom: 1px solid #ddd;
	}
	.header-container {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    max-width: 1200px;
	    margin: 0 auto;
	    padding: 30px 20px;
	    width: 100%;
	}
	.header-title {
	    font-family: 'Pretendard-SemiBold';
	    font-size: 24px;
	    margin: 0;
	    color: #333;
	    cursor: pointer;
	}
	.header-right {
	    display: flex;
	    align-items: center;
	}
	header input[type="text"] {
	    padding-right: 30px;
	    border: none;
	    border-bottom: 2px solid #333;
	    outline: none;
	    font-size: 16px;
	    margin-right: 15px;
	}
	header button {
	    background: none;
	    border: none;
	    cursor: pointer;
	    font-size: 14px;
	    color: #D5D5D5;
	    position: relative;
	    right: 10px;
	}
	header input[type="text"]::placeholder {
	    color: #D5D5D5;
	}
	main {
	    display: flex;
	    padding: 20px;
	    margin: 0 40px;
	}
	.container {
	    display: flex;
	    justify-content: space-between;
	    width: 100%;
	    max-width: 1200px;
	    margin: 0 auto;
	    padding-top: 55px;
	}
	.posts {
	    flex: 3;
	    margin-right: 70px;
	}
	.post {
	    display: flex;
	    padding: 20px;
	    position: relative;
	}
    .post::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(213, 213, 213, 0.2);
        opacity: 0;
        transition: opacity 0.3s;
    }

    .post:hover::after {
        opacity: 1;
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
	aside h3 {
		font-size: 16px;
	}
	.profile{
	    padding: 50px 20px 10px;
	    margin-bottom: 20px;
		border: 1px solid #ddd;
	    border-radius: 5px;
	    text-align: center;
	}
	.blog-intro {
		margin-bottom: 30px;
	}
	.nickName {
		font-family: 'Pretendard-Medium';
		margin-bottom: 5px;
		font-size: 20px;
	}
	.actions {
	    background: #fff;
	    display: flex;
	    justify-content: space-around;
	}
	
	.action-link {
	    display: block;
	    font-size: 14px;
	    color: #333;
	    text-decoration: none;
	    margin-bottom: 10px;
	    cursor: pointer;
	}
	
	.action-link i {
	    margin-right: 8px;
	}
	
	.action-link:hover {
		color: #ff7200;
	    text-decoration: underline;
	}
	.categories,
	.recent-comments,
	.counter {
	    padding: 10px;
	}
	li {font-size:14px}
	.profile img {
	    width: 150px;
	    height: 150px;
	    border-radius: 50%;
	    display: block;
	    margin: 0 auto;
	    margin-bottom: 20px;
	    object-fit: cover;
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
	.totalVisit {
		font-family: 'Pretendard-Bold';
		color: #ff7200;
		font-size: 20px;
	}
	.todayVisit {
		font-size: 12px;
	}
	footer {
	    text-align: center;
	    padding: 20px;
	    background: #fff;
	    border-top: 1px solid #ddd;
	    background-color: #eee;
	}
	.home-button {
	    position: fixed;
	    top: 25px;
	    right: 45px;
	    background-color: #ff7200;
	    color: #fff;
	    border-radius: 50%;
	    width: 50px;
	    height: 50px;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    text-decoration: none;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	    z-index: 1000; /* 다른 요소들 위에 표시되도록 설정 */
	}
	
	.home-button:hover {
	    background-color: #afeeee;
	}
	
	.home-button i {
	    font-size: 24px;
	}
	
	.pagination {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
	
	.pagination a {
	    color: black;
	    float: left;
	    padding: 8px 16px;
	    text-decoration: none;
	    transition: background-color .3s;
	    border-radius: 50%;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    height: 32px;
	    width: 32px;
	    text-align: center;
	    margin: 0 4px;
	}
	
	.pagination a.active {
	    background-color: black;
	    color: white;
	    border-radius: 50%;
	}
	
	.pagination a:hover:not(.active) {
	    background-color: #ddd;
	}
	a:link {
  		color : #212529;
	}
	a:visited {
	  color : #212529;
	}
	a:hover {
	  color : #212529;
	  text-decoration-line: none;
	}
	a:active {
	  color : #212529;
	}
	
	.category-ac {
		font-family: Pretendard-Medium;
		color: #ff7200;
	}
</style>