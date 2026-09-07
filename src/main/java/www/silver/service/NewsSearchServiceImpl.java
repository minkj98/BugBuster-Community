package www.silver.service;

import org.springframework.stereotype.Service;
import www.silver.dao.NewsSearchDAO;
import www.silver.vo.NewsVO;
import www.silver.vo.PageVO;
import javax.inject.Inject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class NewsSearchServiceImpl implements NewsSearchService {

    @Inject
    NewsSearchDAO newsSearchDAO;

    int pageLimit = 10; // 한 페이지에 보여줄 뉴스 개수
    int blockLimit = 5; // 한 번에 보여줄 페이지 번호 개수(페이징 블록)

    // 키워드와 타입(제목/카테고리), 페이지 번호를 이용해 뉴스 목록을 검색
    @Override
    public List<NewsVO> searchNews(String keyword, String type, int page) {
        try {
            if (page < 1) {
                page = 1;
            }
            int pagingStart = (page - 1) * pageLimit;

            Map<String, Object> searchParams = new HashMap<>();
            searchParams.put("keyword", keyword);
            searchParams.put("start", pagingStart);
            searchParams.put("limit", pageLimit);

            switch (type) {
                case "title":
                    return newsSearchDAO.searchByTitle(searchParams);
                case "category":
                    return newsSearchDAO.searchByCategory(searchParams);
                default:
                    return new ArrayList<>();
            }
        } catch (Exception e) {
            System.out.println("뉴스 검색 중 예외 발생: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    // 키워드, 타입, 페이지 번호에 따른 페이징 정보를 계산하여 반환
    @Override
    public PageVO searchPagingParam(String keyword, String type, int page) {
        try {
            int searchCount = getSearchTotalCount(keyword, type);
            int maxPage = (int) Math.ceil((double) searchCount / pageLimit);
            if (maxPage < 1) maxPage = 1;

            if (page < 1) page = 1;
            if (page > maxPage) page = maxPage;

            int startPage = ((page - 1) / blockLimit) * blockLimit + 1;
            int endPage = startPage + blockLimit - 1;
            if (endPage > maxPage) endPage = maxPage;

            PageVO pageVO = new PageVO();
            pageVO.setPage(page);
            pageVO.setMaxPage(maxPage);
            pageVO.setStartPage(startPage);
            pageVO.setEndPage(endPage);

            return pageVO;
        } catch (Exception e) {
            System.out.println("페이징 계산 중 예외 발생: " + e.getMessage());
            PageVO defaultPageVO = new PageVO();
            defaultPageVO.setPage(1);
            defaultPageVO.setMaxPage(1);
            defaultPageVO.setStartPage(1);
            defaultPageVO.setEndPage(1);
            return defaultPageVO;
        }
    }

    // 키워드와 타입에 해당하는 전체 검색 결과 개수를 조회
    @Override
    public int getSearchTotalCount(String keyword, String type) {
        try {
            switch (type) {
                case "title":
                    return newsSearchDAO.countByTitle(keyword);
                case "category":
                    return newsSearchDAO.countByCategory(keyword);
                default:
                    return 0;
            }
        } catch (Exception e) {
            System.out.println("총 개수 조회 중 예외 발생: " + e.getMessage());
            return 0;
        }
    }
}
