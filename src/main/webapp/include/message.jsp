<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ include file = "/include/certification.jsp" %> --%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>message.jsp</title>
<%@ include file="/include/bs4.jsp"%>
<%@ include file="/include/maincss.jsp"%>
	<script>
    'use strict';

    // 완전히 로드된 후 스크립트코드 실행
    document.addEventListener('DOMContentLoaded', (event) => {
        if("${message}" != "NO") {
            $("#myModal #modalTitle").html("${title}");
            $("#myModal #modalText").html("${message}");
            $('#myModal').modal('show');
	        // 모달창이 닫힐 때 페이지 이동
	        $('#myModal').on('hide.bs.modal', function () {
	            window.location.href = "${url}";
	        });
        }
        else {
        	location.href = "${url}";
        }
        
    });
	</script>
</head>
<body>
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