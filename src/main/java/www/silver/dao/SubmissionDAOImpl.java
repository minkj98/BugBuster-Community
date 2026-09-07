package www.silver.dao;

import org.apache.ibatis.session.SqlSession;
import www.silver.vo.SubmissionVO;

import javax.inject.Inject;

@org.springframework.stereotype.Repository
public class SubmissionDAOImpl implements SubmissionDAO {
    @Inject
    private SqlSession sqlSession;

    @Override
    public void saveSubmission(SubmissionVO submission) {
        sqlSession.insert("www.silver.dao.SubmissionDAO.saveSubmission", submission);
    }
}