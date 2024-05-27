package blog;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/CategoryEditOk")
public class CategoryEditOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] categories = request.getParameterValues("categories");
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		BlogDAO dao = new BlogDAO();
		
        if (categories != null) {
            for (String category : categories) {
            	String[] parts = category.split("/");
                String parentId = parts[0];
                String parentName = parts[1];

            }
        }
        else {
            System.out.println("No categories received");
        }
	}
}
