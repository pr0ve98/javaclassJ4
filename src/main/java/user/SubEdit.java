package user;

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
import content.ReplyDAO;
import content.ReplyVO;

@SuppressWarnings("serial")
@WebServlet("/SubEdit/*")
public class SubEdit extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BlogDAO bDao = new BlogDAO();
		UserDAO uDao = new UserDAO();
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
        request.setAttribute("bVo", bVo);
        request.setAttribute("uVo", uVo);
        
        // 페이지네이션 처리
    	int page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));
    	int pageSize = request.getParameter("pageSize")==null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
    	
    	int totRecCnt = uDao.getSubCnt(mid);
    	
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize)+1;
		if(page > totPage) page = 1;
		int startIndexNo = (page - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 10;
		int curBlock = (page - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		request.setAttribute("page", page);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
        
		ArrayList<SubVO> vos = uDao.getSubAllList(startIndexNo, pageSize, mid); // 전체 구독한 블로그
		request.setAttribute("vos", vos);
		
		ReplyDAO rDao = new ReplyDAO();
		ArrayList<ReplyVO> nVos = rDao.getNotReadReplys(bVo.getBlogIdx(), sMid);
		int newReplyCnt = rDao.getNotReadReplysCnt(bVo.getBlogIdx(), sMid);
		
		request.setAttribute("nVos", nVos);
		request.setAttribute("newReplyCnt", newReplyCnt);
        
		String viewPage = "/WEB-INF/blog/blogSubEdit.jsp";
	    dispatcher = request.getRequestDispatcher(viewPage);
	    dispatcher.forward(request, response);
		
	}

}

