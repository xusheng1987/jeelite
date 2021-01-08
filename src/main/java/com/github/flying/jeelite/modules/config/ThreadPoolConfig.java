package com.github.flying.jeelite.modules.config;

import java.util.concurrent.ThreadPoolExecutor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

/**
 * 线程池配置
 *
 */
@Configuration
public class ThreadPoolConfig {

	@Bean("taskExecutor")
    public TaskExecutor taskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(10);//核心线程数
        executor.setMaxPoolSize(20);//最大线程数
        executor.setQueueCapacity(200);//缓冲队列容量
        executor.setKeepAliveSeconds(60);//允许线程空闲的时间60秒：当超过了核心线程之外的线程在空闲时间到达之后会被销毁
        executor.setWaitForTasksToCompleteOnShutdown(true);//线程池关闭的时候等待所有任务都完成
        executor.setAwaitTerminationSeconds(60);//设置线程池关闭时，线程池中任务的等待时间，如果超过这个时间任务还没有关闭就强制关闭
        executor.setThreadNamePrefix("taskExecutor-");//线程池名的前缀
        executor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());//拒绝策略
        return executor;
    }
}