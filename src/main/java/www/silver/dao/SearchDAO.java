package www.silver.dao;

import www.silver.vo.BoardVO;
import java.util.List;
import java.util.Map;

public interface SearchDAO {

	// 게시글 작성자(writer) 기준으로 검색어에 해당하는 게시글 목록을 페이징하여 조회
	List<BoardVO> searchByWriter(Map<String, Object> params);

	// 게시글의 프로그래밍 언어 기준으로 검색어에 해당하는 게시글 목록을 페이징하여 조회
	List<BoardVO> searchByProgrammingLanguage(Map<String, Object> params);

	// 특정 키워드가 포함된 작성자의 게시글 전체 개수를 조회
	int countByWriter(String keyword);

	// 특정 키워드가 포함된 기술스택의 게시글 전체 개수를 조회
	int countByProgrammingLanguage(String keyword);
}
