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
	
	// 유저 정보 변경
	function userEditCheck() {
		let nickName = editForm.nickName.value;
		let nickNameReg = /^[a-zA-Z가-힣0-9]{2,8}$/;
		
		let name = editForm.name.value;
		let nameReg = /^[가-힣]{2,6}$/;
		
		let birthday = document.forms["editForm"]["birthday"].valueAsDate;
		let today = new Date();
		let minDate = new Date('1900-01-01');
		
		if(nickName.trim() == ""){
			$("#myModal #modalTitle").text("닉네임 오류");
			$("#myModal #modalText").text("닉네임을 입력해주세요!");
			$('#myModal').modal('show');
			editForm.nickName.focus();
		}
		else if(!nickNameReg.test(nickName)){
			$("#myModal #modalTitle").text("닉네임 오류");
			$("#myModal #modalText").text("닉네임은 2~8자 영문대소문자, 한글, 숫자만 가능합니다!");
			$('#myModal').modal('show');
			editForm.nickName.value = "";
			editForm.nickName.focus();
    	}
		else if(name.trim() == ""){
			$("#myModal #modalTitle").text("이름 오류");
			$("#myModal #modalText").text("이름을 입력해주세요!");
			$('#myModal').modal('show');
			editForm.name.focus();
		}
		else if(!nameReg.test(name)){
			$("#myModal #modalTitle").text("이름 오류");
			$("#myModal #modalText").text("이름은 한글 2~6자만 가능합니다!");
			$('#myModal').modal('show');
			editForm.name.value = "";
			editForm.name.focus();
    	}
		else if(birthday === null || birthday > today || birthday < minDate) {
			$("#myModal #modalTitle").text("생년월일 오류");
			$("#myModal #modalText").text("생년월일을 정확히 입력해주세요!");
			$('#myModal').modal('show');
            document.forms["editForm"]["birthday"].focus();
        }
		else {
			editForm.submit();
		}
	}
	
	// 유저 탈퇴
	function userDeleteCheck() {
		let htmlFooter = '<button type="button" class="btn btn-danger mr-2" onclick="location.href=&quot;UserDeleteOk.u&quot;;">탈퇴</button>'
		+'<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>';
		
		$("#myModal2 #modalTitle2").text("회원 탈퇴");
		$("#myModal2 #modalText2").html("정말로 탈퇴하시겠습니까?<br/><font color='red'>다시 되돌릴 수 없습니다</font>");
		$("#myModal2 #modalFooter2").html(htmlFooter);
		$('#myModal2').modal('show');
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
								<input type="button" value="비밀번호 변경" onclick="location.href='UserPwdEdit.u';" class="proBtn"/>
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
								<input type="button" value="변경" onclick="userEditCheck()" class="proBtn mr-2"/>
								<input type="button" value="메인으로" class="proBtn" onclick="location.href='Main';"/>
							</td>
						</tr>
					</table>
					<input type="hidden" name="mid" id="mid" value="${sMid}" />
				</form>
				<div class="text-right font-light" style="font-size:12px;cursor:pointer;" onclick="userDeleteCheck()">계정 탈퇴</div>
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
<!-- The Modal -->
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