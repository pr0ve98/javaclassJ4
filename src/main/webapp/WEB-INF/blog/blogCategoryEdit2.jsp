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
<%@ include file="/include/blogeditcss.jsp"%>
</head>
<body class="body-layout">
	<div class="menu-title">
		<a class="navbar-brand" href="${ctp}/Main"><img src="${ctp}/images/logo.png" alt="logo" style="width: 200px;"></a>
		<div class="menu-right-bar">
			<button class="orangeBtn-sm" onclick="location.href='';">글쓰기</button>
			<i class="fa-solid fa-bell fa-xl mt-4" style="color: gray;" onclick="alarmBtn()"></i>
			<div class="user-profile"><img src="${ctp}/images/user/user_basic.jpg" alt="유저프로필" onclick="profileBtn()"></div>
		</div>
	</div>
	<main>
		<div class="container">
			<div class="sidebar">
		        <div class="profile">
		            <img src="${ctp}/images/user/${uVo.userImg}" alt="Profile" class="profile-img">
		            <div class="profile-name">${bVo.blogTitle}</div>
		            <div class="profile-link">${bVo.blogIntro}</div>
		        </div>
		        <nav>
		            <ul>
		                <li class="parent-li"><i class="fa-solid fa-gear mr-2" style="color: #363636;"></i>기본 설정</li>
		                <hr/>
		                <li class="parent-li active"><i class="fa-regular fa-image mr-2"></i>콘텐츠</li>
		                <ul>
		                    <li>글 관리</li>
		                    <li class="active">카테고리 관리</li>
		                </ul>
		                <hr/>
		                <li class="parent-li"><i class="fa-regular fa-comment mr-2" style="color: #424242;"></i>댓글·방명록</li>
		                <ul>
		                    <li>댓글 관리</li>
		                    <li>방명록 관리</li>
		                </ul>
		            </ul>
		        </nav>
		    </div>
		    <div class="main-content">
		        <h1>카테고리 관리</h1>
		        <div class="category-manager">
		            <div class="category-list">
		        		하위카테고리를 추가하려면 상위 카테고리를 선택 후 카테고리를 추가해주세요.<br/>
		        		카테고리를 추가했을 경우 적용 버튼을 누르고 수정, 삭제해주세요.
		                <div class="category-box">
					    <ul class="list-group" id="category-list">
					        <c:forEach var="cPVo" items="${cPVos}">
					            <li class="parent-category">
					                <div class="list-group-item">
					                    <strong>${cPVo.category}</strong>
				                    	<div class="edit-btns">
					            			<input type="button" value="수정" onclick="categoryEdit(${cPvo.caIdx})" class="proBtn-sm mr-1">
					            			<input type="button" value="삭제" class="proBtn-sm mr-1">
					            		</div>
					                </div>
					                <ul class="list-group-child mt-2" id="parent-${cPVo.caIdx}">
					                    <c:forEach var="cCVo" items="${cCVos}">
					                        <c:if test="${cCVo.parentCategoryIdx == cPVo.caIdx}">
					                            <li class="list-group-item" data-id="${cCVo.caIdx}">
					                                ${cCVo.category}
						                           	<div class="edit-btns">
								            			<input type="button" value="수정" onclick="categoryEdit(${cPvo.caIdx})" class="proBtn-sm mr-1">
								            			<input type="button" value="삭제" class="proBtn-sm mr-1">
							            			</div>
					                            </li>
					                        </c:if>
					                    </c:forEach>
					                </ul>
					            </li>
					        </c:forEach>
					    </ul>
						</div>
				        <div class="category-btns mt-3">
				        	<span>
				        	<input type="button" value="적용" class="proBtn mr-1" onclick="categorySubmit()"/>
				        	<input type="button" value="취소" class="proBtn" onclick="categoryReload()" />
				        	</span>
				        	<input type="button" value="카테고리 추가" class="proBtn" id="add-category" onclick="categoryAdd()" />
				        </div>
		            </div>
		        </div>
		    </div>
		</div>
	</main>
	<div class="footer"></div>
	<script>
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
	            headerLayer.innerHTML = '<div class="notification-top">새소식</div><hr class="notification-hr"/>'
	                    +'<div class="notification-list">'
	                        +'<div class="notification" data-clicked="false">'
	                            +'<img src="images/user_basic.jpg" alt="프로필 사진" class="profile-pic">'
	                            +'<div class="notification-content">'
	                                +'<div class="notification-header">'
	                                    +'<p class="user"><span class="user-name">김요운</span>님이 댓글을 남겼습니다.</p>'
	                                    +'<p class="date">2023.04.18</p>'
	                                +'</div>'
	                                +'<p class="comment">"나도....친구됐다...코붕이쿼카"</p>'
	                                +'<p class="title">23.03.20</p>'
	                            +'</div>'
	                        +'</div>'
	                        +'<div class="notification" data-clicked="false">'
	                            +'<img src="images/user_basic.jpg" alt="프로필 사진" class="profile-pic">'
	                            +'<div class="notification-content">'
	                                +'<div class="notification-header">'
	                                    +'<p class="user"><span class="user-name">김요운</span>님이 댓글을 남겼습니다.</p>'
	                                    +'<p class="date">2023.03.08</p>'
	                                +'</div>'
	                                +'<p class="comment">"일기좀 자주 써주세요"</p>'
	                                +'<p class="title">23.03.06</p>'
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
	            +'    <span class="layer_profile_username">${uVo.nickName}</span>'
	            +'    </div>'
	            +'  <div class="u-mail_u-account"><span class="layer_profile_email">${uVo.email}</span>'
	            +'    <span class="layer_profile_account-management" onclick="location.href=&quot;UserEdit.u&quot;">계정관리</span>'
	            +'</div>'
	            +'        <hr/>'
	            +'<div class="user_blogs">'
	            +'    <div class="user_blog">'
	            +'        <span class="b-title">운영중인 블로그</span>'
	            +'    </div>'
	            +'    <div class="user_blog">'
	            +'        <span class="user_blog-title" onclick="location.href=&quot;${ctp}/blog/${sMid}&quot;">${bVo.blogTitle}</span>'
	            +'            <div class="user-blog-btn">'
	            +'        <span class="user_write-icon"><i class="fa-solid fa-pen-to-square fa-sm" style="color: #A6A6A6;"></i></span>'
	            +'        <span class="user_settings-icon"><i class="fa-solid fa-gear fa-sm" style="color: #A6A6A6;" onclick="location.href=&quot;${ctp}/blogEdit/${sMid}&quot;"></i></span>'
	            +'            </div>'
	            +'    </div>'
	            +'</div>'
	            +'<hr/>'
	            +'<div class="user_logout">'
	            +'    <span onclick="location.href=&quot;${ctp}/UserLogout.u&quot;">로그아웃</span>'
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
	    
	    // 부모 카테고리 선택
	    $(document).on('click', '.parent-category', function(e) {
	        if (selectedParent) {
	            $(selectedParent).removeClass('selected');
	        }
	        selectedParent = this;
	        $(this).addClass('selected');
	        e.stopPropagation();
	    });
	
	    // 부모 카테고리 외 다른 부분 클릭시 선택 해제
	    $(document).on('click', function(e) {
	        if (selectedParent && !$(e.target).closest('.parent-category').length) {
	            $(selectedParent).removeClass('selected');
	            selectedParent = null;
	        }
	    });
	    
	    let selectedParent = null;

	    // 카테고리 추가함수
	    function categoryAdd() {
	    	let temp = Date.now();
	    	
	        if (selectedParent) {
	            let parentCategoryId = $(selectedParent).find('ul').attr('id');
	            let newSubCategoryHtml = '<li class="list-group-item" data-id="temp-child-'+temp+'">새 카테고리</li>';
	            document.getElementById(parentCategoryId).innerHTML += newSubCategoryHtml;
	        } else {
	            let newParentCategoryHtml = '<li class="parent-category">'
	                    +'<strong class="list-group-item">새 카테고리</strong>'
	                    +'<ul class="list-group-child mt-2" id="temp-parent-'+temp+'"></ul>'
	                +'</li>';
	            	document.getElementById('category-list').innerHTML += newParentCategoryHtml;
	        }
	    }
	
	    
	 	// 변경사항 적용 함수
	    function categorySubmit() {
	        let categories = [];
	        $('#category-list .parent-category').each(function() {
	            let parentId = $(this).find('ul').attr('id');
	            let parentName = $(this).find('> .list-group-item').text().trim();
	            let subCategories = [];

	            $(this).find('.list-group-child .list-group-item').each(function() {
	                subCategories.push($(this).attr('data-id') + '/' + $(this).text().trim());
	            });

	            categories.push(parentId + '/' + parentName);
	            categories.push(subCategories);
	        });

	        $.ajax({
	            url: '${ctp}/CategoryEditOk',
	            type: 'post',
	            traditional: true,
	            data: {categories : categories, mid : '${sMid}'},
	            success: function(res) {
	                alert('카테고리가 성공적으로 저장되었습니다.');
	                location.reload();
	            },
	            error: function() {
	                alert('카테고리 저장 중 오류가 발생했습니다.');
	            }
	        });
	    }
	 
	    // 카테고리 영역 부분 리로드(적용 취소)
	    function categoryReload() {
	        $('#category-list').load(window.location.href + ' #category-list');
	    }
	    
	    // 수정 삭제 버튼 보이기/감추기
	    $(".list-group-item").hover(
    	    function() {
    	        // 마우스를 요소 위로 올렸을 때 실행되는 함수
    	        $(this).find(".edit-btns").show();
    	    }, 
    	    function() {
    	        // 마우스를 요소에서 벗어났을 때 실행되는 함수
    	        $(this).find(".edit-btns").hide();
    	    }
	    );
	    
	    // 카테고리 수정
	    function categoryEdit(caIdx) {
			
		}
    </script>
</body>
</html>