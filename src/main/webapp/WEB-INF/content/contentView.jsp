<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${contentVo.title} - 에이치로그</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/bs4.jsp"%>
<%@ include file="/include/blogcss.jsp"%>
<script>
	'use strict';
	
    $(document).ready(function() {
    	const replyCheck = ${rIdx};

        if(replyCheck && replyCheck !== 'null'){
            const targetElement = $('#reply' + replyCheck);

            // 요소가 렌더링된 후에 스크롤 위치 설정
            setTimeout(function() {
                if (targetElement.length) {
                    // 요소로 스크롤
                    $('html, body').scrollTop(targetElement.offset().top);
                    // reply-active 클래스 추가
                    targetElement.addClass('reply-active');
                }
            }, 500); // 500ms 지연
        }
    	
        let sw2 = localStorage.getItem('replyViewState');
        if (sw2 == 1) {
            $("#replys").show();
        }
        else {
            $("#replys").hide();
        }
        
    });
	
    
	function contentDelete(coIdx) {
		$('#myModal').modal('hide');
		$.ajax({
			url : "${ctp}/ContentDelete",
			type : "get",
			data : {
				coIdx : coIdx,
				mid : '${userMid}',
				categoryIdx : ${categoryIdx},
				page : ${page},
				imgName : '${contentVo.imgName}',
				sw : 0
			},
			success : function(res) {
				if(res == "0"){
					$("#myModal #modalTitle").text("게시글 삭제");
					$("#myModal #modalText").text("삭제 실패!");
					$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
				    $('#myModal').modal('show');
				}
				else {
					window.location.replace(res); // 뒤로가기 방지용
				}
			},
			error : function() {
				$("#myModal #modalTitle").text("오류");
				$("#myModal #modalText").text("전송 오류!");
				$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
			    $('#myModal').modal('show');
				
			}
		});
	}
	
	function replyWriteCheck() {
		let rContent = $("#rContent").val();
		let mid = replyWrite.mid.value;
		let nickName = replyWrite.nickName.value;
		let hostIp = replyWrite.hostIp.value;
		let coIdx = replyWrite.coIdx.value;
		let userMid = replyWrite.userMid.value;
		let replyCheckBox = document.querySelector('input[id="replySC"]');
        let replySC = replyCheckBox.checked ? replyCheckBox.value : '공개';
		
		if(rContent == null || rContent == ""){
			$("#myModal #modalTitle").text("댓글 오류");
			$("#myModal #modalText").text("댓글 내용을 작성해주세요!");
			$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
		    $('#myModal').modal('show');
		    return;
		}
		
		let query = {
			mid : mid,
			nickName : nickName,
			hostIp : hostIp,
			coIdx : coIdx,
			replySC : replySC,
			rContent : rContent,
			userMid : userMid,
			sw : 0
		}
		
		$.ajax({
			url : "${ctp}/ReplyInput",
			type : "post",
			data : query,
			success : function(res) {
				if(res != "0") location.reload();
			},
			error : function() {
				$("#myModal #modalTitle").text("오류");
				$("#myModal #modalText").text("전송 오류!");
				$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
			    $('#myModal').modal('show');
			}
		});
	}
	
	function replyWriteCheck2(prIdx) {
		let rContent = $("#rContent"+prIdx).val();
		let mid = $("#mid"+prIdx).val();
		let nickName = $("#nickName"+prIdx).val();
		let hostIp = $("#hostIp"+prIdx).val();
		let coIdx = $("#coIdx"+prIdx).val();
		let userMid = $("#userMid"+prIdx).val();
		let replyCheckBox = document.querySelector('input[id="replySC'+prIdx+'"]');
        let replySC = replyCheckBox.checked ? replyCheckBox.value : '공개';
		
		if(rContent == null || rContent == ""){
			$("#myModal #modalTitle").text("댓글 오류");
			$("#myModal #modalText").text("댓글 내용을 작성해주세요!");
			$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
		    $('#myModal').modal('show');
		    return;
		}
		
		let query = {
			mid : mid,
			nickName : nickName,
			hostIp : hostIp,
			coIdx : coIdx,
			replySC : replySC,
			rContent : rContent,
			parentReplyIdx : prIdx,
			userMid : userMid,
			sw : 1
		}
		
		$.ajax({
			url : "${ctp}/ReplyInput",
			type : "post",
			data : query,
			success : function(res) {
				if(res != "0") location.reload();
			},
			error : function() {
				$("#myModal #modalTitle").text("오류");
				$("#myModal #modalText").text("전송 오류!");
				$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
			    $('#myModal').modal('show');
			}
		});
	}
	
	let sw = 0;
	function rreplyShow(rIdx) {
		if(sw == 0){
			$("#rre"+rIdx).show();
			sw = 1;
		}
		else {
			sw = 0;
			$("#rre"+rIdx).hide();
		}
	}
	
	function replyEditModal(content, rPublic, rIdx) {
		$("#modalContent").text(content);
		let fh = '<button type="button" class="proBtn mr-2" onclick="replyEdit('+rIdx+')">수정</button>'
          	+'<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>';
        $("#myModal2 #modal-footer2").html(fh);
        
        let th = '<form name="replyEditForm" method="post">'
        		+'<textarea rows="3" class="form-control" name="modalContent" id="modalContent">'+content+'</textarea>'
        		+'<div id="error-name">공백으로 수정할 수 없습니다!</div>'
        		+'<div class="custom-control custom-checkbox">';
        		
	    if(rPublic == '비공개') th += '<input type="checkbox" class="custom-control-input" id="replyEditSC" name="replyEditSC" value="비공개" checked>';
	    else th += '<input type="checkbox" class="custom-control-input" id="replyEditSC" name="replyEditSC" value="비공개">';
		
	    th += '<label class="custom-control-label" for="replyEditSC">비밀글로 작성</label>'
			+'</div></form>';
        $("#myModal2 #modalText2").html(th);
        
        $('#myModal2').modal('show');
	}
	
	function replyEdit(rIdx) {
		let content = $("#modalContent").val();
		let replyEditCheckBox = document.querySelector('input[id="replyEditSC"]');
        let replyEditSC = replyEditCheckBox.checked ? replyEditCheckBox.value : '공개';
        
		if(content == "" || content == null){
			$("#error-name").show();
			return;
		}
		
		$('#myModal2').modal('hide');
		
		$.ajax({
			url : "${ctp}/ReplyEdit",
			type : "post",
			data : {content : content, rIdx : rIdx, replyEditSC : replyEditSC},
			success : function(res) {
				if(res != "0"){
					location.reload();
				}
			},
			error : function() {
				$("#myModal #modalTitle").text("오류");
				$("#myModal #modalText").text("전송 오류!");
				$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
			    $('#myModal').modal('show');
			}
		});
	}
	
    function replyView() {
        let sw2 = localStorage.getItem('replyViewState');
        if (sw2 == 0 || sw2 === null) {
            $("#replys").show();
            localStorage.setItem('replyViewState', 1);
        } else {
            $("#replys").hide();
            localStorage.setItem('replyViewState', 0);
        }
    }
    
	function replyDeleteModal(rIdx) {
        $("#myModal #title").text("댓글 삭제");
        $("#myModal #modalText").html("정말 삭제하시겠습니까?<br><font color='red'>상위 댓글을 삭제하면 대댓글도 삭제됩니다</font>");
		let fh = '<button type="button" class="btn btn-danger mr-2" onclick="replyDelete('+rIdx+')">삭제</button>'
          	+'<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>';
        $("#myModal #modal-footer").html(fh);
        $('#myModal').modal('show');
	}
	
	function replyDelete(rIdx) {
		$.ajax({
			url : "${ctp}/ReplyDelete",
			type : "post",
			data : {rIdx : rIdx},
			success : function(res) {
				if(res != "0"){
					location.reload();
				}
			},
			error : function() {
				$("#myModal #modalTitle").text("오류");
				$("#myModal #modalText").text("전송 오류!");
				$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
			    $('#myModal').modal('show');
			}
		});
	}
	
	function contentSearch() {
		let search = $("#search").val();
		location.href = "${ctp}/blog/${userMid}?search="+search;
	}
	
	// 엔터로도 검색
	document.addEventListener('DOMContentLoaded', function() {
	    let searchInput = document.getElementById('search');

	    if (searchInput) {
	        searchInput.addEventListener('keyup', function(e) {
	            if (e.key === 'Enter') {
	            	contentSearch();
	            }
	        });
	    }
	});
	
	function subOk() {
		$.ajax({
			url : "${ctp}/Subscribe/${sMid}",
			type : "post",
			data : {blogIdx : ${bVo.blogIdx}},
			success : function(res) {
				if(res != "0"){
					$("#myModal #modalTitle").text("블로그 구독");
					$("#myModal #modalText").text("구독에 성공했어요!");
					$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
				    $('#myModal').modal('show');
				    $('#myModal').on('hide.bs.modal', function () {
			            location.reload();
			        });
				}
				else {
					$("#myModal #modalTitle").text("블로그 구독");
					$("#myModal #modalText").text("구독에 실패했어요...");
					$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
				    $('#myModal').modal('show');
				}
			},
			error : function() {
				$("#myModal #modalTitle").text("오류");
				$("#myModal #modalText").text("전송 오류!");
				$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
			    $('#myModal').modal('show');
			}
		});
	}
	
	function subDelete() {
		$.ajax({
			url : "${ctp}/SubscribeDelete/${sMid}",
			type : "post",
			data : {blogIdx : ${bVo.blogIdx}},
			success : function(res) {
				if(res != "0"){
					$("#myModal #modalTitle").text("블로그 구독");
					$("#myModal #modalText").text("구독 해제에 성공했어요!");
					$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
				    $('#myModal').modal('show');
				    $('#myModal').on('hide.bs.modal', function () {
			            location.reload();
			        });
				}
				else {
					$("#myModal #modalTitle").text("블로그 구독");
					$("#myModal #modalText").text("구독 해제에 실패했어요...");
					$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
				    $('#myModal').modal('show');
				}
			},
			error : function() {
				$("#myModal #modalTitle").text("오류");
				$("#myModal #modalText").text("전송 오류!");
				$("#myModal #modal-footer").html('<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>');
			    $('#myModal').modal('show');
			}
		});
	}
</script>
<style>
	.reply-active {
		background-color: rgba(255, 255, 0, 0.2);
	}
</style>
</head>
<body>
<header>
    <div class="header-container">
        <div class="header-left">
            <div class="header-title" onclick="location.href='${ctp}/blog/${userMid}';">${bVo.blogTitle}</div>
        </div>
        <div class="header-right">
            <input type="text" name="search" id="search" value="${param.search}" placeholder="Search...">
            <button type="button" onclick="contentSearch()"><i class="fas fa-search"></i></button>
        </div>
    </div>
</header>
<main class="container">
	<section class="posts">
		 <div class="post-list">
            <table>
               <tr style="color:#D5D5D5;">
                   <td></td>
                   <td class="title">글 제목</td>
                   <td class="viewCnt">조회수</td>
                   <td class="wDate">작성일</td>
               </tr>
               <c:if test="${!empty preVo.title}">
               <tr>
                   <td>이전글</td>
                   <td class="title"><a href="${ctp}/content/${userMid}?coIdx=${preVo.coIdx}&categoryIdx=${categoryIdx}&page=${page}">${preVo.title}</a></td>
                   <td class="viewCnt">${preVo.viewCnt}</td>
                   <td class="wDate">
                    <fmt:parseDate value="${preVo.wDate}" var="preWDate" pattern="yyyy-MM-dd HH:mm:ss.0" />
					<fmt:formatDate value="${preWDate}" pattern="yyyy. MM. dd" />
                   </td>
               </tr>
               </c:if>
               <tr class="nowContent">
                   <td>현재글</td>
                   <td class="title">${contentVo.title}</td>
                   <td class="viewCnt">${contentVo.viewCnt}</td>
                   <td class="wDate">
                  	<fmt:parseDate value="${contentVo.wDate}" var="nowWDate" pattern="yyyy-MM-dd HH:mm:ss.0" />
					<fmt:formatDate value="${nowWDate}" pattern="yyyy. MM. dd" />
                   </td>
               </tr>
				<c:if test="${!empty nextVo.title}">
               <tr>
                   <td class="">다음글</td>
                   <td class="title"><a href="${ctp}/content/${userMid}?coIdx=${nextVo.coIdx}&categoryIdx=${categoryIdx}&page=${page}">${nextVo.title}</a></td>
                   <td class="viewCnt">${nextVo.viewCnt}</td>
                   <td class="wDate">
                   <fmt:parseDate value="${nextVo.wDate}" var="nextWDate" pattern="yyyy-MM-dd HH:mm:ss.0" />
					<fmt:formatDate value="${nextWDate}" pattern="yyyy. MM. dd" />
                   </td>
               </tr>
               </c:if>
            </table>
        </div>
        <div class="post-detail">
            <h5><a href="${ctp}/blog/${userMid}?categoryIdx=${contentVo.categoryIdx}">${contentVo.categoryName}</a></h5>
            <h1 class="mb-5">${contentVo.title}</h1>
            <div class="post-data">
            	<div>
            		<img src="${ctp}/images/user/${userImg}" alt="profile" class="mr-2">
	                <span class="author mr-2">${nickName}</span>
	                <span class="date">
	                	<fmt:parseDate value="${contentVo.wDate}" var="wDate" pattern="yyyy-MM-dd HH:mm:ss.0" />
						<fmt:formatDate value="${wDate}" pattern="yyyy. MM. dd HH:mm" />
	                </span>
                </div>
                <div class="content-menu">
	                <div class="proBtn-sm"><a href="javascript:history.back()">돌아가기</a></div>
	                <c:if test="${userMid == sMid}">
						<div class="dropdown ml-3"><i class="fa-solid fa-bars fa-xl" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" style="color: #D5D5D5; cursor:pointer;"></i>
				 			<div class="dropdown-menu">
				 			<a class="dropdown-item" href="${ctp}/edit/${userMid}?coIdx=${coIdx}&categoryIdx=${categoryIdx}">
				 				<i class="fa-solid fa-pen fa-sm mr-2" style="color:gray"></i>수정
				 			</a>
				 			<a class="dropdown-item" data-toggle="modal" data-target="#myModal">
				 				<font color="#FF5A5A"><i class="fa-solid fa-trash fa-sm mr-2"></i>삭제</font>
				 			</a>
				 			</div>
				 		</div>
			 		</c:if>
		 		</div>
            </div>
            <hr/>
            <div class="content mb-3">${contentVo.content}</div>
        </div>
		<div class="mb-5"><span class="proBtn" onclick="replyView()"><i class="fa-regular fa-comment-dots fa-sm" style="color: #6b6b6b;"></i> | 댓글 ${contentVo.replyCnt}</span></div>
		<div id="replys">
		<c:forEach var="rPVo" items="${rPVos}">
		<c:if test="${rPVo.rPublic == '공개' || (rPVo.rPublic == '비공개' && (rPVo.rMid == sMid || sMid == userMid))}">
		<div class="reply-list" id="reply${rPVo.rIdx}">
			<c:if test="${rPVo.rUserImg != null}"><img src="${ctp}/images/user/${rPVo.rUserImg}" alt="profile" class="mr-2"></c:if>
			<c:if test="${rPVo.rUserImg == null}"><img src="${ctp}/images/user/user_basic.jpg" alt="profile" class="mr-2"></c:if>
			<span style="cursor:pointer;" onclick="location.href='${ctp}/blog/${rPVo.rMid}';">${rPVo.rNickName}</span><c:if test="${rPVo.rPublic == '비공개'}"><i class="fa-solid fa-lock fa-sm ml-2" style="color: gray;"></i></c:if>
			<div>${fn:replace(rPVo.rContent, newLine, "<br/>")}</div>
			<div class="date" style="font-size:14px;">
               	<fmt:parseDate value="${rPVo.rDate}" var="rPDate" pattern="yyyy-MM-dd HH:mm:ss.0" />
				<fmt:formatDate value="${rPDate}" pattern="yyyy. MM. dd HH:mm" />
			</div>
			<div>
				<span class="proBtn-sm mt-2" onclick="rreplyShow(${rPVo.rIdx})">답글</span>
				<c:if test="${rPVo.rMid == sMid}"><span class="proBtn-sm mt-2" onclick="replyEditModal('${rPVo.rContent}', '${rPVo.rPublic}', ${rPVo.rIdx})">수정</span></c:if>
				<c:if test="${rPVo.rMid == sMid || sMid == userMid}"><span class="proBtn-sm mt-2" onclick="replyDeleteModal('${rPVo.rIdx}')">삭제</span></c:if>
			</div>
		</div>
		</c:if>
		<c:if test="${rPVo.rPublic == '비공개' && (rPVo.rMid != sMid && sMid != userMid)}">
		<div class="reply-list">
			<div>비공개 댓글입니다.</div>
			<div class="date" style="font-size:14px;">
               	<fmt:parseDate value="${rPVo.rDate}" var="rPDate" pattern="yyyy-MM-dd HH:mm:ss.0" />
				<fmt:formatDate value="${rPDate}" pattern="yyyy. MM. dd HH:mm" />
			</div>
		</div>
		</c:if>
			<c:forEach var="rCVo" items="${rCVos}">
				<c:if test="${rPVo.rIdx == rCVo.parentReplyIdx}">
					<c:if test="${rCVo.rPublic == '공개' || (rCVo.rPublic == '비공개' && (rCVo.rMid == sMid || sMid == userMid))}">
						<div class="reply-list-re" id="reply${rCVo.rIdx}">
							<div>┗</div>
							<div>
							<c:if test="${rCVo.rUserImg != null}"><img src="${ctp}/images/user/${rCVo.rUserImg}" alt="profile" class="mr-2"></c:if>
							<c:if test="${rCVo.rUserImg == null}"><img src="${ctp}/images/user/user_basic.jpg" alt="profile" class="mr-2"></c:if>
							<span style="cursor:pointer;" onclick="location.href='${ctp}/blog/${rCVo.rMid}';">${rCVo.rNickName}</span><c:if test="${rCVo.rPublic == '비공개'}"><i class="fa-solid fa-lock fa-sm ml-2" style="color: gray;"></i></c:if>
							<div>${fn:replace(rCVo.rContent, newLine, "<br/>")}</div>
							<div class="date" style="font-size:14px;">
								<fmt:parseDate value="${rCVo.rDate}" var="rCDate" pattern="yyyy-MM-dd HH:mm:ss.0" />
								<fmt:formatDate value="${rCDate}" pattern="yyyy. MM. dd HH:mm" />
							</div>
							<div>
								<span class="proBtn-sm mt-2" onclick="rreplyShow(${rPVo.rIdx})">답글</span>
								<c:if test="${rCVo.rMid == sMid}"><span class="proBtn-sm mt-2" onclick="replyEditModal('${rCVo.rContent}', '${rCVo.rPublic}', ${rCVo.rIdx})">수정</span></c:if>
								<c:if test="${rCVo.rMid == sMid || sMid == userMid}"><span class="proBtn-sm mt-2">삭제</span></c:if>
							</div>
							</div>
						</div>
					</c:if>
					<c:if test="${rCVo.rPublic == '비공개' && (rCVo.rMid != sMid && sMid != userMid)}">
						<div class="reply-list-re">
							<div>┗</div>
							<div>
								<div>비공개 댓글입니다.</div>
								<div class="date" style="font-size:14px;">
									<fmt:parseDate value="${rCVo.rDate}" var="rCDate" pattern="yyyy-MM-dd HH:mm:ss.0" />
									<fmt:formatDate value="${rCDate}" pattern="yyyy. MM. dd HH:mm" />
								</div>
							</div>
						</div>
					</c:if>
				</c:if>
			</c:forEach>
			<div class="reply-list-rre" id="rre${rPVo.rIdx}">
				<form class="reply-write-re" name="replyWrite${rPVo.rIdx}" method="post">
					<div class="mb-2"><img src="${ctp}/images/user/${sUserImg == null ? 'user_basic.jpg' : sUserImg}" alt="profile" class="mr-2">${sNickName == null ? '익명' : sNickName}</div>
					<textarea rows="3" name="rContent${rPVo.rIdx}" id="rContent${rPVo.rIdx}" class="form-control" placeholder="작성할 댓글 내용을 입력하세요"></textarea>
					<div class="reply-write-menu">
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" id="replySC${rPVo.rIdx}" name="replySC${rPVo.rIdx}" value="비공개" ${rPVo.rPublic == '비공개' ? 'checked' : ''}>
							<label class="custom-control-label" for="replySC${rPVo.rIdx}">비밀글로 작성</label>
						</div>
						<input type="button" value="작성" class="proBtn" onclick="replyWriteCheck2(${rPVo.rIdx})" />
						<input type="hidden" name="hostIp${rPVo.rIdx}" id="hostIp${rPVo.rIdx}" value="${pageContext.request.remoteAddr}" />
						<input type="hidden" name="mid${rPVo.rIdx}" id="mid${rPVo.rIdx}" value="${sMid == null ? 'noname' : sMid}" />
						<input type="hidden" name="nickName${rPVo.rIdx}" id="nickName${rPVo.rIdx}" value="${sNickName == null ? '익명' : sNickName}" />
						<input type="hidden" name="coIdx${rPVo.rIdx}" id="coIdx${rPVo.rIdx}" value="${coIdx}" />
						<input type="hidden" name="userMid${rPVo.rIdx}" id="userMid${rPVo.rIdx}" value="${userMid}" />
					</div>
				</form>
			</div>
		</c:forEach>
		<c:if test="${sMid == null}">
			<div class="reply-write">로그인 후 댓글을 작성해주세요.</div>
		</c:if>
		<c:if test="${sMid != null}">
			<form class="reply-write" name="replyWrite" method="post">
				<div class="mb-2"><img src="${ctp}/images/user/${sUserImg == null ? 'user_basic.jpg' : sUserImg}" alt="profile" class="mr-2">${sNickName == null ? '익명' : sNickName}</div>
				<textarea rows="3" name="rContent" id="rContent" class="form-control" placeholder="작성할 댓글 내용을 입력하세요"></textarea>
				<div class="reply-write-menu">
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="replySC" name="replySC" value="비공개">
						<label class="custom-control-label" for="replySC">비밀글로 작성</label>
					</div>
					<input type="button" value="작성" class="proBtn" onclick="replyWriteCheck()" />
					<input type="hidden" name="hostIp" id="hostIp" value="${pageContext.request.remoteAddr}" />
					<input type="hidden" name="mid" id="mid" value="${sMid == null ? 'noname' : sMid}" />
					<input type="hidden" name="nickName" id="nickName" value="${sNickName == null ? '익명' : sNickName}" />
					<input type="hidden" name="coIdx" id="coIdx" value="${coIdx}" />
					<input type="hidden" name="userMid" id="userMid" value="${userMid}" />
				</div>
			</form>
		</c:if>
		</div>
	</section>
    <aside>
        <div class="profile">
            <img src="${ctp}/images/user/${userImg}" alt="profile">
            <div class="nickName">${nickName}</div>
            <div class="blog-intro">${bVo.blogIntro}</div>
            <c:if test="${userMid == sMid}">
            <hr/>
	        <div class="actions">
		        <div class="action-link" onclick="location.href='${ctp}/ContentInput/${sMid}';"><i class="fas fa-pencil-alt"></i> 글쓰기</div>
		        <div class="action-link" onclick="location.href='${ctp}/BlogEdit/${sMid}';"><i class="fas fa-cogs"></i> 블로그 관리</div>
	    	</div>
	    	</c:if>
	    	<c:if test="${userMid != sMid}">
	    	<hr/>
	    	<div class="actions">
	    		<c:if test="${sVo.subMid == sMid && sVo.subMid != null}">
	    			<div class="action-link active" onclick="subDelete()"><i class="fa-solid fa-check"></i> 구독해제</div>
	    		</c:if>
	    		<c:if test="${sVo.subMid != sMid || sVo.subMid == null}">
	    			<div class="action-link" onclick="subOk()"><i class="fa-solid fa-check"></i> 구독하기</div>
	    		</c:if>
	    	</div>
	    	</c:if>
        </div>
        <div class="categories">
            <ul>
            	<li><a href="${ctp}/blog/${userMid}"><strong ${categoryIdx == 0 ? 'class="category-ac"' : ""}>전체보기</strong></a></li>
            	<c:forEach var="cPVo" items="${cPVos}">
            		<c:if test="${userMid == sMid}">
			            <li id="parent-${cPVo.caIdx}">
			                <a href="${ctp}/blog/${userMid}?categoryIdx=${cPVo.caIdx}"><strong ${categoryIdx == cPVo.caIdx ? 'class="category-ac"' : ""}>${cPVo.category}</strong></a><c:if test="${cPVo.publicSetting == '비공개'}"><i class="fa-solid fa-lock fa-2xs ml-2" style="color: gray;"></i></c:if>
			                <ul id="parent-${cPVo.caIdx}-children">
			                    <c:forEach var="cCVo" items="${cCVos}">
			                        <c:if test="${cCVo.parentCategoryIdx == cPVo.caIdx}">
			                            <li class="ml-2" id="child-${cCVo.caIdx}" data-id="${cCVo.caIdx}">
			                                <a href="${ctp}/blog/${userMid}?categoryIdx=${cCVo.caIdx}"><span  ${categoryIdx == cCVo.caIdx ? 'class="category-ac"' : ""}>- ${cCVo.category}</span></a><c:if test="${cCVo.publicSetting == '비공개'}"><i class="fa-solid fa-lock fa-2xs ml-2" style="color: gray;"></i></c:if>
			                            </li>
			                        </c:if>
			                    </c:forEach>
			                </ul>
			            </li>
		            </c:if>
            		<c:if test="${userMid != sMid}">
            			<c:if test="${cPVo.publicSetting == '공개'}">
			            <li id="parent-${cPVo.caIdx}">
			                <a href="${ctp}/blog/${userMid}?categoryIdx=${cPVo.caIdx}"><strong ${categoryIdx == cPVo.caIdx ? 'class="category-ac"' : ""}>${cPVo.category}</strong></a>
			                <ul id="parent-${cPVo.caIdx}-children">
			                    <c:forEach var="cCVo" items="${cCVos}">
            						<c:if test="${cCVo.publicSetting == '공개'}">
				                        <c:if test="${cCVo.parentCategoryIdx == cPVo.caIdx}">
				                            <li class="ml-2" id="child-${cCVo.caIdx}" data-id="${cCVo.caIdx}">
				                                <a href="${ctp}/blog/${userMid}?categoryIdx=${cCVo.caIdx}"><span  ${categoryIdx == cCVo.caIdx ? 'class="category-ac"' : ""}>- ${cCVo.category}</span></a>
				                            </li>
				                        </c:if>
			                		</c:if>
			                    </c:forEach>
			                </ul>
			            </li>
			            </c:if>
		            </c:if>
		        </c:forEach>
            </ul>
        </div>
        <hr/>
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
<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title" id="modalTitle">게시글 삭제</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <div id="modalText">정말로 삭제하시겠습니까?</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer" id="modal-footer">
        	<button type="button" class="btn btn-danger mr-2" onclick="contentDelete(${contentVo.coIdx})">삭제</button>
          	<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>
<!-- 댓글 수정 모달 -->
  <div class="modal fade" id="myModal2">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title" id="modalTitle2">댓글 수정</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <div id="modalText2">
          </div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer" id="modal-footer2">
        	<button type="button" class="proBtn mr-2" onclick="">수정</button>
          	<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>
</body>
</html>
