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
@WebServlet("/blog/*")
public class BlogServlet extends HttpServlet {
	private final Map<String, Map<String, LocalDateTime>> visitMap = new ConcurrentHashMap<>(); // 블로그별 방문자 IP와 마지막 방문 시간 저장하는 맵
	private final Map<String, Integer> todayVisit = new ConcurrentHashMap<>(); // 블로그별 오늘 방문자수 저장하는 맵
	
	// 서블릿 최초 실행 시 스케줄러(자정이 지날 때 일일방문자 초기화) 추가하기
	// init 메소드를 사용한 이유는 서버가 실행될 때 최초에 한번만 실행하기 위해서이다 불필요한 반복을 막는 용도
	@Override
	public void init() throws ServletException {
		super.init();
		scheduleTodayReset();
	}
	
	// 자정 오늘 방문자 초기화 메소드
	private void scheduleTodayReset() {
		ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime midNight = now.toLocalDate().atStartOfDay().plusDays(1);
		long delay = ChronoUnit.SECONDS.between(now, midNight);
		
		// todayVisit을 delay(자정이 되기 전까지 남은 초)만큼 기다렸다가 매일 1번 초기화 실행
		scheduler.scheduleAtFixedRate(() -> todayVisit.clear(), delay, TimeUnit.DAYS.toSeconds(1), TimeUnit.SECONDS);
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BlogDAO bDao = new BlogDAO();
		UserDAO uDao = new UserDAO();
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
        visitMap.putIfAbsent(mid, new ConcurrentHashMap<>());
        Map<String, LocalDateTime> userVisitMap = visitMap.get(mid);
        
        todayVisit.putIfAbsent(mid, 0);
        
        userVisitMap.compute(hostIp, (key, lastVisit) -> {
        	// 오늘 방문이 없거나, 방문한지 30분이 지났거나, 블로그주인이 방문한 게 아니면 방문수 증가
        	if((lastVisit == null || ChronoUnit.MINUTES.between(lastVisit, now) >= 30) && !mid.equals(sMid)) {
        		todayVisit.put(mid, todayVisit.get(mid) + 1);
        		bDao.setTotalVisit(mid);
        		return now;
        	}
        	else {
        		// 30분 내 재방문 경우 마지막 방문시간 유지
        		return lastVisit;
        	}
        });
        
        request.setAttribute("todayVisit", todayVisit.get(mid));
        
        BlogVO bVo = bDao.getUserBlog(mid);
        UserVO uVo = uDao.getUserIdCheck(mid);
        ArrayList<CategoryVO> cPVos = bDao.getCategory(bVo.getBlogIdx(), 1); // 부모 카테고리만 가져오기
        ArrayList<CategoryVO> cCVos = bDao.getCategory(bVo.getBlogIdx(), 2); // 자식 카테고리만 가져오기     
        
        // 유저가 없으면 메인페이지로 이동
        if(bVo.getBlogMid() == null || uVo.getMid() == null) {
            dispatcher = request.getRequestDispatcher("/");
            dispatcher.forward(request, response);
            return;
        }
        
        request.setAttribute("bVo", bVo);
        request.setAttribute("uVo", uVo);
        request.setAttribute("cPVos", cPVos);
        request.setAttribute("cCVos", cCVos);
        
        String viewPage = "/WEB-INF/blog/blog.jsp";
        dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
	}
}