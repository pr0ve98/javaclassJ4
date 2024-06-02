package content;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import blog.BlogDAO;
import blog.BlogVO;

@SuppressWarnings("serial")
@WebServlet("/ReplyInput")
public class ReplyInput extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "noname" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "익명" : request.getParameter("nickName");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		String rPublic = request.getParameter("replySC")==null ? "공개" : request.getParameter("replySC");
		String content = request.getParameter("rContent")==null ? "" : request.getParameter("rContent");
		String userMid = request.getParameter("userMid")==null ? "" : request.getParameter("userMid");
		int coIdx = request.getParameter("coIdx")==null ? 0 : Integer.parseInt(request.getParameter("coIdx"));
		int sw = request.getParameter("sw")==null ? 0 : Integer.parseInt(request.getParameter("sw"));
		int parentReplyIdx = request.getParameter("parentReplyIdx")==null ? 0 : Integer.parseInt(request.getParameter("parentReplyIdx"));
		
		ReplyDAO dao = new ReplyDAO();
		BlogDAO bDao = new BlogDAO();
		BlogVO vo = bDao.getUserBlog(userMid);
		int blogIdx = vo.getBlogIdx();
		
		int res = 0;
		if(sw == 0) res = dao.setReplyInput(blogIdx, coIdx, mid, nickName, content, hostIp, rPublic, 0, sw);
		else res = dao.setReplyInput(blogIdx, coIdx, mid, nickName, content, hostIp, rPublic, parentReplyIdx, sw);
		
		response.getWriter().write(res+"");
	}
}
