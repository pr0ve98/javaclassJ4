package blog;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.Pagination;
import common.VisitManager;
import user.SubVO;
import user.UserDAO;
import user.UserVO;

@SuppressWarnings("serial")
@WebServlet("/blog/*")
public class BlogServlet extends HttpServlet {
	private VisitManager visitManager;
	
	// 서블릿 최초 실행 시 스케줄러(자정이 지날 때 일일방문자 초기화) 추가하기
	// init 메소드를 사용한 이유는 서버가 실행될 때 최초에 한번만 실행하기 위해서이다 불필요한 반복을 막는 용도
	@Override
	public void init() throws ServletException {
		super.init();
        ServletContext context = getServletContext();
        visitManager = (VisitManager) context.getAttribute("visitManager");
        if (visitManager == null) {
            visitManager = new VisitManager();
            context.setAttribute("visitManager", visitManager);
        }
	}
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BlogDAO bDao = new BlogDAO();
		UserDAO uDao = new UserDAO();
		RequestDispatcher dispatcher = null;
		HttpSession session = request.getSession();
		
       String pathInfo = request.getPathInfo(); // 사용자 아이디 부분 가져오기(/blog'/mid')
       
       // 경로 정보가 없으면 메인페이지로 이동
        if (pathInfo == null || pathInfo.equals("/")) {
            dispatcher = request.getRequestDispatcher("/");
            dispatcher.forward(request, response);
            return;
        }
        
        String sMid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
        String mid = pathInfo.substring(1); // 슬래시 빼고 뒤에 아이디만 추출
        String hostIp = request.getRemoteAddr();
        
        // 블로그별 방문자 맵 가져오기
        visitManager.recordVisit(mid, hostIp, sMid);
        int todayVisitCount = visitManager.getTodayVisit(mid);
        request.setAttribute("todayVisit", todayVisitCount);
        
        BlogVO bVo = bDao.getUserBlog(mid);
        UserVO uVo = uDao.getUserIdCheck(mid);
        
        // 유저가 없으면 메인페이지로 이동
        if(bVo.getBlogMid() == null || uVo.getMid() == null) {
            dispatcher = request.getRequestDispatcher("/");
            dispatcher.forward(request, response);
            return;
        }
        
        ArrayList<CategoryVO> cVos = bDao.getCategory(bVo.getBlogIdx(), 0); // 전체 카테고리 가져오기
        ArrayList<CategoryVO> cPVos = bDao.getCategory(bVo.getBlogIdx(), 1); // 부모 카테고리만 가져오기
        ArrayList<CategoryVO> cCVos = bDao.getCategory(bVo.getBlogIdx(), 2); // 자식 카테고리만 가져오기     
        
        String user = mid.equals(sMid) ? "주인" : "일반";
        
    	// 페이지네이션 처리
    	int page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));
    	int pageSize = request.getParameter("pageSize")==null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
    	int categoryIdx = request.getParameter("categoryIdx")==null ? 0 : Integer.parseInt(request.getParameter("categoryIdx"));
    	String search = request.getParameter("search")==null ? "" : request.getParameter("search");
    			
    	Pagination.pageChange(request, page, pageSize, user, bVo.getBlogIdx(), categoryIdx, search);
    	
    	// 방문자가 이 블로그를 구독했는지
    	SubVO sVo = uDao.getBlogsub(sMid, bVo.getBlogIdx());
    	request.setAttribute("sVo", sVo);
        	
        String userMid = uVo.getMid();
        String nickName = uVo.getNickName();
        String userImg = uVo.getUserImg();
        
        request.setAttribute("userMid", userMid);
        request.setAttribute("nickName", nickName);
        request.setAttribute("userImg", userImg);
        
        request.setAttribute("bVo", bVo);
        request.setAttribute("cVos", cVos);
        request.setAttribute("cPVos", cPVos);
        request.setAttribute("cCVos", cCVos);
        
        String viewPage = "/WEB-INF/blog/blog.jsp";
        dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
	}
}