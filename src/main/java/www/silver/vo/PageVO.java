package www.silver.vo;

public class PageVO {
	private int page; // 현재 페이지
	private int maxPage; // 전체 필요한 페이지 수
	private int startPage; // 현재 페이지 블록의 시작 페이지 값
	private int endPage; // 현재 페이지 블록의 마지막 페이지 값
	private int totalCount; // 총 게시글 수
	private int pageSize; // 페이지당 게시글 수

	// getter/setter 추가
	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

}
