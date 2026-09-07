package www.silver.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import www.silver.vo.MemberVO;

// AuthInterceptor 클래스는 Spring MVC에서 요청을 처리하기 전에 인증(로그인) 여부를 체크하기 위한 인터셉터
public class AuthInterceptor extends HandlerInterceptorAdapter {

	// preHandle 메서드는 컨트롤러의 실제 메서드가 호출되기 전에 실행
	// 이 메서드에서 요청에 대한 인증(예: 로그인 여부 확인)을 처리할 수 있습니다.
	// request 클라이언트에서 보낸 HTTP 요청 객체
	// response 서버가 클라이언트로 보낼 HTTP 응답 객체
	// handler 호출될 컨트롤러 메서드 객체
	// return true를 반환하면 요청이 컨트롤러로 전달되고, false를 반환하면 요청이 중단
	// throws Exception 예외가 발생할 경우 서블릿 컨테이너가 처리
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String requestURI = request.getRequestURI();
		System.out.println("인증 인터셉터 동작 - 요청 URI: " + requestURI);

		// 1단계: 세션 존재 여부 확인
		HttpSession session = request.getSession(false);
		if (session == null) {
			System.out.println("세션이 존재하지 않습니다.");
			response.sendRedirect(request.getContextPath() + "/");
			return false; // 요청 중단
		}

		// 2단계: 로그인 여부 확인
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			System.out.println("세션에 로그인 정보가 존재하지 않습니다.");
			response.sendRedirect(request.getContextPath() + "/");
			return false; // 요청 중단
		}

		// 3단계: 사용자 ID 유효성 확인
		String userId = loginUser.getUserId();
		if (userId == null) {
			System.out.println("사용자 ID가 null입니다.");
			response.sendRedirect(request.getContextPath() + "/");
			return false; // 요청 중단
		}

		System.out.println("인증 완료 - 사용자 ID: " + userId);
		return true; // 요청 계속 진행
	}
}
