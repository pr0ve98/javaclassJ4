package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserIdCheckCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = new UserDAO();
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		UserVO vo = dao.getUserIdCheck(mid);
		
		String str = "0";
		if(vo.getMid() != null) str = "1";
		
		response.getWriter().write(str);

	}

}
