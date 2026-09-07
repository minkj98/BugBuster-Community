package www.silver.dao;

import java.util.List;
import java.util.Map;
import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;

public interface WriteDAO {

	// �깉濡쒖슫 寃뚯떆湲��쓣 ���옣
	public void insertWrite(BoardVO boardvo);

	// 寃뚯떆湲��뿉 泥⑤��맂 �뙆�씪紐� ���옣
	public void attachFname(Map<String, Object> params);

	// 紐⑤뱺 寃뚯떆湲� 紐⑸줉�쓣 議고쉶
	public List<BoardVO> selectall();

	// �럹�씠吏� 泥섎━瑜� �쐞�븳 �듅�젙 踰붿쐞�쓽 寃뚯떆湲� 紐⑸줉�쓣 議고쉶
	public List<BoardVO> pagingList(Map<String, Integer> pagingParams);

	// �쟾泥� 寃뚯떆湲��쓽 媛쒖닔瑜� 諛섑솚�빀�땲�떎. (�럹�씠吏뺤뿉 �궗�슜)
	public int boardCount();

	// �듅�젙 寃뚯떆湲� 踰덊샇�뿉 �빐�떦�븯�뒗 寃뚯떆湲� �긽�꽭 �젙蹂대�� 議고쉶
	public BoardVO selectOne(Long postNum);

	// �듅�젙 寃뚯떆湲��뿉 泥⑤��맂 �뙆�씪紐� 由ъ뒪�듃瑜� 議고쉶
	public List<String> getAttach(Long postNum);

	// �듅�젙 寃뚯떆湲��쓣 �궘�젣
	public void deleteWrite(Long postNum);

	// �듅�젙 寃뚯떆湲��쓽 �궡�슜�쓣 �닔�젙
	public void modifyWrite(BoardVO boardVO);

	// �듅�젙 寃뚯떆湲��뿉 泥⑤��맂 �뙆�씪 �젙蹂대�� �궘�젣
	public void deleteAttach(Long postNum);

	// �듅�젙 寃뚯떆湲��쓽 議고쉶�닔瑜� 1 利앷�
	public void viewCount(Long postNum);

	// �깉濡쒖슫 �뙎湲� ���옣
	public void insertCommentWrite(CommentVO commentvo);

	// �듅�젙 寃뚯떆湲��뿉 �떖由� 紐⑤뱺 �뙎湲� 紐⑸줉�쓣 議고쉶
	public List<CommentVO> selectAllComment(Long postNum);

	// �듅�젙 �뙎湲��쓣 �궘�젣 (�옉�꽦�옄 �솗�씤 �썑 �궘�젣)
	public boolean deleteComment(int commentId, String userId);

	// �듅�젙 �뙎湲��쓽 �궡�슜�쓣 �닔�젙
	public boolean updateComment(int commentId, String content, Long postNum);

	// �듅�젙 �뙎湲� ID�뿉 �빐�떦�븯�뒗 �뙎湲� �젙蹂대�� 議고쉶�빀�땲�떎.
	public CommentVO getCommentById(int parentCommentId);

	// ���뙎湲� ���옣
	public void addCommentReply(CommentVO commentvo);

	// �듅�젙 ���뙎湲��쓽 �궡�슜�쓣 �닔�젙
	public boolean updateReplyComment(int commentId, String content, Long postNum);

	// �듅�젙 �쉶�썝�쓽 �쟾泥� 寃뚯떆湲� 議고쉶�닔 �빀怨꾨�� 諛섑솚
	public int viewtotal(String id);

	// �듅�젙 �쉶�썝�씠 諛쏆� �쟾泥� 醫뗭븘�슂 �닔瑜� 諛섑솚
	public int likestotal(String id);

	// �듅�젙 �쉶�썝�씠 醫뗭븘�슂瑜� �늻瑜� 寃뚯떆湲� 紐⑸줉�쓣 議고쉶
	public List<BoardVO> likeboard(Map<String, Object> params);

	// �듅�젙 �쉶�썝�씠 �늻瑜� 醫뗭븘�슂�쓽 珥� 媛쒖닔瑜� 諛섑솚
	public int clicklikes(String id);

	// �듅�젙 �쉶�썝�쓽 紐⑤뱺 寃뚯떆湲�/�뙎湲�/�젙蹂대�� �궘�젣�빀�땲�떎.
	public void deletemember(String userId);

// 전체 게시글 조회
	public int getTotalCount();
}
