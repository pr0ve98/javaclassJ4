package main;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/MainContent")
public class MainContent extends HttpServlet {
	  @Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  // 구독한 블로그 글, 메인에 띄울 글 받아오기
		  String nav = request.getParameter("nav")==null ? "sub" : request.getParameter("nav");
		  String category = request.getParameter("category")==null ? "all" : request.getParameter("category");
		  String responseData = "";
		  
		  HttpSession session = request.getSession();
		  String nickName = session.getAttribute("sNickName")==null ? "" : (String)session.getAttribute("sNickName");
		  
		  if (nav.equals("sub")) {
			  if(nickName.equals("")) {
				  responseData = "<div class=\"sub-main\">"
						  + "				<p>로그아웃 상태입니다<br/>로그인 후 블로그들을 구독해보세요!</p>"
						  + "				</div>";
			  }
			  else {
				  responseData = "<div class=\"sub-main\">"
						+ "				<p>구독한 블로그가 없어요!<br/>아래에서 마음에 드는 블로그들을 구독하세요!</p>"
						+ "				</div>";
			  }
			  
			  responseData += "<hr/>"
				  		+ "				<div class=\"sub-blogs\">\r\n"
				  		+ "					<div class=\"sub-blog\">\r\n"
				  		+ "						<img src=\""+request.getContextPath()+"/images/user1.jpg\" width=\"100px\" />\r\n"
				  		+ "						<div class=\"blog-title\">꽃구경이 제일 좋아</div>\r\n"
				  		+ "						<div>꽃빈</div>\r\n"
				  		+ "						<div class=\"blog-ment\">다양한 꽃들을 알아가고 있습니다. 꽃구경 같이 합시다.</div>\r\n"
				  		+ "						<div class=\"orangeBtn-sm\">구독하기</div>\r\n"
				  		+ "					</div>\r\n"
				  		+ "					<div class=\"sub-blog\">\r\n"
				  		+ "						<img src=\""+request.getContextPath()+"/images/user2.jpg\" width=\"100px\" />\r\n"
				  		+ "						<div class=\"blog-title\">나연뚜 블로그</div>\r\n"
				  		+ "						<div>낭연</div>\r\n"
				  		+ "						<div class=\"blog-ment\">히히 개가튼 인생</div>\r\n"
				  		+ "						<div class=\"orangeBtn-sm\">구독하기</div>\r\n"
				  		+ "					</div>\r\n"
				  		+ "					<div class=\"sub-blog\">\r\n"
				  		+ "						<img src=\""+request.getContextPath()+"/images/user3.jpg\" width=\"100px\" />\r\n"
				  		+ "						<div class=\"blog-title\">사랑, 정열, 열정!</div>\r\n"
				  		+ "						<div>건강한 하루</div>\r\n"
				  		+ "						<div class=\"blog-ment\">전국 방방곡곡을 다니며 여러가지 지역의 풍경들을 담아내는 블로그를 운영하고 있습니다. 다같이 풍경을 감상해봅시다!</div>\r\n"
				  		+ "						<div class=\"orangeBtn-sm\">구독하기</div>\r\n"
				  		+ "					</div>\r\n"
				  		+ "					<div class=\"sub-blog\">\r\n"
				  		+ "						<img src=\""+request.getContextPath()+"/images/user4.jpg\" width=\"100px\" />\r\n"
				  		+ "						<div class=\"blog-title\">Monday</div>\r\n"
				  		+ "						<div>월요</div>\r\n"
				  		+ "						<div class=\"blog-ment\">언젠간 퇴사하고 만다</div>\r\n"
				  		+ "						<div class=\"orangeBtn-sm\">구독하기</div>\r\n"
				  		+ "					</div>\r\n"
				  		+ "					<div class=\"sub-blog\">\r\n"
				  		+ "						<img src=\""+request.getContextPath()+"/images/user5.jpg\" width=\"100px\" />\r\n"
				  		+ "						<div class=\"blog-title\">해피바이러스</div>\r\n"
				  		+ "						<div>happy1234</div>\r\n"
				  		+ "						<div class=\"blog-ment\">다같이 웃어보아요~</div>\r\n"
				  		+ "						<div class=\"orangeBtn-sm\">구독하기</div>\r\n"
				  		+ "					</div>\r\n"
				  		+ "					<div class=\"sub-blog\">\r\n"
				  		+ "						<img src=\""+request.getContextPath()+"/images/user6.jpg\" width=\"100px\" />\r\n"
				  		+ "						<div class=\"blog-title\">속닥속닥 일상기록</div>\r\n"
				  		+ "						<div>마링</div>\r\n"
				  		+ "						<div class=\"blog-ment\">♥ 마링이의 일상 기록장 ♥</div>\r\n"
				  		+ "						<div class=\"orangeBtn-sm\">구독하기</div>\r\n"
				  		+ "					</div>\r\n"
				  		+ "				</div>";
		  } else if (nav.equals("pop")) {
			  responseData = "				<div class=\"menu2\">\r\n"
			  		+ "					<div><a href=\"#\" class=\"mr-4 active-color\" onclick=\"loadContent('pop', 'all');\">전체</a></div>\r\n"
			  		+ "					<div><a href=\"#\" class=\"mr-4\" onclick=\"loadContent('pop', 'life');\">일상</a></div>\r\n"
			  		+ "					<div><a href=\"#\" class=\"mr-4\">취미</a></div>\r\n"
			  		+ "					<div><a href=\"#\" class=\"mr-4\">공연·전시</a></div>\r\n"
			  		+ "					<div><a href=\"#\" class=\"mr-4\">게임</a></div>\r\n"
			  		+ "					<div><a href=\"#\" class=\"mr-4\">패션·미용</a></div>\r\n"
			  		+ "					<div><a href=\"#\" class=\"mr-4\">비즈니스·경제</a></div>\r\n"
			  		+ "					<div><a href=\"#\" class=\"mr-4\">육아·결혼</a></div>\r\n"
			  		+ "					<div><a href=\"#\" class=\"mr-4\">문학·책</a></div>\r\n"
			  		+ "				</div>\r\n"
			  		+ "				<hr/>\r\n"
			  		+ "				<div class=\"content-bt\">\r\n"
			  		+ "					<div class=\"content-box\">\r\n"
			  		+ "						<div class=\"imgBox\"><img class=\"img-box\" src=\""+request.getContextPath()+"/images/test1.jpg\"></div>\r\n"
			  		+ "						<div class=\"text-box text-left\">\r\n"
			  		+ "							<h3><a href=\"#\">햄스터 짤 모음집</a></h3>\r\n"
			  		+ "							<div class=\"blog-user-info\">햄러버 <span class=\"blog-date\">| 12시간 전</span></div>\r\n"
			  		+ "							<div class=\"content-text\">햄스터 짤들을 모아뒀어요 그냥 아무거나 넣을 말을 쓰고 있습니다 안녕하세요? 햄스터는 정말 귀여워요.\r\n"
			  		+ "							반갑습니다? 햄스터를 아세요? 햄스터란? 설치목 비단털쥐과 비단털쥐아과에 속한 포유류이다. 한국에서는 1990년대에 들어서부터 반려동물로 널리 사육되기 시작했다.\r\n"
			  		+ "							화석상의 기록으로는 유럽과 북아프리카의 중신세 중기인 1640만 년~1120만 년 전으로 지층에서 발견된 것이 최초이다.\r\n"
			  		+ "							햄스터는 이미 1839년 G.R.워터하우스에 의해 과학적으로 분류되었으나, 성공적으로 사육 및 번식이 시작된 것은 현재 기준으로 94년 정도밖에 지나지 않았다. 1930년 시리아의 알레포 지역에서 채집된 암컷 1마리와 새끼 12마리가 최초이며, 이 때 이 13마리가 현재 사육되는 골든햄스터의 시초가 되었다.\r\n"
			  		+ "							</div>\r\n"
			  		+ "						</div>\r\n"
			  		+ "					</div>\r\n"
			  		+ "					<hr class=\"content-box-line\"/>\r\n"
			  		+ "					<div class=\"content-box\">\r\n"
			  		+ "						<div class=\"imgBox\"><img class=\"img-box\" src=\""+request.getContextPath()+"/images/test2.jpg\"></div>\r\n"
			  		+ "						<div class=\"text-box text-left\">\r\n"
			  		+ "							<h3><a href=\"#\">정사각형 이미지가 아닐 경우</a></h3>\r\n"
			  		+ "							<div class=\"blog-user-info\">누군가 <span class=\"blog-date\">| 2024. 05. 10</span></div>\r\n"
			  		+ "							<div class=\"content-text\">\r\n"
			  		+ "							유저가 정사각형 이미지를 넣지 않았을 경우도 있기에 정사각형 이미지가 아니라면 이미지를 확대해서 정사각형 이미지로 바꿔줍니다.\r\n"
			  		+ "							그리고 내용을 써보자면 아무거나 써도 됩니다. 근데 블로그라는 것을 보여줘야 하니 내용을 그래도 조금은 넣어야겠죠. 근데 너무 귀찮으니 블로그를 짧게 쓰는 사람도 있을 것이니까\r\n"
			  		+ "							그냥 이만큼만 써보겠습니다. 그럼 이만!\r\n"
			  		+ "							</div>\r\n"
			  		+ "						</div>\r\n"
			  		+ "					</div>\r\n"
			  		+ "					<hr class=\"content-box-line\"/>\r\n"
			  		+ "					<div class=\"content-box\">\r\n"
			  		+ "						<div class=\"imgBox\"><img class=\"img-box\" src=\""+request.getContextPath()+"/images/test3.gif\"></div>\r\n"
			  		+ "						<div class=\"text-box text-left\">\r\n"
			  		+ "							<h3><a href=\"#\">카리나 짱 예쁘다</a></h3>\r\n"
			  		+ "							<div class=\"blog-user-info\">유찌민 <span class=\"blog-date\">| 2024. 05. 03</span></div>\r\n"
			  		+ "							<div class=\"content-text\">\r\n"
			  		+ "							에스파 외계인 컨셉으로 컴백 많관부~\r\n"
			  		+ "							</div>\r\n"
			  		+ "						</div>\r\n"
			  		+ "					</div>\r\n"
			  		+ "				</div>";
			  if (category.equals("life")) {
				  responseData = "				<div class=\"menu2\">\r\n"
						  + "					<div><a href=\"#\" class=\"mr-4\" onclick=\"loadContent('pop', 'all');\">전체</a></div>\r\n"
						  + "					<div><a href=\"#\" class=\"mr-4 active-color\" onclick=\"loadContent('pop', 'life');\">일상</a></div>\r\n"
						  + "					<div><a href=\"#\" class=\"mr-4\">취미</a></div>\r\n"
						  + "					<div><a href=\"#\" class=\"mr-4\">공연·전시</a></div>\r\n"
						  + "					<div><a href=\"#\" class=\"mr-4\">게임</a></div>\r\n"
						  + "					<div><a href=\"#\" class=\"mr-4\">패션·미용</a></div>\r\n"
						  + "					<div><a href=\"#\" class=\"mr-4\">비즈니스·경제</a></div>\r\n"
						  + "					<div><a href=\"#\" class=\"mr-4\">육아·결혼</a></div>\r\n"
						  + "					<div><a href=\"#\" class=\"mr-4\">문학·책</a></div>\r\n"
						  + "				</div>\r\n"
						  + "				<hr/>\r\n"
						  + "				<div class=\"content-bt\">\r\n"
						  + "					<div class=\"content-box\">\r\n"
						  + "						<div class=\"imgBox\"><img class=\"img-box\" src=\""+request.getContextPath()+"/images/test4.jpg\"></div>\r\n"
						  + "						<div class=\"text-box text-left\">\r\n"
						  + "							<h3><a href=\"#\">안녕 친구들</a></h3>\r\n"
						  + "							<h6><b>안녕</b> | 22시간 전</h6>\r\n"
						  + "							<div class=\"content-text\">"
						  + "							안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! 안녕! "
						  + "							</div>\r\n"
						  + "						</div>\r\n"
						  + "					</div>\r\n"
						  + "					<hr class=\"content-box-line\"/>\r\n"
						  + "					<div class=\"content-box\">\r\n"
						  + "						<div class=\"imgBox\"><img class=\"img-box\" src=\""+request.getContextPath()+"/images/test5.jpg\"></div>\r\n"
						  + "						<div class=\"text-box text-left\">\r\n"
						  + "							<h3><a href=\"#\">돈까스는 역시 경양식</a></h3>\r\n"
						  + "							<h6><b>돈까스맨</b> | 2시간 전</h6>\r\n"
						  + "							<div class=\"content-text\">\r\n"
						  + "							돈까스......... 돈까스........ 경양식 돈까스.......... 어쩌구 저쩌구.............."
						  + "							</div>\r\n"
						  + "						</div>\r\n"
						  + "					</div>\r\n"
						  + "					<hr class=\"content-box-line\"/>\r\n"
						  + "					<div class=\"content-box\">\r\n"
						  + "						<div class=\"imgBox\"><img class=\"img-box\" src=\""+request.getContextPath()+"/images/test6.jpg\"></div>\r\n"
						  + "						<div class=\"text-box text-left\">\r\n"
						  + "							<h3><a href=\"#\">민희진 국힙 원탑</a></h3>\r\n"
						  + "							<h6><b>김모씨</b> | 2024. 05. 11</h6>\r\n"
						  + "							<div class=\"content-text\">\r\n"
						  + "							하이브는 단월드인가?\r\n"
						  + "							</div>\r\n"
						  + "						</div>\r\n"
						  + "					</div>\r\n"
						  + "				</div>";
		        }
		  } else if (nav.equals("rec")) {
			  responseData = "<h2>여기는 최신글</h2><p>최신 글들이 올라와요</p>";
		  }
		  
		  response.setContentType("text/html");
		  PrintWriter out = response.getWriter();
		  out.println(responseData);
		  out.close();
	}
}
