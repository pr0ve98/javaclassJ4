package content;

public class ContentVO {
	private int coIdx;
	private int coBlogIdx;
	private int categoryIdx;
	private String part;
	private String wDate;
	private int viewCnt;
	private String content;
	private String ctPreview;
	private String cHostIp;
	
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
	@Override
	public String toString() {
		return "ContentVO [coIdx=" + coIdx + ", coBlogIdx=" + coBlogIdx + ", categoryIdx=" + categoryIdx + ", part="
				+ part + ", wDate=" + wDate + ", viewCnt=" + viewCnt + ", content=" + content + ", ctPreview="
				+ ctPreview + ", cHostIp=" + cHostIp + "]";
	}
	
}
