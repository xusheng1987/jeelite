/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.monitor.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.service.BaseService;
import com.github.flying.jeelite.modules.monitor.dao.JobLogDao;
import com.github.flying.jeelite.modules.monitor.entity.JobLog;

/**
 * 定时任务日志Service
 *
 * @author flying
 * @version 2019-01-11
 */
@Service
@Transactional(readOnly = true)
public class JobLogService extends BaseService<JobLogDao, JobLog> {

}