package www.silver.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import www.silver.dao.SubmissionDAO;
import www.silver.vo.SubmissionVO;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SubmissionServiceImpl implements SubmissionService {
    @Inject
    private SubmissionDAO submissionDAO;

    private final RestTemplate restTemplate = new RestTemplate();

    private String apiKey = "AIzaSyAxfZZisd9-XKV5UUEIBjyGp9R2v4sFWcI"; // 실제 API 키로 교체

    @Override
    public void saveSubmission(SubmissionVO submission) {
        submissionDAO.saveSubmission(submission);
    }

    @Override
    public String gradeSubmission(String code, String problemDescription, String language) {
        System.out.println("로드된 API 키: " + apiKey);
        String prompt = "다음은 코딩 문제입니다: " + problemDescription + "\n\n" +
                "사용자가 제출한 솔루션은 " + language + " 언어로 작성되었습니다:\n" + code + "\n\n" +
                "이 솔루션이 정확한지 확인해 주세요. 정확하다면 응답을 'Correct'로 시작하고, 그렇지 않다면 'Incorrect'로 시작한 후 피드백을 제공하세요.";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");

        Map<String, Object> requestBody = new HashMap<>();
        List<Map<String, Object>> contentsList = new ArrayList<>();
        Map<String, Object> contentMap = new HashMap<>();
        List<Map<String, String>> partsList = new ArrayList<>();
        Map<String, String> partMap = new HashMap<>();
        partMap.put("text", prompt);
        partsList.add(partMap);
        contentMap.put("parts", partsList);
        contentsList.add(contentMap);
        requestBody.put("contents", contentsList);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
        try {
            String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + apiKey;
            ResponseEntity<Map> response = restTemplate.exchange(
                    url,
                    HttpMethod.POST,
                    entity,
                    Map.class
            );
            Map<String, Object> responseBody = response.getBody();
            if (responseBody != null && responseBody.containsKey("candidates")) {
                List<Map<String, Object>> candidates = (List<Map<String, Object>>) responseBody.get("candidates");
                if (!candidates.isEmpty()) {
                    Map<String, Object> candidate = candidates.get(0);
                    Map<String, Object> content = (Map<String, Object>) candidate.get("content");
                    List<Map<String, String>> parts = (List<Map<String, String>>) content.get("parts");
                    if (!parts.isEmpty()) {
                        return parts.get(0).get("text");
                    }
                }
            }
            return "오류: Gemini API에서 응답을 가져올 수 없습니다.";
        } catch (HttpClientErrorException e) {
            System.err.println("Gemini API 오류: " + e.getResponseBodyAsString());
            throw e;
        }
    }
}