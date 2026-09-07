package www.silver.client;

import www.silver.vo.NewsVO;

import java.util.List;

/**
 * 외부 뉴스 제공자(External news source) 추상화.
 *
 * <p>구현체는 특정 뉴스 API(네이버 등) 호출과 응답 파싱을 담당한다.
 * 서비스 계층은 이 인터페이스에만 의존하므로, 제공자 교체 시 서비스 코드는 변경되지 않는다.
 */
public interface NewsProvider {

    /**
     * 키워드로 뉴스를 검색하여 도메인 객체 목록으로 반환한다.
     *
     * @param keyword 검색 키워드
     * @return 파싱된 뉴스 목록. 호출 실패 시 빈 목록.
     */
    List<NewsVO> fetchNews(String keyword);
}
