package www.silver.client;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Google Gemini API 기반 채점기 어댑터.
 *
 * <p>Gemini 요청 본문 구성과 응답 파싱을 캡슐화한다. Gemini API 형식에 대한 지식은 이 클래스 밖으로
 * 새어 나가지 않는다.
 */
@Component
public class GeminiCodeGrader implements SubmissionGrader {

    private static final String ENDPOINT =
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";

    /** Gemini API 키 (config.properties의 gemini.api.key) */
    @Value("${gemini.api.key:}")
    private String apiKey;

    /** root-context.xml restTemplate 빈 */
    @Inject
    private RestTemplate restTemplate;

    @Override
    @SuppressWarnings("unchecked")
    public String grade(String code, String problemDescription, String language) {
        String prompt = "다음은 코딩 문제입니다: " + problemDescription + "\n\n" +
                "사용자가 제출한 솔루션은 " + language + " 언어로 작성되었습니다:\n" + code + "\n\n" +
                "이 솔루션이 정확한지 확인해 주세요. 정확하다면 응답을 'Correct'로 시작하고, 그렇지 않다면 'Incorrect'로 시작한 후 피드백을 제공하세요.";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");

        Map<String, String> partMap = new HashMap<>();
        partMap.put("text", prompt);
        List<Map<String, String>> partsList = new ArrayList<>();
        partsList.add(partMap);
        Map<String, Object> contentMap = new HashMap<>();
        contentMap.put("parts", partsList);
        List<Map<String, Object>> contentsList = new ArrayList<>();
        contentsList.add(contentMap);
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("contents", contentsList);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
        try {
            String url = ENDPOINT + "?key=" + apiKey;
            ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);

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
