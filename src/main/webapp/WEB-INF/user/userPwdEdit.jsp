<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>에이치로그 비밀번호 변경</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<%@ include file="/include/bs4.jsp"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/maincss.jsp"%>
<%@ include file="/include/editcss.jsp"%>
<script>
	'use strict';
	
</script>
</head>
<body class="body-layout">
	<div class="menu-title">
		<a class="navbar-brand" href="${ctp}/Main"><img src="${ctp}/images/logo.png" alt="logo" style="width: 200px;"></a>
	</div>
	<div class="main-content">
		<div class="container-fluid">
			<div class="content-list">
				<form name="editPwdForm" method="post" action="UserPwdEditOk.u">
					<table class="table table-bordered text-center">
						<tr>
							<td colspan="2" class="table-content">
								<div style="font-size:16pt;">비밀번호 변경</div>
								<div class="font-light" style="font-size:14px;">비밀번호는 8~16자 영문대소문자, 숫자, 특수문자(@$!%*#?&^)를 
								<span style="color:#ff7200;">하나씩은 포함</span>해야 합니다</div>
							</td>
						</tr>
						<tr>
							<td class="table-label">현재 비밀번호</td>
							<td class="table-content">
								<input type="password" name="pwdNow" id="pwdNow" class="form-control"/>
							</td>
						</tr>
						<tr>
							<td class="table-label">변경할 비밀번호</td>
							<td class="table-content">
								<input type="password" name="pwd" id="pwd" class="form-control"/>
							</td>
						</tr>
						<tr>
							<td class="table-label">비밀번호 확인</td>
							<td class="table-content">
								<input type="password" name="pwdCheck" id="pwdCheck" class="form-control"/>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="table-content">
								<input type="button" value="변경" onclick="pwdEditCheck()" class="proBtn mr-2"/>
								<input type="button" value="돌아가기" class="proBtn" onclick="location.href='UserEdit.u';"/>
							</td>
						</tr>
					</table>
					<input type="hidden" name="mid" id="mid" value="${sMid}" />
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