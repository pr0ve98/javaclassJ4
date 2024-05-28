package blog;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserVO;

@SuppressWarnings("serial")
@WebServlet("/CategoryEdit/*")
public class CategoryEditServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BlogDAO bDao = new BlogDAO();
		UserDAO uDao = new UserDAO();
		RequestDispatcher dispatcher = null;
		String viewPage = "/WEB-INF/blog/blogCategoryEdit.jsp";
		
		HttpSession session = request.getSession();
		String sMid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		
       String pathInfo = request.getPathInfo(); // 사용자 아이디 부분 가져오기(/blog'/mid')
       String mid = pathInfo.substring(1); // 슬래시 빼고 뒤에 아이디만 추출
       
       // 경로 정보가 없거나 로그인한 유저가 블로그 주인과 다르면 메인페이지로 이동
        if (pathInfo == null || pathInfo.equals("/") || !sMid.equals(mid)) {
            dispatcher = request.getRequestDispatcher("/");
            dispatcher.forward(request, response);
            return;
        }
        
        BlogVO bVo = bDao.getUserBlog(mid);
        UserVO uVo = uDao.getUserIdCheck(mid);
        ArrayList<CategoryVO> cPVos = bDao.getCategory(bVo.getBlogIdx(), 1); // 부모 카테고리만 가져오기
        ArrayList<CategoryVO> cCVos = bDao.getCategory(bVo.getBlogIdx(), 2); // 자식 카테고리만 가져오기
        
        request.setAttribute("bVo", bVo);
        request.setAttribute("uVo", uVo);
        request.setAttribute("cPVos", cPVos);
        request.setAttribute("cCVos", cCVos);
        
        dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
	}
}