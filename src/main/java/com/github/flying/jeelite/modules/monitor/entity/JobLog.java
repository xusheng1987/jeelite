/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.monitor.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.github.flying.jeelite.common.persistence.BaseEntity;

/**
 * 定时任务日志Entity
 *
 * @author flying
 * @version 2019-01-11
 */
@TableName("sys_job_log")
public class JobLog extends BaseEntity<JobLog> {

	private static final long serialVersionUID = 1L;
	private String jobId; // 任务ID
	private String beanName; // bean名称
	private String methodName; // 方法名
	private String params; // 参数
	private String status; // 任务状态  0：成功,1：失败
	private String errorInfo; // 失败信息
	private Integer costTime; // 耗时(单位：毫秒)
	private Date createDate; // 创建日期
	@TableField(exist = false)
	private Date beginCreateDate; // 开始创建时间
	@TableField(exist = false)
	private Date endCreateDate; // 结束创建时间

	public JobLog() {
		super();
	}

	public JobLog(String id) {
		super(id);
	}

	public String getJobId() {
		return jobId;
	}

	public void setJobId(String jobId) {
		this.jobId = jobId;
	}

	public String getBeanName() {
		return beanName;
	}

	public void setBeanName(String beanName) {
		this.beanName = beanName;
	}

	public String getMethodName() {
		return methodName;
	}

	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getErrorInfo() {
		return errorInfo;
	}

	public void setErrorInfo(String errorInfo) {
		this.errorInfo = errorInfo;
	}

	public Integer getCostTime() {
		return costTime;
	}

	public void setCostTime(Integer costTime) {
		this.costTime = costTime;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}

	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}

}