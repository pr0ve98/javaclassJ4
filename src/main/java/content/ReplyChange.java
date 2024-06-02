package content;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/ReplyChange")
public class ReplyChange extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String selected = request.getParameter("selected")==null ? "" : request.getParameter("selected");
		String checkedrIdx = request.getParameter("checkedrIdx")==null ? "" : request.getParameter("checkedrIdx");
		checkedrIdx = checkedrIdx.substring(0, checkedrIdx.length()-1);
		
		ReplyDAO dao = new ReplyDAO();
		
		int res = 0;
		if(selected.equals("읽음")) {
			res = dao.setReplysUpdateRead(checkedrIdx);
		}
		else if(selected.equals("삭제")) {
			res = dao.setReplysDelete(checkedrIdx);
		}

		response.getWriter().write(res+"");
		
	}
}
