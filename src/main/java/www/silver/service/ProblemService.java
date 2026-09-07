package www.silver.service;

import www.silver.vo.ProblemVO;

import java.util.List;
import java.util.Map;

public interface ProblemService {
    List<ProblemVO> getAllProblems();
    List<ProblemVO> getProblemsByLanguageAndDifficulty(String language, String difficulty);
    ProblemVO getProblemById(int problemId);
}