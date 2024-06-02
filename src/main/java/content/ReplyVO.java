package content;

public class ReplyVO {
	private int rIdx;
	private int rBlogIdx;
	private int rCoIdx;
	private String rMid;
	private String rNickName;
	private String rContent;
	private String rDate;
	private String rHostIp;
	private int parentReplyIdx;
	private String rPublic;
	private String readCheck;
	
	private String rUserImg;
	private String coTitle;

	public int getrIdx() {
		return rIdx;
	}

	public void setrIdx(int rIdx) {
		this.rIdx = rIdx;
	}

	public int getrBlogIdx() {
		return rBlogIdx;
	}

	public void setrBlogIdx(int rBlogIdx) {
		this.rBlogIdx = rBlogIdx;
	}

	public int getrCoIdx() {
		return rCoIdx;
	}

	public void setrCoIdx(int rCoIdx) {
		this.rCoIdx = rCoIdx;
	}

	public String getrMid() {
		return rMid;
	}

	public void setrMid(String rMid) {
		this.rMid = rMid;
	}

	public String getrNickName() {
		return rNickName;
	}

	public void setrNickName(String rNickName) {
		this.rNickName = rNickName;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public String getrDate() {
		return rDate;
	}

	public void setrDate(String rDate) {
		this.rDate = rDate;
	}

	public String getrHostIp() {
		return rHostIp;
	}

	public void setrHostIp(String rHostIp) {
		this.rHostIp = rHostIp;
	}

	public int getParentReplyIdx() {
		return parentReplyIdx;
	}

	public void setParentReplyIdx(int parentReplyIdx) {
		this.parentReplyIdx = parentReplyIdx;
	}

	public String getrPublic() {
		return rPublic;
	}

	public void setrPublic(String rPublic) {
		this.rPublic = rPublic;
	}

	public String getReadCheck() {
		return readCheck;
	}

	public void setReadCheck(String readCheck) {
		this.readCheck = readCheck;
	}

	public String getrUserImg() {
		return rUserImg;
	}

	public void setrUserImg(String rUserImg) {
		this.rUserImg = rUserImg;
	}

	public String getCoTitle() {
		return coTitle;
	}

	public void setCoTitle(String coTitle) {
		this.coTitle = coTitle;
	}

	@Override
	public String toString() {
		return "ReplyVO [rIdx=" + rIdx + ", rBlogIdx=" + rBlogIdx + ", rCoIdx=" + rCoIdx + ", rMid=" + rMid
				+ ", rNickName=" + rNickName + ", rContent=" + rContent + ", rDate=" + rDate + ", rHostIp=" + rHostIp
				+ ", parentReplyIdx=" + parentReplyIdx + ", rPublic=" + rPublic + ", readCheck=" + readCheck
				+ ", rUserImg=" + rUserImg + ", coTitle=" + coTitle + "]";
	}

	
	
	
}
