package www.silver.dao;

import java.util.List;
import java.util.Map;

import www.silver.vo.MemberVO;

public interface SignUpDAO {

	// 회원가입 한 회원의 정보를 저장
	public void insertAccount(MemberVO membervo);

	// 주어진 사용자 ID가 이미 존재하는지 중복 여부를 확인
	public int duplicateCheckId(String userId);

	// 사용자 ID와 비밀번호를 기반으로 회원 로그인 정보를 조회
	public MemberVO loginUser(String userId, String userPassword);

	// 회원의 비밀번호를 변경
	public void updateMemberPass(MemberVO membervo);

	// 사용자 ID로 회원 정보를 조회
	public MemberVO getMemberById(String userid);

	public MemberVO selectByUserId(String userId) throws Exception;

	// 회원 정보를 수정합니다.
	public int updateMember(MemberVO memberVO) throws Exception;

	// 회원 프로필 이미지를 첨부(업로드)
	public void attachProfileImg(Map<String, Object> params);

	// 회원 관심태그 저장
	public void insertInterest(String userId, String interest);

	public List<String> getProfileAttach(String userId);
	
	 public int memberreset(MemberVO memberVO);
}
