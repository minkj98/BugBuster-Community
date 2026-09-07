package www.silver.exception;

/**
 * API/웹 요청에서 예외 발생 시 클라이언트에게 반환하는 표준 에러 응답 객체입니다. - 빌더 패턴을 사용해 유연하게 생성할 수 있습니다.
 */
public class CustomErrorResponse {
	private final long timestamp; // 에러 발생 시각 (밀리초)
	private final int status; // HTTP 상태 코드
	private final String code; // 애플리케이션 에러 코드
	private final String message; // 기본 에러 메시지
	private final String path; // 요청이 발생한 URL 경로
	private final String detail; // 추가 상세 메시지

	// Builder 객체를 받아 내부 필드를 초기화
	private CustomErrorResponse(Builder b) {
		this.timestamp = System.currentTimeMillis();
		this.status = b.errorCode.getStatus().value(); // HTTP 상태 코드
		this.code = b.errorCode.getCode(); // 애플리케이션 에러 코드
		this.message = b.errorCode.getMessage(); // 기본 에러 메시지
		this.path = b.path; // 요청 URL
		this.detail = b.detail; // 상세 메시지
	}

	public long getTimestamp() {
		return timestamp;
	}

	public int getStatus() {
		return status;
	}

	public String getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}

	public String getPath() {
		return path;
	}

	public String getDetail() {
		return detail;
	}

	// CustomErrorResponse 객체 생성을 위한 Builder를 반환
	public static Builder builder() {
		return new Builder();
	}

	// CustomErrorResponse 객체 생성을 위한 빌더 클래스
	public static class Builder {
		private ErrorCode errorCode;
		private String path = "";
		private String detail = "";

		public Builder errorCode(ErrorCode ec) {
			this.errorCode = ec;
			return this;
		}

		public Builder path(String path) {
			this.path = path;
			return this;
		}

		public Builder detail(String d) {
			this.detail = d;
			return this;
		}

		// CustomErrorResponse 객체를 생성
		public CustomErrorResponse build() {
			return new CustomErrorResponse(this);
		}
	}
}
