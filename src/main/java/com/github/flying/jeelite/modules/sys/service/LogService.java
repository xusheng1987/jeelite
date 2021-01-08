/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.persistence.Page;
import com.github.flying.jeelite.common.service.BaseService;
import com.github.flying.jeelite.common.utils.DateUtils;
import com.github.flying.jeelite.modules.sys.dao.LogDao;
import com.github.flying.jeelite.modules.sys.entity.Log;

/**
 * 日志Service
 *
 * @author flying
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class LogService extends BaseService<LogDao, Log> {

	@Override
	public Page<Log> findPage(Log log) {

		// 设置默认时间范围，默认当前月
		if (log.getBeginDate() == null) {
			log.setBeginDate(DateUtils.setDays(DateUtils.parseDate(DateUtils.getDate()), 1));
		}
		if (log.getEndDate() == null) {
			log.setEndDate(DateUtils.addMonths(log.getBeginDate(), 1));
		}

		return super.findPage(log);
	}

}