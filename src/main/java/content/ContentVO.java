package content;

public class ContentVO {
	private int coIdx;
	private int coBlogIdx;
	private int categoryIdx;
	private String title;
	private String part;
	private String wDate;
	private int viewCnt;
	private String content;
	private String ctPreview;
	private String cHostIp;
	private String coPublic;
	private String imgName;
	
	private String categoryName;
	private int hour_diff;
	private int min_diff;
	private int replyCnt;
	private String nickName;
	private String userImg;
	private String userMid;
	
	public int getCoIdx() {
		return coIdx;
	}
	public void setCoIdx(int coIdx) {
		this.coIdx = coIdx;
	}
	public int getCoBlogIdx() {
		return coBlogIdx;
	}
	public void setCoBlogIdx(int coBlogIdx) {
		this.coBlogIdx = coBlogIdx;
	}
	public int getCategoryIdx() {
		return categoryIdx;
	}
	public void setCategoryIdx(int categoryIdx) {
		this.categoryIdx = categoryIdx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPart() {
		return part;
	}
	public void setPart(String part) {
		this.part = part;
	}
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCtPreview() {
		return ctPreview;
	}
	public void setCtPreview(String ctPreview) {
		this.ctPreview = ctPreview;
	}
	public String getcHostIp() {
		return cHostIp;
	}
	public void setcHostIp(String cHostIp) {
		this.cHostIp = cHostIp;
	}
	public String getCoPublic() {
		return coPublic;
	}
	public void setCoPublic(String coPublic) {
		this.coPublic = coPublic;
	}
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public int getHour_diff() {
		return hour_diff;
	}
	public void setHour_diff(int hour_diff) {
		this.hour_diff = hour_diff;
	}
	public int getMin_diff() {
		return min_diff;
	}
	public void setMin_diff(int min_diff) {
		this.min_diff = min_diff;
	}
	public int getReplyCnt() {
		return replyCnt;
	}
	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getUserImg() {
		return userImg;
	}
	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}
	public String getUserMid() {
		return userMid;
	}
	public void setUserMid(String userMid) {
		this.userMid = userMid;
	}
	@Override
	public String toString() {
		return "ContentVO [coIdx=" + coIdx + ", coBlogIdx=" + coBlogIdx + ", categoryIdx=" + categoryIdx + ", title="
				+ title + ", part=" + part + ", wDate=" + wDate + ", viewCnt=" + viewCnt + ", content=" + content
				+ ", ctPreview=" + ctPreview + ", cHostIp=" + cHostIp + ", coPublic=" + coPublic + ", imgName="
				+ imgName + ", categoryName=" + categoryName + ", hour_diff=" + hour_diff + ", min_diff=" + min_diff
				+ ", replyCnt=" + replyCnt + ", nickName=" + nickName + ", userImg=" + userImg + ", userMid=" + userMid
				+ "]";
	}

	

}
