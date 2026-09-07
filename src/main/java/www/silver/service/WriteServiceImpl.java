package www.silver.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;
import www.silver.vo.PageVO;
import www.silver.dao.WriteDAO;

@Service
public class WriteServiceImpl implements WriteService {

	@Inject
    WriteDAO writedao;

	int pageLimit = 10; // 한 페이지당 보여줄 게시글 개수
	int blockLimit = 5; // 하단에 보여줄 페이지 번호 개수

	// 게시글 작성 및 첨부파일 저장
	// 게시글 저장 후, 첨부파일이 있으면 각 파일명을 DB에 저장
	@Override
	public void addWrite(BoardVO boardvo) {
		// 게시글 정보 저장 (postNum이 자동 생성되어 boardvo에 설정됨)
		writedao.insertWrite(boardvo);
		// 게시글 저장 후 첨부파일 정보 저장 - postNum 값을 이용해서 파일명 저장
		Long postNum = boardvo.getPostNum();
		List<String> fname = boardvo.getFilename();
		for (String filename : fname) {
			Map<String, Object> params = new HashMap<>();
			params.put("postNum", postNum);
			params.put("filename", filename);
			writedao.attachFname(params);
		}
	}

	// 모든 게시글 목록을 조회
	@Override
	public List<BoardVO> boardAllView() {
		List<BoardVO> clist = writedao.selectall();
		return clist;
	}

	// 페이징 처리된 게시글 목록을 조회
	@Override
	public List<BoardVO> pagingList(int page) {
		if (page < 1) {
			page = 1;
		}
		int pagingStart = (page - 1) * pageLimit;
		Map<String, Integer> pagingParams = new HashMap<>();
		pagingParams.put("start", pagingStart);
		pagingParams.put("limit", pageLimit);
		List<BoardVO> pagingList = writedao.pagingList(pagingParams);
		System.out.println("Paging list retrieved: " + pagingList.size() + " items for page " + page);
		return pagingList;
	}

	// 페이징 정보를 계산하여 반환
	@Override
	public PageVO pagingParam(int page) {
		int boardCount = writedao.boardCount();
		System.out.println("Total board count: " + boardCount);

		int maxPage = (int) Math.ceil((double) boardCount / pageLimit);
		if (maxPage < 1)
			maxPage = 1;

		// 현재 페이지 범위 체크
		if (page < 1)
			page = 1;
		if (page > maxPage)
			page = maxPage;

		// 하단 페이지 번호 범위 계산
		int startPage = ((page - 1) / blockLimit) * blockLimit + 1;
		int endPage = startPage + blockLimit - 1;
		if (endPage > maxPage)
			endPage = maxPage;

		PageVO pagevo = new PageVO();
		pagevo.setPage(page);
		pagevo.setMaxPage(maxPage);
		pagevo.setStartPage(startPage);
		pagevo.setEndPage(endPage);

		System.out.println("== 페이징 정보 확인 ==");
		System.out.println("page = " + page);
		System.out.println("startPage = " + startPage);
		System.out.println("endPage = " + endPage);
		System.out.println("maxPage = " + maxPage);

		return pagevo;
	}

	// 특정 게시글 상세 정보를 조회
	@Override
	public BoardVO textview(Long postNum) {
		BoardVO boardvo = writedao.selectOne(postNum);
		System.out.println("게시글 상세조회, 글번호 " + postNum + "번을 조회했습니다.");
		return boardvo;
	}

	// 특정 게시글에 첨부된 파일명 리스트를 조회
	@Override
	public List<String> getAttach(Long postNum) {
		return writedao.getAttach(postNum);
	}

	// 특정 게시글을 삭제
	@Override
	public void deleteWrite(Long postNum) {
		writedao.deleteWrite(postNum);
	}

	// 특정 게시글의 내용을 수정합니다. - 게시글 정보 수정 후, 기존 첨부파일 삭제 및 새로운 첨부파일 등록
	@Override
	public void modifyWrite(BoardVO boardvo) {
		System.out.println("modify POST 호출됨");
		// 1) 게시글 수정
		writedao.modifyWrite(boardvo);

		// 2) 수정 작업시 기존 첨부파일 삭제
		writedao.deleteAttach(boardvo.getPostNum());

		// 3) 새로운 첨부파일 삽입
		List<String> filenames = boardvo.getFilename();
		if (filenames != null) {
			for (String filename : filenames) {
				Map<String, Object> params = new HashMap<>();
				params.put("postNum", boardvo.getPostNum());
				params.put("filename", filename);
				writedao.attachFname(params);
			}
		}
	}

	// 특정 게시글의 조회수를 1 증가
	@Override
	public void viewCount(Long postNum) {
		writedao.viewCount(postNum);
	}

	// 새로운 댓글을 등록
	@Override
	public void addCommentWrite(CommentVO commentvo) {
		writedao.insertCommentWrite(commentvo);
	}

	// 특정 게시글에 달린 모든 댓글 목록을 조회
	@Override
	public List<CommentVO> getComments(Long postNum) {
		List<CommentVO> commentList = writedao.selectAllComment(postNum);
		return commentList;
	}

	// 특정 댓글을 삭제
	@Override
	public boolean deleteComment(int commentId, String userId) {
		return writedao.deleteComment(commentId, userId);
	}

	// 특정 댓글의 내용을 수정
	@Override
	public boolean updateComment(int commentId, String content, Long postNum) {
		return writedao.updateComment(commentId, content, postNum);
	}

	// 대댓글(댓글의 답글)을 추가합니다. - 부모 댓글의 depth를 참고하여 대댓글의 depth를 설정
	@Override
	public void addCommentReply(CommentVO commentvo) {
		// 부모 댓글 정보 조회
		Integer parentCommentId = commentvo.getParentCommentId();
		// 부모 댓글의 id값이 null이 아니면
		if (parentCommentId != null) {
			CommentVO parentComment = writedao.getCommentById(parentCommentId);
			if (parentComment != null) {
				// 대댓글의 depth를 부모 댓글의 depth + 1로 설정
				commentvo.setDepth(parentComment.getDepth() + 1);
				// postNum은 클라이언트에서 전달받은 값을 우선 사용하거나, 부모 댓글 값으로 보완
				if (commentvo.getPostNum() == null) {
					commentvo.setPostNum(parentComment.getPostNum());
				}
			} else {
				// 부모 댓글이 존재하지 않는 경우 (예외 상황)
				commentvo.setDepth(1);
			}
		}
		// 대댓글 저장
		writedao.addCommentReply(commentvo);
	}

	// 특정 대댓글의 내용을 수정
	@Override
	public boolean updateReply(int commentId, String content, Long postNum) {
		return writedao.updateReplyComment(commentId, content, postNum);
	}

	// 특정 회원의 전체 게시글 조회수 합계를 반환
	@Override
	public int viewtotal(String id) {
		int totalViews = writedao.viewtotal(id);
		System.out.println("서비스: 사용자 " + id + "의 총 조회수: " + totalViews);
		return totalViews;
	}

	// 특정 회원이 받은 전체 좋아요 수를 반환
	@Override
	public int likestotal(String id) {
		int totallikes = writedao.likestotal(id);
		return totallikes;
	}

	// 특정 회원이 좋아요를 누른 게시글 목록을 페이징하여 조회
	@Override
	public List<BoardVO> likeboard(String id, int page) {
		if (page < 1) {
			page = 1;
		}
		int pageLimit = 3;
		int pagingStart = (page - 1) * pageLimit;
		Map<String, Object> params = new HashMap<>();
		params.put("userId", id);
		params.put("start", pagingStart);
		params.put("limit", pageLimit);
		List<BoardVO> pagingList = writedao.likeboard(params);
		System.out.println("Paging list retrieved: " + pagingList.size() + " items for page " + page);
		return pagingList;
	}

	// 특정 회원이 누른 좋아요의 총 개수를 반환
	@Override
	public int clicklikes(String id) {
		return writedao.clicklikes(id);
	}

	// 회원 탈퇴시 모든 게시글/댓글/정보를 삭제
	@Override
	public void deletemember(String userId) {
		writedao.deletemember(userId);
	}

	@Override
	public int getTotalCount() {
		return writedao.getTotalCount();
	}
}
