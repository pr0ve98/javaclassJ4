package user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import blog.BlogDAO;
import blog.BlogVO;
import blog.CategoryVO;

@SuppressWarnings("serial")
@WebServlet("/SubscribeDelete/*")
public class SubscribeDeleteSevlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int sIdx = request.getParameter("sIdx")==null ? 0 : Integer.parseInt(request.getParameter("sIdx"));
		UserDAO dao = new UserDAO();
		
       String pathInfo = request.getPathInfo(); // 사용자 아이디 부분 가져오기(/blog'/mid')
       String sMid = pathInfo.substring(1); // 슬래시 빼고 뒤에 아이디만 추출
       
       int res = dao.setUserSubDelete(sMid, sIdx);
        
       response.getWriter().write(res+"");
        
	}
}
