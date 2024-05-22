package user;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserImgBasicChangeCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		UserDAO dao = new UserDAO();
		UserVO vo = dao.getUserIdCheck(mid);
		
		if(!vo.getUserImg().equals("user_basic.jpg")) {
			String filePath = request.getServletContext().getRealPath("/images/user/");
			File file = new File(filePath+vo.getUserImg());
			if(file.exists()) {
				file.delete();
			}
		}
		
		int res = dao.setUserImgBasicChange(mid);
		
		response.getWriter().write(res+"");
	}

}
