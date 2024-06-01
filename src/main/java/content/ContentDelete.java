package content;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/ContentDelete")
public class ContentDelete extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int coIdx = request.getParameter("coIdx")==null ? 0 : Integer.parseInt(request.getParameter("coIdx"));
		int categoryIdx = request.getParameter("categoryIdx")==null ? 0 : Integer.parseInt(request.getParameter("categoryIdx"));
		int page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));
		int sw = request.getParameter("sw")==null ? 0 : Integer.parseInt(request.getParameter("sw"));
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String imgNames = request.getParameter("imgName")==null ? "" : request.getParameter("imgName");
		
		ContentDAO dao = new ContentDAO();
		int res = dao.setContentDelete(coIdx);
		
		if(res != 0) {
			boolean isDeleted = false;
			if(!imgNames.equals("")) {
				String[] imgName = imgNames.split("\\|");
				for(int i=0; i<imgName.length; i++) {
					if(imgName[i].indexOf("http") == -1) {
						String realPath = request.getServletContext().getRealPath("/images/content/"+imgName[i]);
						File file = new File(realPath);
						if (file.exists() && file.isFile()) {
			                if (file.delete()) {
			                	isDeleted = true;
			                }
						}
					}
				}
			    if (isDeleted) {
			    	if(sw == 0)response.getWriter().write(request.getContextPath()+"/blog/"+mid+"?categoryIdx="+categoryIdx+"&page="+page);
			    	else response.getWriter().write(request.getContextPath()+"/ContentsEdit/"+mid+"?page="+page);
			    } else {
			        response.getWriter().write("0");
			    }
			}
			else {
				if(sw == 0)response.getWriter().write(request.getContextPath()+"/blog/"+mid+"?categoryIdx="+categoryIdx+"&page="+page);
		    	else response.getWriter().write(request.getContextPath()+"/ContentsEdit/"+mid+"?page="+page);
			}
		}
		else {
			response.getWriter().write("0");
		}
	}
}
