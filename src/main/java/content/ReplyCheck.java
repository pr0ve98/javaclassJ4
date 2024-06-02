package content;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/ReplyCheck")
public class ReplyCheck extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ReplyDAO dao = new ReplyDAO();
		String rIdx = request.getParameter("rIdx")==null ? "" : request.getParameter("rIdx");
		dao.setReplysUpdateRead(rIdx);
		
		ReplyVO vo = dao.getReply(rIdx);
		
        String viewPage = "/WEB-INF/content/contentView.jsp?coIdx="+vo.getrCoIdx()+"&rc=rc";
        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
	}
}
