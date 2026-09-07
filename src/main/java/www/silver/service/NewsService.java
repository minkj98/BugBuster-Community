package www.silver.service;

import www.silver.vo.NewsVO;
import java.util.List;

public interface NewsService {

	// 외부 IT 뉴스 API를 호출하여 최신 뉴스를 수집하고, DB에 저장
	public void fetchAndSaveNews();

	// 2025년에 발행된 IT 뉴스 목록을 페이지 단위로 조회
	public List<NewsVO> get2025ItNews(int page, int pageSize);

	// 전체 IT 뉴스 데이터의 개수를 조회
	public int getTotalNewsCount();
}
