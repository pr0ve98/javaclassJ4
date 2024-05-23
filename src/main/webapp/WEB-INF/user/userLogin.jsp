<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>에이치로그 로그인</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<%@ include file="/include/bs4.jsp"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/maincss.jsp"%>
<%@ include file="/include/logincss.jsp"%>
<style>
	.login-menu {
		display: flex;
		justify-content: space-between;
		color: gray;
		width:95%;
		margin: 0 auto;
	}
</style>
<script>
	'use strict';
	
	function loginCheck() {
		let mid = loginForm.mid.value.trim();
		let pwd = loginForm.pwd.value.trim();
		
		if(mid == "") {
			$("#myModal #modalTitle").text("아이디 오류");
			$("#myModal #modalText").text("아이디를 입력해주세요!");
			$('#myModal').modal('show');
			loginForm.mid.focus();
		}
		else if(pwd == ""){
			$("#myModal #modalTitle").text("비밀번호 오류");
			$("#myModal #modalText").text("비밀번호를 입력해주세요!");
			$('#myModal').modal('show');
			loginForm.pwd.focus();
		}
		else loginForm.submit();
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
				<form name="loginForm" method="post" action="UserLoginOk.u">
					<div class="form-group">
						<label for="mid">아이디</label>
						<input type="text" name="mid" id="mid" value="${cMid}" placeholder="아이디를 입력하세요" class="form-control mb-3" />
					</div>
					<div class="form-group">
						<label for="pwd">비밀번호</label>
						<input type="password" name="pwd" id="pwd" value="qwer1234!" placeholder="비밀번호를 입력하세요" class="form-control mb-2" />
						<div class="login-menu font-light mb-4">
							<span><input type="checkbox" name="idSave" value="저장" ${check} /> 아이디 저장&nbsp;&nbsp;&nbsp;</span>
							<span><a href="UserIdSearch.u">아이디 찾기</a>&nbsp;&nbsp;
							<a href="UserPwdSearch.u">비밀번호 찾기</a></span>
						</div>
					</div>
				</form>
				<input type="button" value="로그인" onclick="loginCheck()" class="orangeBtn mb-3" data-target="#myModal"/>
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