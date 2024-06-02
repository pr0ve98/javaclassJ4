package common;

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
import user.UserDAO;
import user.UserVO;

@SuppressWarnings("serial")
@WebServlet("/Main")
public class Main extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		String nickName = session.getAttribute("sNickName")==null ? "" : (String)session.getAttribute("sNickName");
		
		if(!mid.equals("")) {
			UserDAO dao = new UserDAO();
			UserVO vo = dao.getUserIdCheck(mid);
			request.setAttribute("vo", vo);
		}
		
		BlogDAO bDao = new BlogDAO();
		BlogVO bVo = bDao.getUserBlog(mid);
		
		ReplyDAO rDao = new ReplyDAO();
		ArrayList<ReplyVO> vos = rDao.getNotReadReplys(bVo.getBlogIdx());
		int newReplyCnt = rDao.getNotReadReplysCnt(bVo.getBlogIdx());
		
		request.setAttribute("vos", vos);
		request.setAttribute("newReplyCnt", newReplyCnt);
		
		String viewPage = "/WEB-INF/main/main.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
