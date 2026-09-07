package www.silver.vo;

import java.util.Date;
import java.util.List;
import org.springframework.format.annotation.DateTimeFormat;

public class MemberVO {
	private String userId; // 사용자 ID (고유 식별자)
	private String userPassword; // 사용자 비밀번호
	private String oldPassword; // 기존 비밀번호 (비밀번호 변경 시 사용)
	private String userName; // 사용자 이름
	private String zipCode; // 우편번호
	private String address; // 기본 주소
	private String detailAddress; // 상세 주소
	private String userEmail; // 이메일 주소 (아이디 부분)
	private String fullEmail; // 전체 이메일 주소 (도메인 포함)
	private String userPhoneNum; // 전화번호
	private List<String> filename; // 첨부파일 이름 (프로필 이미지 등)
	private	List<String> interest;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthdate; // 생년월일

	public List<String> getInterest() {
		return interest;
	}

	public void setInterest(List<String> interest) {
		this.interest = interest;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getFullEmail() {
		return fullEmail;
	}

	public void setFullEmail(String fullEmail) {
		this.fullEmail = fullEmail;
	}

	public String getUserPhoneNum() {
		return userPhoneNum;
	}

	public void setUserPhoneNum(String userPhoneNum) {
		this.userPhoneNum = userPhoneNum;
	}

	public List<String> getFilename() {
		return filename;
	}

	public void setFilename(List<String> filename) {
		this.filename = filename;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

}
