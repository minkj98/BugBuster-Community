package www.silver.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import www.silver.vo.BoardVO;
import javax.inject.Inject;
import java.util.List;
import java.util.Map;

@Repository
public class SearchDAOImpl implements SearchDAO {

    @Inject
    SqlSession sqlSession;

    // 검색 타입이 작성자일 때
    @Override
    public List<BoardVO> searchByWriter(Map<String, Object> params) {
        return sqlSession.selectList("www.silver.dao.SearchDAO.searchByWriter", params);
    }

    // 검색 타입이 기술스택일 때
    @Override
    public List<BoardVO> searchByProgrammingLanguage(Map<String, Object> params) {
        return sqlSession.selectList("www.silver.dao.SearchDAO.searchByProgrammingLanguage", params);
    }

    // 작성자를 기준으로 검색했을 때 검색되는 게시글 수를 반환
    @Override
    public int countByWriter(String keyword) {
        return sqlSession.selectOne("www.silver.dao.SearchDAO.countByWriter", keyword);
    }

    // 기술 스택을 기준으로 검색했을 때 검색되는 게시글 수를 반환
    @Override
    public int countByProgrammingLanguage(String keyword) {
        return sqlSession.selectOne("www.silver.dao.SearchDAO.countByProgrammingLanguage", keyword);
    }

}
