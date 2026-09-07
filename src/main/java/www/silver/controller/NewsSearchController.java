package www.silver.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import www.silver.service.NewsSearchService;
import www.silver.vo.NewsVO;
import www.silver.vo.PageVO;
import javax.inject.Inject;
import java.util.List;

@Controller
public class NewsSearchController {

    @Inject
    NewsSearchService newsSearchService;

    @GetMapping("/searchNews")
    public String searchNews(
            @RequestParam("type") String type,      // 검색 유형
            @RequestParam("keyword") String keyword, // 검색어
            @RequestParam(value = "page", defaultValue = "1") int page, // 페이지 번호 (기본값 1)
            Model model) {

        try {
            // 뉴스 검색 결과 조회
            List<NewsVO> searchResults = newsSearchService.searchNews(keyword, type, page);
            // 페이징 정보 조회
            PageVO pageVO = newsSearchService.searchPagingParam(keyword, type, page);

            // 모델에 검색 결과와 페이징 정보 추가
            model.addAttribute("newsList", searchResults); // 뉴스 리스트
            model.addAttribute("paging", pageVO);           // 페이징 정보
            model.addAttribute("isSearchResult", true);     // 검색 결과 여부 표시
            model.addAttribute("searchType", type);         // 검색 유형
            model.addAttribute("searchKeyword", keyword);   // 검색어
            model.addAttribute("totalCount", newsSearchService.getSearchTotalCount(keyword, type)); // 전체 검색 결과 수

            return "getuseds/itNews"; // itNews.jsp로 이동
        } catch (Exception e) {
            // 검색 중 예외 발생 시 에러 메시지 전달
            model.addAttribute("error", "뉴스 검색 중 오류가 발생하였습니다.");
            return "getuseds/itNews";
        }
    }
}
