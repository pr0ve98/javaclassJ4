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
    	<c:if test="${param.categoryIdx == null}">
    	<b>전체 글 <span style="color:#ff7200">${totRecCnt}</span></b>
    	</c:if>
    	<c:forEach var="cVo" items="${cVos}">
    	<c:if test="${cVo.caIdx == param.categoryIdx}">
    	<b>${cVo.category} 글 <span style="color:#ff7200">${totRecCnt}</span></b>
    	</c:if>
    	</c:forEach>
    	<hr/>
    	<c:if test="${coVos.size() == 0}">
    		<div class="post">
	    		<div class="post-content">
	    			<div class="text-center">작성된 글이 없습니다.</div>
	    		</div>
    		</div>
	    	<hr/>
    	</c:if>
    	<c:forEach var="coVo" items="${coVos}">
        <div class="post">
            <div class="post-content">
            	<c:if test="${param.categoryIdx != null}">
                <h2><b><a href="${ctp}/content/${userMid}?coIdx=${coVo.coIdx}&categoryIdx=${param.categoryIdx}&page=${page}">${coVo.title}</a></b></h2>
                </c:if>
            	<c:if test="${param.categoryIdx == null}">
                <h2><b><a href="${ctp}/content/${userMid}?coIdx=${coVo.coIdx}&page=${page}">${coVo.title}</a></b></h2>
                </c:if>
                <p>${coVo.ctPreview}</p>
                <span>${coVo.categoryName} · 
                <c:if test="${coVo.hour_diff < 1}">${coVo.min_diff}분 전</c:if>
                <c:if test="${coVo.hour_diff < 24 && coVo.hour_diff >= 1}">${coVo.hour_diff}시간 전</c:if>
                <c:if test="${coVo.hour_diff >= 24}">${fn:substring(coVo.wDate, 0, 10)}</c:if>
                </span>
            </div>
            <c:if test="${coVo.imgName != null && coVo.imgName != ''}">
	            <div class="post-thumbnail">
	            	<c:set var="thumbnailImg" value="${fn:split(coVo.imgName, '|')}"/>
	            	<c:if test="${fn:indexOf(thumbnailImg[0], 'http')== -1}">
	                <img src="${ctp}/images/content/${thumbnailImg[0]}" alt="thumbnail">
	                </c:if>
	            	<c:if test="${fn:indexOf(thumbnailImg[0], 'http')!= -1}">
	                <img src="${thumbnailImg[0]}" alt="thumbnail">
	                </c:if>
	            </div>
            </c:if>
            <c:if test="${coVo.imgName == null || coVo.imgName == ''}">
	            <div class="post-thumbnail">
	                <img src="${ctp}/images/content/no_image.jpg" alt="thumbnail">
	            </div>
            </c:if>
        </div>
        <hr/>
        </c:forEach>
        <!-- 페이지네이션 시작 -->
        <div class="pagination">
	        <c:if test="${curBlock > 0}"><a href="${ctp}/blog/${userMid}?page=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}"><i class="fa-solid fa-angle-left fa-2xs"></i></a></c:if>
	        <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
		        <c:if test="${i <= totPage && i == page}"><a href="${ctp}/blog/${userMid}?page=${i}&pageSize=${pageSize}" class="active">${i}</a></c:if>
		        <c:if test="${i <= totPage && i != page}"><a href="${ctp}/blog/${userMid}?page=${i}&pageSize=${pageSize}">${i}</a></c:if>
	        </c:forEach>
	        <c:if test="${curBlock < lastBlock}"><a href="${ctp}/blog/${userMid}?page=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}"><i class="fa-solid fa-angle-right fa-2xs"></i></a></c:if>
    	</div>
    	<!-- 페이지네이션 끝 -->
    </section>
    <aside>
        <div class="profile">
            <img src="${ctp}/images/user/${userImg}" alt="profile">
            <div class="nickName">${nickName}</div>
            <div class="blog-intro">${bVo.blogIntro}</div>
            <c:if test="${userMid == sMid}">
            <hr/>
	        <div class="actions">
	        	<c:if test="${param.categoryIdx != null}">
		        <div class="action-link" onclick="location.href='${ctp}/ContentInput/${sMid}?categoryIdx=${param.categoryIdx}';"><i class="fas fa-pencil-alt"></i> 글쓰기</div>
		        </c:if>
	        	<c:if test="${param.categoryIdx == null}">
		        <div class="action-link" onclick="location.href='${ctp}/ContentInput/${sMid}';"><i class="fas fa-pencil-alt"></i> 글쓰기</div>
		        </c:if>
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
