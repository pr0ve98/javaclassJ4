<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${bVo.blogTitle} - 기본정보 관리</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<%@ include file="/include/bs4.jsp"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/blogeditcss.jsp"%>
</head>
<body class="body-layout">
	<div class="menu-title">
		<a class="navbar-brand" href="${ctp}/Main"><img src="${ctp}/images/logo.png" alt="logo" style="width: 200px;"></a>
		<div class="menu-right-bar">
			<button class="orangeBtn-sm" onclick="location.href='${ctp}/ContentInput/${uVo.mid}';">글쓰기</button>
			<c:if test="${newReplyCnt != 0}"><span class="new-edit">${newReplyCnt}</span></c:if>
			<i class="fa-solid fa-bell fa-xl mt-4" style="color: gray;" onclick="alarmBtn()"></i>
			<div class="user-profile"><img src="${ctp}/images/user/${uVo.userImg}" alt="유저프로필" onclick="profileBtn()"></div>
		</div>
	</div>
	<main>
		<div class="container">
			<div class="sidebar">
		        <div class="profile">
		            <img src="${ctp}/images/user/${uVo.userImg}" alt="Profile" class="profile-img">
		            <div class="profile-name" onclick="location.href='${ctp}/blog/${uVo.mid}';">${bVo.blogTitle}</div>
		            <div class="profile-link">${fn:replace(bVo.blogIntro, newLine, "<br/>")}</div>
		        </div>
		        <nav>
		            <ul>
		                <li class="parent-li active" style="cursor:pointer;" onclick="location.href='${ctp}/BlogEdit/${sMid}';"><i class="fa-solid fa-gear mr-2"></i>기본 설정</li>
		                <hr/>
		                <li class="parent-li"><i class="fa-regular fa-image mr-2"></i>콘텐츠</li>
		                <ul>
		                    <li onclick="location.href='${ctp}/ContentsEdit/${sMid}';">글 관리</li>
		                    <li onclick="location.href='${ctp}/CategoryEdit/${sMid}';">카테고리 관리</li>
		                </ul>
		                <hr/>
		                <li class="parent-li"><i class="fa-regular fa-comment mr-2" style="color: #424242;"></i>댓글·구독</li>
		                <ul>
		                    <li onclick="location.href='${ctp}/ReplysEdit/${sMid}';">댓글 관리</li>
		                    <li  onclick="location.href='${ctp}/SubEdit/${sMid}';">구독 관리</li>
		                </ul>
		            </ul>
		        </nav>
		    </div>
		    <div class="main-content">
		        <h1>기본 설정</h1>
		        <div class="category-manager">
		            <div class="category-list">
						<form name="blogEditForm" method="post">
							<table class="table table-bordered text-center">
								<tr>
									<td class="table-label">블로그 이름</td>
									<td class="table-content">
										<input type="text" value="${bVo.blogTitle}" name="blogTitle" id="blogTitle" class="form-control"/>
									</td>
								</tr>
								<tr>
									<td class="table-label">블로그 소개</td>
									<td class="table-content">
										<textarea rows="3" class="form-control font-light" name="blogIntro" id="blogIntro">${bVo.blogIntro}</textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="table-content">
										<input type="button" value="변경" onclick="blogEditCheck()" class="proBtn mr-2"/>
									</td>
								</tr>
							</table>
							<input type="hidden" name="mid" id="mid" value="${sMid}" />
						</form>
		            </div>
		        </div>
		    </div>
		</div>
	</main>
	<div class="footer"></div>
	<script>
		$(document).ready(function() {
		    $(window).scrollTop(0);
		});
		
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
	            headerLayer.innerHTML = '<div class="notification-top">새소식 &nbsp;<font color="#ff7200">${newReplyCnt}</font></div><hr class="notification-hr"/>'
	                +'<div class="notification-list">'
	                +'<c:if test="${fn:length(vos) == 0}"><div class="text-center" style="margin-top:170px;">새 소식이 없습니다.</div></c:if>'
	                +'<c:forEach var="vo" items="${vos}">'
	                    +'<div class="notification" onclick="location.href=&quot;${ctp}/content/${sMid}?coIdx=${vo.rCoIdx}&rIdx=${vo.rIdx}&quot;">'
	                        +'<img src="${ctp}/images/user/${vo.rUserImg}" alt="프로필 사진" class="profile-pic">'
	                        +'<div class="notification-content">'
	                            +'<div class="notification-header">'
	                                +'<p class="user"><span class="user-name">${vo.rNickName}</span>님이 댓글을 남겼습니다.</p>'
	                                +'<p class="date">${fn:substring(vo.rDate, 0, 10)}</p>'
	                            +'</div>'
	                            +'<p class="comment">"${fn:replace(vo.rContent, newLine, "<br/>")}"</p>'
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
	            +'    <span class="layer_profile_username">${uVo.nickName}</span>'
	            +'    </div>'
	            +'  <div class="u-mail_u-account"><span class="layer_profile_email">${uVo.email}</span>'
	            +'    <span class="layer_profile_account-management" onclick="location.href=&quot;${ctp}/UserEdit.u&quot;">계정관리</span>'
	            +'</div>'
	            +'        <hr/>'
	            +'<div class="user_blogs">'
	            +'    <div class="user_blog">'
	            +'        <span class="b-title">운영중인 블로그</span>'
	            +'    </div>'
	            +'    <div class="user_blog">'
	            +'        <span class="user_blog-title" onclick="location.href=&quot;${ctp}/blog/${sMid}&quot;">${bVo.blogTitle}</span>'
	            +'            <div class="user-blog-btn">'
	            +'        <span class="user_write-icon"><i class="fa-solid fa-pen-to-square fa-sm" style="color: #A6A6A6;" onclick="location.href=&quot;${ctp}/ContentInput/${sMid}&quot;"></i></span>'
	            +'        <span class="user_settings-icon"><i class="fa-solid fa-gear fa-sm" style="color: #A6A6A6;" onclick="location.href=&quot;${ctp}/BlogEdit/${sMid}&quot;"></i></span>'
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
	    
	    // 블로그 변경
	    function blogEditCheck() {
			let blogTitle = blogEditForm.blogTitle.value.trim();
			let blogIntro = blogEditForm.blogIntro.value.trim();
			let mid = blogEditForm.mid.value;
			
			if(blogTitle == ""){
				$("#myModal #modalTitle").text("블로그 이름");
				$("#myModal #modalText").text("블로그 이름을 적어주세요!");
			    $('#myModal').modal('show');
			}
			else {
				$.ajax({
					url : "${ctp}/BlogEditOk",
					type : "post",
					data : {blogTitle : blogTitle, blogIntro : blogIntro, mid : mid},
					success : function(res) {
						if(res != "0"){
							$("#myModal #modalTitle").text("블로그 수정");
							$("#myModal #modalText").text("블로그 정보를 수정했습니다!");
						    $('#myModal').modal('show');
					        $('#myModal').on('hide.bs.modal', function () {
								location.reload();
					        });
						}
					},
					error : function() {
						$("#myModal #modalTitle").text("오류");
						$("#myModal #modalText").text("전송 오류!");
					    $('#myModal').modal('show');
					}
				});
			}
		}

    </script>
   <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title" id="modalTitle"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <div id="modalText"></div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>
</body>
</html>