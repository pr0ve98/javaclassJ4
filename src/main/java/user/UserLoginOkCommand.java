package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import blog.BlogDAO;
import blog.BlogVO;
import common.SecurityUtil;

public class UserLoginOkCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		UserDAO dao = new UserDAO();
		UserVO vo = dao.getUserIdCheck(mid);
		
		BlogDAO bDao = new BlogDAO();
		BlogVO bVo = bDao.getUserBlog(mid);
		
		if(vo.getMid() == null || vo.getIsDel() == 1) {
			request.setAttribute("title", "아이디 오류");
			request.setAttribute("message", "해당 아이디가 없습니다!");
			request.setAttribute("url", "UserLogin.u");
			return;
		}
		
		if(bVo.getBlogMid() == null) {
			request.setAttribute("title", "아이디 오류");
			request.setAttribute("message", "해당 아이디가 없습니다!");
			request.setAttribute("url", "UserLogin.u");
			return;
		}
		
		String salt = vo.getPwd().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt+pwd);
		
		if(!vo.getPwd().substring(8).equals(pwd)) {
			request.setAttribute("title", "비밀번호 오류");
			request.setAttribute("message", "비밀번호가 맞지 않습니다!");
			request.setAttribute("url", "UserLogin.u");
			return;
		}
		
		// 아이디 저장 체크
		String idSave = request.getParameter("idSave")==null ? "off" : "on";
		Cookie cookieMid = new Cookie("cMid", mid);
		cookieMid.setPath("/");
		if(idSave.equals("on")) cookieMid.setMaxAge(60*60*24*7);
		else cookieMid.setMaxAge(0);
		response.addCookie(cookieMid);
		
		HttpSession session = request.getSession();
		session.setAttribute("sMid", mid);
		session.setAttribute("sNickName", vo.getNickName());
		session.setAttribute("sBlogTitle", bVo.getBlogTitle());
		session.setAttribute("sUserImg", vo.getUserImg());
		
		request.setAttribute("title", "로그인 성공");
		request.setAttribute("message", "<span style='color:#ff7200'>"+vo.getNickName()+"</span>님 에이치로그에 어서오세요!");
		request.setAttribute("url", "Main");
	}

}
