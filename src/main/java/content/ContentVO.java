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
	@Override
	public String toString() {
		return "ContentVO [coIdx=" + coIdx + ", coBlogIdx=" + coBlogIdx + ", categoryIdx=" + categoryIdx + ", title="
				+ title + ", part=" + part + ", wDate=" + wDate + ", viewCnt=" + viewCnt + ", content=" + content
				+ ", ctPreview=" + ctPreview + ", cHostIp=" + cHostIp + ", coPublic=" + coPublic + ", imgName="
				+ imgName + ", categoryName=" + categoryName + "]";
	}

}
