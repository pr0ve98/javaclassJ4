<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>H-Blog</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<%@ include file="/include/bs4.jsp"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/maincss.jsp"%>
<script>
	document.addEventListener('DOMContentLoaded', function() {
	  loadContent('sub','');

	  const $$navDiv = document.querySelectorAll('.menu div');
	  const handleToggleActive = (e) => {
	  	const target = e.target.closest('div');
	  	if (!target) return;
	    
	    $$navDiv.forEach((div) => {
	      div.classList.remove('active-color');
	      div.classList.remove('active');
	    });
	    target.classList.add('active');
	    target.classList.add('active-color');
	  };
	  $$navDiv.forEach((div) => {
	    div.addEventListener('click', handleToggleActive);
	  });
	  
	});
	
	// 구독/인기/최신 블로그글 부분 로드
	function loadContent(nav, category) {
			$.ajax({
			url: "MainContent",
			method: "GET",
			data: { nav: nav, category: category },
			success: function(res) {
			  $("#main-blog").html(res);
			},
			error : function() {
			alert("오류");
			}
		});
	}
	
	// 알람 버튼
	function alarmBtn() {
	    let profileHeaderLayer = document.querySelector('.menu-right-bar .layer_profile');
	    
	    // 프로필 버튼의 header_layer 제거
	    if (profileHeaderLayer) {
	        profileHeaderLayer.remove();
	    }

	    let alarmHeaderLayer = document.querySelector('.menu-right-bar .layer_news');
	    
	    // 알람 버튼의 header_layer가 없는 경우 생성
	    if (!alarmHeaderLayer) {
	        let headerLayer = document.createElement('div');
	        headerLayer.className = 'header_layer layer_news';
	        headerLayer.innerHTML = '<div class="notification-top">새소식 <font color="#ff7200">${newReplyCnt}</font></div><hr class="notification-hr"/>'
	                +'<div class="notification-list">'
	                +'<c:forEach var="vo" items="${vos}">'
	                    +'<div class="notification" onclick="location.href=&quot;${ctp}/content/${sMid}?coIdx=${vo.rCoIdx}&rIdx=${vo.rIdx}&quot;">'
	                        +'<img src="${ctp}/images/user/${vo.rUserImg}" alt="프로필 사진" class="profile-pic">'
	                        +'<div class="notification-content">'
	                            +'<div class="notification-header">'
	                                +'<p class="user"><span class="user-name">${vo.rNickName}</span>님이 댓글을 남겼습니다.</p>'
	                                +'<p class="date">2023.04.18</p>'
	                            +'</div>'
	                            +'<p class="comment">"${vo.rContent}"</p>'
	                            +'<p class="title">${vo.coTitle}</p>'
	                        +'</div>'
	                    +'</div>'
	                    +'</c:forEach>'
	                    +'</div>'
	                +'</div>';
	        document.querySelector('.menu-right-bar').appendChild(headerLayer);
	        document.addEventListener('click', handleClickOutsideAlarm);
	    } else {
	        alarmHeaderLayer.remove();
	        document.removeEventListener('click', handleClickOutsideAlarm);
	    }
	}

	function handleClickOutsideAlarm(e) {
	    let alarmHeaderLayer = document.querySelector('.menu-right-bar .layer_news');
	    if (alarmHeaderLayer && !alarmHeaderLayer.contains(e.target) && !e.target.matches('.menu-right-bar *')) {
	        alarmHeaderLayer.remove();
	        document.removeEventListener('click', handleClickOutsideAlarm);
	    }
	}

	// 프로필 버튼
	function profileBtn() {
	    let alarmHeaderLayer = document.querySelector('.menu-right-bar .layer_news');

	    // 알람 버튼의 header_layer 제거
	    if (alarmHeaderLayer) {
	        alarmHeaderLayer.remove();
	    }

	    let profileHeaderLayer = document.querySelector('.menu-right-bar .layer_profile');

	    // 프로필 버튼의 header_layer가 없는 경우 생성
	    if (!profileHeaderLayer) {
	        let headerLayer = document.createElement('div');
	        headerLayer.className = 'header_layer layer_profile';
	        headerLayer.innerHTML = '<div class="layer_profile_header">'
	        +'    <span class="layer_profile_username">${vo.nickName}</span>'
	        +'    </div>'
	        +'  <div class="u-mail_u-account"><span class="layer_profile_email">${vo.email}</span>'
	        +'    <span class="layer_profile_account-management" onclick="location.href=&quot;UserEdit.u&quot;">계정관리</span>'
	        +'</div>'
	        +'        <hr/>'
	        +'<div class="user_blogs">'
	        +'    <div class="user_blog">'
	        +'        <span class="b-title">운영중인 블로그</span>'
	        +'    </div>'
	        +'    <div class="user_blog">'
	        +'        <span class="user_blog-title" onclick="location.href=&quot;${ctp}/blog/${sMid}&quot;">${sBlogTitle}</span>'
	        +'            <div class="user-blog-btn">'
	        +'        <span class="user_write-icon"><i class="fa-solid fa-pen-to-square fa-sm" style="color: #A6A6A6;" onclick="location.href=&quot;${ctp}/ContentInput/${sMid}&quot;"></i></span>'
	        +'        <span class="user_settings-icon"><i class="fa-solid fa-gear fa-sm" style="color: #A6A6A6;" onclick="location.href=&quot;BlogEdit/${sMid}&quot;"></i></span>'
	        +'            </div>'
	        +'    </div>'
	        +'</div>'
	        +'<hr/>'
	        +'<div class="user_logout">'
	        +'    <span onclick="location.href=&quot;UserLogout.u&quot;">로그아웃</span>'
	        +'</div>';
	        document.querySelector('.menu-right-bar').appendChild(headerLayer);
	        document.addEventListener('click', handleClickOutsideProfile);
	    } else { // 프로필 버튼의 header_layer가 있는 경우 제거
	        profileHeaderLayer.remove();
	        document.removeEventListener('click', handleClickOutsideProfile);
	    }
	}

	function handleClickOutsideProfile(e) {
	    let profileHeaderLayer = document.querySelector('.menu-right-bar .layer_profile');
	    if (profileHeaderLayer && !profileHeaderLayer.contains(e.target) && !e.target.matches('.menu-right-bar *')) {
	        profileHeaderLayer.remove();
	        document.removeEventListener('click', handleClickOutsideProfile);
	    }
	}
</script>
</head>
<body class="body-layout">
	<div class="menu-title">
		<a class="navbar-brand" href="${ctp}/Main"><img src="${ctp}/images/logo.png" alt="logo" style="width: 200px;"></a>
		<div class="menu-right-bar">
			<c:if test="${sNickName == null}"><button class="orangeBtn" onclick="location.href='Login.u';">가입하기</button></c:if>
			<c:if test="${sNickName != null}">
				<c:if test="${newReplyCnt != 0}"><span class="new">${newReplyCnt}</span></c:if>
				<i class="fa-solid fa-bell fa-xl mt-4 alarmBtn" style="color: gray;" onclick="alarmBtn()"></i>
				<div class="user-profile"><img src="${ctp}/images/user/${vo.userImg}" alt="유저프로필" onclick="profileBtn()"></div>
			</c:if>
		</div>
	</div>
	<div class="menu">
		<nav>
			<div class="mr-5 active-color" onclick="loadContent('sub','')">구독</div>
			<div class="mr-5" onclick="loadContent('pop','')">인기</div>
			<div class="mr-5" onclick="loadContent('rec','')">최신</div>
			<span class="animation"></span>
		</nav>
	</div>
	<div class="main-content">
		<div class="container-fluid">
			<div class="content-list">
				<hr/>
				<div id="main-blog" class="main-blog"></div>
			</div>
		</div>
	</div>
	<div class="footer">footer</div>
</body>
</html>