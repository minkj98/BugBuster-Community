package www.silver.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import www.silver.dao.NewsDAO;
import www.silver.vo.NewsVO;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 뉴스 수집 서비스 구현체. 네이버 뉴스 검색 Open API를 호출해 IT-뉴스를 수집-가공-저장한다.
 *
 * Spring Batch에서는 Reader → Processor → Writer 역할을 한 메서드(fetchAndSaveNews)에서
 * 순차적으로 수행한다.
 */
@Service
public class NewsServiceImpl implements NewsService {

	/* =========================== DI 영역 =========================== */

	/** News DAO 주입 */
	@Inject
	private NewsDAO newsDAO;

	/** 네이버 API Client-Id (applicationContext.xml에서 주입) */
	@Value("#{naverApiConfig['naver.client.id']}")
	private String clientId;

	/** 네이버 API Client-Secret */
	@Value("#{naverApiConfig['naver.client.secret']}")
	private String clientSecret;

	@PostConstruct
	public void init() {
		System.out.println("Client ID        : " + clientId + " (length=" + clientId.length() + ")");
		System.out.println("Client Secret    : " + clientSecret + " (length=" + clientSecret.length() + ")");
	}

	/**
	 * 키워드 배열을 돌면서 API를 호출하고, 2025년에 발행된 뉴스만 DB에 저장한다. Reader → API 호출 Processor →
	 * JSON 파싱 & 도메인 매핑 Writer → DB insert
	 */
	@Override
	public void fetchAndSaveNews() {
		System.out.println("fetchAndSaveNews() 호출!");

		/* -------- Step Reader 설정 -------- */
		// 뉴스 검색 키워드 목록
		String[] keywords = {
				// AI / 데이터 
				"인공지능", "생성형 AI", "대규모 언어 모델", "머신러닝", "딥러닝", "Agentic AI", "AI 거버넌스", "AI 가속기", "GPU", "NPU", "TPU",
				"빅데이터 분석", "MLOps", "엣지 AI", "디지털 트윈",  "클라우드 데이터 센터", "분산 AI", "디지털 트랜스포메이션",

				// 클라우드 / 인프라 
				"클라우드 컴퓨팅", "멀티클라우드", "엣지 컴퓨팅", "서버리스", "쿠버네티스", "도커", "DevOps", "CI/CD", "마이크로서비스", "데이터 센터", "SDN",
				"SD-WAN", "NFV",

				// 보안 
				"정보보안", "사이버 보안", "클라우드 보안", "해킹", "랜섬웨어", "제로트러스트", "사이버 공격", "데이터 유출", "AIOps",
				"Post-Quantum Cryptography", "Zero-Knowledge Proof", "데이터 프라이버시",

				/* 블록체인 / Web3 */
				"블록체인", "Web3", "NFT", "암호화폐", "스테이블코인",

				/* 하드웨어 / 네트워킹 */
				"양자 컴퓨팅", "Post-Quantum Security", "FPGA", "RISC-V", "칩셋", "슈퍼컴퓨팅", "HPC", "5G", "6G", "위성 인터넷",
				"Starlink", "LoRa", "와이파이 7",

				/* XR / 메타버스 */
				"메타버스", "가상현실", "증강현실", "혼합현실", "Spatial Computing",

				/* 로봇 / 자동화 */
				"로봇공학", "산업용 로봇", "협동로봇", "AMR", "RPA", "로봇 프로세스 자동화", "자율주행",

				/* 개발 생태계 */
				"사물 인터넷", "IoT 보안", "프로그래밍 언어", "오픈소스", "백엔드", "프런트엔드", "로우코드", "노코드", "웹어셈블리",
				"앱 개발", "게임 개발", "웹 개발",

				// 산업·정책 
				"핀테크", "모바일 결제", "간편결제", "디지털 전환", "ESG 기술", "그린 IT",

				// 국내 특화
				"K-테크", "삼성 SDS", "LG CNS", "SK C&C", "전자정부", "클라우드 규제", "K-스마트시티",
				
				// 개발자 이벤트
				"개발자 컨퍼런스", "개발자 세미나", "개발자 밋업", "해커톤", 
				"코딩 부트캠프", "개발자 워크샵", "테크톤",

				// 국내 기업 개발자 이벤트
				"NAVER DEVIEW", "토스 SLASH", "삼성 개발자 컨퍼런스", 
				"카카오 개발자 컨퍼런스", "라인 개발자 데이", "쿠팡 개발자 컨퍼런스",
				"우아한테크세미나", "NHN 포워드", "LG CNS 개발자 데이"

				
		};

		/* -------- Step Reader 설정 끝 -------- */

		for (String keyword : keywords) {

			/* -------- Step Reader 처리 -------- */
			// 네이버 API 호출 → JSON 수신
			String json = callNaverNewsApi(keyword);
			System.out.println("네이버 API 응답(JSON) : " + json);
			/* -------- Step Reader 처리 끝 -------- */

			/* -------- Step Processor 처리 -------- */
			// JSON → List<NewsVO> 변환
			List<NewsVO> newsList = parseNewsJson(json, keyword);
			/* -------- Step Processor 처리 끝 -------- */

			for (NewsVO news : newsList) {

				/* --- Step Processor 후속 필터링 --- */
				// 2025년 뉴스만 저장
				if (news.getPubDate() != null && news.getPubDate().toString().startsWith("2025")) {

					/* -------- Step Writer 처리 -------- */
					// DB INSERT
					newsDAO.insertNews(news);
					/* -------- Step Writer 처리 끝 -------- */
				}
			}
		}
		System.out.println("fetchAndSaveNews() 종료!");
	}

	/* ========================== 조회 로직 ========================== */

	/** 2025년 IT-뉴스를 페이지 단위로 조회 */
	@Override
	public List<NewsVO> get2025ItNews(int page, int pageSize) {
		int start = (page - 1) * pageSize;
		return newsDAO.select2025ItNews(start, pageSize);
	}

	/** 전체 뉴스 건수 조회 */
	@Override
	public int getTotalNewsCount() {
		return newsDAO.selectTotalNewsCount();
	}

	/* ======================= 내부 헬퍼 메서드 ======================= */

	/* ------------------------- Reader 역할 ------------------------- */
	/**
	 * 네이버 뉴스 검색 Open API 호출 후 응답 JSON 문자열을 반환한다.
	 */
	private String callNaverNewsApi(String keyword) {
		try {
			System.out.println("[API 호출] 키워드: " + keyword);

			/* 1) 쿼리 파라미터 인코딩 */
			String text = URLEncoder.encode(keyword, "UTF-8");

			/* 2) 요청 URL 구성 */
			String apiURL = "https://openapi.naver.com/v1/search/news.json" + "?query=" + text + "&display=100"
					+ "&sort=date";
			System.out.println("요청 URL: " + apiURL);

			/* 3) HTTP 연결 */
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");

			/* 4) 인증 헤더 추가 */
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);

			/* 5) 응답 코드 확인 및 스트림 선택 */
			int responseCode = con.getResponseCode();
			System.out.println("응답 코드: " + responseCode);

			InputStream is = (responseCode == 200) ? con.getInputStream() : con.getErrorStream();

			/* 6) 응답 Body 읽기 */
			BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null)
				sb.append(line);
			br.close();

			return sb.toString();
		} catch (Exception e) {
			System.err.println("API 호출 중 예외 발생");
			e.printStackTrace();
			return null;
		}
	}

	/* ------------------------ Processor 역할 ----------------------- */
	/**
	 * 네이버 뉴스 JSON을 파싱하여 도메인 객체(NewsVO) 리스트로 변환한다.
	 */
	private List<NewsVO> parseNewsJson(String json, String keyword) {
		List<NewsVO> newsList = new ArrayList<>();

		try {
			ObjectMapper mapper = new ObjectMapper();
			JsonNode root = mapper.readTree(json);
			JsonNode items = root.path("items");

			// 네이버 API 날짜 포맷 예) "Fri, 20 Jun 2025 09:30:00 +0900"
			SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z", Locale.ENGLISH);

			for (JsonNode item : items) {
				NewsVO news = new NewsVO();

				news.setTitle(item.path("title").asText());
				news.setOriginallink(item.path("originallink").asText());
				news.setLink(item.path("link").asText());
				news.setDescription(item.path("description").asText());

				// 게시 날짜 파싱
				String pubDateStr = item.path("pubDate").asText();
				Date date = sdf.parse(pubDateStr);
				news.setPubDate(new Timestamp(date.getTime()));

				// 검색 키워드 → 카테고리, 쿼리 컬럼에 저장
				news.setQuery(keyword);
				news.setCategory(keyword);

				newsList.add(news);
			}
		} catch (Exception e) {
			System.err.println("JSON 파싱 중 예외 발생");
			e.printStackTrace();
		}
		return newsList;
	}
}
