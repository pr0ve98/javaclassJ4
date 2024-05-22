package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserEmailCheckCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = new UserDAO();
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		
		UserVO vo = dao.getUserEmailCheck(email);
		
		String str = "0";
		if(vo.getEmail() != null) str = "1";
		
		response.getWriter().write(str);
	}

}
