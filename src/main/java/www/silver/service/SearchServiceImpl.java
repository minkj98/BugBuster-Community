package www.silver.service;

import org.springframework.stereotype.Service;
import www.silver.dao.SearchDAO;
import www.silver.vo.BoardVO;
import www.silver.vo.PageVO;
import javax.inject.Inject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SearchServiceImpl implements SearchService {

    @Inject
    SearchDAO searchDAO;

    int pageLimit = 10; // 한 페이지에 보여줄 게시글 수
    int blockLimit = 5; // 아래에 보여줄 페이지 번호 개수(페이징 블록)

    // 키워드, 타입(작성자/프로그래밍 언어), 페이지 번호에 따라 게시글 목록을 검색
    @Override
    public List<BoardVO> searchContent(String keyword, String type, int page) {
        try {
            if (page < 1) {
                page = 1;
            }
            int pagingStart = (page - 1) * pageLimit;

            Map<String, Object> searchType = new HashMap<>();
            searchType.put("keyword", keyword);
            searchType.put("start", pagingStart);
            searchType.put("limit", pageLimit);

            switch (type) {
                case "writer":
                    return searchDAO.searchByWriter(searchType);
                case "programmingLanguage":
                    return searchDAO.searchByProgrammingLanguage(searchType);
                default:
                    return new ArrayList<>();
            }
        } catch (Exception e) {
            System.out.println("검색 중 예외 발생: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    // 검색 결과에 대한 게시글 페이징 정보를 계산하여 반환
    @Override
    public PageVO searchPagingParam(String keyword, String type, int page) {
        try {
            // 전체 검색 결과 개수 조회
            int searchCount = getSearchTotalCount(keyword, type);
            System.out.println("Total search count: " + searchCount);

            // 전체 페이지 수 계산
            int maxPage = (int) Math.ceil((double) searchCount / pageLimit);
            if (maxPage < 1) maxPage = 1;

            // 현재 페이지 번호 유효성 체크
            if (page < 1) page = 1;
            if (page > maxPage) page = maxPage;

            // 한 블록에 보여줄 시작/끝 페이지 번호 계산
            int startPage = ((page - 1) / blockLimit) * blockLimit + 1;
            int endPage = startPage + blockLimit - 1;
            if (endPage > maxPage) endPage = maxPage;

            PageVO pagevo = new PageVO();
            pagevo.setPage(page);
            pagevo.setMaxPage(maxPage);
            pagevo.setStartPage(startPage);
            pagevo.setEndPage(endPage);
            
            pagevo.setTotalCount(searchCount);   // ★ 누락됐던 부분
            pagevo.setPageSize(pageLimit);       // ★ pageSize 도 채워 주면 JSP 계산식이 안전

            System.out.println("== 검색 페이징 파라미터 확인 ==");
            System.out.println("keyword = " + keyword + ", type = " + type);
            System.out.println("page = " + page);
            System.out.println("startPage = " + startPage);
            System.out.println("endPage = " + endPage);
            System.out.println("maxPage = " + maxPage);

            return pagevo;

        } catch (Exception e) {
            System.out.println("페이징 계산 중 예외 발생: " + e.getMessage());
            // 예외 발생 시 기본 페이징 정보 반환
            PageVO defaultPagevo = new PageVO();
            defaultPagevo.setPage(1);
            defaultPagevo.setMaxPage(1);
            defaultPagevo.setStartPage(1);
            defaultPagevo.setEndPage(1);
            return defaultPagevo;
        }
    }

    // 작성자 또는 프로그래밍 언어 기준 검색 결과의 전체 게시글 개수를 반환
    @Override
    public int getSearchTotalCount(String keyword, String type) {
        try {
            switch (type) {
                case "writer":
                    return searchDAO.countByWriter(keyword);
                case "programmingLanguage":
                    return searchDAO.countByProgrammingLanguage(keyword);
                default:
                    return 0;
            }
        } catch (Exception e) {
            System.out.println("총 개수 조회 중 예외 발생: " + e.getMessage());
            return 0;
        }
    }
}
