package www.silver.batch;

import javax.inject.Inject;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecutionListener;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableBatchProcessing
public class NewsUpdateBatch {

	@Inject
	private JobBuilderFactory jobBuilderFactory; // Spring Batch Job 빌더

	@Inject
	private StepBuilderFactory stepBuilderFactory; // Spring Batch Step 빌더

	@Inject
	private NewsUpdateTasklet ITnewsUpdateTasklet; // 실제 뉴스 업데이트 로직이 구현된 Tasklet

	// IT 뉴스 업데이트 배치 Job을 Bean으로 등록
	// "ITnewsUpdateJob"이라는 이름으로 Job을 생성
	// RunIdIncrementer를 사용하여 매 실행마다 고유한 Job 인스턴스 ID를 부여
	// ITnewsUpdateStep을 첫 번째 Step으로 등록
	@Bean
	public Job ITnewsUpdateJob(JobBuilderFactory jbf, Step ITnewsUpdateStep) {
	    return jbf.get("ITnewsUpdateJob")         
	              .incrementer(new RunIdIncrementer())
	              .start(ITnewsUpdateStep)         // 뉴스 수집 Tasklet
	              .build();
	}



	// IT 뉴스 업데이트를 수행하는 Step을 Bean으로 등록
	// "ITnewsUpdateStep"이라는 이름으로 Step을 생성
	// ITnewsUpdateTasklet을 실행하여 실제 뉴스 수집 및 저장 로직을 처리
	@Bean
	public Step ITnewsUpdateStep() {
		return stepBuilderFactory.get("ITnewsUpdateStep").tasklet(ITnewsUpdateTasklet).build();
	}
}
