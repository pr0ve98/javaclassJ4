package blog;

public class BlogVO {
	private int blogIdx;
	private String blogMid;
	private String blogTitle;
	private String blogIntro;
	private int totalVisit;
	private int todayVisit;
	
	private String userImg;
	private String nickName;

	public int getBlogIdx() {
		return blogIdx;
	}

	public void setBlogIdx(int blogIdx) {
		this.blogIdx = blogIdx;
	}

	public String getBlogMid() {
		return blogMid;
	}

	public void setBlogMid(String blogMid) {
		this.blogMid = blogMid;
	}

	public String getBlogTitle() {
		return blogTitle;
	}

	public void setBlogTitle(String blogTitle) {
		this.blogTitle = blogTitle;
	}

	public String getBlogIntro() {
		return blogIntro;
	}

	public void setBlogIntro(String blogIntro) {
		this.blogIntro = blogIntro;
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

	public String getUserImg() {
		return userImg;
	}

	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	@Override
	public String toString() {
		return "BlogVO [blogIdx=" + blogIdx + ", blogMid=" + blogMid + ", blogTitle=" + blogTitle + ", blogIntro="
				+ blogIntro + ", totalVisit=" + totalVisit + ", todayVisit=" + todayVisit + ", userImg=" + userImg
				+ ", nickName=" + nickName + "]";
	}
	
}
