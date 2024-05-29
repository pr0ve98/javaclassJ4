package content;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@SuppressWarnings("serial")
@WebServlet("/ContentImageDelete")
public class ContentImageDelete extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String imageUrl = request.getParameter("src");

        if (imageUrl != null) {
            String realPath = request.getServletContext().getRealPath(imageUrl);

            File file = new File(realPath);
            if (file.exists() && file.isFile()) {
                if (file.delete()) {
                    response.getWriter().write("1");
                }
                else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete image");
                }
            }
            else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            }
        }
        else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid image URL");
        }
    }
}

