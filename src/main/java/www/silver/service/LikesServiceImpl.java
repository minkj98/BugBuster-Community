package www.silver.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import www.silver.dao.LikesDAO;
import www.silver.vo.LikeVO;

@Service
public class LikesServiceImpl implements LikesService {

	@Inject
    LikesDAO likesdao;

	// 게시글에 대한 좋아요 상태를 토글
	// 사용자가 해당 게시글에 좋아요를 누르지 않았다면 추가
	// 이미 눌렀다면 삭제
	@Override
	public boolean toggleLike(LikeVO likevo) {
		try {
			if (getMyLikeCount(likevo) < 1) {
				// 좋아요 추가
				likesdao.postLike(likevo);
				System.out.println("좋아요 추가 - postNum: " + likevo.getPostNum() + ", userId: " + likevo.getUserId());
			} else {
				// 좋아요 취소
				likesdao.deleteLike(likevo);
				System.out.println("좋아요 취소 - postNum: " + likevo.getPostNum() + ", userId: " + likevo.getUserId());
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 특정 사용자가 특정 게시글에 좋아요를 눌렀는지 여부를 조회
	@Override
	public int getMyLikeCount(LikeVO likevo) {
		return likesdao.getMyLikeCount(likevo);
	}

	// 특정 게시글의 전체 좋아요 개수를 조회
	@Override
	public int getTotalLikeCount(int postNum) {
		return likesdao.getTotalLikeCount(postNum);
	}
}
