package blog;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/CategoryEditOk")
public class CategoryEditOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] categories = request.getParameterValues("categories");
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		BlogDAO dao = new BlogDAO();
		
		BlogVO vo = dao.getUserBlog(mid);
		CategoryVO cVo = null;
		
        int pIdx = 0;
        int cIdx = 0;
        int tempPIdx = 0;
        int tempCIdx = 0;
        if (categories != null) {
            for (String category : categories) {
            	 System.out.println(category);
                 if (category.contains("parent")) {
                     String[] part = category.split("/");
                     String pCategoryName = part[1];
                     String[] parentIdx = part[0].split("-");
                     if (parentIdx.length > 2) {
                         // 임시 부모 카테고리
                         tempPIdx = Integer.valueOf(parentIdx[2].substring(7));
                         cVo = dao.getCategoryIdx(tempPIdx);
                     } else {
                         // 기존 부모 카테고리
                         pIdx = Integer.valueOf(parentIdx[1]);
                         cVo = dao.getCategoryIdx(pIdx);
                     }

                     if (cVo.getCategory() != null) {
                         // 기존 카테고리 업데이트
                         dao.setCategoryUpdate(cVo.getCaIdx(), cVo.getCaBlogIdx(), pCategoryName, cVo.getParentCategoryIdx(), cVo.getPublicSetting());
                     } else {
                         // 새 부모 카테고리 입력
                         dao.setCategoryInput(pCategoryName, vo.getBlogIdx(), 0, 0);
                         if (parentIdx.length > 2) {
                             // 새로 생성된 부모 카테고리 ID를 받아옴
                             pIdx = dao.getLastInsertedCategoryId();
                         }
                     }
                 }
                 else {
            	 	if(!category.equals("")) {
	            		 String[] part = category.split(",");
	            		 for (int i = 0; i < part.length; i++) {
	            			 String[] subCategory = part[i].split("/");
	            			 String[] childIdx = subCategory[0].split("-");
	            			 String scName = subCategory[1];
	            			 
	            			 if(childIdx.length > 2) {
	            				 tempCIdx = Integer.valueOf(childIdx[2].substring(7));
	            				 cVo = dao.getCategoryIdx(tempPIdx);
	            			 }
	            			 else {
	            				 cIdx = Integer.valueOf(childIdx[0]);
	            				 cVo = dao.getCategoryIdx(cIdx);
	            			 }
	            			 if(cVo.getCategory() != null) {
	            				 dao.setCategoryUpdate(cVo.getCaIdx(), cVo.getCaBlogIdx(), scName, pIdx, cVo.getPublicSetting());
	            			 }
	            			 else {
	            				 dao.setCategoryInput(scName, vo.getBlogIdx(), pIdx, 1);
	            			 }
	            		 }
	            		 pIdx = 0;
            	 	}
                 }
            }
        }
        else {
            System.out.println("No categories received");
        }
	}
}
