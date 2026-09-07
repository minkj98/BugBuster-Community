package www.silver.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import www.silver.dao.SignUpDAO;
import www.silver.vo.MemberVO;

@Service
public class SignUpServiceImpl implements SignUpService {

	@Inject
    SignUpDAO signupdao;

	// 회원 정보를 DB에 저장하여 신규 계정을 생성
	// 프로필 이미지가 여러 개인 경우, 각 파일명을 DB에 별도로 저장
	// 트랜잭션 처리: 회원 정보와 프로필 이미지 등록이 모두 성공해야 커밋
	@Override
	@Transactional
	public void insert(MemberVO membervo) {
		signupdao.insertAccount(membervo);
		List<String> fname = membervo.getFilename();

		for (String filename : fname) {
			Map<String, Object> params = new HashMap<>();
			params.put("userId", membervo.getUserId());
			params.put("filename", filename);
			signupdao.attachProfileImg(params);
		}

		
		List<String> interests = membervo.getInterest();
		for (String interest : interests) {
			signupdao.insertInterest(membervo.getUserId(), interest);
		}

	}

	// 주어진 사용자 ID가 이미 존재하는지 중복 여부를 확인
	@Override
	public int duplicateId(String userId) {
		return signupdao.duplicateCheckId(userId);
	}

	// 비밀번호가 유효한지(8자 이상, 영문자, 숫자, 특수문자 포함) 검증
	@Override
	public boolean isValidPassword(String password) {
		// 비밀번호 유효성: 8자 이상, 영문자, 숫자, 특수문자 포함
		return password.matches("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$");
	}

	// 사용자 ID와 비밀번호로 로그인 시도 후 회원 정보를 반환
	@Override
	public MemberVO loginUser(String userId, String userPassword) {
		return signupdao.loginUser(userId, userPassword);
	}

	// 회원의 비밀번호를 변경
	@Override
	public void updateMemberPass(MemberVO membervo) {
		signupdao.updateMemberPass(membervo);
	}

	// 기존 비밀번호가 맞는지 검증
	@Override
	public boolean validateOldPassword(String userid, String oldPassword) {
		// DB에서 사용자 정보 조회
		MemberVO member = signupdao.getMemberById(userid);
		if (member == null) {
			return false;
		}
		return oldPassword.equals(member.getUserPassword());
	}

	// 사용자 ID로 회원 정보를 조회
	@Override
	public MemberVO getMemberById(String userId) throws Exception {
		return signupdao.selectByUserId(userId);
	}

	// 회원 정보를 수정
	@Override
	public int updateMember(MemberVO memberVO) throws Exception {
		return signupdao.updateMember(memberVO);
	}

	@Override
	public List<String> getProfileAttach(String userId) {
		return signupdao.getProfileAttach(userId);
	}
	
	@Override
	public void memberresert(MemberVO membervo) {
		signupdao.memberreset(membervo);
		
	}
}
