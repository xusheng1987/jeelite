package com.github.flying.jeelite.modules.job.utils;

import java.text.ParseException;
import java.util.Date;

import org.quartz.*;

import com.github.flying.jeelite.common.rest.RestException;
import com.github.flying.jeelite.modules.job.entity.Job;

/**
 * 定时任务工具类
 *
 */
public class ScheduleUtils {

	private final static String JOB_NAME = "TASK_";

	/**
	 * 获取触发器key
	 */
	private static TriggerKey getTriggerKey(String jobId) {
		return TriggerKey.triggerKey(JOB_NAME + jobId);
	}

	/**
	 * 获取jobKey
	 */
	private static JobKey getJobKey(String jobId) {
		return JobKey.jobKey(JOB_NAME + jobId);
	}

	/**
	 * 获取表达式触发器
	 */
	public static CronTrigger getCronTrigger(Scheduler scheduler, String jobId) {
		try {
			return (CronTrigger) scheduler.getTrigger(getTriggerKey(jobId));
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 创建定时任务
	 */
	public static void createJob(Scheduler scheduler, Job job) {
		try {
			TriggerKey triggerKey = getTriggerKey(job.getId());
			// 构建job信息
			JobDetail jobDetail = JobBuilder.newJob(ScheduleJob.class).withIdentity(getJobKey(job.getId())).requestRecovery().storeDurably().build();
			// 表达式调度构建器
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression())
					.withMisfireHandlingInstructionDoNothing();
			// 按新的cronExpression表达式构建一个新的trigger
			CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(triggerKey)
					.withSchedule(scheduleBuilder).build();
			// 放入参数，运行时的方法可以获取
			jobDetail.getJobDataMap().put(Job.JOB_PARAM_KEY, job);
			scheduler.scheduleJob(jobDetail, trigger);
			
			// 暂停任务
			if (Job.JOB_STATUS_PAUSE.equals(job.getStatus())) {
				pauseJob(scheduler, job.getId());
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RestException("创建定时任务失败");
		}
	}

	/**
	 * 更新定时任务
	 */
	public static void updateJob(Scheduler scheduler, Job job) {
		try {
			TriggerKey triggerKey = getTriggerKey(job.getId());
			// 表达式调度构建器
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression())
					.withMisfireHandlingInstructionDoNothing();
			CronTrigger trigger = getCronTrigger(scheduler, job.getId());
			// 按新的cronExpression表达式重新构建trigger
			trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();
			// 参数
			trigger.getJobDataMap().put(Job.JOB_PARAM_KEY, job);
			scheduler.rescheduleJob(triggerKey, trigger);

			// 暂停任务
			if (Job.JOB_STATUS_PAUSE.equals(job.getStatus())) {
				pauseJob(scheduler, job.getId());
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RestException("更新定时任务失败");
		}
	}

	/**
	 * 立即执行任务
	 */
	public static void runJob(Scheduler scheduler, Job job) {
		// 参数
		JobDataMap dataMap = new JobDataMap();
		dataMap.put(Job.JOB_PARAM_KEY, job);
		try {
			scheduler.triggerJob(getJobKey(job.getId()), dataMap);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RestException("执行定时任务失败");
		}
	}

	/**
	 * 暂停任务
	 */
	public static void pauseJob(Scheduler scheduler, String jobId) {
		try {
			scheduler.pauseJob(getJobKey(jobId));
		} catch (Exception e) {
			e.printStackTrace();
			throw new RestException("暂停定时任务失败");
		}
	}

	/**
	 * 恢复任务
	 */
	public static void resumeJob(Scheduler scheduler, String jobId) {
		try {
			scheduler.resumeJob(getJobKey(jobId));
		} catch (Exception e) {
			e.printStackTrace();
			throw new RestException("恢复定时任务失败");
		}
	}

	/**
	 * 删除定时任务
	 */
	public static void deleteJob(Scheduler scheduler, String jobId) {
		try {
			scheduler.deleteJob(getJobKey(jobId));
		} catch (Exception e) {
			e.printStackTrace();
			throw new RestException("删除定时任务失败");
		}
	}
	
	/**
	 * 校验Cron表达式的有效性
	 */
	public static boolean checkCronExpressionIsValid(String cronExpression) {
		return CronExpression.isValidExpression(cronExpression);
	}
	
	/**
	 * 返回任务的下次执行时间
	 */
	public static Date getNextExecutionDate(String cronExpression) {
		try {
			CronExpression cron = new CronExpression(cronExpression);
			return cron.getNextValidTimeAfter(new Date());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
}