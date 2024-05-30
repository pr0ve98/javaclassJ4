package content;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/ContentImageDelete")
public class ContentImageDelete extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String imageUrl = request.getParameter("src");
        imageUrl = imageUrl.substring(imageUrl.lastIndexOf("/")+1);
        
        if (imageUrl != null) {
            String realPath = request.getServletContext().getRealPath("/images/content/"+imageUrl);

            File file = new File(realPath);
            if (file.exists() && file.isFile()) {
                if (file.delete()) {
                    response.getWriter().write("1");
                }
                else {
                	response.getWriter().write("0");
                }
            }
            else {
            	response.getWriter().write("0");
            }
        }
        else {
        	response.getWriter().write("0");
        }
    }
}

