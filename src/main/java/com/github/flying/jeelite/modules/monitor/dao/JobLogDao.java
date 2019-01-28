/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.monitor.dao;

import com.github.flying.jeelite.common.persistence.CrudDao;
import com.github.flying.jeelite.common.persistence.annotation.MyBatisDao;
import com.github.flying.jeelite.modules.monitor.entity.JobLog;

/**
 * 定时任务日志DAO接口
 *
 * @author flying
 * @version 2019-01-11
 */
@MyBatisDao
public interface JobLogDao extends CrudDao<JobLog> {

}