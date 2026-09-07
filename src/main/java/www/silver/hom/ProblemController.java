package www.silver.hom;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.silver.service.ProblemService;
import www.silver.service.SubmissionService;
import www.silver.vo.MemberVO;
import www.silver.vo.ProblemVO;
import www.silver.vo.SubmissionVO;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ProblemController {

    @Inject
    private ProblemService problemService;

    @Inject
    private SubmissionService submissionService;

    private static final List<String> SUPPORTED_LANGUAGES = Arrays.asList(
        "Python", "JavaScript", "Java", "C++", "C", "C#", "TypeScript", "Go", "Rust", "Swift", "Kotlin", "PHP", "Ruby", "Dart", "R", "Julia"
    );

    @GetMapping("/problems")
    public String listProblems(HttpSession session, RedirectAttributes ra,
            @RequestParam(value = "language", required = false, defaultValue = "") String language,
            @RequestParam(value = "difficulty", required = false, defaultValue = "") String difficulty,
            Model model) {
        model.addAttribute("problemList", problemService.getProblemsByLanguageAndDifficulty(language, difficulty));
        model.addAttribute("language", language);
        model.addAttribute("difficulty", difficulty);
        Map<String, Object> result = new HashMap<>();
        
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
           ra.addFlashAttribute("message", "로그인 상태에서 문제풀기를 할 수 있습니다.");
           return "redirect:/";
        }
        return "/getuseds/problemList"; // problemList.jsp로 매핑
    }

    @GetMapping("/problem")
    public String showProblem(@RequestParam("id") int problemId, Model model) {
        System.out.println("Received problemId: " + problemId); // 디버깅용 로그
        ProblemVO problem = problemService.getProblemById(problemId);
        if (problem == null) {
            throw new IllegalArgumentException("문제 ID " + problemId + "에 해당하는 문제가 없습니다.");
        }
        String language = problem.getLanguage();
        boolean languageSupported = SUPPORTED_LANGUAGES.contains(language);
        model.addAttribute("problem", problem);
        model.addAttribute("languageSupported", languageSupported);
        return "/getuseds/problem"; // problem.jsp로 매핑
    }

    @PostMapping("/submitSolution")
    public String submitSolution(@RequestParam("problemId") int problemId,
                                @RequestParam("code") String code,
                                @RequestParam("language") String language,
                                HttpSession session,
                                Model model) {
        ProblemVO problem = problemService.getProblemById(problemId);
        String feedback = submissionService.gradeSubmission(code, problem.getDescription(), language);

        MemberVO id = (MemberVO) session.getAttribute("loginUser");
        if (id == null) {
            throw new IllegalStateException("로그인 정보가 없습니다.");
        }

        SubmissionVO submission = new SubmissionVO();
        submission.setUserId(id.getUserId());
        submission.setProblemId(problemId);
        submission.setCode(code);
        submission.setLanguage(language);
        submission.setFeedback(feedback);
        submission.setCorrect(feedback.startsWith("Correct"));

        submissionService.saveSubmission(submission);

        model.addAttribute("problem", problem);
        model.addAttribute("feedback", feedback);
        model.addAttribute("isCorrect", submission.isCorrect());
        model.addAttribute("submittedCode", code); // 제출된 코드 유지
        return "/getuseds/problem"; // 피드백과 함께 problem.jsp로 반환
    }
}