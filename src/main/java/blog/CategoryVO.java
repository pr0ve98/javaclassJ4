package blog;

public class CategoryVO {
	private int caIdx;
	private int caBlogIdx;
	private String category;
	private int parentCategoryIdx;
	private String publicSetting;
	
	public int getCaIdx() {
		return caIdx;
	}
	public void setCaIdx(int caIdx) {
		this.caIdx = caIdx;
	}
	public int getCaBlogIdx() {
		return caBlogIdx;
	}
	public void setCaBlogIdx(int caBlogIdx) {
		this.caBlogIdx = caBlogIdx;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getParentCategoryIdx() {
		return parentCategoryIdx;
	}
	public void setParentCategoryIdx(int parentCategoryIdx) {
		this.parentCategoryIdx = parentCategoryIdx;
	}
	public String getPublicSetting() {
		return publicSetting;
	}
	public void setPublicSetting(String publicSetting) {
		this.publicSetting = publicSetting;
	}
	@Override
	public String toString() {
		return "CategoryVO [caIdx=" + caIdx + ", caBlogIdx=" + caBlogIdx + ", category=" + category
				+ ", parentCategoryIdx=" + parentCategoryIdx + ", publicSetting=" + publicSetting + "]";
	}
	
}
