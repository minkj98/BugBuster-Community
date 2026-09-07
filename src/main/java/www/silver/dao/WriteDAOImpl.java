package www.silver.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;

@Repository
public class WriteDAOImpl implements WriteDAO {

	@Inject
	SqlSession sqlSession;

	// 새로운 게시글 저장
	@Override
	public void insertWrite(BoardVO boardvo) {
		sqlSession.insert("www.silver.dao.WriteDAO.insertone", boardvo);
	}

	// 게시글에 첨부된 파일명 저장
	@Override
	public void attachFname(Map<String, Object> params) {
		sqlSession.insert("www.silver.dao.WriteDAO.board_attach", params);
	}

	// 모든 게시글 목록을 조회
	@Override
	public List<BoardVO> selectall() {
		List<BoardVO> clist = sqlSession.selectList("www.silver.dao.WriteDAO.selectall");
		return clist;
	}

	// 페이징 처리를 위한 특정 범위의 게시글 목록을 조회
	@Override
	public List<BoardVO> pagingList(Map<String, Integer> pagingParams) {
		return sqlSession.selectList("www.silver.dao.WriteDAO.pagingList", pagingParams);
	}

	// 전체 게시글의 개수를 반환
	@Override
	public int boardCount() {
		int count = sqlSession.selectOne("www.silver.dao.WriteDAO.boardCount");
		System.out.println("DAO: 게시글 수 = " + count); // 게시글 수 로그 출력
		return count;
	}

	//특정 게시글 번호에 해당하는 게시글 상세 정보를 조회
	@Override
	public BoardVO selectOne(Long postNum) {
		BoardVO boardvo = sqlSession.selectOne("www.silver.dao.WriteDAO.selectOne", postNum);
		return boardvo;
	}

	// 특정 게시글에 첨부된 파일명 리스트를 조회
	@Override
	public List<String> getAttach(Long postNum) {
		return sqlSession.selectList("www.silver.dao.WriteDAO.getAttach", postNum);
	}

	//특정 게시글을 삭제
	@Override
	public void deleteWrite(Long postNum) {
		sqlSession.delete("www.silver.dao.WriteDAO.deleteone", postNum);
	}

	// 특정 게시글의 내용을 수정
	@Override
	public void modifyWrite(BoardVO boardvo) {
		sqlSession.update("www.silver.dao.WriteDAO.modifyone", boardvo);
	}

	// 특정 게시글에 첨부된 파일 정보를 삭제
	@Override
	public void deleteAttach(Long postNum) {
		sqlSession.delete("www.silver.dao.WriteDAO.deleteAttach", postNum);
	}

	// 특정 게시글의 조회수를 1 증가
	@Override
	public void viewCount(Long postNum) {
		sqlSession.update("www.silver.dao.WriteDAO.viewCount", postNum);
	}

	// 새로운 댓글 저장
	@Override
	public void insertCommentWrite(CommentVO commentvo) {
		sqlSession.insert("www.silver.dao.WriteDAO.insertComment", commentvo);
	}

	// 특정 게시글에 달린 모든 댓글 목록을 조회
	@Override
	public List<CommentVO> selectAllComment(Long postNum) {
		List<CommentVO> commentlist = sqlSession.selectList("www.silver.dao.WriteDAO.selectAllComment", postNum);
		return commentlist;
	}

	// 특정 댓글을 삭제
	@Override
	public boolean deleteComment(int commentId, String userId) {
		Map<String, Object> params = new HashMap<>();
		params.put("commentId", commentId);
		params.put("userId", userId);
		int deletedRows = sqlSession.delete("www.silver.dao.WriteDAO.deleteComment", params);
		return deletedRows > 0;
	}

	// 특정 댓글의 내용을 수정
	@Override
	public boolean updateComment(int commentId, String content, Long postNum) {
		Map<String, Object> params = new HashMap<>();
		params.put("commentId", commentId);
		params.put("content", content);
		params.put("postNum", postNum);
		int updatedRows = sqlSession.update("www.silver.dao.WriteDAO.updateComment", params);
		return updatedRows > 0;
	}

	// 특정 댓글 ID에 해당하는 댓글 정보를 조회
	@Override
	public CommentVO getCommentById(int parentCommentId) {
		return sqlSession.selectOne("www.silver.dao.WriteDAO.getCommentById", parentCommentId);
	}

	// 대댓글 저장
	@Override
	public void addCommentReply(CommentVO commentvo) {
		sqlSession.insert("www.silver.dao.WriteDAO.addCommentReply", commentvo);
	}

	// 특정 대댓글의 내용을 수정
	@Override
	public boolean updateReplyComment(int commentId, String content, Long postNum) {
		Map<String, Object> params = new HashMap<>();
		params.put("commentId", commentId);
		params.put("content", content);
		params.put("postNum", postNum);
		int updatedReplyComment = sqlSession.update("www.silver.dao.WriteDAO.updateReplyComment", params);
		return updatedReplyComment > 0;
	}

	// 특정 회원의 전체 게시글 조회수 합계를 반환
	@Override
	public int viewtotal(String id) {
		int totalViews = sqlSession.selectOne("www.silver.dao.WriteDAO.getTotalViewsByUserId", id);
		System.out.println("DAO: 사용자 " + id + "의 총 조회수: " + totalViews);
		return totalViews;
	}

	// 특정 회원이 받은 전체 좋아요 수를 반환
	@Override
	public int likestotal(String id) {
		int totallikes = sqlSession.selectOne("www.silver.dao.WriteDAO.gettotallikes", id);
		return totallikes;
	}

	// 특정 회원이 좋아요를 누른 게시글 목록을 조회
	@Override
	public List<BoardVO> likeboard(Map<String, Object> params) {
		List<BoardVO> clist = sqlSession.selectList("www.silver.dao.WriteDAO.likeboard", params);
		return clist;
	}

	// 특정 회원이 누른 좋아요의 총 개수를 반환
	@Override
	public int clicklikes(String id) {
		return sqlSession.selectOne("www.silver.dao.WriteDAO.clicktotallikes", id);
	}

	// 회원 탈퇴시 특정 회원의 모든 게시글/댓글/정보를 삭제
	@Override
	public void deletemember(String userId) {
		sqlSession.delete("www.silver.dao.WriteDAO.deletemember", userId);
	}

	// 전체 게시글 수 조회
	@Override
	public int getTotalCount() {
		return sqlSession.selectOne("www.silver.dao.WriteDAO.getTotalCount");
	}

}
