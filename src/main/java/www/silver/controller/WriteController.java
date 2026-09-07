package www.silver.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import www.silver.vo.PageVO;
import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;
import www.silver.vo.MemberVO;
import www.silver.vo.NewsVO;
import www.silver.exception.CustomException;
import www.silver.exception.ErrorCode;
import www.silver.service.NewsService;
import www.silver.service.SignUpService;
import www.silver.service.WriteService;
import www.silver.util.FileDataUtil;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

@Controller
public class WriteController {

	@Inject
    WriteService writeService;
	
	@Inject
	SignUpService signupService;

	@Inject
	FileDataUtil filedatautil;

	// QA게시판 페이지로 리다이렉트
	@RequestMapping(value = "/QABoard", method = RequestMethod.GET)
	public String viewBoard() {
		return "redirect:boardview";
	}

	// 글 작성 페이지로 이동
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write() {
		return "getuseds/write";
	}

	
	// 게시글 저장 처리
	@RequestMapping(value = "/insertContent", method = RequestMethod.POST)
	public String saveWrite(@ModelAttribute BoardVO boardvo, MultipartFile[] file, HttpSession session) {
	    // 이미 인터셉터에서 로그인 체크가 끝났으므로 바로 꺼냄
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    boardvo.setWriter(loginUser.getUserId());

	    try {
	        List<String> filename = filedatautil.fileUpload(file);
	        boardvo.setFilename(filename == null ? new ArrayList<>() : filename);
	    } catch (Exception e) {
	        throw new CustomException(ErrorCode.UPLOAD_FAIL, e);
	    }

	    writeService.addWrite(boardvo);
	    return "redirect:boardview";
	}

	
	// 게시판 목록 페이지로 리다이렉트
	@RequestMapping(value = "/boardview", method = RequestMethod.GET)
	public String boardview() {
		return "redirect:/paging?page=1";
	}

	
	@GetMapping("/paging")
	public String paging(Model model, @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
	    int pageSize = 10; // 페이지당 게시글 수
	    int totalCount = writeService.getTotalCount(); // 전체 게시글 수 조회 메서드 필요

	    PageVO pagevo = writeService.pagingParam(page);
	    pagevo.setTotalCount(totalCount);
	    pagevo.setPageSize(pageSize);

	    model.addAttribute("contentlist", writeService.pagingList(page));
	    model.addAttribute("paging", pagevo);
	    return "getuseds/board";
	}


	// 게시글 상세 조회
	@RequestMapping(value = "/textview", method = RequestMethod.GET)
	public String textview(@RequestParam("postNum") Long postNum, Model model) {
		// 조회수 증가
		writeService.viewCount(postNum);

		// 글 및 첨부 파일정보 가져오기
		BoardVO boardvo = writeService.textview(postNum);
		model.addAttribute("post", boardvo);
		List<String> attachList = writeService.getAttach(boardvo.getPostNum());
		List<String> profileAttachList = signupService.getProfileAttach(boardvo.getWriter());
		model.addAttribute("profileAttachList",  profileAttachList);
		model.addAttribute("attachList", attachList);
		model.addAttribute("writer", boardvo.getWriter());

		List<CommentVO> commentList = writeService.getComments(postNum);
		for (CommentVO comment : commentList) {
			if (comment.getParentCommentId() == null) {
				comment.setDepth(0); // 부모(최상위)
			} else {
				comment.setDepth(1); // 자식(답글)
			}
		}
		model.addAttribute("commentList", commentList);

		// 상세보기 JSP로 이동
		return "getuseds/detailview";
	}
	



	// 게시글 삭제 처리
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String deleteContent(@RequestParam("postNum") Long postNum,
	                            @RequestParam("writer") String writer,
	                            HttpSession session, RedirectAttributes ra) {

	    // 인터셉터에서 로그인 체크가 끝났으므로 바로 꺼냄
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

	    // 작성자 본인만 삭제 가능 (권한 체크)
	    String currentUserId = loginUser.getUserId();
	    if (!currentUserId.equals(writer)) {
	        System.out.println("로그인한 사용자와 작성자 정보가 일치하지 않습니다.");
	        // 필요하다면 에러 메시지 전달
	        ra.addFlashAttribute("msg", "본인만 삭제할 수 있습니다.");
	        return "redirect:/boardview";
	    }

	    // 삭제 처리
	    writeService.deleteWrite(postNum);
	    System.out.println("게시글 삭제 완료했습니다.");
	    return "redirect:/boardview";
	}


	// 게시글 수정 페이지로 이동
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyContent(@RequestParam("postNum") Long postNum, HttpSession session, Model model,
								RedirectAttributes ra) {
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		BoardVO boardVO = writeService.textview(postNum);

		// 글 작성자와 로그인 사용자가 다른 경우
		if (!loginUser.getUserId().equals(boardVO.getWriter())) {
			System.out.println("글 수정은 해당 글의 작성한 회원만 가능합니다");
			return "redirect:/boardview";
		}

		// 수정 페이지로 이동
		model.addAttribute("boardVO", boardVO);
		return "getuseds/write";
	}

	// 게시글 수정 처리
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyContent(@ModelAttribute BoardVO boardvo,
	                            @RequestParam("file") MultipartFile[] file,
	                            HttpSession session, RedirectAttributes ra) {
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

	    // 1. 기존 게시글 정보 조회
	    BoardVO existingBoard = writeService.textview(boardvo.getPostNum());

	    // 2. 수정 권한(작성자 본인) 체크
	    if (!loginUser.getUserId().equals(existingBoard.getWriter())) {
	        throw new CustomException(ErrorCode.NO_PERMISSION, "작성자와 로그인 유저 불일치");
	    }
	    boardvo.setWriter(loginUser.getUserId());

	    // 3. 파일 업로드 처리
	    try {
	        List<String> filename = filedatautil.fileUpload(file);
	        if (filename != null && !filename.isEmpty()) {
	            boardvo.setFilename(filename);
	        }
	    } catch (Exception e) {
	        throw new CustomException(ErrorCode.UPLOAD_FAIL, e);
	    }

	    // 4. 게시글 수정
	    writeService.modifyWrite(boardvo);

	    // 5. 수정 후 상세보기로 리다이렉트
	    return "redirect:/boardview?postNum=" + boardvo.getPostNum();
	}



	@PostMapping("/commentWrite")
	@ResponseBody
	public Map<String, Object> saveCommentWrite(@ModelAttribute CommentVO commentvo,
	                                            @RequestParam("postNum") Long postNum,
	                                            HttpSession session) {
	    // 로그인 체크는 인터셉터에서 이미 끝났으므로 바로 사용
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    commentvo.setUserId(loginUser.getUserId());
	    commentvo.setPostNum(postNum);

	    // 댓글 계층 구조 처리
	    if (commentvo.getDepth() == null) commentvo.setDepth(0);
	    if (commentvo.getParentCommentId() == null || commentvo.getParentCommentId() == 0) {
	        commentvo.setParentCommentId(null);
	        commentvo.setDepth(0);
	    } else {
	        commentvo.setDepth(1);
	    }

	    Map<String, Object> result = new HashMap<>();
	    try {
	        writeService.addCommentWrite(commentvo);
	        result.put("success", true);
	    } catch (Exception e) {
	        result.put("success", false);
	        result.put("message", "댓글 등록 중 오류가 발생했습니다.");
	    }
	    return result;
	}

	
	// 댓글 목록 조회
	@GetMapping("/commentSection")
	public String getCommentList(@RequestParam Long postNum, Model model) {
		List<CommentVO> commentList = writeService.getComments(postNum);

		
		for (CommentVO comment : commentList) {
			if (comment.getParentCommentId() == null) {
				comment.setDepth(0); // 부모(최상위)
			} else {
				comment.setDepth(1); // 자식(답글)
			}
			
		}

		model.addAttribute("commentList", commentList);
		return "getuseds/commentSection";
	}

	// 댓글 삭제 처리
	@PostMapping("/deleteComment")
	@ResponseBody
	public Map<String, Object> deleteComment(@RequestParam("commentId") int commentId, HttpSession session) {
	    Map<String, Object> result = new HashMap<>();
	    // 로그인 체크는 인터셉터에서 이미 끝남
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

	    boolean deleteSuccess;
	    try {
	        // 본인 댓글만 삭제 가능하도록 userId 전달
	        deleteSuccess = writeService.deleteComment(commentId, loginUser.getUserId());
	    } catch (Exception e) {
	        throw new CustomException(ErrorCode.COMMENT_FAIL, e);
	    }
	    result.put("success", deleteSuccess);
	    result.put("message", deleteSuccess ? "댓글이 성공적으로 삭제되었습니다." : "댓글 삭제에 실패했습니다.");
	    return result;
	}


	// 댓글 수정 처리
	@PostMapping("/updateComment")
	@ResponseBody
	public Map<String, Object> updateComment(@RequestBody CommentVO commentvo) {
	    boolean success;
	    try {
	        if (commentvo.getDepth() == 0) {
	            success = writeService.updateComment(commentvo.getCommentId(), commentvo.getContent(), commentvo.getPostNum());
	        } else {
	            success = writeService.updateReply(commentvo.getCommentId(), commentvo.getContent(), commentvo.getPostNum());
	        }
	    } catch (Exception e) {
	        throw new CustomException(ErrorCode.COMMENT_FAIL, e);
	    }
	    Map<String, Object> result = new HashMap<>();
	    result.put("success", success);
	    result.put("message", success ? "댓글 수정이 완료되었습니다." : "댓글 수정에 실패했습니다.");
	    return result;
	}

	// 대댓글 작성 처리
	@PostMapping("/commentReply")
	@ResponseBody
	public Map<String, Object> saveCommentReply(@RequestBody CommentVO commentvo, HttpSession session) {
	    Map<String, Object> result = new HashMap<>();
	    // 로그인 체크는 인터셉터에서 이미 끝났으므로 바로 사용
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    System.out.println("parentCommentId(Controller): " + commentvo.getParentCommentId());

	    try {
	        commentvo.setUserId(loginUser.getUserId());
	        writeService.addCommentReply(commentvo);
	    } catch (Exception e) {
	        throw new CustomException(ErrorCode.REPLY_FAIL, e);
	    }
	    result.put("success", true);
	    result.put("message", "답글이 등록되었습니다.");
	    return result;
	}

	
	
	@GetMapping("/backToList")
	public String backBoard() {
		return "redirect:boardview";
	}
	
	@GetMapping("/mypage")
	public String showMyPage(HttpSession session, Model model, @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        System.out.println("세션에 로그인 정보가 없습니다.");
	        return "redirect:/index";
	    }

	    String userId = loginUser.getUserId();
	    if (userId == null) {
	        System.out.println("사용자 ID가 null입니다.");
	        return "redirect:/index";
	    }
	    System.out.println("세션에서 가져온 사용자 ID: " + userId);
	    
	    List<String> profileAttachList = signupService.getProfileAttach(userId);

	    int totalViews = writeService.viewtotal(userId);
	    System.out.println("사용자 " + userId + "의 총 조회수: " + totalViews);

	    int likestotal = writeService.likestotal(userId);
	    System.out.println("사용자 " + userId + "의 좋아요 수: " + likestotal);

	    model.addAttribute("profileAttachList", profileAttachList);
	    model.addAttribute("totalview", totalViews);
	    model.addAttribute("totallikes", likestotal);

	    if (page < 1) {
	        return "redirect:/mypage?page=1";
	    }
	    System.out.println("요청된 페이지: " + page);
	    List<BoardVO> pagingList = writeService.likeboard(userId, page);
	    System.out.println("페이징 리스트 크기: " + pagingList.size());

	    int pageLimit = 3;
	    int totalLikes = writeService.clicklikes(userId);
	    int maxPage = (int) Math.ceil((double) totalLikes / pageLimit);
	    int startPage = ((page - 1) / 5) * 5 + 1;
	    int endPage = Math.min(startPage + 4, maxPage);

	    PageVO pagevo = new PageVO();
	    pagevo.setPage(page);
	    pagevo.setMaxPage(maxPage);
	    pagevo.setStartPage(startPage);
	    pagevo.setEndPage(endPage);

	    if (maxPage < 1) {
	        System.out.println("경고: maxPage가 1보다 작습니다");
	        pagevo.setMaxPage(1);
	        pagevo.setStartPage(1);
	        pagevo.setEndPage(1);
	    }

	    model.addAttribute("likesdata", pagingList);
	    model.addAttribute("paginglike", pagevo);

	    return "mypage";
	}
	
	@GetMapping("/")
	public String pagingindex(Model model, @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		if (page < 1) {
			return "redirect:/paging?page=1"; // ������ ��ȣ ��ȿ�� üũ
		}
		
		List<BoardVO> pagingList = writeService.pagingList(page);
		
		model.addAttribute("contentlist", pagingList);
		
		int pageSize = 10; // 한 페이지에 보여줄 뉴스 개수
        
        // 해당 페이지의 뉴스 목록 조회
        List<NewsVO> newsList = newsService.get2025ItNews(page, pageSize);
        // 모델에 뉴스 목록과 페이지 정보 추가
        model.addAttribute("newsList", newsList);
		
		return "index";
	}
	
	@Inject
    private NewsService newsService;

    @GetMapping("/itNews")
    public String showItNews(Model model,
                             // page 파라미터를 받아옴, 없으면 기본값 1
                             @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        System.out.println("=== IT뉴스 컨트롤러 진입 ===");
        int pageSize = 10; // 한 페이지에 보여줄 뉴스 개수
        int totalCount = newsService.getTotalNewsCount(); // 전체 뉴스 개수 조회
        System.out.println("전체 뉴스 개수: " + totalCount);
        
        // 데이터가 없으면 자동으로 수집
        if (totalCount == 0) {
            newsService.fetchAndSaveNews();
            totalCount = newsService.getTotalNewsCount(); // 수집 후 다시 조회
        }
        
        int maxPage = (int) Math.ceil((double) totalCount / pageSize); // 전체 페이지 수 계산
        int startPage = ((page - 1) / 10) * 10 + 1; // 페이지 네비게이션의 시작 페이지 (1~10, 11~20 등)
        int endPage = Math.min(startPage + 9, maxPage); // 페이지 네비게이션의 끝 페이지

        // 페이지 정보를 담을 PageVO 객체 생성 및 값 설정
        PageVO pagevo = new PageVO();
        pagevo.setPage(page);
        pagevo.setMaxPage(maxPage);
        pagevo.setStartPage(startPage);
        pagevo.setEndPage(endPage);

        // 해당 페이지의 뉴스 목록 조회
        List<NewsVO> newsList = newsService.get2025ItNews(page, pageSize);
        // 모델에 뉴스 목록과 페이지 정보 추가
        model.addAttribute("newsList", newsList);
        model.addAttribute("paging", pagevo);
        return "getuseds/itNews";
    }

    // 전체 뉴스 목록 페이지 요청을 처리하는 메서드
    @GetMapping("/news")
    public String showNews(Model model,
                           // page 파라미터를 받아옴, 없으면 기본값 1
                           @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        int pageSize = 10; // 한 페이지에 보여줄 뉴스 개수
        int totalCount = newsService.getTotalNewsCount(); // 전체 뉴스 개수 조회
        int maxPage = (int) Math.ceil((double) totalCount / pageSize); // 전체 페이지 수 계산
        int startPage = ((page - 1) / 10) * 10 + 1; // 페이지 네비게이션의 시작 페이지
        int endPage = Math.min(startPage + 9, maxPage); // 페이지 네비게이션의 끝 페이지

        PageVO pagevo = new PageVO();
        pagevo.setPage(page);
        pagevo.setMaxPage(maxPage);
        pagevo.setStartPage(startPage);
        pagevo.setEndPage(endPage);

        // 해당 페이지의 뉴스 목록 조회
        List<NewsVO> newsList = newsService.get2025ItNews(page, pageSize);
        // 모델에 뉴스 목록과 페이지 정보 추가
        model.addAttribute("newsList", newsList);
        model.addAttribute("paging", pagevo);
        return "getuseds/itNews";
    }

    @GetMapping("/userdelete")
    public String deletemember(HttpSession session, RedirectAttributes ra) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            System.out.println("사용자 정보 없음. 로그인하세요.");
            ra.addFlashAttribute("message", "로그인이 필요합니다.");
            return "redirect:/";
        }
        try {
            String userId = loginUser.getUserId();
            writeService.deletemember(userId);
            session.invalidate();
            ra.addFlashAttribute("message", "회원 탈퇴가 완료되었습니다.");
            return "redirect:/";
        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("message", "회원 탈퇴 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/mypage";
        }
    }
}
