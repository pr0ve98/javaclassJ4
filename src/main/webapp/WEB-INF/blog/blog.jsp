<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${bVo.blogTitle}</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/bs4.jsp"%>
<%@ include file="/include/blogcss.jsp"%>
</head>
<body>
<header>
    <div class="header-container">
        <div class="header-left">
            <div class="header-title" onclick="location.href='${ctp}/blog/${uVo.mid}';">${bVo.blogTitle}</div>
        </div>
        <div class="header-right">
            <input type="text" placeholder="Search...">
            <button type="button"><i class="fas fa-search"></i></button>
        </div>
    </div>
</header>
<main class="container">
    <section class="posts">
    	<b>전체 글 <span style="color:#ff7200">27</span></b>
    	<hr/>
    	<c:forEach var="coAllVo" items="${coAllVos}">
        <div class="post">
            <div class="post-content">
                <h2><b>${coAllVo.title}</b></h2>
                <p>${coAllVo.ctPreview}</p>
                <span>${coAllVo.categoryName} · ${fn:substring(coAllVo.wDate, 0, 10)}</span>
            </div>
            <div class="post-thumbnail">
            	<c:set var="thumbnailImg" value="${fn:split(coAllVo.imgName, '/')}"/>
                <img src="${ctp}/images/content/${thumbnailImg[0]}" alt="thumbnail">
            </div>
        </div>
        </c:forEach>
    </section>
    <aside>
        <div class="profile">
            <img src="${ctp}/images/user/${uVo.userImg}" alt="profile">
            <div class="nickName">${uVo.nickName}</div>
            <div class="blog-intro">${bVo.blogIntro}</div>
            <c:if test="${uVo.mid == sMid}">
            <hr/>
	        <div class="actions">
		        <div class="action-link" onclick="location.href='${ctp}/ContentInput/${sMid}';"><i class="fas fa-pencil-alt"></i> 글쓰기</div>
		        <div class="action-link" onclick="location.href='${ctp}/BlogEdit/${sMid}';"><i class="fas fa-cogs"></i> 블로그 관리</div>
	    	</div>
	    	</c:if>
        </div>
        <div class="categories">
            <ul>
            	<li>전체보기 (27)</li>
            	<c:forEach var="cPVo" items="${cPVos}">
            		<c:if test="${uVo.mid == sMid}">
			            <li id="parent-${cPVo.caIdx}">
			                <strong>${cPVo.category}</strong><c:if test="${cPVo.publicSetting == '비공개'}"><i class="fa-solid fa-lock fa-2xs ml-2" style="color: gray;"></i></c:if>
			                <ul id="parent-${cPVo.caIdx}-children">
			                    <c:forEach var="cCVo" items="${cCVos}">
			                        <c:if test="${cCVo.parentCategoryIdx == cPVo.caIdx}">
			                            <li class="ml-2" id="child-${cCVo.caIdx}" data-id="${cCVo.caIdx}">
			                                - ${cCVo.category}<c:if test="${cCVo.publicSetting == '비공개'}"><i class="fa-solid fa-lock fa-2xs ml-2" style="color: gray;"></i></c:if>
			                            </li>
			                        </c:if>
			                    </c:forEach>
			                </ul>
			            </li>
		            </c:if>
            		<c:if test="${uVo.mid != sMid}">
            			<c:if test="${cPVo.publicSetting == '공개'}">
			            <li id="parent-${cPVo.caIdx}">
			                <strong>${cPVo.category}</strong>
			                <ul id="parent-${cPVo.caIdx}-children">
			                    <c:forEach var="cCVo" items="${cCVos}">
            						<c:if test="${cCVo.publicSetting == '공개'}">
				                        <c:if test="${cCVo.parentCategoryIdx == cPVo.caIdx}">
				                            <li class="ml-2" id="child-${cCVo.caIdx}" data-id="${cCVo.caIdx}">
				                                - ${cCVo.category}
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
        <div class="tags">
            <h3>Tag</h3>
            <!-- 태그 목록 추가 -->
        </div>
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
