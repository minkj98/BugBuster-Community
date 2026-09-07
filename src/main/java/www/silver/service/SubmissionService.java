package www.silver.service;

import www.silver.vo.SubmissionVO;

public interface SubmissionService {
    void saveSubmission(SubmissionVO submission);
    String gradeSubmission(String code, String problemDescription, String language);
}