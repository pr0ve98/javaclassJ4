package content;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import blog.BlogDAO;
import blog.BlogVO;
import blog.CategoryVO;
import common.Pagination;
import user.UserDAO;
import user.UserVO;

@SuppressWarnings("serial")
@WebServlet("/ContentsEdit/*")
public class ContentsEdit extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BlogDAO bDao = new BlogDAO();
		UserDAO uDao = new UserDAO();
		ContentDAO coDao = new ContentDAO();
		RequestDispatcher dispatcher = null;
		HttpSession session = request.getSession();
		String sMid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		
       String pathInfo = request.getPathInfo(); // 사용자 아이디 부분 가져오기(/blog'/mid')
       String mid = pathInfo.substring(1); // 슬래시 빼고 뒤에 아이디만 추출
       
       // 경로 정보가 없거나 로그인한 유저가 블로그 주인과 다르면 메인페이지로 이동
        if (pathInfo == null || pathInfo.equals("/") || !sMid.equals(mid)) {
            dispatcher = request.getRequestDispatcher("/");
            dispatcher.forward(request, response);
            return;
        }
		
        BlogVO bVo = bDao.getUserBlog(mid);
        UserVO uVo = uDao.getUserIdCheck(mid);
        
        ArrayList<CategoryVO> cPVos = bDao.getCategory(bVo.getBlogIdx(), 1); // 부모 카테고리만 가져오기
        ArrayList<CategoryVO> cCVos = bDao.getCategory(bVo.getBlogIdx(), 2); // 자식 카테고리만 가져오기
        
        // 페이지네이션 처리
    	int page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));
    	int pageSize = request.getParameter("pageSize")==null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
    	int categoryIdx = request.getParameter("categoryIdx")==null ? 0 : Integer.parseInt(request.getParameter("categoryIdx"));
    	String search = request.getParameter("search")==null ? "" : request.getParameter("search");
    	
    	Pagination.pageChange(request, page, pageSize, "주인", bVo.getBlogIdx(), categoryIdx, search);
        
        request.setAttribute("bVo", bVo);
        request.setAttribute("uVo", uVo);
        request.setAttribute("cPVos", cPVos);
        request.setAttribute("cCVos", cCVos);
        
		ReplyDAO rDao = new ReplyDAO();
		ArrayList<ReplyVO> vos = rDao.getNotReadReplys(bVo.getBlogIdx());
		int newReplyCnt = rDao.getNotReadReplysCnt(bVo.getBlogIdx());
		
		request.setAttribute("vos", vos);
		request.setAttribute("newReplyCnt", newReplyCnt);
        
		String viewPage = "/WEB-INF/blog/blogContentEdit.jsp";
	    dispatcher = request.getRequestDispatcher(viewPage);
	    dispatcher.forward(request, response);
		
	}

}

