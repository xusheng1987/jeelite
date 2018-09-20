/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.web;

import java.util.Date;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.plugins.Page;
import com.github.flying.jeelite.common.persistence.PageFactory;
import com.github.flying.jeelite.common.utils.DateUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.modules.sys.entity.Log;
import com.github.flying.jeelite.modules.sys.service.LogService;

/**
 * 日志Controller
 *
 * @author flying
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/log")
public class LogController extends BaseController {

	@Autowired
	private LogService logService;

	@RequiresPermissions("sys:log:view")
	@RequestMapping(value = { "list", "" })
	public String list(Model model) {
		Date beginDate = DateUtils.setDays(DateUtils.parseDate(DateUtils.getDate()), 1);
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", DateUtils.parseDate(DateUtils.formatDate(DateUtils.addMonths(beginDate, 1)) + " 23:59:59"));
		return "modules/sys/logList";
	}

	@ResponseBody
	@RequiresPermissions("sys:log:view")
	@RequestMapping(value = "data")
	public Map listData(Log log) {
		log.setEndDate(DateUtils.parseDate(DateUtils.formatDate(log.getEndDate()) + " 23:59:59"));
		Page<Log> page = logService.findPage(new PageFactory<Log>().defaultPage(), log);
		return jsonPage(page);
	}

}