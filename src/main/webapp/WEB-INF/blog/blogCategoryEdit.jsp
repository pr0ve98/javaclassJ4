<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${bVo.blogTitle} - 카테고리 관리</title>
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
		            <div class="profile-link">${bVo.blogIntro}</div>
		        </div>
		        <nav>
		            <ul>
		                <li class="parent-li" style="cursor:pointer;" onclick="location.href='${ctp}/BlogEdit/${sMid}';"><i class="fa-solid fa-gear mr-2" style="color: #363636;"></i>기본 설정</li>
		                <hr/>
		                <li class="parent-li active"><i class="fa-regular fa-image mr-2"></i>콘텐츠</li>
		                <ul>
		                    <li onclick="location.href='${ctp}/ContentsEdit/${sMid}';">글 관리</li>
		                    <li class="active" onclick="location.href='${ctp}/CategoryEdit/${sMid}';">카테고리 관리</li>
		                </ul>
		                <hr/>
		                <li class="parent-li"><i class="fa-regular fa-comment mr-2" style="color: #424242;"></i>댓글·구독</li>
		                <ul>
		                    <li onclick="location.href='${ctp}/ReplysEdit/${sMid}';">댓글 관리</li>
		                    <li onclick="location.href='${ctp}/SubEdit/${sMid}';">구독 관리</li>
		                </ul>
		            </ul>
		        </nav>
		    </div>
		    <div class="main-content">
		        <h1>카테고리 관리</h1>
		        <div class="category-manager">
		            <div class="category-list">
		        		하위 카테고리를 추가하려면 상위 카테고리를 선택 후 카테고리를 추가해주세요.<br/>
		        		카테고리를 추가했을 경우 적용 버튼을 누르고 수정, 삭제해주세요.
		                <div class="category-box">
						    <ul class="list-group" id="category-list">
						        <c:forEach var="cPVo" items="${cPVos}">
						            <li class="parent-category" id="parent-${cPVo.caIdx}">
						                <div class="list-group-item">
						                    <strong>${cPVo.category}</strong><c:if test="${cPVo.publicSetting == '비공개'}"><i class="fa-solid fa-lock fa-sm ml-2" style="color: gray;"></i></c:if>
						                    <div class="edit-btns">
						                    	<c:if test="${cPVo.publicSetting == '공개'}"><input type="button" value="비공개로 변경" onclick="categoryPrivateEdit(${cPVo.caIdx})" class="proBtn-sm mr-1"></c:if>
						                    	<c:if test="${cPVo.publicSetting == '비공개'}"><input type="button" value="공개로 변경" onclick="categoryPublicEdit(${cPVo.caIdx})" class="proBtn-sm mr-1"></c:if>
						                        <input type="button" value="추가" onclick="categoryPrAdd('parent-${cPVo.caIdx}-children')" class="proBtn-sm mr-1">
						                        <input type="button" value="수정" onclick="categoryEditModal(${cPVo.caIdx},'${cPVo.category}')" data-target="#myModal" class="proBtn-sm mr-1">
						                        <input type="button" value="삭제" onclick="categoryDeleteModal(${cPVo.caIdx},'${cPVo.category}')" class="proBtn-sm mr-1">
						                    </div>
						                </div>
						                <ul class="list-group-child mt-2" id="parent-${cPVo.caIdx}-children">
						                    <c:forEach var="cCVo" items="${cCVos}">
						                        <c:if test="${cCVo.parentCategoryIdx == cPVo.caIdx}">
						                            <li class="list-group-item" id="child-${cCVo.caIdx}" data-id="${cCVo.caIdx}">
						                                ${cCVo.category}<c:if test="${cCVo.publicSetting == '비공개'}"><i class="fa-solid fa-lock fa-sm ml-2" style="color: gray;"></i></c:if>
						                                <div class="edit-btns">
						                                	<c:if test="${cCVo.publicSetting == '공개'}"><input type="button" value="비공개로 변경" onclick="categoryPrivateEdit(${cCVo.caIdx})" class="proBtn-sm mr-1"></c:if>
						                    				<c:if test="${cCVo.publicSetting == '비공개'}"><input type="button" value="공개로 변경" onclick="categoryPublicEdit(${cCVo.caIdx})" class="proBtn-sm mr-1"></c:if>
						                                    <input type="button" value="수정" onclick="categoryEditModal(${cCVo.caIdx}, '${cCVo.category}')" data-target="#myModal" class="proBtn-sm mr-1">
						                                    <input type="button" value="삭제" onclick="categoryDeleteModal(${cCVo.caIdx}, '${cCVo.category}')" class="proBtn-sm mr-1">
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
				        	<input type="button" value="취소" class="proBtn" onclick="location.reload()" />
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
	    
	    let selectedParent = null;
	    
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
	    

	    // 카테고리 추가함수
	    function categoryAdd() {
	    	let temp = Date.now();
	    	
	        if (selectedParent) {
	            let parentCategoryId = $(selectedParent).find('ul').attr('id');
	            console.log(parentCategoryId);
	            let newSubCategoryHtml = '<li class="list-group-item" data-id="temp-child-'+temp+'">새 카테고리</li>';
	            document.getElementById(parentCategoryId).innerHTML += newSubCategoryHtml;
	        } else {
	            let newParentCategoryHtml = '<li class="parent-category" id="temp-parent-'+temp+'">'
	                    +'<strong class="list-group-item">새 카테고리</strong>'
	                    +'<ul class="list-group-child mt-2" id="parent-'+temp+'-children"></ul>'
	                +'</li>';
	            	document.getElementById('category-list').innerHTML += newParentCategoryHtml;
	        }
	    }
	    
	    // 카테고리 버튼으로 추가
	    function categoryPrAdd(id) {
	    	let temp = Date.now();
	    	
            let newSubCategoryHtml = '<li class="list-group-item" data-id="temp-child-'+temp+'">새 카테고리</li>';
            document.getElementById(id).innerHTML += newSubCategoryHtml;
		}
	
	    
	 	// 변경사항 적용 함수
	    function categorySubmit() {
	        let categories = [];
	        $('#category-list .parent-category').each(function() {
	            let parentId = $(this).attr('id');
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
					$("#myModal #modalTitle").text("카테고리 저장");
					$("#myModal #modalText").text("카테고리가 저장됐어요!");
				    $('#myModal').modal('show');
			        $('#myModal').on('hide.bs.modal', function () {
	                	location.reload();
			        });
	            },
	            error: function() {
					$("#myModal #modalTitle").text("오류");
					$("#myModal #modalText").text("전송 오류!");
				    $('#myModal').modal('show');
	            }
	        });
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
	    
	    // 카테고리 수정 모달
	    function categoryEditModal(caIdx, caName) {
	    	let formHtml = '<div>변경할 이름을 적어주세요</div>'
	    		+'<form class="form-inline" name="categoryEditForm" method="post">'
	    		+'<div class="input-group">'
	    		+'<input type="text" name="caName" id="caName" placeholder="'+caName+'" class="form-control" />'
	    		+'<div class="input-group-append">'
	    		+'<input type="button" value="변경" onclick="categoryEdit()" class="proBtn ml-2">'
	    		+'<input type="hidden" name="caIdx" id="caIdx" value='+caIdx+' />'
	    		+'</div></div></form>';
			$("#myModal #modalTitle").text("카테고리 수정");
			$("#myModal #modalText").html(formHtml);
			
		    $('#myModal').on('shown.bs.modal', function () {
		        $('#caName').focus();
		    });

		    $('#myModal').modal('show');
		}
	    
	    // 카테고리 수정
	    function categoryEdit() {
			let caName = categoryEditForm.caName.value.trim();
			let caIdx = categoryEditForm.caIdx.value;
			
			if(caName == ""){
				$("#error-name").show();
				return;
			}
			
			$("#error-name").hide();
			
			$.ajax({
				url : "${ctp}/BlogCategoryEdit",
				type : "post",
				data : {caName : caName, caIdx : caIdx},
				success : function(res) {
					if(res != "0"){
						location.reload();
					}
				},
				error : function() {
					$("#myModal #modalTitle").text("오류");
					$("#myModal #modalText").text("전송 오류!");
				    $('#myModal').modal('show');
				}
			});
		}
	    
	    // 카테고리 삭제 모달
	    function categoryDeleteModal(caIdx, caName) {
			let htmlFooter = '<button type="button" class="btn btn-danger mr-2" onclick="categoryDelete('+caIdx+')">삭제</button>'
				+'<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>';
			
			$("#myModal2 #modalTitle2").text("카테고리 삭제");
			$("#myModal2 #modalText2").html("정말로 "+caName+" 카테고리를 삭제하시겠습니까?<br/>카테고리를 삭제하면 카테고리에 속한 글들이 <font color='red'>모두 삭제</font>되며<br/><font color='red'>상위 카테고리를 삭제하면 하위 카테고리도 같이 삭제됩니다</font>");
			$("#myModal2 #modalFooter2").html(htmlFooter);
			$('#myModal2').modal('show');
		}
	    
	    // 카테고리 삭제
	    function categoryDelete(caIdx) {
			$.ajax({
				url : "${ctp}/BlogCategoryDelete",
				type : "post",
				data : {caIdx : caIdx},
				success : function(res) {
					if(res != "0"){
						location.reload();
					}
				},
				error : function() {
					$("#myModal #modalTitle").text("오류");
					$("#myModal #modalText").text("전송 오류!");
					$('#myModal').modal('show');
				}
			});
		}
	    
	    // 카테고리 비공개로 변경
	    function categoryPrivateEdit(caIdx) {
			$.ajax({
				url : "${ctp}/BlogCategoryPrivate",
				type : "post",
				data : {caIdx : caIdx},
				success : function(res) {
					if(res != 0){
						location.reload();
					}
					else {
						$("#myModal #modalTitle").text("카테고리 오류");
						$("#myModal #modalText").text("설정을 변경할 수 없었어요...");
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
	    
	    // 카테고리 공개로 변경
	    function categoryPublicEdit(caIdx) {
			$.ajax({
				url : "${ctp}/BlogCategoryPublic",
				type : "post",
				data : {caIdx : caIdx},
				success : function(res) {
					if(res == "부모비공개"){
						$("#myModal #modalTitle").text("카테고리 오류");
						$("#myModal #modalText").text("먼저 상위 카테고리를 공개로 변경해주세요!");
						$('#myModal').modal('show');
					}
					else if(res == "1") {
						location.reload();
					}
					else {
						$("#myModal #modalTitle").text("카테고리 오류");
						$("#myModal #modalText").text("설정을 변경할 수 없었어요...");
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
          <div id="error-name">카테고리 이름을 입력해야 합니다!</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>
  <!-- 카테고리 삭제 모달 -->
  <div class="modal fade" id="myModal2">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title" id="modalTitle2"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <div id="modalText2"></div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <div id="modalFooter2">
          	
          </div>
        </div>
        
      </div>
    </div>
  </div>
</body>
</html>