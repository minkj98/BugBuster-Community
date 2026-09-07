package www.silver.dao;

import www.silver.vo.NewsVO;
import java.util.List;
import java.util.Map;

public interface NewsSearchDAO {

	// 뉴스 제목을 기준으로 검색어에 해당하는 뉴스 목록을 페이징하여 조회
	List<NewsVO> searchByTitle(Map<String, Object> params);

	// 뉴스 카테고리를 기준으로 검색어에 해당하는 뉴스 목록을 페이징하여 조회
	List<NewsVO> searchByCategory(Map<String, Object> params);

	// 특정 키워드가 포함된 뉴스 제목의 전체 개수를 조회
	int countByTitle(String keyword);

	// 특정 키워드가 포함된 뉴스 카테고리의 전체 개수를 조회
	int countByCategory(String keyword);
}
