/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.TableName;
import com.github.flying.jeelite.common.persistence.BaseEntity;

/**
 * 用户Token
 * 
 * @author flying
 * @version 2019-02-21
 */
@TableName("sys_user_token")
public class UserToken extends BaseEntity<UserToken> {

	private static final long serialVersionUID = 1L;
	private String userId;// 用户ID
	private String token;
	private Date expireDate;//过期时间
	private Date updateDate;//更新时间

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Date getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

}