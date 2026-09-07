package www.silver.dao;

import org.apache.ibatis.session.SqlSession;
import www.silver.vo.ProblemVO;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;

@org.springframework.stereotype.Repository
public class ProblemDAOImpl implements ProblemDAO {
    @Inject
    private SqlSession sqlSession;

    @Override
    public List<ProblemVO> getAllProblems() {
        return sqlSession.selectList("www.silver.dao.ProblemDAO.getAllProblems");
    }

    @Override
    public List<ProblemVO> getProblemsByLanguageAndDifficulty(Map<String, String> params) {
        return sqlSession.selectList("www.silver.dao.ProblemDAO.getProblemsByLanguageAndDifficulty", params);
    }

    @Override
    public ProblemVO getProblemById(int problemId) {
        return sqlSession.selectOne("www.silver.dao.ProblemDAO.getProblemById", problemId);
    }
}