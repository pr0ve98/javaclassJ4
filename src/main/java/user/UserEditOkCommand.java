package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserEditOkCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String birthday = request.getParameter("birthday")==null ? "" : request.getParameter("birthday");
		
		UserDAO dao = new UserDAO();
		int res = dao.setUserEdit(nickName, name, birthday, mid);
		
		if(res != 0) {
			request.setAttribute("title", "수정 완료");
			request.setAttribute("message", "정보가 수정되었습니다!");
			request.setAttribute("url", "Main");
		}
		else {
			request.setAttribute("title", "수정 실패");
			request.setAttribute("message", "정보 수정에 실패했습니다!");
			request.setAttribute("url", "UserEdit.u");
		}
	}

}
