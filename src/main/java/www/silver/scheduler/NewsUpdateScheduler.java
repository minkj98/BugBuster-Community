package www.silver.scheduler;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.inject.Inject;
import java.time.LocalDateTime;

@Component
@EnableScheduling
public class NewsUpdateScheduler {

    @Inject private JobLauncher jobLauncher;

    /* ① 뉴스 수집 Job  (ITnewsUpdateJob) */
    @Inject private Job ITnewsUpdateJob;

    

    /* -------------------- 스케줄 -------------------- */

    /** 매일 10:00  뉴스 수집 */
    @Scheduled(cron = "0 26 09 * * *")
    public void runCollectJob() {
        launch(ITnewsUpdateJob, "뉴스 수집");
    }

   

    /* ----------------- 공통 실행 로직 ---------------- */

    private void launch(Job job, String name) {
        try {
            JobParameters params = new JobParametersBuilder()
                    .addLong("time", System.currentTimeMillis())   // 항상 새로운 인스턴스
                    .toJobParameters();

            System.out.printf("=== [%s] Job 시작 : %s%n", name, LocalDateTime.now());
            jobLauncher.run(job, params);
            System.out.printf("=== [%s] Job 완료 : %s%n", name, LocalDateTime.now());

        } catch (Exception e) {
            System.err.printf("=== [%s] Job 실패 : %s%n", name, e.getMessage());
            e.printStackTrace();
        }
    }
}
