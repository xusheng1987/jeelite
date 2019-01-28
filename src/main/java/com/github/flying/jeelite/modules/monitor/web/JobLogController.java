/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.monitor.web;

import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.plugins.Page;
import com.github.flying.jeelite.common.persistence.PageFactory;
import com.github.flying.jeelite.common.utils.DateUtils;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.modules.monitor.entity.JobLog;
import com.github.flying.jeelite.modules.monitor.service.JobLogService;

/**
 * 定时任务日志Controller
 *
 * @author flying
 * @version 2019-01-11
 */
@Controller
@RequestMapping(value = "${adminPath}/monitor/job/log")
public class JobLogController extends BaseController {

	@Autowired
	private JobLogService jobLogService;

	@ModelAttribute
	public JobLog get(@RequestParam(required = false) String id) {
		JobLog entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = jobLogService.get(id);
		}
		if (entity == null) {
			entity = new JobLog();
		}
		return entity;
	}

	@RequiresPermissions("monitor:job:view")
	@RequestMapping(value = {"list", ""})
	public String list() {
		return "modules/monitor/jobLogList";
	}

	@ResponseBody
	@RequiresPermissions("monitor:job:view")
	@RequestMapping(value = "data")
	public Map listData(JobLog jobLog) {
		if (jobLog.getEndCreateDate() != null) {
			jobLog.setEndCreateDate(DateUtils.parseDate(DateUtils.formatDate(jobLog.getEndCreateDate()) + " 23:59:59"));
		}
		Page<JobLog> page = jobLogService.findPage(new PageFactory<JobLog>().defaultPage(), jobLog);
		return jsonPage(page);
	}

}