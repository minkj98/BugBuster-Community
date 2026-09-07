package www.silver.service;

import www.silver.vo.LikeVO;

public interface LikesService {

	// 게시글에 대한 좋아요 상태를 토글(추가 또는 취소).
	// 이미 좋아요를 누른 경우 취소, 누르지 않은 경우 추가
	boolean toggleLike(LikeVO likevo);

	// 특정 사용자가 특정 게시글에 좋아요를 눌렀는지 여부(개수)를 조회
	int getMyLikeCount(LikeVO likevo);

	// 특정 게시글의 전체 좋아요 개수를 조회합니다.
	int getTotalLikeCount(int postNum);
}
