/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.entity;

import java.util.Date;
import java.util.Map;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.github.flying.jeelite.common.persistence.BaseEntity;
import com.github.flying.jeelite.common.persistence.typeHandler.CommonTypeHandler;
import com.github.flying.jeelite.common.utils.StringUtils;

/**
 * 日志Entity
 *
 * @author flying
 * @version 2014-8-19
 */
@TableName("sys_log")
public class Log extends BaseEntity<Log> {

	private static final long serialVersionUID = 1L;
	private String type; // 日志类型（1：接入日志；2：错误日志）
	private String title; // 日志标题
	private String remoteAddr; // 操作用户的IP地址
	private String requestUri; // 操作的URI
	private String method; // 操作的方式
	private String params; // 操作提交的数据
	private String userAgent; // 操作用户代理信息
	private String exception; // 异常信息

	@TableField(exist=false)
	private Date beginDate; // 开始日期
	@TableField(exist=false)
	private Date endDate; // 结束日期

	@TableField(typeHandler = CommonTypeHandler.class)
	private User createBy; // 创建者
	private Date createDate; // 创建日期
	private Integer costTime; // 请求耗时(毫秒)

	/**
	 *  日志类型（1：接入日志；2：错误日志）
	 */
	public static final String TYPE_ACCESS = "1";
	public static final String TYPE_EXCEPTION = "2";

	public Log() {
		super();
	}

	public Log(String id) {
		super(id);
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRemoteAddr() {
		return remoteAddr;
	}

	public void setRemoteAddr(String remoteAddr) {
		this.remoteAddr = remoteAddr;
	}

	public String getUserAgent() {
		return userAgent;
	}

	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}

	public String getRequestUri() {
		return requestUri;
	}

	public void setRequestUri(String requestUri) {
		this.requestUri = requestUri;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	public String getException() {
		return exception;
	}

	public void setException(String exception) {
		this.exception = exception;
	}

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public User getCreateBy() {
		return createBy;
	}

	public void setCreateBy(User createBy) {
		this.createBy = createBy;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Integer getCostTime() {
		return costTime;
	}

	public void setCostTime(Integer costTime) {
		this.costTime = costTime;
	}

	/**
	 * 设置请求参数
	 *
	 */
	public void setParams(Map<String, String[]> paramMap) {
		if (paramMap == null) {
			return;
		}
		StringBuilder sb = new StringBuilder();
		for (Map.Entry<String, String[]> param : paramMap.entrySet()) {
			sb.append(("".equals(sb.toString()) ? "" : "&") + param.getKey() + "=");
			String paramValue = (param.getValue() != null && param.getValue().length > 0 ? param.getValue()[0] : "");
			sb.append(StringUtils.abbreviate(StringUtils.endsWithIgnoreCase(param.getKey(), "password") ? "" : paramValue,
					100));
		}
		this.params = sb.toString();
	}
}