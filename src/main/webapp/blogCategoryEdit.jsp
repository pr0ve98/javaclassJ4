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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js"></script>
<%@ include file="/include/blogeditcss.jsp"%>
<style>
	.list-group-child {
	    cursor: move;
	}
</style>
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
		        		카테고리 순서를 변경하고 주제 연결을 설정할 수 있습니다.<br/>
		        		하위카테고리를 추가하려면 상위 카테고리를 선택 후 카테고리를 추가해주세요.
		                <div class="category-box">
							<ul class="list-group" id="category-list">
					            <li class="parent-category">
					                <strong class="list-group-item">일기</strong>
					                <ul class="list-group-child mt-2" id="parent-1">
					                    <li class="list-group-item" data-id="1">2024년</li>
					                    <li class="list-group-item" data-id="2">2023년</li>
					                    <li class="list-group-item" data-id="3">2022년</li>
					                </ul>
					            </li>
					            <li class="parent-category">
					                <strong class="list-group-item">리뷰</strong>
					                <ul class="list-group-child mt-2" id="parent-2">
					                    <li class="list-group-item" data-id="4">영화</li>
					                    <li class="list-group-item" data-id="5">드라마</li>
					                </ul>
					            </li>
					        </ul>
				        </div>
				        <div class="category-btns mt-3">
				        	<span>
				        	<input type="button" value="적용" class="proBtn mr-1"/>
				        	<input type="button" value="취소" class="proBtn" onclick="location.reload()" />
				        	</span>
				        	<input type="button" value="카테고리 추가" class="proBtn" id="add-category" />
				        </div>
		            </div>
		        </div>
		    </div>
		</div>
	</main>
	<div class="footer"></div>
	<script>
        let selectedParent = null;

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
    	        			+'</div>'
    	        			+'<div class="notification" data-clicked="false">'
        					+'<img src="images/user_basic.jpg" alt="프로필 사진" class="profile-pic">'
    	    					+'<div class="notification-content">'
    	    						+'<div class="notification-header">'
    			        				+'<p class="user"><span class="user-name">괴도 유빈</span>님이 댓글을 남겼습니다.</p>'
    			        				+'<p class="date">2023.02.26</p>'
    			        			+'</div>'
    		        				+'<p class="comment">"ㅋㅋㅋㅋㅋ"</p>'
    	        					+'<p class="title">23.02.26</p>'
    	        				+'</div>'
    	        			+'</div>'
    	        			+'<div class="notification" data-clicked="false">'
        					+'<img src="images/user_basic.jpg" alt="프로필 사진" class="profile-pic">'
        						+'<div class="notification-content">'
        							+'<div class="notification-header">'
    	        						+'<p class="user"><span class="user-name">김요운</span>님이 댓글을 남겼습니다.</p>'
    			        				+'<p class="date">2023.02.22</p>'
    				        		+'</div>'
    	        					+' <p class="comment">"해줘 나랑도ㅠ"</p>'
    	        					+'<p class="title">덩킴 Dinkum</p>'
    	        				+'</div>'
    	        			+'</div>'
            			+'</div>';
    	        document.querySelector('.menu-right-bar').appendChild(headerLayer);
    	    } else {
    	        alarmHeaderLayer.remove();
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
    	        headerLayer.className = 'header_layer layer_profile'
    	        headerLayer.innerHTML = '<div class="layer_profile_header">'
    	        +'	<span class="layer_profile_username">${uVo.nickName}</span>'
    	        +'	</div>'
    	        +'  <div class="u-mail_u-account"><span class="layer_profile_email">${uVo.email}</span>'
    	        +'    <span class="layer_profile_account-management" onclick="location.href=&quot;UserEdit.u&quot;">계정관리</span>'
    	        +'</div>'
    	        +'		<hr/>'
    	        +'<div class="user_blogs">'
    	        +'    <div class="user_blog">'
    	        +'        <span class="b-title">운영중인 블로그</span>'
    	        +'    </div>'
    	        +'    <div class="user_blog">'
    	        +'        <span class="user_blog-title" onclick="location.href=&quot;${ctp}/blog/${sMid}&quot;">${sBlogTitle}</span>'
    	        +'			<div class="user-blog-btn">'
    	        +'        <span class="user_write-icon"><i class="fa-solid fa-pen-to-square fa-sm" style="color: #A6A6A6;"></i></span>'
    	        +'        <span class="user_settings-icon"><i class="fa-solid fa-gear fa-sm" style="color: #A6A6A6;" onclick="location.href=&quot;${ctp}/blogEdit/${sMid}&quot;"></i></span>'
    	        +'			</div>'
    	        +'    </div>'
    	        +'</div>'
    	        +'<hr/>'
    	        +'<div class="user_logout">'
    	        +'    <span onclick="location.href=&quot;UserLogout.u&quot;">로그아웃</span>'
    	        +'</div>';
    	        document.querySelector('.menu-right-bar').appendChild(headerLayer);
    	    } else { // 프로필 버튼의 header_layer가 있는 경우 제거
    	        profileHeaderLayer.remove();
    	    }
    	}
        
        // 부모 카테고리 선택
        $(document).on('click', '.parent-category', function(e) {
            if (!selectedParent) {
                $(selectedParent).removeClass('selected');
            }
            selectedParent = this;
            $(this).addClass('selected');
            e.stopPropagation();
        });

        // 부모 카테고리 외 다른 부분 클릭시 선택 해제
        $(document).on('click', function(e) {
            if (!selectedParent && !$(e.target).closest('.parent-category').length) {
                $(selectedParent).removeClass('selected');
                selectedParent = null;
            }
        });

        // 카테고리 추가 버튼 클릭 이벤트
        $('#add-category').click(function() {
            if (!selectedParent) {
                const newParentId = 'parent-' + (new Date().getTime());
                const newParentHtml = `
                    <li class="parent-category">
                        <strong class="list-group-item">새 카테고리</strong>
                        <ul class="list-group-child mt-2" id="${newParentId}"></ul>
                    </li>
                `;
                $('#category-list').append(newParentHtml);
                new Sortable(document.getElementById(newParentId), sortableOptions);
            }
            else {
                let newChildHtml = `<li class="list-group-item" data-id="${ct.idx}">새 카테고리</li>`;
                $(selectedParent).find('.list-group-child').append(newChildHtml);
            }
        });

        // Sortable 옵션 설정
        const sortableOptions = {
            animation: 150,
            onEnd: function (evt) {
                const parentId = evt.to.id;
                const order = [];
                const items = evt.to.children;
                for (let i = 0; i < items.length; i++) {
                    order.push(items[i].dataset.id);
                }
                console.log('New order for ' + parentId + ':', order);
                updateOrder(parentId, order);
            }
        };

        // Sortable 초기화
        $('#category-list .list-group-child').each(function() {
            new Sortable(this, sortableOptions);
        });

        // 카테고리 순서 변경
        function updateOrder(parentId, order) {
            $.ajax({
                url: '/saveOrder',
                type: 'POST',
                contentType: 'application/json',
                data: { parentId: parentId, order: order },
                success: function(res) {
                    console.log('Order saved for ' + parentId + ':', res);
                },
                error: function() {
                    console.error('Error saving order for ' + parentId + ':', error);
                }
            });
        }
    </script>
</body>
</html>