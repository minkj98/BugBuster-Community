package www.silver.service;

import org.springframework.stereotype.Service;

import www.silver.client.SubmissionGrader;
import www.silver.dao.SubmissionDAO;
import www.silver.vo.SubmissionVO;

import javax.inject.Inject;

@Service
public class SubmissionServiceImpl implements SubmissionService {

    @Inject
    private SubmissionDAO submissionDAO;

    /** 외부 채점기 (Gemini 등) */
    @Inject
    private SubmissionGrader submissionGrader;

    @Override
    public void saveSubmission(SubmissionVO submission) {
        submissionDAO.saveSubmission(submission);
    }

    @Override
    public String gradeSubmission(String code, String problemDescription, String language) {
        return submissionGrader.grade(code, problemDescription, language);
    }
}
