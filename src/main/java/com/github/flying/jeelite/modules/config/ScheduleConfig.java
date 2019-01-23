package com.github.flying.jeelite.modules.config;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

/**
 * 定时任务配置
 *
 */
@Configuration
public class ScheduleConfig {
	@Bean
	public SchedulerFactoryBean schedulerFactoryBean(DataSource dataSource) {
		SchedulerFactoryBean factory = new SchedulerFactoryBean();
		factory.setDataSource(dataSource);
		factory.setConfigLocation(new ClassPathResource("quartz.properties"));
		factory.setSchedulerName("JeeliteScheduler");
		// 延时启动
		factory.setStartupDelay(30);
		factory.setApplicationContextSchedulerContextKey("applicationContext");
		// 可选，QuartzScheduler启动时更新己存在的Job，这样就不用每次修改targetObject后删除qrtz_job_details表对应记录了
		factory.setOverwriteExistingJobs(true);

		return factory;
	}
}