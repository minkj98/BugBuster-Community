package www.silver.dao;

import www.silver.vo.NewsVO;
import java.util.List;

public interface NewsDAO {

	// 뉴스 데이터를 DB에 저장
	public void insertNews(NewsVO news);

	// 2025년 IT 뉴스 목록을 페이징하여 조회
	// start 조회 시작 인덱스 (0부터 시작)
	// pageSize 한 페이지에 조회할 뉴스 개수
	public List<NewsVO> select2025ItNews(int start, int pageSize);

	// 전체 뉴스 데이터의 개수를 조회
	public int selectTotalNewsCount();
	

}
