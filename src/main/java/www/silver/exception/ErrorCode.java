package www.silver.exception;

import org.springframework.http.HttpStatus;

// 애플리케이션에서 발생할 수 있는 주요 에러 상황을 열거형(enum)으로 정의

public enum ErrorCode {

	// 권한 없음
	NO_PERMISSION(HttpStatus.FORBIDDEN, "AUTH-001", "권한이 없습니다."),

	// 게시글 파일 업로드 실패
	UPLOAD_FAIL(HttpStatus.INTERNAL_SERVER_ERROR, "FILE-001", "파일 업로드 실패"),

	// 댓글 처리 실패 (댓글 작성, 수정, 삭제 등)
	COMMENT_FAIL(HttpStatus.INTERNAL_SERVER_ERROR, "COMMENT-001", "댓글 처리 실패"),

	// 대댓글 처리 실패
	REPLY_FAIL(HttpStatus.INTERNAL_SERVER_ERROR, "REPLY-001", "대댓글 처리 실패"),

	// 시스템에서 처리하지 않은 예외 발생 시 Fallback 코드
	UNKNOWN(HttpStatus.INTERNAL_SERVER_ERROR, "SYS-999", "알 수 없는 오류");

	private final HttpStatus status; // HTTP 상태 코드 (예: 403, 500 등)
	private final String code; // 애플리케이션 고유 에러 코드 (예: "AUTH-001")
	private final String message; // 사용자에게 보여줄 에러 메시지

	ErrorCode(HttpStatus status, String code, String message) {
		this.status = status;
		this.code = code;
		this.message = message;
	}

	public HttpStatus getStatus() {
		return status;
	}

	public String getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}
}
