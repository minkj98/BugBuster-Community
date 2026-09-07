package www.silver.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import www.silver.client.NewsProvider;
import www.silver.dao.NewsDAO;
import www.silver.vo.NewsVO;

import java.util.List;

/**
 * 뉴스 수집 서비스 구현체. 외부 뉴스 제공자({@link NewsProvider})로부터 IT-뉴스를 수집해 필터링 후 저장한다.
 *
 * <p>Spring Batch에서는 Reader → Processor → Writer 역할을 fetchAndSaveNews 한 메서드에서
 * 순차적으로 수행한다. 실제 API 호출/파싱은 {@link NewsProvider} 구현체가 담당한다.
 */
@Service
public class NewsServiceImpl implements NewsService {

	/** News DAO 주입 */
	@Inject
	private NewsDAO newsDAO;

	/** 외부 뉴스 제공자 (네이버 등) */
	@Inject
	private NewsProvider newsProvider;

	/**
	 * 키워드 배열을 돌면서 뉴스를 수집하고, 2025년에 발행된 뉴스만 DB에 저장한다.
	 */
	@Override
	public void fetchAndSaveNews() {
		System.out.println("fetchAndSaveNews() 호출!");

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

		for (String keyword : keywords) {

			// Reader + Processor: 외부 제공자가 API 호출 + JSON 파싱까지 수행
			List<NewsVO> newsList = newsProvider.fetchNews(keyword);

			for (NewsVO news : newsList) {

				// Processor 후속 필터링: 2025년 뉴스만 저장
				if (news.getPubDate() != null && news.getPubDate().toString().startsWith("2025")) {

					// Writer: DB INSERT
					newsDAO.insertNews(news);
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
}
