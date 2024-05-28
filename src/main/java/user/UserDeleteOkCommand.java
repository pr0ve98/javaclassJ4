package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import blog.BlogDAO;

public class UserDeleteOkCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		
		UserDAO dao = new UserDAO();
		int res = dao.setUserDelete(mid);
		
		if(res != 0) {
			BlogDAO bDao = new BlogDAO();
			bDao.setBlogDelete(mid);
			session.invalidate();
			request.setAttribute("message", "탈퇴되었습니다!");
			request.setAttribute("url", "Main");
		}
		else {
			request.setAttribute("message", "탈퇴에 실패했어요...");
			request.setAttribute("url", "UserEdit.u");
		}
	}

}
