/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.persistence;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 数据Entity类
 * @author flying
 * @version 2014-05-16
 */
public abstract class DataEntity<T> extends BaseEntity<T> {

	private static final long serialVersionUID = 1L;

	protected String remarks;	// 备注

	@TableField(fill = FieldFill.INSERT)
	protected String createBy;	// 创建者

	@TableField(fill = FieldFill.INSERT)
	protected Date createDate;	// 创建日期

	@TableField(fill = FieldFill.INSERT_UPDATE)
	protected String updateBy;	// 更新者

	@TableField(fill = FieldFill.INSERT_UPDATE)
	protected Date updateDate;	// 更新日期

	@TableLogic
	protected String delFlag; 	// 删除标记（0：正常；1：删除）

	public DataEntity() {
		super();
		this.delFlag = DEL_FLAG_NORMAL;
	}

	public DataEntity(String id) {
		super(id);
	}

	@Length(min=0, max=255)
	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	@JsonIgnore
	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@JsonIgnore
	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@JsonIgnore
	@Length(min=1, max=1)
	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

}