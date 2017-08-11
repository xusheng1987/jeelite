/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.oa.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 通知通告记录Entity
 * @author ThinkGem
 * @version 2014-05-16
 */
@TableName("oa_notify_record")
public class OaNotifyRecord extends BaseEntity<OaNotifyRecord> {
	
	private static final long serialVersionUID = 1L;
	@TableField(value="oa_notify_id", el = "oaNotify, typeHandler=com.thinkgem.jeesite.common.persistence.typeHandler.EntityTypeHandler")
	private OaNotify oaNotify;		// 通知通告ID
	@TableField(value="user_id", el = "user, typeHandler=com.thinkgem.jeesite.common.persistence.typeHandler.EntityTypeHandler")
	private User user;		// 接受人
	private String readFlag;		// 阅读标记（0：未读；1：已读）
	private Date readDate;		// 阅读时间
	
	public OaNotifyRecord() {
		super();
	}

	public OaNotifyRecord(String id){
		super(id);
	}
	
	public OaNotifyRecord(OaNotify oaNotify){
		this.oaNotify = oaNotify;
	}

	public OaNotify getOaNotify() {
		return oaNotify;
	}

	public void setOaNotify(OaNotify oaNotify) {
		this.oaNotify = oaNotify;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=1, message="阅读标记（0：未读；1：已读）长度必须介于 0 和 1 之间")
	public String getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}
	
	public Date getReadDate() {
		return readDate;
	}

	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}
	
}