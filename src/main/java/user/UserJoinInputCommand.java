package user;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import blog.BlogDAO;
import blog.BlogVO;
import common.SecurityUtil;

public class UserJoinInputCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		String nickName = request.getParameter("nickName") == null ? "" : request.getParameter("nickName");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String birthday = request.getParameter("birthday") == null ? "" : request.getParameter("birthday");
		
		UserDAO dao = new UserDAO();
		UserVO vo = dao.getUserIdCheck(mid);
		if(vo.getMid() != null) {
			request.setAttribute("title", "아이디 오류");
			request.setAttribute("message", "이미 사용중인 아이디입니다!");
			request.setAttribute("url", "UserJoin.u");
			return;
		}
		
		UUID uid = UUID.randomUUID();
		String salt = uid.toString().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt+pwd);
		pwd = salt + pwd;
		
		vo = new UserVO();
		vo.setMid(mid);
		vo.setEmail(email);
		vo.setPwd(pwd);
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setBirthday(birthday);
		
		int res = dao.setUserJoinInput(vo);
		
		// 회원가입 시 블로그 자동생성
		BlogVO bVo = new BlogVO();
		bVo.setBlogMid(mid);
		bVo.setBlogTitle(vo.getNickName()+"의 Blog");
		bVo.setBlogIntro(vo.getNickName()+"의 블로그입니다");
		
		BlogDAO bDao = new BlogDAO();
		bDao.setInputBlog(mid, bVo.getBlogTitle(), bVo.getBlogIntro());
		
		bVo = bDao.getUserBlog(mid);
		
		// 블로그 기본 카테고리 생성
		bDao.setCategoryInput("기본카테고리", bVo.getBlogIdx(), 0, 0);
		
		
		if(res != 0) {
			request.setAttribute("title", "회원가입 성공");
			request.setAttribute("message", "<span style='color:#ff7200'>"+nickName+"</span>님 에이치로그에 어서오세요!");
			request.setAttribute("url", "UserLogin.u");
		}
		else {
			request.setAttribute("title", "회원가입 실패");
			request.setAttribute("message", "회원가입에 실패했어요...");
			request.setAttribute("url", "UserJoin.u");
		}
	}

}
