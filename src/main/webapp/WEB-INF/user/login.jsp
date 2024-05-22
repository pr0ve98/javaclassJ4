<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>에이치로그 로그인</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<%@ include file="/include/bs4.jsp"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/maincss.jsp"%>
<style>
	.body-layout {
		display: grid;
		grid-template-areas: 'header' 'content';
		grid-template-rows: 100px 1fr;
	}
	.menu-title {
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.navbar-brand {
		margin: 0 auto;
	}
	.content-list {
		width: 30%;
		padding: 100px 0;
		margin: 50px auto 100px;
		box-sizing: content-box;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, .1), 0 0 1px rgba(0, 0, 0, .3);
	}
	.grayBtn, .orangeBtn {
		width: 80%;
	}
</style>
</head>
<body class="body-layout">
	<div class="menu-title">
		<a class="navbar-brand" href="${ctp}/Main"><img src="${ctp}/images/logo.png" alt="logo" style="width: 200px;"></a>
	</div>
	<div class="main-content">
		<div class="container-fluid">
			<div class="content-list">
				<input type="button" value="로그인" onclick="location.href='UserLogin.u';" class="grayBtn mb-3"/>
				<input type="button" value="회원가입" onclick="location.href='UserJoin.u';" class="orangeBtn"/>
			</div>
		</div>
	</div>
</body>
</html>