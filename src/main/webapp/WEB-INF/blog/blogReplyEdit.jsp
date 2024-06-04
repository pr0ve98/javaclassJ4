<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${bVo.blogTitle} - 댓글 관리</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<%@ include file="/include/bs4.jsp"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/blogeditcss.jsp"%>
<style>
	.list-group-item{
		display: flex;
		align-items: center;
		gap: 10px;
		border: none;
		border-top: 1px solid rgba(0, 0, 0, .125);
		border-bottom: 1px solid rgba(0, 0, 0, .125);
	}
	.header-right input[type="text"] {
		width: 50%;
	    padding-right: 30px;
	    border: 1px solid #ced4da;
	    border-radius: .25rem;
	    outline: none;
	    font-size: 16px;
	    margin-right: 15px;
	}
	.header-right button {
	    background: none;
	    border: none;
	    cursor: pointer;
	    font-size: 14px;
	    color: #D5D5D5;
	    position: relative;
	    right: 10px;
	}
	.header-right input[type="text"]::placeholder {
		padding-left: 5px;
	    color: #D5D5D5;
	}
	.header-left, .header-right {
		align-items: center;
		display: flex;
	}
	.header-right {
		justify-content: flex-end;
	}
</style>
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
		            <div class="profile-link">${bVo.blogIntro}</div>
		        </div>
		        <nav>
		            <ul>
		                <li class="parent-li" style="cursor:pointer;" onclick="location.href='${ctp}/BlogEdit/${sMid}';"><i class="fa-solid fa-gear mr-2"></i>기본 설정</li>
		                <hr/>
		                <li class="parent-li"><i class="fa-regular fa-image mr-2"></i>콘텐츠</li>
		                <ul>
		                    <li onclick="location.href='${ctp}/ContentsEdit/${sMid}';">글 관리</li>
		                    <li onclick="location.href='${ctp}/CategoryEdit/${sMid}';">카테고리 관리</li>
		                </ul>
		                <hr/>
		                <li class="parent-li active"><i class="fa-regular fa-comment mr-2"></i>댓글·구독</li>
		                <ul>
		                    <li class="active" onclick="location.href='${ctp}/ReplysEdit/${sMid}';">댓글 관리</li>
		                    <li  onclick="location.href='${ctp}/SubEdit/${sMid}';">구독 관리</li>
		                </ul>
		            </ul>
		        </nav>
		    </div>
		    <div class="main-content">
		        <h1>글 관리</h1>
		        <div class="category-manager mb-3">
					<div class="contentEdit mb-3">
						<div class="header-left">
							<div class="custom-control custom-checkbox">
								<input type="checkbox" class="custom-control-input" id="allCheck" name="example1" onclick="checkboxAllCheck()">
								<label class="custom-control-label" for="allCheck"></label>
							</div>
							<select name="change" class="custom-select custom-select-sm" onchange="ReplyChange()">
								<option value="0" selected>변경</option>
								<option>읽음</option>
								<option>삭제</option>
							</select>
						</div>
						<div class="header-right">
				            <select name="replyView" class="custom-select custom-select-sm mr-2">
								<option ${param.part == null || param.part == '작성자' ? 'selected' : ''}>작성자</option>
								<option ${param.part == '내용' ? 'selected' : ''}>내용</option>
							</select>
				            <input type="text" name="search" id="search" value="${param.search}" placeholder="Search..." />
				            <button type="button" onclick="replySearch()"><i class="fas fa-search"></i></button>
							<div class="proBtn-sm" onclick="location.href='${ctp}/ReplysEdit/${uVo.mid}'">처음으로</div>
				        </div>
					</div>
		            <div class="category-list">
		            	<c:if test="${fn:length(vos) == 0}">
		            	<div class="pt-5 pb-5">
		            		<div class="text-center">등록된 댓글이 없습니다.</div>
						</div>		            	
		            	</c:if>
		            	<c:forEach var="vo" items="${vos}" varStatus="st">
		                <div class="list-group-item pt-3 pb-3">
							<div class="custom-control custom-checkbox">
								<input type="checkbox" class="custom-control-input" id="ReplyCheck${st.index}" name="ReplyCheck" value="${vo.rIdx}">
								<label class="custom-control-label" for="ReplyCheck${st.index}"></label>
							</div>
							<div class="contentView">
								<fmt:parseDate value="${vo.rDate}" var="rDate" pattern="yyyy-MM-dd HH:mm:ss.0" />
								<div style="color:#999999; font-size:14px;"><span style="color:#ff7200">${vo.rNickName}</span> · ${vo.rHostIp} · <fmt:formatDate value="${rDate}" pattern="yyyy. MM. dd HH:mm" /><c:if test="${vo.rPublic == '비공개'}"><i class="fa-solid fa-lock fa-sm ml-2" style="color: gray;"></i></c:if></div>
			                    <c:if test="${vo.parentReplyIdx != 0}"><span style="color:#B2EBF4">[답글]&nbsp;</span></c:if><strong style="cursor:pointer" onclick="location.href=&quot;${ctp}/content/${sMid}?coIdx=${vo.rCoIdx}&rIdx=${vo.rIdx}&quot;">${vo.rContent}</strong><c:if test="${vo.readCheck == '읽지않음' && vo.rMid != sMid}"><i class="fa-solid fa-n fa-sm ml-2" style="color: #ff7200;"></i></c:if>
								<div style="color:#999999; font-size:14px;">
									${vo.coTitle}
								</div>
							</div>
		                    <div class="edit-btns">
		                        <input type="button" value="삭제" onclick="replyDeleteModal(${vo.rIdx})" class="proBtn-sm mr-1">
		                    </div>
		                </div>
		                </c:forEach>
					</div>
	            </div>
			    <!-- 페이지네이션 시작 -->
		        <div class="pagination">
			        <c:if test="${curBlock > 0}"><a href="${ctp}/ContentsEdit/${uVo.mid}?page=${(curBlock-1)*blockSize + 1}"><i class="fa-solid fa-angle-left fa-2xs"></i></a></c:if>
			        <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
				        <c:if test="${i <= totPage && i == page}"><a href="${ctp}/ContentsEdit/${uVo.mid}?page=${i}" class="active">${i}</a></c:if>
				        <c:if test="${i <= totPage && i != page}"><a href="${ctp}/ContentsEdit/${uVo.mid}?page=${i}">${i}</a></c:if>
			        </c:forEach>
			        <c:if test="${curBlock < lastBlock}"><a href="${ctp}/ContentsEdit/${uVo.mid}?page=${(curBlock+1)*blockSize+1}"><i class="fa-solid fa-angle-right fa-2xs"></i></a></c:if>
		    	</div>
		    	<!-- 페이지네이션 끝 -->
	        </div>
	    </div>
	</main>
	<div class="footer"></div>
	<script>
		'use strict';
	
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
	                +'<c:if test="${fn:length(nVos) == 0}"><div class="text-center" style="margin-top:170px;">새 소식이 없습니다.</div></c:if>'
	                +'<c:forEach var="nVo" items="${nVos}">'
	                    +'<div class="notification" onclick="location.href=&quot;${ctp}/content/${sMid}?coIdx=${nVo.rCoIdx}&rIdx=${nVo.rIdx}&quot;">'
	                        +'<img src="${ctp}/images/user/${nVo.rUserImg}" alt="프로필 사진" class="profile-pic">'
	                        +'<div class="notification-content">'
	                            +'<div class="notification-header">'
	                                +'<p class="user"><span class="user-name">${nVo.rNickName}</span>님이 댓글을 남겼습니다.</p>'
	                                +'<p class="date">${fn:substring(nVo.rDate, 0, 10)}</p>'
	                            +'</div>'
	                            +'<p class="comment">"${fn:replace(nVo.rContent, newLine, "<br/>")}"</p>'
	                            +'<p class="title">${nVo.coTitle}</p>'
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
	    
	    
	    // 삭제 버튼 보이기/감추기
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
	    
		let sw = 0;
		function checkboxAllCheck() {
			if(sw == 0){
				$("#allCheck").prop("checked", true);
				for(let i=0; i<${fn:length(vos)}; i++){
					$("#ReplyCheck"+i).prop("checked", true);
				}
				sw = 1;
			}
			else {
				$("#allCheck").prop("checked", false);
				for(let i=0; i<${fn:length(vos)}; i++){
					$("#ReplyCheck"+i).prop("checked", false);
				}
				sw = 0;
			}
		}
		
		let deleteSw = 0;
		function replyDeleteOk() {
			deleteSw = 1;
			$('#myModal2').modal('hide');
			ReplyChange();
		}
		
		function ReplyChange() {
			let changeSelected = document.querySelector('select[name="change"]');
			let selected = changeSelected.value;
			let checkedBoxes = document.querySelectorAll('input[name="ReplyCheck"]:checked');
			let checkedrIdx = "";
			
			if(selected == 0) return;
			
			if(checkedBoxes.length == 0) return;
			
			for(let i=0; i<checkedBoxes.length; i++){
				checkedrIdx += checkedBoxes[i].value+",";
			}
			
			if(selected == '삭제'){
			    $('#myModal2').modal('show');
			    if(deleteSw == 0) return;
			}
			$('#myModal').modal('hide');
			
			$.ajax({
				url : "${ctp}/ReplyChange",
				type : "post",
				data : {selected : selected, checkedrIdx : checkedrIdx},
				success : function(res) {
					if(res != "0"){
						location.reload();
					}
					else {
						$("#myModal #modalTitle").text("댓글 수정");
						$("#myModal #modalText").text("댓글 수정 실패!");
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
		
		function replyDeleteModal(rIdx) {
			$("#myModal #modalTitle").text("댓글 삭제"); 
			$("#myModal #modalText").text("정말로 삭제하시겠습니까?");
			let footerHtml = '<button type="button" class="btn btn-danger mr-2" onclick="replyDelete('+rIdx+')">삭제</button>'
							+'<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>';
			$("#myModal #modal-footer").html(footerHtml);
		    $('#myModal').modal('show');
		}
		
		function replyDelete(rIdx) {
			$('#myModal').modal('hide');
			$.ajax({
				url : "${ctp}/ReplyDelete",
				type : "post",
				data : {rIdx : rIdx},
				success : function(res) {
					if(res != "0"){
						location.reload();
					}
					else {
						$("#myModal #modalTitle").text("댓글 삭제");
						$("#myModal #modalText").text("댓글 삭제 실패!");
					    $('#myModal').modal('show');
					}
				},
				error : function() {
					$("#myModal #modalTitle").text("오류");
					$("#myModal #modalText").text("전송 오류!");
				    $('#myModal').modal('show');
					
				}
			});
		}
		
		function replySearch() {
			let viewSelected = document.querySelector('select[name="replyView"]');
			let selected = viewSelected.value;
			let search = $("#search").val();
			location.href = "${ctp}/ReplysEdit/${uVo.mid}?search="+search+"&part="+selected;
		}
		
		// 엔터로도 검색
		document.addEventListener('DOMContentLoaded', function() {
		    let searchInput = document.getElementById('search');

		    if (searchInput) {
		        searchInput.addEventListener('keyup', function(e) {
		            if (e.key === 'Enter') {
		            	replySearch();
		            }
		        });
		    }
		});

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
        <div class="modal-footer" id="modal-footer">
          <button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>
  
  <!-- 삭제 확인 모달 -->
  <div class="modal fade" id="myModal2">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title" id="modalTitle">댓글 삭제</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <div id="modalText">정말로 삭제하시겠습니까?</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer" id="modal-footer">
        	<button type="button" class="btn btn-danger mr-2" onclick="replyDeleteOk()">삭제</button>
          	<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>
</body>
</html>