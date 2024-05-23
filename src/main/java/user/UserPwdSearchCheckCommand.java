package user;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SecurityUtil;

public class UserPwdSearchCheckCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String birthday = request.getParameter("birthday") == null ? "" : request.getParameter("birthday");
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z", Locale.ENGLISH);
			sdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
			Date pBirthday = sdf.parse(birthday);
			java.sql.Date sBirthday = new java.sql.Date(pBirthday.getTime());
			
			UserDAO dao = new UserDAO();
			UserVO vo = dao.getUserPwdSearch(mid, email, name, sBirthday);
			
			String str = "";
			if(vo.getMid() != null) {
				SecurityUtil security = new SecurityUtil();
				UUID uid = UUID.randomUUID();
				UUID pwdUid = UUID.randomUUID();
				
				String pwd = pwdUid.toString().substring(0, 6);
				String salt = uid.toString().substring(0, 8);
				String securityPwd = security.encryptSHA256(salt + pwd);
				securityPwd = salt + securityPwd;
				
				int res = dao.setPwdEdit(vo.getMid(), securityPwd);
				if(res != 0) {
					str = "임시비밀번호 <span style='color:#ff7200'>"+pwd+"</span>를 발급했습니다<br>다시 로그인해주세요!";
				}
			}
			else {
				str = "입력하신 정보에 해당하는 유저가 없습니다";
			}
			response.getWriter().write(str);
			
		} catch (ParseException e) {
			System.out.println("parse error "+e.getMessage());
		}
	}

}
