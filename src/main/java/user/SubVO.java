package user;

public class SubVO {
	private int sIdx;
	private int sBlogIdx;
	private String subMid;
	
	private String sBlogTitle;
	private String sBlogIntro;
	private String sNickName;
	private String blogMid;
	
	public int getsIdx() {
		return sIdx;
	}
	public void setsIdx(int sIdx) {
		this.sIdx = sIdx;
	}
	public int getsBlogIdx() {
		return sBlogIdx;
	}
	public void setsBlogIdx(int sBlogIdx) {
		this.sBlogIdx = sBlogIdx;
	}
	public String getSubMid() {
		return subMid;
	}
	public void setSubMid(String subMid) {
		this.subMid = subMid;
	}
	public String getsBlogTitle() {
		return sBlogTitle;
	}
	public void setsBlogTitle(String sBlogTitle) {
		this.sBlogTitle = sBlogTitle;
	}
	public String getsBlogIntro() {
		return sBlogIntro;
	}
	public void setsBlogIntro(String sBlogIntro) {
		this.sBlogIntro = sBlogIntro;
	}
	public String getsNickName() {
		return sNickName;
	}
	public void setsNickName(String sNickName) {
		this.sNickName = sNickName;
	}
	public String getBlogMid() {
		return blogMid;
	}
	public void setBlogMid(String blogMid) {
		this.blogMid = blogMid;
	}
	@Override
	public String toString() {
		return "SubVO [sIdx=" + sIdx + ", sBlogIdx=" + sBlogIdx + ", subMid=" + subMid + ", sBlogTitle=" + sBlogTitle
				+ ", sBlogIntro=" + sBlogIntro + ", sNickName=" + sNickName + ", blogMid=" + blogMid + "]";
	}

	
	
}
