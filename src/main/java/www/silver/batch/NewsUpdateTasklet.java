package www.silver.batch;

import java.time.LocalDateTime;

import javax.inject.Inject;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.stereotype.Component;

import www.silver.service.NewsService;

@Component
public class NewsUpdateTasklet implements Tasklet {

	@Inject
	private NewsService newsService;

	// 배치 Step에서 실행되는 메서드
	// 실행 시작/완료 시각, 작업 ID 등을 로그로 출력
	// 예외 발생 시 로그를 출력하고, 예외를 다시 던져 Spring Batch가 실패로 인식하게 함
	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {

		System.out.println("=== 뉴스 업데이트 시작 ===");
		System.out.println("시작 시간: " + LocalDateTime.now());
		System.out.println("작업 배치 ID: " + chunkContext.getStepContext().getJobName());

		try {
			// 외부 API를 호출하여 최신 뉴스 데이터 수집
			System.out.println("뉴스 데이터 수집 - 외부 API 호출 예정");

			// Reader + Processor + Writer 역할을 서비스 계층에서 처리
			newsService.fetchAndSaveNews();

			System.out.println("=== 뉴스 업데이트 완료 ===");
			System.out.println("완료 시간: " + LocalDateTime.now());
		} catch (Exception e) {
			// 예외 발생 시 로그 출력 및 예외 재전파
			System.err.println("=== 뉴스 업데이트 중 오류 발생 ===");
			System.err.println("오류 메시지: " + e.getMessage());
			System.err.println("오류 발생 시간: " + LocalDateTime.now());
			e.printStackTrace();

			// Spring Batch가 실패로 인식하도록 예외 재전파
			throw e;
		}

		// 작업이 정상적으로 끝났음을 알림
		return RepeatStatus.FINISHED;
	}
}
