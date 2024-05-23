package user;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserIdSearchCheckCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String birthday = request.getParameter("birthday") == null ? "" : request.getParameter("birthday");
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z", Locale.ENGLISH);
			sdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
			Date pBirthday = sdf.parse(birthday);
			java.sql.Date sBirthday = new java.sql.Date(pBirthday.getTime());
			
			UserDAO dao = new UserDAO();
			UserVO vo = dao.getUserIdSearch(email, name, sBirthday);
			
			String str = "";
			if(vo.getMid() != null) {
				String mid = vo.getMid();
				str = "당신의 아이디는 <span style='color:#ff7200'>"+mid+"</span>입니다";
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
