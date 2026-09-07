package www.silver.dao;

import www.silver.vo.ProblemVO;

import java.util.List;
import java.util.Map;

public interface ProblemDAO {
    List<ProblemVO> getAllProblems();
    List<ProblemVO> getProblemsByLanguageAndDifficulty(Map<String, String> params);
    ProblemVO getProblemById(int problemId);
}