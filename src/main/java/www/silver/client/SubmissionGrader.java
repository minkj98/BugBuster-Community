package www.silver.client;

/**
 * 제출 코드 채점기(External grading engine) 추상화.
 *
 * <p>구현체는 특정 채점 수단(LLM API 등) 연동을 담당한다. 서비스 계층은 이 인터페이스에만
 * 의존하므로 채점 수단 교체 시 서비스 코드는 변경되지 않는다.
 */
public interface SubmissionGrader {

    /**
     * 제출 코드를 채점하고 피드백 문자열을 반환한다.
     *
     * <p>정답이면 응답은 {@code "Correct"}로 시작하고, 오답이면 {@code "Incorrect"}로 시작한다.
     *
     * @param code               제출된 소스 코드
     * @param problemDescription 문제 설명
     * @param language           제출 언어
     * @return 채점 피드백
     */
    String grade(String code, String problemDescription, String language);
}
