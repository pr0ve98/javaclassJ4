package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import content.ReplyDAO;

@SuppressWarnings("serial")
@WebServlet("/SubChange")
public class SubChange extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String checkedsIdx = request.getParameter("checkedsIdx")==null ? "" : request.getParameter("checkedsIdx");
		checkedsIdx = checkedsIdx.substring(0, checkedsIdx.length()-1);
		
		System.err.println(checkedsIdx);
		
		UserDAO dao = new UserDAO();
		
		int res = dao.setSubsDelete(checkedsIdx);

		response.getWriter().write(res+"");
		
	}
}
