package www.silver.service;

import java.util.List;

import www.silver.vo.MemberVO;

public interface SignUpService {

    // 회원 정보를 DB에 저장하여 신규 계정을 생성
    public void insert(MemberVO membervo);

    // 주어진 사용자 ID가 이미 존재하는지 중복 여부를 확인
    public int duplicateId(String userId);

    // 비밀번호가 유효한지(예: 규칙, 길이 등) 검증
    public boolean isValidPassword(String password);

    // 기존 비밀번호가 맞는지 검증
    public boolean validateOldPassword(String userid, String oldPassword);

    // 사용자 ID와 비밀번호로 로그인 시도 후 회원 정보를 반환
    public MemberVO loginUser(String userId, String userPassword);

    // 회원의 비밀번호를 변경
    public void updateMemberPass(MemberVO membervo);

    // 사용자 ID로 회원 정보를 조회
    public MemberVO getMemberById(String userId) throws Exception;

    // 회원 정보를 수정
    public int updateMember(MemberVO memberVO) throws Exception;

	public List<String> getProfileAttach(String userId);
	
	public void memberresert(MemberVO membervo);
	
}
