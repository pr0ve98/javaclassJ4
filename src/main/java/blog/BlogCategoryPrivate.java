package blog;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/BlogCategoryPrivate")
public class BlogCategoryPrivate extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int caIdx = request.getParameter("caIdx")==null ? 0 : Integer.parseInt(request.getParameter("caIdx"));
		
		BlogDAO dao = new BlogDAO();
		CategoryVO vo = dao.getCategoryIdx(caIdx);
		
		int res = 0;
		if(vo.getParentCategoryIdx() != 0) { // 자식 카테고리일 경우
			res = dao.setCategoryPrivate(caIdx);
		}
		else { // 부모 카테고리일 경우
			ArrayList<CategoryVO> vos = dao.getCategoryChild(caIdx);
			for(CategoryVO cVo : vos) {
				res += dao.setCategoryPrivate(cVo.getCaIdx());
			}
			res += dao.setCategoryPrivate(caIdx);
		}
		response.getWriter().write(res+"");
		
	}

}
