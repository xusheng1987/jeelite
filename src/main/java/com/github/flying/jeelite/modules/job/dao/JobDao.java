/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.job.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.flying.jeelite.common.persistence.CrudDao;
import com.github.flying.jeelite.common.persistence.annotation.MyBatisDao;
import com.github.flying.jeelite.modules.job.entity.Job;

/**
 * 定时任务DAO接口
 *
 * @author flying
 * @version 2019-01-11
 */
@MyBatisDao
public interface JobDao extends CrudDao<Job> {
	
	/**
	 * 批量更新状态
	 */
	int updateStatus(@Param("status") String status, @Param("list") List<String> jobIds);

}