package content;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/ReplyDelete")
public class ReplyDelete extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int rIdx = request.getParameter("rIdx")==null ? 0 : Integer.parseInt(request.getParameter("rIdx"));
		
		ReplyDAO dao = new ReplyDAO();
		int res = dao.setReplyDelete(rIdx);
		
		response.getWriter().write(res+"");
	}
}
