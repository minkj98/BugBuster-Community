package www.silver.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import www.silver.vo.NewsVO;
import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class NewsDAOImpl implements NewsDAO {

    @Inject
    private SqlSession sqlSession;

    // 뉴스 정보를 db 저장
    @Override
    public void insertNews(NewsVO news) {
        sqlSession.insert("www.silver.dao.NewsDAO.insertNews", news);
    }

    // 2025년 IT 뉴스를 페이징 처리하여 조회
    @Override
    public List<NewsVO> select2025ItNews(int start, int pageSize) {
        Map<String, Object> param = new HashMap<>();
        param.put("start", start);       // 시작 위치
        param.put("pageSize", pageSize); // 페이지당 조회할 뉴스 개수
        return sqlSession.selectList("www.silver.dao.NewsDAO.select2025ItNews", param);
    }

    // 전체 뉴스 개수를 조회하는 메서드 (페이징 처리를 위한 총 개수 계산용)
    @Override
    public int selectTotalNewsCount() {
        return sqlSession.selectOne("www.silver.dao.NewsDAO.selectTotalNewsCount");
    }
 
}
