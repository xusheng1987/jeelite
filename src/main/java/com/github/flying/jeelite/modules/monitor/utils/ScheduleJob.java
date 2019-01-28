package com.github.flying.jeelite.modules.monitor.utils;

import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.quartz.DisallowConcurrentExecution;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.github.flying.jeelite.common.utils.SpringContextHolder;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.modules.monitor.dao.JobLogDao;
import com.github.flying.jeelite.modules.monitor.entity.Job;
import com.github.flying.jeelite.modules.monitor.entity.JobLog;

/**
 * 定时任务
 *
 */
@DisallowConcurrentExecution // 不允许并发执行
public class ScheduleJob extends QuartzJobBean {
	private Logger logger = LoggerFactory.getLogger(getClass());
	private ExecutorService service = Executors.newSingleThreadExecutor();

	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		Job job = (Job) context.getMergedJobDataMap().get(Job.JOB_PARAM_KEY);

		// 获取spring bean
		JobLogDao jobLogDao = SpringContextHolder.getBean(JobLogDao.class);

		// 数据库保存执行记录
		JobLog log = new JobLog();
		log.setJobId(job.getId());
		log.setBeanName(job.getBeanName());
		log.setMethodName(job.getMethodName());
		log.setParams(job.getParams());
		log.setCreateDate(new Date());

		// 任务开始时间
		long startTime = System.currentTimeMillis();
		try {
			// 执行任务
			ScheduleRunnable task = new ScheduleRunnable(job.getBeanName(), job.getMethodName(), job.getParams());
			Future<?> future = service.submit(task);

			future.get();
			// 任务状态 0：成功 1：失败
			log.setStatus("0");
		} catch (Exception e) {
			logger.error("任务执行失败，任务ID：" + job.getId(), e);
			// 任务状态 0：成功 1：失败
			log.setStatus("1");
			log.setErrorInfo(StringUtils.substring(e.toString(), 0, 2000));
		} finally {
			// 任务执行总时长
			Long costTime = System.currentTimeMillis() - startTime;
			log.setCostTime(costTime.intValue());
			jobLogDao.insert(log);
		}
	}
}