package www.silver.service;

import www.silver.vo.NewsVO;
import www.silver.vo.PageVO;
import java.util.List;

public interface NewsSearchService {

	// 키워드와 타입(제목/카테고리 등), 페이지 번호를 이용해 뉴스 목록을 검색
	List<NewsVO> searchNews(String keyword, String type, int page);

	// 키워드, 타입, 페이지 번호에 따른 페이징 정보를 계산하여 반환
	PageVO searchPagingParam(String keyword, String type, int page);

	// 키워드와 타입에 해당하는 전체 검색 결과 개수를 조회
	int getSearchTotalCount(String keyword, String type);
}
