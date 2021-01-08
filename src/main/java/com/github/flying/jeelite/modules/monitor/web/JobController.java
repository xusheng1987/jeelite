/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.monitor.web;

import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.flying.jeelite.common.persistence.Page;
import com.github.flying.jeelite.common.rest.Result;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.modules.monitor.entity.Job;
import com.github.flying.jeelite.modules.monitor.service.JobService;
import com.github.flying.jeelite.modules.monitor.utils.ScheduleUtils;

/**
 * 定时任务Controller
 *
 * @author flying
 * @version 2019-01-11
 */
@Controller
@RequestMapping(value = "${adminPath}/monitor/job")
public class JobController extends BaseController {

	@Autowired
	private JobService jobService;

	@ModelAttribute
	public Job get(@RequestParam(required = false) String id) {
		Job entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = jobService.get(id);
		}
		if (entity == null) {
			entity = new Job();
		}
		return entity;
	}

	@RequiresPermissions("monitor:job:view")
	@RequestMapping(value = {"list", ""})
	public String list() {
		return "modules/monitor/jobList";
	}

	@ResponseBody
	@RequiresPermissions("monitor:job:view")
	@RequestMapping(value = "data")
	public Map listData(Job job) {
		Page<Job> page = jobService.findPage(job);
		return jsonPage(page);
	}

	@RequiresPermissions("monitor:job:view")
	@RequestMapping(value = "form")
	public String form(Job job, Model model) {
		model.addAttribute("job", job);
		return "modules/monitor/jobForm";
	}

	@ResponseBody
	@RequiresPermissions("monitor:job:edit")
	@RequestMapping(value = "save")
	public Result save(Job job) {
		beanValidator(job);
		
		String jobId = job.getId();
		if (StringUtils.isEmpty(jobId)) {
			jobService.save(job);
			return renderSuccess("保存定时任务成功");
		} else {
			jobService.update(job);
			return renderSuccess("修改定时任务成功");
		}
	}

	@ResponseBody
	@RequiresPermissions("monitor:job:edit")
	@RequestMapping(value = "delete")
	public Result delete(@RequestBody List<String> jobIds) {
		jobService.deleteBatch(jobIds);
		return renderSuccess("删除定时任务成功");
	}

	@ResponseBody
	@RequiresPermissions("monitor:job:edit")
	@RequestMapping(value = "run")
	public Result run(Job job) {
		jobService.run(job.getId());
		return renderSuccess("执行定时任务成功");
	}

	@ResponseBody
	@RequiresPermissions("monitor:job:edit")
	@RequestMapping(value = "pause")
	public Result pause(@RequestBody List<String> jobIds) {
		jobService.pause(jobIds);
		return renderSuccess("暂停定时任务成功");
	}

	@ResponseBody
	@RequiresPermissions("monitor:job:edit")
	@RequestMapping(value = "resume")
	public Result resume(@RequestBody List<String> jobIds) {
		jobService.resume(jobIds);
		return renderSuccess("恢复定时任务成功");
	}

	/**
	 * 验证Cron表达式是否有效
	 */
	@ResponseBody
	@RequiresPermissions("monitor:job:edit")
	@RequestMapping(value = "checkCronExpression")
	public String checkCronExpression(String oldCronExpression, String cronExpression) {
		if (cronExpression != null && cronExpression.equals(oldCronExpression)) {
			return "true";
		} else if (cronExpression != null && ScheduleUtils.checkCronExpressionIsValid(cronExpression)) {
			return "true";
		}
		return "false";
	}

}