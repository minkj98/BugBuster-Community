package www.silver.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import www.silver.dao.LikesDAO;
import www.silver.vo.LikeVO;

// 단위 테스트
// 좋아요 토글(toggleLike) 분기/예외 처리
// 좋아요 개수 조회(getMyLikeCount/getTotalLikeCount)
@RunWith(MockitoJUnitRunner.class)
public class LikesServiceImplTest {

	@Mock
	private LikesDAO likesDAO;

	@InjectMocks
	private LikesServiceImpl service;

	private LikeVO like(String userId, int postNum) {
		LikeVO vo = new LikeVO();
		vo.setUserId(userId);
		vo.setPostNum(postNum);
		return vo;
	}

	// 좋아요 추가
	@Test
	public void toggleLike_addsLike_whenNotLikedYet() {
		//given
		LikeVO vo = like("gildong", 10);
		when(likesDAO.getMyLikeCount(vo)).thenReturn(0);

		//when
		boolean result = service.toggleLike(vo);

		//then
		verify(likesDAO).postLike(vo);
		verify(likesDAO, never()).deleteLike(vo);
		assertTrue(result);
	}

	// 좋아요 취소
	@Test
	public void toggleLike_removesLike_whenAlreadyLiked() {
		//given
		LikeVO vo = like("gildong", 10);
		when(likesDAO.getMyLikeCount(vo)).thenReturn(1);

		//when
		boolean result = service.toggleLike(vo);

		//then
		verify(likesDAO).deleteLike(vo);
		verify(likesDAO, never()).postLike(vo);
		assertTrue(result);
	}

	// 중복 좋아요 방지: 이미 눌린 상태에서 다시 호출해도 postLike를 부르지 않는다
	@Test
	public void toggleLike_doesNotInsertLikeAgain_whenAlreadyLiked() {
		//given
		LikeVO vo = like("gildong", 10);
		when(likesDAO.getMyLikeCount(vo)).thenReturn(2); // 어떤 이유로 2건이어도 추가 금지

		//when
		service.toggleLike(vo);

		//then
		verify(likesDAO, never()).postLike(vo);
		verify(likesDAO).deleteLike(vo);
	}

	// 예외 상황: 좋아요 여부 조회에서 예외가 나면 false
	@Test
	public void toggleLike_returnsFalse_whenLikeCountLookupThrows() {
		//given
		LikeVO vo = like("gildong", 10);
		when(likesDAO.getMyLikeCount(vo)).thenThrow(new RuntimeException("DB down"));

		//when
		boolean result = service.toggleLike(vo);

		//then
		assertFalse(result);
		verify(likesDAO, never()).postLike(vo);
		verify(likesDAO, never()).deleteLike(vo);
	}

	// 예외 상황: 좋아요 추가(INSERT)에서 예외가 나면 false
	@Test
	public void toggleLike_returnsFalse_whenPostLikeThrows() {
		//given
		LikeVO vo = like("gildong", 10);
		when(likesDAO.getMyLikeCount(vo)).thenReturn(0);
		doThrow(new RuntimeException("insert failed")).when(likesDAO).postLike(vo);

		//when
		boolean result = service.toggleLike(vo);

		//then
		assertFalse(result);
	}

	// 예외 상황: 좋아요 취소(DELETE)에서 예외가 나면 false
	@Test
	public void toggleLike_returnsFalse_whenDeleteLikeThrows() {
		//given
		LikeVO vo = like("gildong", 10);
		when(likesDAO.getMyLikeCount(vo)).thenReturn(1);
		doThrow(new RuntimeException("delete failed")).when(likesDAO).deleteLike(vo);

		//when
		boolean result = service.toggleLike(vo);

		//then
		assertFalse(result);
	}

	// 내 좋아요 여부 조회: DAO 결과를 그대로 반환
	@Test
	public void getMyLikeCount_returnsValueFromDao() {
		//given
		LikeVO vo = like("gildong", 10);
		when(likesDAO.getMyLikeCount(vo)).thenReturn(1);

		//when
		int result = service.getMyLikeCount(vo);

		//then
		assertEquals(1, result);
		verify(likesDAO).getMyLikeCount(vo);
	}

	// 전체 좋아요 개수 조회: 받은 postNum을 그대로 넘기고 DAO 결과를 반환
	@Test
	public void getTotalLikeCount_passesPostNumToDao_andReturnsCount() {
		//given
		when(likesDAO.getTotalLikeCount(10)).thenReturn(5);

		//when
		int result = service.getTotalLikeCount(10);

		//then
		assertEquals(5, result);
		verify(likesDAO).getTotalLikeCount(10);
	}
}
