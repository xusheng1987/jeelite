/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.monitor.service;

import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.quartz.CronTrigger;
import org.quartz.Scheduler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.service.BaseService;
import com.github.flying.jeelite.modules.monitor.dao.JobDao;
import com.github.flying.jeelite.modules.monitor.entity.Job;
import com.github.flying.jeelite.modules.monitor.utils.ScheduleUtils;

/**
 * 定时任务Service
 *
 * @author flying
 * @version 2019-01-11
 */
@Service
@Transactional(readOnly = true)
public class JobService extends BaseService<JobDao, Job> {

	@Autowired
	private Scheduler scheduler;

	/**
	 * 项目启动时，初始化quartz的定时器
	 */
	@PostConstruct
	public void init() {
		List<Job> jobList = super.findList(new Job());
		for (Job job : jobList) {
			CronTrigger cronTrigger = ScheduleUtils.getCronTrigger(scheduler, job.getId());
			// 如果不存在，则创建
			if (cronTrigger == null) {
				ScheduleUtils.createJob(scheduler, job);
			} else {
				ScheduleUtils.updateJob(scheduler, job);
			}
		}
	}

	/**
	 * 保存定时任务
	 */
	@Override
	@Transactional(readOnly = false)
	public void save(Job job) {
		job.setStatus(Job.JOB_STATUS_NORMAL);
		job.setCreateDate(new Date());
		job.setUpdateDate(new Date());
		dao.insert(job);

		ScheduleUtils.createJob(scheduler, job);
	}

	/**
	 * 更新定时任务
	 */
	@Transactional(readOnly = false)
	public void update(Job job) {
		ScheduleUtils.updateJob(scheduler, job);

		job.setUpdateDate(new Date());
		dao.updateById(job);
	}

	/**
	 * 删除定时任务
	 */
	@Transactional(readOnly = false)
	public void deleteBatch(List<String> jobIds) {
		for (String jobId : jobIds) {
			ScheduleUtils.deleteJob(scheduler, jobId);
		}
		super.deleteBatchIds(jobIds);
	}

	/**
	 * 执行定时任务
	 */
	@Transactional(readOnly = false)
	public void run(String jobId) {
		ScheduleUtils.runJob(scheduler, super.get(jobId));
	}

	/**
	 * 暂停定时任务
	 */
	@Transactional(readOnly = false)
	public void pause(List<String> jobIds) {
		for (String jobId : jobIds) {
			ScheduleUtils.pauseJob(scheduler, jobId);
		}
		dao.updateStatus(Job.JOB_STATUS_PAUSE, jobIds);
	}

	/**
	 * 恢复定时任务
	 */
	@Transactional(readOnly = false)
	public void resume(List<String> jobIds) {
		for (String jobId : jobIds) {
			ScheduleUtils.resumeJob(scheduler, jobId);
		}
		dao.updateStatus(Job.JOB_STATUS_NORMAL, jobIds);
	}

}