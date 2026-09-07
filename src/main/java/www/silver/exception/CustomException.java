package www.silver.exception;

import org.springframework.http.HttpStatus;

public class CustomException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	private final ErrorCode errorCode; // 에러 코드(HTTP 상태, 코드, 메시지 포함)
	private final String detailMessage; // 상세 메시지(추가 설명)

	private CustomException(ErrorCode errorCode, String detail, Throwable cause) {
		// 예외 메시지는 상세 메시지(detail)가 있으면 그걸로, 없으면 에러 코드의 기본 메시지로 설정
		super((detail == null) ? errorCode.getMessage() : detail, cause);
		this.errorCode = errorCode;
		this.detailMessage = detail == null ? "" : detail;
	}

	public CustomException(ErrorCode errorCode) {
		this(errorCode, errorCode.getMessage(), null);
	}

	public CustomException(ErrorCode errorCode, String detail) {
		this(errorCode, detail, null);
	}

	public CustomException(ErrorCode errorCode, Throwable cause) {
		this(errorCode, cause.getMessage(), cause);
	}

	public HttpStatus getStatus() {
		return errorCode.getStatus();
	}

	public String getCode() {
		return errorCode.getCode();
	}

	public ErrorCode getErrorCode() {
		return errorCode;
	}

	public String getDetailMessage() {
		return detailMessage;
	}
}
