package www.silver.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import www.silver.dao.ProblemDAO;
import www.silver.vo.ProblemVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProblemServiceImpl implements ProblemService {
    @Autowired
    private ProblemDAO problemDAO;

    @Override
    public List<ProblemVO> getAllProblems() {
        return problemDAO.getAllProblems();
    }

    @Override
    public List<ProblemVO> getProblemsByLanguageAndDifficulty(String language, String difficulty) {
        Map<String, String> params = new HashMap<>();
        params.put("language", language);
        params.put("difficulty", difficulty);
        return problemDAO.getProblemsByLanguageAndDifficulty(params);
    }

    @Override
    public ProblemVO getProblemById(int problemId) {
        return problemDAO.getProblemById(problemId);
    }
}