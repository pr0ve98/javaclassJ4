package user;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;

public class UserPwdEditOkCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pwdNow = request.getParameter("pwdNow")==null ? "" : request.getParameter("pwdNow");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		String str = "";
		
		UserDAO dao = new UserDAO();
		UserVO vo = dao.getUserIdCheck(mid);
		
		String salt = vo.getPwd().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		pwdNow = security.encryptSHA256(salt+pwdNow);
		pwdNow = salt + pwdNow;
		
		if(!vo.getPwd().equals(pwdNow)) {
			str = "현재비밀번호오류";
			response.getWriter().write(str);
			return;
		}
		
		String imsiPwd = security.encryptSHA256(salt+pwd);
		imsiPwd = salt + imsiPwd;
		if(vo.getPwd().equals(imsiPwd)) {
			str = "비밀번호같음";
			response.getWriter().write(str);
			return;
		}
		
		UUID uid = UUID.randomUUID();
		salt = uid.toString().substring(0,8);
		pwd = security.encryptSHA256(salt+pwd);
		pwd = salt + pwd;
		
		int res = dao.setPwdEdit(mid, pwd);
		str = res+"";
		
		response.getWriter().write(str);
	}

}
