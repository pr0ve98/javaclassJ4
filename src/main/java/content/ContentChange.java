package content;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import blog.BlogDAO;
import blog.CategoryVO;

@SuppressWarnings("serial")
@WebServlet("/ContentChange")
public class ContentChange extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String selected = request.getParameter("selected")==null ? "" : request.getParameter("selected");
		String checkedCoIdx = request.getParameter("checkedCoIdx")==null ? "" : request.getParameter("checkedCoIdx");
		checkedCoIdx = checkedCoIdx.substring(0, checkedCoIdx.length()-1);
		
		ContentDAO dao = new ContentDAO();
		BlogDAO bDao = new BlogDAO();
		ContentVO coVo = null;
		CategoryVO cVo = null;
		
		int res = 0;
		if(selected.equals("공개")) {
			int coIdx = 0;
			if(checkedCoIdx.length() > 1) {
				String[] coIdxs = checkedCoIdx.split(",");
				for(int i=0; i<coIdxs.length; i++) {
					coIdx = Integer.parseInt(coIdxs[i]);
					coVo = dao.getContent(coIdx);
					cVo = bDao.getCategoryIdx(coVo.getCategoryIdx());
					if(cVo.getPublicSetting().equals("비공개")) {
						response.getWriter().write("카테고리비공개");
						return;
					}
				}
			} 
			else {
				coIdx = Integer.parseInt(checkedCoIdx);
				coVo = dao.getContent(coIdx);
				cVo = bDao.getCategoryIdx(coVo.getCategoryIdx());
				if(cVo.getPublicSetting().equals("비공개")) {
					response.getWriter().write("카테고리비공개");
					return;
				}
			}
			res = dao.setContentsUpdatePublic(checkedCoIdx, selected);
		}
		else if(selected.equals("비공개")) {
			res = dao.setContentsUpdatePublic(checkedCoIdx, selected);
		}
		else if(selected.equals("삭제")) {
			int coIdx = 0;
			String img = "";
			if(checkedCoIdx.length() > 1) {
				String[] coIdxs = checkedCoIdx.split(",");
				for(int i=0; i<coIdxs.length; i++) {
					coIdx = Integer.parseInt(coIdxs[i]);
					coVo = dao.getContent(coIdx);
					img += coVo.getImgName()+"|";
				}
				img = img.substring(0, img.length()-1);
				if(img != null) {
					String[] imgName = img.split("\\|");
					for(int i=0; i<imgName.length; i++) {
						if(imgName[i].indexOf("http") == -1) {
							String realPath = request.getServletContext().getRealPath("/images/content/"+imgName[i]);
							File file = new File(realPath);
							if (file.exists() && file.isFile()) {
								file.delete();
							}
						}
					}
				}
			}
			else {
				coIdx = Integer.parseInt(checkedCoIdx);
				coVo = dao.getContent(coIdx);
				img += coVo.getImgName();
				img = img.substring(0, img.length()-1);
				if(img != null) {
					String[] imgName = img.split("\\|");
					for(int i=0; i<imgName.length; i++) {
						if(imgName[i].indexOf("http") == -1) {
							String realPath = request.getServletContext().getRealPath("/images/content/"+imgName[i]);
							File file = new File(realPath);
							if (file.exists() && file.isFile()) {
								file.delete();
							}
						}
					}
				}
			}
			res = dao.setContentsDelete(checkedCoIdx);
		}
		else { // 카테고리 변경
			int categoryIdx = Integer.parseInt(selected);
			cVo = bDao.getCategoryIdx(categoryIdx);
			int sw = 0;
			if(cVo.getPublicSetting().equals("비공개")) sw = 1;
			res = dao.setContentCategoryUpdate(checkedCoIdx, categoryIdx, sw);
		}
		
		response.getWriter().write(res+"");
		
	}
}
