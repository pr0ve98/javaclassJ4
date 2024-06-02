package content;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/ReplyEdit")
public class ReplyEdit extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		int rIdx = request.getParameter("rIdx")==null ? 0 : Integer.parseInt(request.getParameter("rIdx"));
		String rPublic = request.getParameter("replyEditSC")==null ? "공개" : request.getParameter("replyEditSC");
		
		ReplyDAO dao = new ReplyDAO();
		int res = dao.setReplyUpdate(content,rPublic, rIdx);
		
		response.getWriter().write(res+"");
	}
}
