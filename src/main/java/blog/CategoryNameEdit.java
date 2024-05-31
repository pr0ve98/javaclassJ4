package blog;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/BlogCategoryEdit")
public class CategoryNameEdit extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String caName = request.getParameter("caName")==null ? "새 카테고리" : request.getParameter("caName");
		int caIdx = request.getParameter("caIdx")==null ? 0 : Integer.parseInt(request.getParameter("caIdx"));
		
		BlogDAO dao = new BlogDAO();
		int res = dao.setCategoryNameUpdate(caName, caIdx);
		
		response.getWriter().write(res+"");
		
	}

}

