package www.silver.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import www.silver.vo.NewsVO;
import javax.inject.Inject;
import java.util.List;
import java.util.Map;

@Repository
public class NewsSearchDAOImpl implements NewsSearchDAO {

	@Inject
	SqlSession sqlSession;

	// 뉴스 제목을 기준으로 검색어에 해당하는 뉴스 목록을 페이징하여 조회
	@Override
	public List<NewsVO> searchByTitle(Map<String, Object> params) {
		return sqlSession.selectList("www.silver.dao.NewsSearchDAO.searchByTitle", params);
	}

	// 뉴스 카테고리를 기준으로 검색어에 해당하는 뉴스 목록을 페이징하여 조회
	@Override
	public List<NewsVO> searchByCategory(Map<String, Object> params) {
		return sqlSession.selectList("www.silver.dao.NewsSearchDAO.searchByCategory", params);
	}

	// 특정 키워드가 포함된 뉴스 제목의 전체 개수를 조회
	@Override
	public int countByTitle(String keyword) {
		return sqlSession.selectOne("www.silver.dao.NewsSearchDAO.countByTitle", keyword);
	}

	// 특정 키워드가 포함된 뉴스 카테고리의 전체 개수를 조회
	@Override
	public int countByCategory(String keyword) {
		return sqlSession.selectOne("www.silver.dao.NewsSearchDAO.countByCategory", keyword);
	}
}
