package content;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import blog.BlogDAO;
import blog.BlogVO;
import blog.CategoryVO;
import common.VisitManager;
import user.SubVO;
import user.UserDAO;
import user.UserVO;

@SuppressWarnings("serial")
@WebServlet("/content/*")
public class ContentView extends HttpServlet {
	private VisitManager visitManager;
	private final Map<Integer, Map<String, LocalDateTime>> ContentvisitMap = new ConcurrentHashMap<>(); // 게시글별 방문자 IP와 마지막 방문 시간 저장하는 맵
	private final Map<Integer, Integer> viewCnt = new ConcurrentHashMap<>(); // 게시글별 조회수 저장하는 맵
	
    @Override
    public void init() throws ServletException {
        super.init();
        ServletContext context = getServletContext();
        visitManager = (VisitManager) context.getAttribute("visitManager");
        if (visitManager == null) {
            visitManager = new VisitManager();
            context.setAttribute("visitManager", visitManager);
        }
    }
    
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BlogDAO bDao = new BlogDAO();
		UserDAO uDao = new UserDAO();
		ContentDAO coDao = new ContentDAO();
		RequestDispatcher dispatcher = null;
		HttpSession session = request.getSession();
		
       String pathInfo = request.getPathInfo(); // 사용자 아이디 부분 가져오기(/blog'/mid')
       
       // 경로 정보가 없으면 메인페이지로 이동
        if (pathInfo == null || pathInfo.equals("/")) {
            dispatcher = request.getRequestDispatcher("/");
            dispatcher.forward(request, response);
            return;
        }
        
        String sMid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
        String mid = pathInfo.substring(1); // 슬래시 빼고 뒤에 아이디만 추출
        String hostIp = request.getRemoteAddr();
        LocalDateTime now = LocalDateTime.now();
        
        // 블로그별 방문자 맵 가져오기
        visitManager.recordVisit(mid, hostIp, sMid);
        int todayVisitCount = visitManager.getTodayVisit(mid);
        request.setAttribute("todayVisit", todayVisitCount);
        
        BlogVO bVo = bDao.getUserBlog(mid);
        UserVO uVo = uDao.getUserIdCheck(mid);
        
        // 유저가 없으면 메인페이지로 이동
        if(bVo.getBlogMid() == null || uVo.getMid() == null) {
            dispatcher = request.getRequestDispatcher("/");
            dispatcher.forward(request, response);
            return;
        }
        
        int coIdx = request.getParameter("coIdx")==null ? 0 : Integer.parseInt(request.getParameter("coIdx"));
        
        if(coIdx == 0) {
            dispatcher = request.getRequestDispatcher("/blog/"+mid);
            dispatcher.forward(request, response);
            return;
        }
        
        // 게시글별 방문자 맵 가져오기
        ContentvisitMap.putIfAbsent(coIdx, new ConcurrentHashMap<>());
        Map<String, LocalDateTime> userContentVisitMap = ContentvisitMap.get(coIdx);
        
        viewCnt.putIfAbsent(coIdx, 0);
        
        userContentVisitMap.compute(hostIp, (key, lastVisit) -> {
        	// 오늘 방문이 없거나, 방문한지 30분이 지났거나, 블로그주인이 방문한 게 아니면 조회수 증가
        	if((lastVisit == null || ChronoUnit.MINUTES.between(lastVisit, now) >= 30) && !mid.equals(sMid)) {
        		viewCnt.put(coIdx, viewCnt.get(coIdx) + 1);
        		coDao.setViewCnt(coIdx);
        		return now;
        	}
        	else {
        		// 30분 내 재방문 경우 마지막 방문시간 유지
        		return lastVisit;
        	}
        });
        
        ArrayList<CategoryVO> cPVos = bDao.getCategory(bVo.getBlogIdx(), 1); // 부모 카테고리만 가져오기
        ArrayList<CategoryVO> cCVos = bDao.getCategory(bVo.getBlogIdx(), 2); // 자식 카테고리만 가져오기
        
        ContentVO contentVo = coDao.getContent(coIdx);
        
        if(contentVo.getTitle() == null || (contentVo.getCoPublic().equals("비공개") && !mid.equals(sMid))) {
            dispatcher = request.getRequestDispatcher("/blog/"+mid);
            dispatcher.forward(request, response);
            return;
        }
        
        String user = mid.equals(sMid) ? "주인" : "일반";
        
        int page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));
    	int categoryIdx = request.getParameter("categoryIdx")==null ? 0 : Integer.parseInt(request.getParameter("categoryIdx"));
    	request.setAttribute("page", page);
    	request.setAttribute("contentVo", contentVo);
    	
    	// 이전글 다음글 처리
		ArrayList<CategoryVO> categoryIdxs = null;
		CategoryVO CateVo = bDao.getCategoryIdx(categoryIdx);
		if(CateVo.getParentCategoryIdx()==0) {
			categoryIdxs = bDao.getCategoryChild(categoryIdx);
		}
		
    	ContentVO preVo = coDao.getPreSearch(bVo.getBlogIdx(), coIdx, categoryIdx, categoryIdxs, user);
    	ContentVO nextVo = coDao.getNextSearch(bVo.getBlogIdx(), coIdx, categoryIdx, categoryIdxs, user);
        request.setAttribute("preVo", preVo);
        request.setAttribute("nextVo", nextVo);
        
        // 댓글 가져오기
        ReplyDAO rDao = new ReplyDAO();
        ArrayList<ReplyVO> rPVos = rDao.getReplyList(coIdx, 0); //부모댓글
        ArrayList<ReplyVO> rCVos = rDao.getReplyList(coIdx, 1); //자식댓글
        request.setAttribute("rPVos", rPVos);
        request.setAttribute("rCVos", rCVos);
        	
        String userMid = uVo.getMid();
        String nickName = uVo.getNickName();
        String userImg = uVo.getUserImg();
        
        request.setAttribute("userMid", userMid);
        request.setAttribute("nickName", nickName);
        request.setAttribute("userImg", userImg);
        request.setAttribute("coIdx", coIdx);
        request.setAttribute("categoryIdx", categoryIdx);
        
        request.setAttribute("bVo", bVo);
        request.setAttribute("cPVos", cPVos);
        request.setAttribute("cCVos", cCVos);
        
		int rIdx = request.getParameter("rIdx")==null ? 0 : Integer.parseInt(request.getParameter("rIdx"));
		ReplyDAO dao = new ReplyDAO();
		dao.setReplyUpdateRead(rIdx);
		request.setAttribute("rIdx", rIdx);
		
    	// 방문자가 이 블로그를 구독했는지
    	SubVO sVo = uDao.getBlogsub(sMid, bVo.getBlogIdx());
    	request.setAttribute("sVo", sVo);
		
		String viewPage = "/WEB-INF/content/contentView.jsp";
        dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
	}
}
