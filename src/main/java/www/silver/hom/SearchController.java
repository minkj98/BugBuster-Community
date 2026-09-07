package www.silver.hom;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import www.silver.service.SearchService;
import www.silver.vo.BoardVO;
import www.silver.vo.PageVO;
import javax.inject.Inject;
import java.util.List;

@Controller
public class SearchController {
    @Inject
    SearchService searchService;

    @GetMapping("/searchContent")
    public String searchContent(
            @RequestParam("type") String type,      // 검색 유형(작성자, 제목 등)
            @RequestParam("keyword") String keyword, // 검색어
            @RequestParam(value = "page", defaultValue = "1") int page, // 페이지 번호(기본 1)
            Model model) {

        try {
            // 검색 결과 조회
            // type: 작성자 or 제목 검색
            // 게시글 리스트 조회
            List<BoardVO> searchResults = searchService.searchContent(keyword, type, page);

            // 페이징 정보 조회
            PageVO pageVO = searchService.searchPagingParam(keyword, type, page);

            // 검색 결과 및 페이징 정보를 모델에 담아 뷰로 전달
            model.addAttribute("contentlist", searchResults); // 검색된 게시글 목록
            model.addAttribute("paging", pageVO);             // 페이징 정보
            model.addAttribute("isSearchResult", true);       // 검색 결과 여부 표시
            model.addAttribute("searchType", type);           // 검색 유형
            model.addAttribute("searchKeyword", keyword);     // 검색어
            model.addAttribute("totalCount", searchService.getSearchTotalCount(keyword, type)); // 전체 결과 개수

            // 게시판 뷰로 이동
            return "getuseds/board";

        } catch (Exception e) {
            // 검색 중 예외 발생 시 에러 메시지 전달
            model.addAttribute("error", "검색 중 오류가 발생하였습니다.");
            return "getuseds/board";
        }
    }
}
