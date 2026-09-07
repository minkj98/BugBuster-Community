package www.silver.exception;

import javax.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice(basePackages = "www.silver")
public class AllExceptionHandler {

	// CustomException(사용자 정의 예외) 발생 시 호출
	@ExceptionHandler(CustomException.class)
	public ModelAndView handleCustom(CustomException e, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("customError/error"); // error.jsp
		mav.addObject("exception", e);
		return mav;
	}

	// 그 외 모든 예외(Exception) 발생 시 호출
	// 에러 정보를 JSON 형태로 응답
	// CustomErrorResponse 객체에 에러 코드, 요청 경로, 상세 메시지를 담아 반환
	@ExceptionHandler(Exception.class)
	public ResponseEntity<CustomErrorResponse> handleUnknown(Exception e, HttpServletRequest request) {
		CustomErrorResponse response = CustomErrorResponse.builder().errorCode(ErrorCode.UNKNOWN)
				.path(request.getRequestURI()).detail(e.getMessage()).build();
		return ResponseEntity.status(ErrorCode.UNKNOWN.getStatus()).body(response);
	}
}
