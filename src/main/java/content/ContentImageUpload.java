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
@WebServlet("/ContentImageUpload")
public class ContentImageUpload extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/content");
		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		String img = multipartRequest.getFilesystemName("file") == null ? "no_image.jpg" : multipartRequest.getFilesystemName("file");
		
		String filePath = request.getServletContext().getRealPath("/images/content/");
		File file = new File(filePath+img);
		
        response.setContentType("text/plain");
        response.getWriter().write(request.getContextPath()+"/images/content/" + img);
	}
}

