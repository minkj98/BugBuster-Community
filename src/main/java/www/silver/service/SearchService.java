package www.silver.service;

import www.silver.vo.BoardVO;
import www.silver.vo.PageVO;
import java.util.List;

public interface SearchService {

	// 키워드와 타입에 해당하는 전체 게시글 검색 결과 개수를 조회
	public int getSearchTotalCount(String keyword, String type);

	// 검색 조건(키워드, 작성자, 페이지 번호)에 따른 페이징 정보를 계산하여 반환
	PageVO searchPagingParam(String keyword, String writer, int page);

	// 키워드, 타입, 페이지 번호에 따라 게시글 목록을 검색
	List<BoardVO> searchContent(String keyword, String type, int page);
}
