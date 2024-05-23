package blog;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;
import user.UserVO;

@SuppressWarnings("serial")
@WebServlet("/blog/*")
public class BlogServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       String pathInfo = request.getPathInfo();
       RequestDispatcher dispatcher = null;
        if (pathInfo == null || pathInfo.equals("/")) {
            dispatcher = request.getRequestDispatcher("/");
            dispatcher.forward(request, response);
            return;
        }
        
        String userMid = pathInfo.substring(1);
        
        BlogDAO bDao = new BlogDAO();
        UserDAO uDao = new UserDAO();
        BlogVO bVo = bDao.getUserBlog(userMid);
        UserVO uVo = uDao.getUserIdCheck(userMid);
        
        if(bVo.getMid() == null && uVo.getMid() == null) {
            dispatcher = request.getRequestDispatcher("/");
            dispatcher.forward(request, response);
            return;
        }
        
        request.setAttribute("bVo", bVo);
        request.setAttribute("uVo", uVo);
        
        String viewPage = "/WEB-INF/blog/blog.jsp";
        dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
	}
}
