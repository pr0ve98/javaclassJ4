package user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.u")
public class UserController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserInterface command = null;
		String viewPage = "/WEB-INF/user";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증처리
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		
		if(com.equals("/Login")) {
			viewPage += "/login.jsp";
		}
		else if(com.equals("/UserLogin")) {
			command = new UserLoginCommand();
			command.execute(request, response);
			viewPage += "/userLogin.jsp";
		}
		else if(com.equals("/UserJoin")) {
			viewPage += "/userJoin.jsp";
		}
		else if(com.equals("/UserIdCheck")) {
			command = new UserIdCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/UserEmailCheck")) {
			command = new UserEmailCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/UserJoinInput")) {
			command = new UserJoinInputCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/UserLoginOk")) {
			command = new UserLoginOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/UserEdit")) {
			command = new UserEditCommand();
			command.execute(request, response);
			viewPage += "/userEdit.jsp";
		}
		else if(com.equals("/UserImgChange")) {
			command = new UserImgChangeCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/UserImgBasicChange")) {
			command = new UserImgBasicChangeCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/UserLogout")) {
			command = new UserLogoutCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
