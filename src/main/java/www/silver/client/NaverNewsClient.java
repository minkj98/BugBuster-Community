package www.silver.client;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import www.silver.vo.NewsVO;

import javax.inject.Inject;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/**
 * 네이버 뉴스 검색 Open API 어댑터.
 *
 * <p>HTTP 호출과 네이버 응답 JSON 파싱을 캡슐화한다. 네이버 API의 요청/응답 형식에 대한 지식은
 * 이 클래스 밖으로 새어 나가지 않는다.
 */
@Component
public class NaverNewsClient implements NewsProvider {

    /** 네이버 API Client-Id (config.properties에서 로드) */
    @Value("#{naverApiConfig['naver.client.id']}")
    private String clientId;

    /** 네이버 API Client-Secret */
    @Value("#{naverApiConfig['naver.client.secret']}")
    private String clientSecret;

    /** JSON 파서 (root-context.xml objectMapper 빈) */
    @Inject
    private ObjectMapper objectMapper;

    @Override
    public List<NewsVO> fetchNews(String keyword) {
        String json = callApi(keyword);
        return parse(json, keyword);
    }

    /**
     * 네이버 뉴스 검색 Open API 호출 후 응답 JSON 문자열을 반환한다.
     */
    private String callApi(String keyword) {
        try {
            String text = URLEncoder.encode(keyword, "UTF-8");
            String apiURL = "https://openapi.naver.com/v1/search/news.json"
                    + "?query=" + text + "&display=100&sort=date";

            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);

            int responseCode = con.getResponseCode();
            InputStream is = (responseCode == 200) ? con.getInputStream() : con.getErrorStream();

            BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            br.close();

            return sb.toString();
        } catch (Exception e) {
            System.err.println("네이버 뉴스 API 호출 중 예외 발생 (keyword=" + keyword + ")");
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 네이버 뉴스 JSON을 파싱하여 도메인 객체(NewsVO) 리스트로 변환한다.
     */
    private List<NewsVO> parse(String json, String keyword) {
        List<NewsVO> newsList = new ArrayList<>();
        if (json == null) {
            return newsList;
        }

        try {
            JsonNode root = objectMapper.readTree(json);
            JsonNode items = root.path("items");

            // 네이버 API 날짜 포맷 예) "Fri, 20 Jun 2025 09:30:00 +0900"
            SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z", Locale.ENGLISH);

            for (JsonNode item : items) {
                NewsVO news = new NewsVO();
                news.setTitle(item.path("title").asText());
                news.setOriginallink(item.path("originallink").asText());
                news.setLink(item.path("link").asText());
                news.setDescription(item.path("description").asText());

                String pubDateStr = item.path("pubDate").asText();
                Date date = sdf.parse(pubDateStr);
                news.setPubDate(new Timestamp(date.getTime()));

                // 검색 키워드 → 카테고리, 쿼리 컬럼에 저장
                news.setQuery(keyword);
                news.setCategory(keyword);

                newsList.add(news);
            }
        } catch (Exception e) {
            System.err.println("네이버 뉴스 JSON 파싱 중 예외 발생");
            e.printStackTrace();
        }
        return newsList;
    }
}
