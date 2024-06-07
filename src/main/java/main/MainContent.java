package main;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import blog.BlogDAO;
import blog.BlogVO;
import content.ContentDAO;
import content.ContentVO;
import user.SubVO;
import user.UserDAO;

@SuppressWarnings("serial")
@WebServlet("/MainContent")
public class MainContent extends HttpServlet {
	  @Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  // 구독한 블로그 글, 메인에 띄울 글 받아오기
		  String nav = request.getParameter("nav")==null ? "sub" : request.getParameter("nav");
		  String category = request.getParameter("category")==null ? "all" : request.getParameter("category");
		  int page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));
	      int pageSize = request.getParameter("pageSize")==null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		  String responseData = "";
		  
		  HttpSession session = request.getSession();
		  String sMid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		  
		  BlogDAO bDao = new BlogDAO();
		  BlogVO vo = bDao.getUserBlog(sMid);
		  ArrayList<BlogVO> randomBlogVos = bDao.getRandomBlog(vo.getBlogIdx());
		  
		  UserDAO uDao = new UserDAO();
		  ArrayList<SubVO> mySubBlogVos = uDao.getMySubBlog(sMid);
		  
		  ContentDAO cDao = new ContentDAO();

		  
		  if (nav.equals("sub")) {
			  if(sMid.equals("")) {
				  responseData = "<div class=\"sub-main\">"
						  + "				<p>로그아웃 상태입니다<br/>로그인 후 블로그들을 구독해보세요!</p>"
						  + "				</div><hr/>"
						  +"<div class='sub-blogs'>";
				  for(BlogVO ranBlog : randomBlogVos) {
					  responseData += "<div class='sub-blog'>"
							  +"<img src='"+request.getContextPath()+"/images/user/"+ranBlog.getUserImg()+"' width='100px'/>"
							  +"<div class='blog-title' style='cursor:pointer;' onclick='location.href=\""+request.getContextPath()+"/blog/"+ranBlog.getBlogMid()+"\";'>"+ranBlog.getBlogTitle()+"</div>"
							  +"<div>"+ranBlog.getNickName()+"</div>"
							  +"<div class='blog-ment'>"+ranBlog.getBlogIntro()+"</div></div>";
				  }
			  }
			  else if(mySubBlogVos.size() == 0) {
				  responseData = "<div class=\"sub-main\">"
						+ "				<p>구독한 블로그가 없어요!<br/>아래에서 마음에 드는 블로그들을 구독하세요!</p>"
						+ "				</div><hr/>"
						+"<div class='sub-blogs'>";
				  for(BlogVO ranBlog : randomBlogVos) {
					  responseData += "<div class='sub-blog'>"
							  +"<img src='"+request.getContextPath()+"/images/user/"+ranBlog.getUserImg()+"' width='100px'/>"
							  +"<div class='blog-title' style='cursor:pointer;' onclick='location.href=\""+request.getContextPath()+"/blog/"+ranBlog.getBlogMid()+"\";'>"+ranBlog.getBlogTitle()+"</div>"
							  +"<div>"+ranBlog.getNickName()+"</div>"
							  +"<div class='blog-ment'>"+ranBlog.getBlogIntro()+"</div>"
							  +"<div class='orangeBtn-sm' onclick='subOk(\""+sMid+"\", "+ranBlog.getBlogIdx()+")'>구독하기</div></div>";
				  }
			  }
			  else {
				  String mySubBlog = "";
				  for(SubVO mysub : mySubBlogVos) {
					  mySubBlog += mysub.getsBlogIdx()+",";
				  }
				  mySubBlog = mySubBlog.substring(0, mySubBlog.length()-1);
				  
				// 페이지네이션
		    	int totRecCnt = cDao.getSubContentCnt(mySubBlog, sMid);
				int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize)+1;
				if(page > totPage) page = 1;
				int startIndexNo = (page - 1) * pageSize;
				int curScrStartNo = totRecCnt - startIndexNo;
				int blockSize = 10;
				int curBlock = (page - 1) / blockSize;
				int lastBlock = (totPage - 1) / blockSize;
				
		    	// 구독한 블로그 최근 일주일 내 게시글 다 가져오기
		    	ArrayList<ContentVO> subContentVos = cDao.getSubContents(startIndexNo, pageSize, mySubBlog, sMid);
				  
		    	if(subContentVos.size() != 0) {
					  responseData += "<div style='font-size:14pt;'>구독한 블로그의 새글 <font color='#ff7200'>"+totRecCnt+"</font></div><hr/><div class='content-bt'>";
					  for(ContentVO subContent : subContentVos) {
						  String[] contentImgs = subContent.getImgName().split("\\|");
						  responseData += "<div class='content-box'>";
						  if(contentImgs[0].equals("")) {
							  responseData += "<div class='imgBox'><img class='img-box' src='"+request.getContextPath()+"/images/content/no_image.jpg'></div>";
						  }
						  else if(contentImgs[0].indexOf("http") == -1) {
							  responseData += "<div class='imgBox'><img class='img-box' src='"+request.getContextPath()+"/images/content/"+contentImgs[0]+"'></div>";
						  }
						  else {
							  responseData += "<div class='imgBox'><img class='img-box' src='"+contentImgs[0]+"'></div>";
						  }
						  responseData += "<div class='text-box text-left'>"
							  		+ "<h3><a href='"+request.getContextPath()+"/content/"+subContent.getUserMid()+"?coIdx="+subContent.getCoIdx()+"'>"+subContent.getTitle()+"</a></h3>"
							  		+ "<div class='blog-user-info'><img class='mr-2' src='"+request.getContextPath()+"/images/user/"+subContent.getUserImg()+"'>"+subContent.getNickName()+" <span class='blog-date'>| ";
						  if(subContent.getHour_diff() > 24) responseData += subContent.getwDate().substring(0, 10);
						  else if(subContent.getHour_diff() <= 24 && subContent.getMin_diff() >= 60) responseData += subContent.getHour_diff()+"시간 전";
						  else responseData += subContent.getMin_diff()+"분 전";
						  responseData += "</span></div>"
								  		+ "<div class='content-text mt-2'>"+subContent.getCtPreview()+"</div>"
								  		+ "</div></div><hr class='content-box-line'/>";
					  }
					  responseData += "<div class='pagination'>";
					  if(curBlock > 0) responseData += "<a href='"+request.getContextPath()+"/Main?page="+((curBlock-1)*blockSize+1)+"pageSize="+pageSize+"'><i class='fa-solid fa-angle-left fa-2xs'></i></a>";
					  for(int i=(curBlock*blockSize)+1; i<((curBlock*blockSize)+blockSize); i++) {
						  if(i <= totPage && i == page) responseData += "<a href='"+request.getContextPath()+"/Main?page="+i+"&pageSize="+pageSize+"' class='active'>"+i+"</a>";
						  if(i <= totPage && i != page) responseData += "<a href='"+request.getContextPath()+"/Main?page="+i+"&pageSize="+pageSize+"'>"+i+"</a>";
					  }
					  if(curBlock < lastBlock) responseData += "<a href='"+request.getContextPath()+"/Main?page="+((curBlock+1)*blockSize+1)+"pageSize="+pageSize+"'><i class='fa-solid fa-angle-right fa-2xs'></i></a></div>";
				  }
			    	else {
			    		responseData += "<div style='font-size:14pt;'>구독한 블로그의 새글 <font color='#ff7200'>"+totRecCnt+"</font></div><hr/><div class='content-bt'>"
			    					+ "<div class='newContentNot'>구독한 블로그의 새 글이 없습니다</div><hr/>"
			    					+"<div class='sub-blogs'>";
						  for(BlogVO ranBlog : randomBlogVos) {
							  responseData += "<div class='sub-blog'>"
									  +"<img src='"+request.getContextPath()+"/images/user/"+ranBlog.getUserImg()+"' width='100px'/>"
									  +"<div class='blog-title' style='cursor:pointer;' onclick='location.href=\""+request.getContextPath()+"/blog/"+ranBlog.getBlogMid()+"\";'>"+ranBlog.getBlogTitle()+"</div>"
									  +"<div>"+ranBlog.getNickName()+"</div>"
									  +"<div class='blog-ment'>"+ranBlog.getBlogIntro()+"</div>";
							boolean found = Arrays.asList(mySubBlog.split(",")).contains(String.valueOf(ranBlog.getBlogIdx()));
							if(!found) responseData += "<div class='orangeBtn-sm' onclick='subOk(\""+sMid+"\", "+ranBlog.getBlogIdx()+")'>구독하기</div></div>";
							else responseData += "<div class='grayBtn-sm' onclick='subDelete(\""+sMid+"\", "+ranBlog.getBlogIdx()+")'>구독취소</div></div>";
						  }
			    	}
			  }

		  } else if (nav.equals("pop")) {
			  if(category.equals("") || category.equals("all")) {
				  responseData = "<div class='menu2'>"
					  		+ "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('pop', 'all');\">전체</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'life');\">일상</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'hobby');\">취미</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'movie');\">영화·드라마</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'game');\">게임</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'beauty');\">패션·미용</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'food');\">맛집</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'star');\">스타·연예인</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'animal');\">반려동물</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'travel');\">여행</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'review');\">상품리뷰</a></div></div><hr/>"
					  		+ "<div class='content-bt'>";
			  }
			  else if(category.equals("life")) {
				  responseData = "<div class='menu2'>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'all');\">전체</a></div>"
					  		+ "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('pop', 'life');\">일상</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'hobby');\">취미</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'movie');\">영화·드라마</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'game');\">게임</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'beauty');\">패션·미용</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'food');\">맛집</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'star');\">스타·연예인</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'animal');\">반려동물</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'travel');\">여행</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'review');\">상품리뷰</a></div></div><hr/>"
					  		+ "<div class='content-bt'>";
			  }
			  else if(category.equals("hobby")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('pop', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("movie")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('pop', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("game")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('pop', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("beauty")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('pop', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("food")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('pop', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("star")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('pop', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("animal")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('pop', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("travel")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('pop', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('pop', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('pop', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  responseData += roadContent(request, category);
		  } else if (nav.equals("rec")) {
			  if(category.equals("") || category.equals("all")) {
				  responseData = "<div class='menu2'>"
					  		+ "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('rec', 'all');\">전체</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'life');\">일상</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'hobby');\">취미</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'movie');\">영화·드라마</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'game');\">게임</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'beauty');\">패션·미용</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'food');\">맛집</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'star');\">스타·연예인</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'animal');\">반려동물</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'travel');\">여행</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'review');\">상품리뷰</a></div></div><hr/>"
					  		+ "<div class='content-bt'>";
			  }
			  else if(category.equals("life")) {
				  responseData = "<div class='menu2'>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'all');\">전체</a></div>"
					  		+ "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('rec', 'life');\">일상</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'hobby');\">취미</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'movie');\">영화·드라마</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'game');\">게임</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'beauty');\">패션·미용</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'food');\">맛집</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'star');\">스타·연예인</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'animal');\">반려동물</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'travel');\">여행</a></div>"
					  		+ "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'review');\">상품리뷰</a></div></div><hr/>"
					  		+ "<div class='content-bt'>";
			  }
			  else if(category.equals("hobby")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('rec', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("movie")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('rec', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("game")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('rec', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("beauty")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('rec', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("food")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('rec', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("star")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('rec', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("animal")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('rec', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else if(category.equals("travel")) {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('rec', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  else {
				  responseData = "<div class='menu2'>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'all');\">전체</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'life');\">일상</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'hobby');\">취미</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'movie');\">영화·드라마</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'game');\">게임</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'beauty');\">패션·미용</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'food');\">맛집</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'star');\">스타·연예인</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'animal');\">반려동물</a></div>"
						  + "<div><a href='#' class='mr-4' onclick=\"loadContent('rec', 'travel');\">여행</a></div>"
						  + "<div><a href='#' class='mr-4 active-color' onclick=\"loadContent('rec', 'review');\">상품리뷰</a></div></div><hr/>"
						  + "<div class='content-bt'>";
			  }
			  responseData += roadRecContent(request, category);
		  }
		  
		  response.setContentType("text/html");
		  PrintWriter out = response.getWriter();
		  out.println(responseData);
		  out.close();
	}
	  
	 public String roadContent(HttpServletRequest request, String category) {
		 ContentDAO cDao = new ContentDAO();
		 String responseData = "";
		 ArrayList<ContentVO> popVos = cDao.getPopContentList(category);
		  		for(ContentVO popvo : popVos) {
					  String[] contentImgs = popvo.getImgName().split("\\|");
					  responseData += "<div class='content-box'>";
					  if(contentImgs[0].equals("")) {
						  responseData += "<div class='imgBox'><img class='img-box' src='"+request.getContextPath()+"/images/content/no_image.jpg'></div>";
					  }
					  else if(contentImgs[0].indexOf("http") == -1) {
						  responseData += "<div class='imgBox'><img class='img-box' src='"+request.getContextPath()+"/images/content/"+contentImgs[0]+"'></div>";
					  }
					  else {
						  responseData += "<div class='imgBox'><img class='img-box' src='"+contentImgs[0]+"'></div>";
					  }
					  responseData += "<div class='text-box text-left'>"
						  		+ "<h3><a href='"+request.getContextPath()+"/content/"+popvo.getUserMid()+"?coIdx="+popvo.getCoIdx()+"'>"+popvo.getTitle()+"</a></h3>"
						  		+ "<div class='blog-user-info'><img class='mr-2' src='"+request.getContextPath()+"/images/user/"+popvo.getUserImg()+"'>"+popvo.getNickName()+" <span class='blog-date'>| ";
					  if(popvo.getHour_diff() > 24) responseData += popvo.getwDate().substring(0, 10);
					  else if(popvo.getHour_diff() <= 24 && popvo.getMin_diff() >= 60) responseData += popvo.getHour_diff()+"시간 전";
					  else responseData += popvo.getMin_diff()+"분 전";
					  responseData += "</span></div>"
							  		+ "<div class='content-text mt-2'>"+popvo.getCtPreview()+"</div>"
							  		+ "</div></div><hr class='content-box-line'/>";
		  		}
		  		responseData += "</div>";
		  		return responseData;
	 }
	 
	 public String roadRecContent(HttpServletRequest request, String category) {
		 ContentDAO cDao = new ContentDAO();
		 String responseData = "";
		 ArrayList<ContentVO> recVos = cDao.getRecContentList(category);
		 for(ContentVO recvo : recVos) {
			 String[] contentImgs = recvo.getImgName().split("\\|");
			 responseData += "<div class='content-box'>";
			 if(contentImgs[0].equals("")) {
				 responseData += "<div class='imgBox'><img class='img-box' src='"+request.getContextPath()+"/images/content/no_image.jpg'></div>";
			 }
			 else if(contentImgs[0].indexOf("http") == -1) {
				 responseData += "<div class='imgBox'><img class='img-box' src='"+request.getContextPath()+"/images/content/"+contentImgs[0]+"'></div>";
			 }
			 else {
				 responseData += "<div class='imgBox'><img class='img-box' src='"+contentImgs[0]+"'></div>";
			 }
			 responseData += "<div class='text-box text-left'>"
					 + "<h3><a href='"+request.getContextPath()+"/content/"+recvo.getUserMid()+"?coIdx="+recvo.getCoIdx()+"'>"+recvo.getTitle()+"</a></h3>"
					 + "<div class='blog-user-info'><img class='mr-2' src='"+request.getContextPath()+"/images/user/"+recvo.getUserImg()+"'>"+recvo.getNickName()+" <span class='blog-date'>| ";
			 if(recvo.getHour_diff() > 24) responseData += recvo.getwDate().substring(0, 10);
			 else if(recvo.getHour_diff() <= 24 && recvo.getMin_diff() >= 60) responseData += recvo.getHour_diff()+"시간 전";
			 else responseData += recvo.getMin_diff()+"분 전";
			 responseData += "</span></div>"
					 + "<div class='content-text mt-2'>"+recvo.getCtPreview()+"</div>"
					 + "</div></div><hr class='content-box-line'/>";
		 }
		 responseData += "</div>";
		 return responseData;
	 }
}
