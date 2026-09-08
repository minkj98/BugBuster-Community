package www.silver.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.InOrder;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.MockitoJUnitRunner;

import www.silver.dao.SignUpDAO;
import www.silver.vo.MemberVO;

/**
단위 테스트
* 회원가입(insert) 흐름, 아이디 중복 확인(duplicateId)
 */
@RunWith(MockitoJUnitRunner.class)
public class SignUpServiceImplTest {

	@Mock
	private SignUpDAO signUpDAO;

	@InjectMocks
	private SignUpServiceImpl service;

	private MemberVO member(String userId, List<String> filenames, List<String> interests) {
		MemberVO vo = new MemberVO();
		vo.setUserId(userId);
		vo.setUserPassword("Abcd1234!");
		vo.setUserName("홍길동");
		vo.setFilename(filenames);
		vo.setInterest(interests);
		return vo;
	}

	// 회원가입
	@Test
	public void insert_delegatesToAccountThenProfileImgThenInterest_inOrder() {
		//given(주어진 것)
		MemberVO vo = member("gildong",
				Arrays.asList("a.png", "b.png"),
				Arrays.asList("java", "spring"));

		//when(실행)
		service.insert(vo);

		//then(결과)
		InOrder inOrder = Mockito.inOrder(signUpDAO);
		inOrder.verify(signUpDAO).insertAccount(vo);
		inOrder.verify(signUpDAO, times(2)).attachProfileImg(any());
		inOrder.verify(signUpDAO, times(2)).insertInterest(eq("gildong"), anyString());
	}

	@Test
	public void insert_putsUserIdAndFilenameIntoProfileImgParamMap() {
		//given(주어진 것)
		MemberVO vo = member("gildong",
				Collections.singletonList("profile.png"),
				Collections.singletonList("java"));

		//when(실행)
		service.insert(vo);

		//then(결과)
		@SuppressWarnings("unchecked")
		ArgumentCaptor<Map<String, Object>> captor = ArgumentCaptor.forClass(Map.class);
		verify(signUpDAO).attachProfileImg(captor.capture());
		Map<String, Object> params = captor.getValue();
		assertEquals("gildong", params.get("userId"));
		assertEquals("profile.png", params.get("filename"));
	}

	@Test
	public void insert_callsInsertInterestForEachTag() {
		//given(주어진 것)
		MemberVO vo = member("gildong",
				Collections.<String>emptyList(),
				Arrays.asList("java", "spring", "mysql"));

		//when(실행)
		service.insert(vo);

		//then(결과)
		verify(signUpDAO).insertInterest("gildong", "java");
		verify(signUpDAO).insertInterest("gildong", "spring");
		verify(signUpDAO).insertInterest("gildong", "mysql");
	}

	@Test
	public void insert_doesNotCallAttachProfileImg_whenNoProfileImg() {
		//given(주어진 것)
		MemberVO vo = member("gildong",
				new ArrayList<String>(),
				Collections.singletonList("java"));

		//when(실행)
		service.insert(vo);

		//then(결과)
		verify(signUpDAO).insertAccount(vo);
		verify(signUpDAO, never()).attachProfileImg(any());
	}


	// 회원 중복가입
	@Test
	public void duplicateId_returnsZero_whenIdAvailable() {
		//given(주어진 것)
		when(signUpDAO.duplicateCheckId("newbie")).thenReturn(0);

		//when(실행)
		int result = service.duplicateId("newbie");

		//then(결과)
		assertEquals(0, result);
	}

	@Test
	public void duplicateId_returnsPositive_whenIdAlreadyExists() {
		//given(주어진 것)
		when(signUpDAO.duplicateCheckId("gildong")).thenReturn(1);

		//when(실행)
		int result = service.duplicateId("gildong");

		//then(결과)
		assertTrue(result > 0);
	}

	@Test
	public void duplicateId_passesIdToDaoAsIs() {
		//given(주어진 것)
		when(signUpDAO.duplicateCheckId(anyString())).thenReturn(0);

		//when(실행)
		service.duplicateId("gildong");

		//then(결과)
		verify(signUpDAO).duplicateCheckId("gildong");
	}

	@Test
	public void insert_doesNotCheckDuplicateId() {
		//given(주어진 것)
		MemberVO vo = member("gildong",
				Collections.<String>emptyList(),
				Collections.singletonList("java"));

		//when(실행)
		service.insert(vo);

		//then(결과)
		verify(signUpDAO, never()).duplicateCheckId(anyString());
	}

	@Test
	public void isValidPassword_validatesLengthLetterDigitSpecialChar() {
		//given(주어진 것)
		String validPw = "Abcd1234!";       // 영문+숫자+특수+8자
		String noSpecialPw = "abcd1234";    // 특수문자 없음
		String tooShortPw = "Ab1!";         // 8자 미만

		//when(실행)
		boolean validResult = service.isValidPassword(validPw);
		boolean noSpecialResult = service.isValidPassword(noSpecialPw);
		boolean tooShortResult = service.isValidPassword(tooShortPw);

		//then(결과)
		assertTrue(validResult);
		assertFalse(noSpecialResult);
		assertFalse(tooShortResult);
	}
}
