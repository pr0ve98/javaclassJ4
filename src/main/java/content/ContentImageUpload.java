package content;

import java.io.IOException;
import java.util.Enumeration;

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
        int maxSize = 1024 * 1024 * 10; // 10MB
        String encoding = "UTF-8";

        // MultipartRequest 객체 생성
        MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());

        // 업로드된 파일명 저장
        StringBuilder filePaths = new StringBuilder();
        Enumeration<?> files = multipartRequest.getFileNames();
        while (files.hasMoreElements()) {
            String name = (String) files.nextElement();
            String fileName = multipartRequest.getFilesystemName(name);
            if (fileName != null) {
                if (filePaths.length() > 0) {
                    filePaths.append("/");
                }
                filePaths.append(request.getContextPath() + "/images/content/" + fileName+"///");
            }
        }

        //System.out.println("File Paths: " + filePaths.toString());

        // 응답 설정
        response.setContentType("text/plain");
        response.getWriter().write(filePaths.toString());
    }
}

