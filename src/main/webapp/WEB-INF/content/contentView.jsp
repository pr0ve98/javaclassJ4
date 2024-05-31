<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
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
	
	function categoryDelete(coIdx) {
		$('#myModal').modal('hide');
		$.ajax({
			url : "${ctp}/CategoryDelete",
			type : "get",
			data : {coIdx : coIdx, mid : '${userMid}', categoryIdx : ${categoryIdx}, page : ${page}},
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
</script>
</head>
<body>
<header>
    <div class="header-container">
        <div class="header-left">
            <div class="header-title" onclick="location.href='${ctp}/blog/${userMid}';">${bVo.blogTitle}</div>
        </div>
        <div class="header-right">
            <input type="text" placeholder="Search...">
            <button type="button"><i class="fas fa-search"></i></button>
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
	                <div class="proBtn-sm"><a href="${ctp}/blog/${userMid}?page=${page}&categoryIdx=${categoryIdx}">돌아가기</a></div>
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
            <div class="content">${contentVo.content}</div>
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
        	<button type="button" class="btn btn-danger mr-2" onclick="categoryDelete(${contentVo.coIdx})">삭제</button>
          	<button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>
</body>
</html>
