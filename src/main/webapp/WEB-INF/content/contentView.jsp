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
		 <div>전체 35개의 글 목록닫기</div>
            <table>
               <tr style="color:#D5D5D5;">
                   <td class="title">글 제목</td>
                   <td class="viewCnt">조회수</td>
                   <td class="wDate">작성일</td>
               </tr>
               <tr>
                   <td class="title">05.16 | 도너츠 사봤다</td>
                   <td class="viewCnt">18</td>
                   <td class="wDate">2024. 5. 16.</td>
               </tr>
            </table>
            <div class="page-menu">
	            <button class="proBtn-sm">글관리 열기</button>
		        <div class="pagination">
			        <c:if test="${curBlock > 0}"><a href="${ctp}/blog/${userMid}?page=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}"><i class="fa-solid fa-angle-left fa-2xs"></i></a></c:if>
			        <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
				        <c:if test="${i <= totPage && i == page}"><a href="${ctp}/blog/${userMid}?page=${i}&pageSize=${pageSize}" class="active">${i}</a></c:if>
				        <c:if test="${i <= totPage && i != page}"><a href="${ctp}/blog/${userMid}?page=${i}&pageSize=${pageSize}">${i}</a></c:if>
			        </c:forEach>
			        <c:if test="${curBlock < lastBlock}"><a href="${ctp}/blog/${userMid}?page=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}"><i class="fa-solid fa-angle-right fa-2xs"></i></a></c:if>
		    	</div>
	               <select class="proBtn-sm">
	                   <option value="5">5줄 보기</option>
	                   <option value="10">10줄 보기</option>
	                   <option value="15">15줄 보기</option>
	                   <option value="20">20줄 보기</option>
	               </select>
	        </div>
        </div>
        <div class="post-detail">
            <h5>${contentVo.categoryName}</h5>
            <h1 class="mb-5">${contentVo.title}</h1>
            <div class="post-data">
            	<div>
            		<img src="${ctp}/images/user/${userImg}" alt="profile" class="mr-2">
	                <span class="author mr-2">${nickName}</span>
	                <span class="date">
	                	<fmt:parseDate value="${contentVo.wDate}" var="wDate" pattern="yyyy-MM-dd HH:mm:ss.0" />
						<fmt:formatDate value="${wDate}" pattern="yyyy.MM.dd HH:mm" />
	                </span>
                </div>
				<i class="fa-solid fa-bars fa-xl" style="color: #D5D5D5;"></i>
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
            	<li><a href="${ctp}/blog/${userMid}"><strong ${param.categoryIdx == null ? 'class="category-ac"' : ""}>전체보기</strong></a></li>
            	<c:forEach var="cPVo" items="${cPVos}">
            		<c:if test="${userMid == sMid}">
			            <li id="parent-${cPVo.caIdx}">
			                <a href="${ctp}/blog/${userMid}?categoryIdx=${cPVo.caIdx}"><strong ${param.categoryIdx == cPVo.caIdx ? 'class="category-ac"' : ""}>${cPVo.category}</strong></a><c:if test="${cPVo.publicSetting == '비공개'}"><i class="fa-solid fa-lock fa-2xs ml-2" style="color: gray;"></i></c:if>
			                <ul id="parent-${cPVo.caIdx}-children">
			                    <c:forEach var="cCVo" items="${cCVos}">
			                        <c:if test="${cCVo.parentCategoryIdx == cPVo.caIdx}">
			                            <li class="ml-2" id="child-${cCVo.caIdx}" data-id="${cCVo.caIdx}">
			                                <a href="${ctp}/blog/${userMid}?categoryIdx=${cCVo.caIdx}"><span  ${param.categoryIdx == cCVo.caIdx ? 'class="category-ac"' : ""}>- ${cCVo.category}</span></a><c:if test="${cCVo.publicSetting == '비공개'}"><i class="fa-solid fa-lock fa-2xs ml-2" style="color: gray;"></i></c:if>
			                            </li>
			                        </c:if>
			                    </c:forEach>
			                </ul>
			            </li>
		            </c:if>
            		<c:if test="${userMid != sMid}">
            			<c:if test="${cPVo.publicSetting == '공개'}">
			            <li id="parent-${cPVo.caIdx}">
			                <a href="${ctp}/blog/${userMid}?categoryIdx=${cPVo.caIdx}"><strong ${param.categoryIdx == cPVo.caIdx ? 'class="category-ac"' : ""}>${cPVo.category}</strong></a>
			                <ul id="parent-${cPVo.caIdx}-children">
			                    <c:forEach var="cCVo" items="${cCVos}">
            						<c:if test="${cCVo.publicSetting == '공개'}">
				                        <c:if test="${cCVo.parentCategoryIdx == cPVo.caIdx}">
				                            <li class="ml-2" id="child-${cCVo.caIdx}" data-id="${cCVo.caIdx}">
				                                <a href="${ctp}/blog/${userMid}?categoryIdx=${cCVo.caIdx}"><span  ${param.categoryIdx == cCVo.caIdx ? 'class="category-ac"' : ""}>- ${cCVo.category}</span></a>
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
</body>
</html>
