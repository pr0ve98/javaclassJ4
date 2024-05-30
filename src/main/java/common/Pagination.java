package common;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import blog.BlogDAO;
import blog.CategoryVO;
import content.ContentDAO;
import content.ContentVO;

public class Pagination {

	public static void pageChange(HttpServletRequest request, int page, int pageSize, String user, int blogIdx,
			int categoryIdx) {
		BlogDAO bDao = new BlogDAO();
		ContentDAO cDao = new ContentDAO();
		
		ArrayList<CategoryVO> categoryIdxs = null;
		CategoryVO CateVo = bDao.getCategoryIdx(categoryIdx);
		if(CateVo.getParentCategoryIdx()==0) {
			categoryIdxs = bDao.getCategoryChild(categoryIdx);
		}
		
		int totRecCnt = cDao.getContentCnt(blogIdx, user, categoryIdx, categoryIdxs);
		
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize)+1;
		if(page > totPage) page = 1;
		int startIndexNo = (page - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 10;
		int curBlock = (page - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		request.setAttribute("page", page);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
		ArrayList<ContentVO> coVos = cDao.getContentList(startIndexNo, pageSize, blogIdx, user, categoryIdx, categoryIdxs);
		request.setAttribute("coVos", coVos);
		
	}

}
