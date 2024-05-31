package content;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/CategoryDelete")
public class CategoryDelete extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int coIdx = request.getParameter("coIdx")==null ? 0 : Integer.parseInt(request.getParameter("coIdx"));
		int categoryIdx = request.getParameter("categoryIdx")==null ? 0 : Integer.parseInt(request.getParameter("categoryIdx"));
		int page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		ContentDAO dao = new ContentDAO();
		int res = dao.setContentDelete(coIdx);
		
		if(res != 0) {
			response.getWriter().write(request.getContextPath()+"/blog/"+mid+"?categoryIdx="+categoryIdx+"&page="+page);
		}
		else {
			response.getWriter().write("0");
		}
	}
}
