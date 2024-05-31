package blog;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/BlogCategoryPublic")
public class CategoryPublic extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int caIdx = request.getParameter("caIdx")==null ? 0 : Integer.parseInt(request.getParameter("caIdx"));
		
		BlogDAO dao = new BlogDAO();
		CategoryVO vo = dao.getCategoryIdx(caIdx);
		
		int res = 0;
		if(vo.getParentCategoryIdx() != 0) { // 자식 카테고리일 경우
			CategoryVO pVo = dao.getCategoryIdx(vo.getParentCategoryIdx());
			if(pVo.getPublicSetting().equals("비공개")) {
				response.getWriter().write("부모비공개");
				return;
			}
			else {
				res = dao.setCategoryPublic(caIdx);
			}
		}
		else { // 부모 카테고리일 경우
			res = dao.setCategoryPublic(caIdx);
		}
		response.getWriter().write(res+"");
		
	}

}
