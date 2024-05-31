package blog;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/BlogCategoryDelete")
public class CategoryDelete extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int caIdx = request.getParameter("caIdx")==null ? 0 : Integer.parseInt(request.getParameter("caIdx"));
		
		BlogDAO dao = new BlogDAO();
		int res = dao.setCategoryDelete(caIdx);
		
		response.getWriter().write(res+"");
		
	}

}

