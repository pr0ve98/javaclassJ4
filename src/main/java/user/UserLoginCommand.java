package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserLoginCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Cookie[] cookies = request.getCookies();
	    String saveMid = "";
	    String check = "";
	    for(int i=0; i<cookies.length; i++) {
	        if(cookies[i].getName().equals("cMid")) {
	        	saveMid = cookies[i].getValue();
	        	check = "checked";
	        }
	    }
	    
	    request.setAttribute("cMid", saveMid);
	    request.setAttribute("check", check);
	}

}
