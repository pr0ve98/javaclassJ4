package common;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import blog.BlogDAO;

public class VisitManager {
	private final Map<String, Map<String, LocalDateTime>> visitMap = new ConcurrentHashMap<>();
    private final Map<String, Integer> todayVisit = new ConcurrentHashMap<>();

    public VisitManager() {
        scheduleTodayReset();
    }

    private void scheduleTodayReset() {
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime midNight = now.toLocalDate().atStartOfDay().plusDays(1);
        long delay = ChronoUnit.SECONDS.between(now, midNight);
        
        scheduler.scheduleAtFixedRate(() -> todayVisit.clear(), delay, TimeUnit.DAYS.toSeconds(1), TimeUnit.SECONDS);
    }

    public synchronized void recordVisit(String mid, String hostIp, String sMid) {
        LocalDateTime now = LocalDateTime.now();

        visitMap.putIfAbsent(mid, new ConcurrentHashMap<>());
        Map<String, LocalDateTime> userVisitMap = visitMap.get(mid);
        
        todayVisit.putIfAbsent(mid, 0);

        userVisitMap.compute(hostIp, (key, lastVisit) -> {
            if ((lastVisit == null || ChronoUnit.MINUTES.between(lastVisit, now) >= 30) && !mid.equals(sMid)) {
                todayVisit.put(mid, todayVisit.get(mid) + 1);
                BlogDAO bDao = new BlogDAO();
                bDao.setTotalVisit(mid);
                return now;
            } else {
                return lastVisit;
            }
        });
    }

    public int getTodayVisit(String mid) {
        return todayVisit.getOrDefault(mid, 0);
    }
}
