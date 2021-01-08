/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.monitor.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.baomidou.mybatisplus.annotation.TableName;
import com.github.flying.jeelite.common.persistence.BaseEntity;
import com.github.flying.jeelite.modules.monitor.utils.ScheduleUtils;

/**
 * 定时任务Entity
 *
 * @author flying
 * @version 2019-01-11
 */
@TableName("sys_job")
public class Job extends BaseEntity<Job> {

	private static final long serialVersionUID = 1L;
	private String beanName; // bean名称
	private String methodName; // 方法名
	private String params; // 参数
	private String cronExpression; // cron表达式
	private String status; // 任务状态  0：正常  1：暂停
	private String remark; // 备注
	private Date createDate; // 创建日期
	private Date updateDate; // 更新日期

	public static final String JOB_PARAM_KEY = "JOB_PARAM_KEY"; //任务调度参数key
	public static final String JOB_STATUS_NORMAL = "0";//正常
	public static final String JOB_STATUS_PAUSE = "1";//暂停
	
	public Job() {
		super();
	}

	public Job(String id) {
		super(id);
	}

	@Length(min = 1, max = 100, message = "bean名称长度必须介于 1 和 100 之间")
	public String getBeanName() {
		return beanName;
	}

	public void setBeanName(String beanName) {
		this.beanName = beanName;
	}

	@Length(min = 1, max = 100, message = "方法名长度必须介于 1 和 100 之间")
	public String getMethodName() {
		return methodName;
	}

	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}

	@Length(min = 0, max = 100, message = "参数长度不能超过100")
	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	@Length(min = 1, max = 100, message = "cron表达式长度必须介于 1 和 100 之间")
	public String getCronExpression() {
		return cronExpression;
	}

	public void setCronExpression(String cronExpression) {
		this.cronExpression = cronExpression;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Length(min = 0, max = 255, message = "备注长度不能超过255")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public Date getNextExecutionDate() {
		if (JOB_STATUS_PAUSE.equals(this.status)) {
			return null;
		} else {
			return ScheduleUtils.getNextExecutionDate(this.cronExpression);
		}
	}
}