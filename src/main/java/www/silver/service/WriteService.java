package www.silver.service;

import java.util.List;

import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;
import www.silver.vo.PageVO;

public interface WriteService {

    // �깉濡쒖슫 寃뚯떆湲��쓣 �벑濡�
    public void addWrite(BoardVO boardvo);

    // 紐⑤뱺 寃뚯떆湲� 紐⑸줉�쓣 議고쉶
    public List<BoardVO> boardAllView();

    // �럹�씠吏� 泥섎━瑜� �쐞�븳 �듅�젙 �럹�씠吏��쓽 寃뚯떆湲� 紐⑸줉�쓣 議고쉶
    public List<BoardVO> pagingList(int page);

    // �럹�씠吏� �젙蹂대�� 怨꾩궛�븯�뿬 諛섑솚
    public PageVO pagingParam(int page);

    // �듅�젙 寃뚯떆湲� 踰덊샇�뿉 �빐�떦�븯�뒗 寃뚯떆湲� �긽�꽭 �젙蹂대�� 議고쉶=
    public BoardVO textview(Long postNum);

    // �듅�젙 寃뚯떆湲��뿉 泥⑤��맂 �뙆�씪紐� 由ъ뒪�듃瑜� 議고쉶
    public List<String> getAttach(Long postNum);

    // �듅�젙 寃뚯떆湲��쓣 �궘�젣
    public void deleteWrite(Long postNum);

    // �듅�젙 寃뚯떆湲��쓽 �궡�슜�쓣 �닔�젙
    public void modifyWrite(BoardVO boardvo);

    // �듅�젙 寃뚯떆湲��쓽 議고쉶�닔瑜� 1 利앷�
    public void viewCount(Long postNum);

    // �깉濡쒖슫 �뙎湲��쓣 �벑濡�
    public void addCommentWrite(CommentVO commentvo);

    // �듅�젙 寃뚯떆湲��뿉 �떖由� 紐⑤뱺 �뙎湲� 紐⑸줉�쓣 議고쉶
    public List<CommentVO> getComments(Long postNum);

    // �듅�젙 �뙎湲��쓣 �궘�젣
    public boolean deleteComment(int commentId, String userId);

    // �듅�젙 �뙎湲��쓽 �궡�슜�쓣 �닔�젙
    public boolean updateComment(int commentId, String content, Long postNum);

    // ���뙎湲�(�뙎湲��쓽 �떟湲�)�쓣 異붽�
    public void addCommentReply(CommentVO commentVO);

    // �듅�젙 ���뙎湲��쓽 �궡�슜�쓣 �닔�젙
    public boolean updateReply(int commentId, String content, Long postNum);

    // �듅�젙 �쉶�썝�쓽 �쟾泥� 寃뚯떆湲� 議고쉶�닔 �빀怨꾨�� 諛섑솚
    public int viewtotal(String id);

    // �듅�젙 �쉶�썝�씠 諛쏆� �쟾泥� 醫뗭븘�슂 �닔瑜� 諛섑솚
    public int likestotal(String id);

    // �듅�젙 �쉶�썝�씠 醫뗭븘�슂瑜� �늻瑜� 寃뚯떆湲� 紐⑸줉�쓣 議고쉶
    public List<BoardVO> likeboard(String id, int page);

    // �듅�젙 �쉶�썝�씠 �늻瑜� 醫뗭븘�슂�쓽 珥� 媛쒖닔瑜� 諛섑솚
    public int clicklikes(String id);

    // �쉶�썝 �깉�눜�떆  �쉶�썝�쓽 紐⑤뱺 寃뚯떆湲�/�뙎湲�/�젙蹂대�� �궘�젣
    public void deletemember(String userId);

	public int getTotalCount();
}
