package blog;

public class BlogVO {
	private int idx;
	private String mid;
	private String blogTitle;
	private int totalVisit;
	private int todayVisit;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getBlogTitle() {
		return blogTitle;
	}
	public void setBlogTitle(String blogTitle) {
		this.blogTitle = blogTitle;
	}
	public int getTotalVisit() {
		return totalVisit;
	}
	public void setTotalVisit(int totalVisit) {
		this.totalVisit = totalVisit;
	}
	public int getTodayVisit() {
		return todayVisit;
	}
	public void setTodayVisit(int todayVisit) {
		this.todayVisit = todayVisit;
	}
	@Override
	public String toString() {
		return "BlogVO [idx=" + idx + ", mid=" + mid + ", blogTitle=" + blogTitle + ", totalVisit=" + totalVisit
				+ ", todayVisit=" + todayVisit + "]";
	}
}
