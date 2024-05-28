package blog;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/BlogEditOk")
public class BlogEditOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String blogTitle = request.getParameter("blogTitle")==null ? "" : request.getParameter("blogTitle");
		String blogIntro = request.getParameter("blogIntro")==null ? "" : request.getParameter("blogIntro");
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		BlogDAO dao = new BlogDAO();
		
		int res = dao.setBlogEdit(blogTitle, blogIntro, mid);
		
		response.getWriter().write(res+"");

	}
}
