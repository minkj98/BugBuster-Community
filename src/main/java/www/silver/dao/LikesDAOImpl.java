package www.silver.dao;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import www.silver.vo.LikeVO;

@Repository // Spring에서 이 클래스를 데이터 접근 계층(DAO) 컴포넌트로 인식
public class LikesDAOImpl implements LikesDAO {

    @Inject // Spring의 의존성 주입을 통해 SqlSession 객체를 자동으로 주입
    private SqlSession sqlSession;

    // 게시글 좋아요 추가
    @Override
    public void postLike(LikeVO likevo) {
        // MyBatis의 insert 메서드를 호출하여 데이터베이스에 좋아요 정보를 저장
        sqlSession.insert("www.silver.dao.LikesDAO.postLike", likevo);
    }

    // 게시글 좋아요 상태 확인 (사용자가 해당 게시글에 좋아요를 눌렀는지)
    @Override
    public int getMyLikeCount(LikeVO likevo) {
        // MyBatis의 selectOne 메서드를 호출하여 특정 사용자의 좋아요 상태를 카운트로 반환
        return sqlSession.selectOne("www.silver.dao.LikesDAO.getMyLikeCount", likevo);
    }

    // 게시글 좋아요 삭제
    @Override
    public void deleteLike(LikeVO likevo) {
        // MyBatis의 delete 메서드를 호출하여 데이터베이스에서 좋아요 정보를 삭제
        sqlSession.delete("www.silver.dao.LikesDAO.deleteLike", likevo);
    }

    // 게시글 좋아요 총 개수 조회
    @Override
    public int getTotalLikeCount(int postNum) {
        // MyBatis의 selectOne 메서드를 호출하여 특정 게시글의 총 좋아요 개수 반환
        return sqlSession.selectOne("www.silver.dao.LikesDAO.getTotalLikeCount", postNum);
    }
}
