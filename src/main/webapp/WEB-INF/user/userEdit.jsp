<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>에이치로그 회원수정</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<%@ include file="/include/bs4.jsp"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/maincss.jsp"%>
<%@ include file="/include/editcss.jsp"%>
<style>
	#fName {
    	display: none;
    }
</style>
<script>
	'use strict';
	
	// 유저 이미지 변경
	function handleFileChange(e) {
		let fName = document.getElementById("fName").value;
		let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
		let maxSize = 1024 * 1024 * 10 // 기본단위는 Byte, 1024 * 1024 * 10 = 10MB 허용
		
		if(fName.trim() == ""){
            $("#myModal #modalTitle").html("파일 오류");
            $("#myModal #modalText").html("파일을 선택해 주세요");
            $('#myModal').modal('show');
			return false;
		}
		
		let fileSize = document.getElementById("fName").files[0].size;
		if(fileSize > maxSize){
            $("#myModal #modalTitle").html("파일 오류");
            $("#myModal #modalText").html("파일의 최대 크기는 10MB입니다");
            $('#myModal').modal('show');
		}
		else if(ext != 'jpg' && ext != 'png' &&ext != 'gif' &&ext != 'jpeg'){
			 $("#myModal #modalTitle").html("파일 오류");
	            $("#myModal #modalText").html("이미지 파일만 업로드해주세요");
	            $('#myModal').modal('show');
		}
		else {
			let formData = new FormData();
			formData.append("fName", document.getElementById("fName").files[0]);
			formData.append("mid", '${sMid}');
			
			$.ajax({
				url : "UserImgChange.u",
				type : "post",
				data : formData,
				processData: false,
				contentType: false,
				success : function(res) {
					if(res != "0"){
						location.reload();
					}
					else {
			            $("#myModal #modalTitle").html("파일 전송 오류");
			            $("#myModal #modalText").html("파일이 전송되지 않았어요...");
			            $('#myModal').modal('show');
					}
				},
				error : function() {
		            $("#myModal #modalTitle").html("오류");
		            $("#myModal #modalText").html("전송 오류!!");
		            $('#myModal').modal('show');
				}
			});
		}
	}
	
	// 기본이미지로 변경
	function userImgBasicChange() {
		$.ajax({
			url : "UserImgBasicChange.u",
			type : "post",
			data : {mid : '${sMid}'},
			success : function(res) {
				if(res != "0"){
					location.reload();
				}
				else {
		            $("#myModal #modalTitle").html("파일 전송 오류");
		            $("#myModal #modalText").html("파일이 전송되지 않았어요...");
		            $('#myModal').modal('show');
				}
			},
			error : function() {
	            $("#myModal #modalTitle").html("오류");
	            $("#myModal #modalText").html("전송 오류!!");
	            $('#myModal').modal('show');
			}
		});
	}
</script>
</head>
<body class="body-layout">
	<div class="menu-title">
		<a class="navbar-brand" href="${ctp}/Main"><img src="${ctp}/images/logo.png" alt="logo" style="width: 200px;"></a>
	</div>
	<div class="main-content">
		<div class="container-fluid">
			<div class="content-list">
				<form name="editForm" method="post" action="UserEditOk.u">
					<table class="table table-bordered text-center">
						<tr>
							<td class="table-label">프로필사진</td>
							<td class="table-content">
								<div class="user-profile"><img src="${ctp}/images/user/${vo.userImg}" alt="유저프로필"></div>
								<div class="mb-2">
									<input type="button" value="사진변경" class="proBtn mr-2" onclick="document.getElementById('fName').click();"/>
									<input type="button" value="기본이미지로 변경" class="proBtn" onclick="userImgBasicChange()" />
									<input type="file" name="fName" id="fName" accept=".jpg, .jpeg, .png, .gif" onchange="handleFileChange(this)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="table-label">비밀번호</td>
							<td class="table-content">
								<input type="button" value="비밀번호 변경" class="proBtn"/>
							</td>
						</tr>
						<tr>
							<td class="table-label">닉네임</td>
							<td class="table-content">
								<input type="text" value="${vo.nickName}" name="nickName" id="nickName" class="form-control"/>
							</td>
						</tr>
						<tr>
							<td class="table-label">이름</td>
							<td class="table-content">
								<input type="text" value="${vo.name}" name="name" id="name" class="form-control"/>
							</td>
						</tr>
						<tr>
							<td class="table-label">생년월일</td>
							<td class="table-content">
								<input type="date" value="${vo.birthday}" name="birthday" id="birthday" class="form-control"/>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="table-content">
								<input type="button" value="변경" class="proBtn mr-2"/>
								<input type="button" value="돌아가기" class="proBtn" onclick="location.href='Main';"/>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
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