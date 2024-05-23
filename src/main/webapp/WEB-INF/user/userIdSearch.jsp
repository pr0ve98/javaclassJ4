<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>에이치로그 아이디찾기</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<%@ include file="/include/bs4.jsp"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/maincss.jsp"%>
<%@ include file="/include/logincss.jsp"%>
<script>
	'use strict';
	
	function idSearchCheck() {
		let name = idSearchForm.name.value;
		
		let birthday = document.forms["idSearchForm"]["birthday"].valueAsDate;
		let today = new Date();
		let minDate = new Date('1900-01-01');
		
		let email = idSearchForm.email.value;
		let emailReg = /^[a-zA-Z0-9_+-]+@[a-zA-Z0-9.-_]+\.[a-zA-Z]{2,63}(\.[a-zA-Z]{2,63})?$/;
		
		if(email.trim() == ""){
			$("#myModal #modalTitle").text("이메일 오류");
			$("#myModal #modalText").text("이메일을 입력해주세요!");
			$('#myModal').modal('show');
			idSearchForm.email.focus();
		}
		else if(!emailReg.test(email)){
			$("#myModal #modalTitle").text("이메일 오류");
			$("#myModal #modalText").text("이메일 형식에 맞지 않습니다!");
			$('#myModal').modal('show');
			idSearchForm.email.value = "";
			idSearchForm.email.focus();
    	}
		else if(name.trim() == ""){
			$("#myModal #modalTitle").text("이름 오류");
			$("#myModal #modalText").text("이름을 입력해주세요!");
			$('#myModal').modal('show');
			idSearchForm.email.focus();
		}
		else if(birthday === null || birthday > today || birthday < minDate){
			$("#myModal #modalTitle").text("생년월일 오류");
			$("#myModal #modalText").text("생년월일을 정확히 입력해주세요!");
			$('#myModal').modal('show');
			idSearchForm.email.focus();
		}
		else {
			$.ajax({
				url : "UserIdSearchCheck.u",
				type : "post",
				data : {email : email, name : name, birthday : birthday},
				success : function(res) {
					$("#myModal #modalTitle").text("아이디 찾기");
					$("#myModal #modalText").html(res);
					$('#myModal').modal('show');
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
</head>
<body class="body-layout">
	<div class="menu-title">
		<a class="navbar-brand" href="${ctp}/Main"><img src="${ctp}/images/logo.png" alt="logo" style="width: 200px;"></a>
	</div>
	<div class="main-content">
		<div class="container-fluid">
			<div class="content-list">
				<form name="idSearchForm" method="post">
					<div class="form-group">
						<label for="email">이메일</label>
						<input type="text" name="email" id="email" placeholder="이메일을 입력하세요" class="form-control mb-3" />
					</div>
					<div class="form-group">
						<label for="name">이름</label>
						<input type="text" name="name" id="name" placeholder="이름를 입력하세요" class="form-control mb-2" />
					</div>
					<div class="form-group">
				      <label for="birthday">생년월일</label>
				      <input type="date" name="birthday" class="form-control mb-5"/>
				    </div>
				</form>
				<input type="button" value="아이디찾기" onclick="idSearchCheck()" class="orangeBtn mb-3" data-target="#myModal"/>
				<input type="button" value="돌아가기" onclick="location.href='UserLogin.u';" class="grayBtn mb-3"/>
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