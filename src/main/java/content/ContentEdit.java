package content;

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
@WebServlet("/edit/*")
public class ContentEdit extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BlogDAO bDao = new BlogDAO();
		ContentDAO coDao = new ContentDAO();
		RequestDispatcher dispatcher = null;
		
		HttpSession session = request.getSession();
		String sMid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		
       String pathInfo = request.getPathInfo(); // 사용자 아이디 부분 가져오기(/blog'/mid')
       String mid = pathInfo.substring(1); // 슬래시 빼고 뒤에 아이디만 추출
       
       // 경로 정보가 없거나 로그인한 유저가 블로그 주인과 다르면 자기 블로그로 이동(로그인 안 했으면 메인)
        if (pathInfo == null || pathInfo.equals("/") || !sMid.equals(mid)) {
            dispatcher = request.getRequestDispatcher(request.getContextPath()+"/blog/"+sMid);
            dispatcher.forward(request, response);
            return;
        }
        
        BlogVO bVo = bDao.getUserBlog(mid);
        ArrayList<CategoryVO> cPVos = bDao.getCategory(bVo.getBlogIdx(), 1); // 부모 카테고리만 가져오기
        ArrayList<CategoryVO> cCVos = bDao.getCategory(bVo.getBlogIdx(), 2); // 자식 카테고리만 가져오기
        
        int coIdx = request.getParameter("coIdx")==null ? 0 : Integer.parseInt(request.getParameter("coIdx"));
        int categoryIdx = request.getParameter("categoryIdx")==null ? 0 : Integer.parseInt(request.getParameter("categoryIdx"));
        ContentVO contentVo = coDao.getContent(coIdx);
        
        request.setAttribute("userMid", mid);
        request.setAttribute("bVo", bVo);
        request.setAttribute("cPVos", cPVos);
        request.setAttribute("cCVos", cCVos);
        request.setAttribute("contentVo", contentVo);
        request.setAttribute("coIdx", coIdx);
        request.setAttribute("categoryIdx", categoryIdx);
        
        String viewPage = "/WEB-INF/content/contentEdit.jsp";
        dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
        
	}
}
