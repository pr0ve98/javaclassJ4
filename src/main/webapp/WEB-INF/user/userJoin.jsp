<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>에이치로그 회원가입</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<%@ include file="/include/bs4.jsp"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/maincss.jsp"%>
<%@ include file="/include/logincss.jsp"%>
<style>
	a:link {
  		color : #fff;
	}
	a:visited {
	  color : #fff;
	}
</style>
<script>
	'use strict';
	
	let idCheckSw = 0;
	let emailCheckSw = 0;
	
	// 아이디 중복체크
	function idCheck() {
		let mid = joinForm.mid.value;
		let midReg = /^[a-zA-Z0-9-_]{4,12}$/;
		
		if(mid.trim() == ""){
			$("#myModal #modalTitle").text("아이디 오류");
			$("#myModal #modalText").text("아이디를 입력해주세요!");
			joinForm.mid.focus();
		}
		else if(!midReg.test(mid)){
			$("#myModal #modalTitle").text("아이디 오류");
			$("#myModal #modalText").text("아이디는 4~12자 영문대소문자, 숫자, 밑줄, 하이픈만 가능합니다!");
    		joinForm.mid.value = "";
    		joinForm.mid.focus();
    	}
		else {
			$.ajax({
				url : "UserIdCheck.u",
				type : "post",
				data : {mid : mid},
				success : function(res) {
					if(res != "0"){
						$("#myModal #modalTitle").text("아이디 오류");
						$("#myModal #modalText").text("이미 사용중인 아이디입니다!");
						joinForm.mid.value = "";
						joinForm.mid.focus();
					}
					else {
						idCheckSw = 1;
						$("#myModal #modalTitle").text("아이디");
						$("#myModal #modalText").html("<span style='color:#ff7200'>"+mid+"</span>은(는) 사용 가능한 아이디입니다!");
					}
				},
				error : function() {
					$("#myModal #modalTitle").text("전송 오류");
					$("#myModal #modalText").text("전송 오류가 났어요!");
				}
			});
		}
	}
	
	// 아이디 중복체크 후 다시 아이디를 수정했을 때
	function resetIdCheckSw() {
		idCheckSw = 0;
	}
	// 이메일 중복체크 후 다시 이메일을 수정했을 때
	function resetEmailCheckSw() {
		emailCheckSw = 0;
	}
	
	// 이메일 중복체크
	function emailCheck() {
		let email = joinForm.email.value;
		let emailReg = /^[a-zA-Z0-9_+-]+@[a-zA-Z0-9.-_]+\.[a-zA-Z]{2,63}(\.[a-zA-Z]{2,63})?$/;
		
		if(email.trim() == ""){
			$("#myModal #modalTitle").text("이메일 오류");
			$("#myModal #modalText").text("이메일을 입력해주세요!");
			joinForm.email.focus();
		}
		else if(!emailReg.test(email)){
			$("#myModal #modalTitle").text("이메일 오류");
			$("#myModal #modalText").text("이메일 형식에 맞지 않습니다!");
    		joinForm.email.value = "";
    		joinForm.email.focus();
    	}
		else {
			$.ajax({
				url : "UserEmailCheck.u",
				type : "post",
				data : {email : email},
				success : function(res) {
					if(res != "0"){
						$("#myModal #modalTitle").text("이메일 오류");
						$("#myModal #modalText").text("이미 사용중인 이메일입니다!");
						joinForm.email.value = "";
						joinForm.email.focus();
					}
					else {
						emailCheckSw = 1;
						$("#myModal #modalTitle").text("이메일");
						$("#myModal #modalText").html("<span style='color:#ff7200'>"+email+"</span>은(는) 사용 가능한 이메일입니다!");
					}
				},
				error : function() {
					$("#myModal #modalTitle").text("전송 오류");
					$("#myModal #modalText").text("전송 오류가 났어요!");
				}
			});
		}
	}
	
	// 회원가입
	function joinCheck() {
		let pwd = joinForm.pwd.value;
		let pwdReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&^])[A-Za-z\d@$!%*#?&^]{8,16}$/;
		
		let nickName = joinForm.nickName.value;
		let nickNameReg = /^[a-zA-Z가-힣0-9]{2,8}$/;
		
		let name = joinForm.name.value;
		let nameReg = /^[가-힣]{2,6}$/;
		
		let birthday = document.forms["joinForm"]["birthday"].valueAsDate;
		let today = new Date();
		let minDate = new Date('1900-01-01');
		
		if(pwd.trim() == ""){
			$("#myModal #modalTitle").text("비밀번호 오류");
			$("#myModal #modalText").text("비밀번호를 입력해주세요!");
			$('#myModal').modal('show');
			joinForm.pwd.focus();
		}
		else if(!pwdReg.test(pwd)){
			$("#myModal #modalTitle").text("비밀번호 오류");
			$("#myModal #modalText").text("비밀번호는 8~16자 영문대소문자, 숫자, 특수문자(@$!%*#?&^)를 하나씩은 포함해야 합니다!");
			$('#myModal').modal('show');
    		joinForm.pwd.value = "";
    		joinForm.pwd.focus();
    	}
		else if(nickName.trim() == ""){
			$("#myModal #modalTitle").text("닉네임 오류");
			$("#myModal #modalText").text("닉네임을 입력해주세요!");
			$('#myModal').modal('show');
			joinForm.nickName.focus();
		}
		else if(!nickNameReg.test(nickName)){
			$("#myModal #modalTitle").text("닉네임 오류");
			$("#myModal #modalText").text("닉네임은 2~8자 영문대소문자, 한글, 숫자만 가능합니다!");
			$('#myModal').modal('show');
    		joinForm.nickName.value = "";
    		joinForm.nickName.focus();
    	}
		else if(name.trim() == ""){
			$("#myModal #modalTitle").text("이름 오류");
			$("#myModal #modalText").text("이름을 입력해주세요!");
			$('#myModal').modal('show');
			joinForm.name.focus();
		}
		else if(!nameReg.test(name)){
			$("#myModal #modalTitle").text("이름 오류");
			$("#myModal #modalText").text("이름은 한글 2~6자만 가능합니다!");
			$('#myModal').modal('show');
    		joinForm.name.value = "";
    		joinForm.name.focus();
    	}
		else if(birthday === null || birthday > today || birthday < minDate) {
			$("#myModal #modalTitle").text("생년월일 오류");
			$("#myModal #modalText").text("생년월일을 정확히 입력해주세요!");
			$('#myModal').modal('show');
            document.forms["joinForm"]["birthday"].focus();
        }
		else if(idCheckSw == 0){
			$("#myModal #modalTitle").text("아이디 중복확인 오류");
			$("#myModal #modalText").text("아이디 중복확인을 해주세요!");
			$('#myModal').modal('show');
			$("#idCheckBtn").focus();
		}
		else if(emailCheckSw == 0){
			$("#myModal #modalTitle").text("이메일 중복확인 오류");
			$("#myModal #modalText").text("이메일 중복확인을 해주세요!");
			$('#myModal').modal('show');
			$("#emailCheckBtn").focus();
		}
		else {
			joinForm.submit();
		}
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
				<form name="joinForm" method="post" action="UserJoinInput.u">
					<div class="form-group">
						<label for="mid">아이디</label>
						<div class="input-group">
							<input type="text" name="mid" id="mid" placeholder="아이디를 입력하세요" oninput="resetIdCheckSw()" maxlength="12" class="form-control" autofocus />
						  	<div class="input-group-append">
						    	<a href="#" id="idCheckBtn" class="orangeBtn-sm" onclick="idCheck()" data-toggle="modal" data-target="#myModal">중복확인</a>
						  	</div>
						</div>
					</div>
					<div class="form-group">
						<label for="email">이메일</label>
						<div class="input-group">
							<input type="text" name="email" id="email" placeholder="이메일을 입력하세요" oninput="resetEmailCheckSw()" class="form-control" />
						  	<div class="input-group-append">
						    	<a href="#" id="emailCheckBtn" class="orangeBtn-sm" onclick="emailCheck()" data-toggle="modal" data-target="#myModal">중복확인</a>
						  	</div>
						</div>
					</div>
					<div class="form-group">
						<label for="pwd">비밀번호</label>
						<input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" maxlength="16" class="form-control mb-3" />
					</div>
					<div class="form-group">
						<label for="nickName">닉네임</label>
						<input type="text" name="nickName" id="nickName" maxlength="8" placeholder="닉네임을 입력하세요" class="form-control mb-3" />
					</div>
					<div class="form-group">
						<label for="name">이름</label>
						<input type="text" name="name" id="name" placeholder="이름을 입력하세요" maxlength="6" class="form-control mb-3" />
					</div>
				    <div class="form-group">
				      <label for="birthday">생년월일</label>
				      <input type="date" name="birthday" class="form-control mb-5"/>
				    </div>
				</form>
				<input type="button" value="회원가입" onclick="joinCheck()" class="orangeBtn mb-3" data-target="#myModal"/>
				<input type="button" value="돌아가기" onclick="location.href='Login.u';" class="grayBtn mb-3"/>
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