package user;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UserImgChangeCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/user");
		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		String img = multipartRequest.getFilesystemName("fName") == null ? "user_basic.jpg" : multipartRequest.getFilesystemName("fName");
		String mid = multipartRequest.getParameter("mid") == null ? "" : multipartRequest.getParameter("mid");
		
		UserVO vo = new UserVO();
		UserDAO dao = new UserDAO();
		
		vo = dao.getUserIdCheck(mid);
		if(!vo.getUserImg().equals("user_basic.jpg")) {
			String filePath = request.getServletContext().getRealPath("/images/user/");
			File file = new File(filePath+vo.getUserImg());
			if(file.exists()) {
				file.delete();
			}
		}
		
		int res = dao.setUserImgChange(img, mid);
		
		response.getWriter().write(res+"");

	}

}
