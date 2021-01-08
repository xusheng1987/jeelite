/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.entity;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.github.flying.jeelite.common.persistence.TreeEntity;
import com.github.flying.jeelite.common.persistence.typeHandler.CommonTypeHandler;

/**
 * 菜单Entity
 * @author flying
 * @version 2013-05-15
 */
@TableName("sys_menu")
public class Menu extends TreeEntity<Menu> {

	private static final long serialVersionUID = 1L;
	@TableField(value="parent_id", typeHandler = CommonTypeHandler.class)
	private Menu parent;	// 父级菜单
	private String href; 	// 链接
	private String target; 	// 目标（ mainFrame、_blank、_self、_parent、_top）
	private String icon; 	// 图标
	private String isShow; 	// 是否在菜单中显示（1：显示；0：不显示）
	private String permission; // 权限标识

	@TableField(exist=false)
	private String userId;

	public Menu(){
		super();
		this.isShow = "1";
	}

	public Menu(String id){
		super(id);
	}

	@Override
	@JsonBackReference
	@NotNull
	public Menu getParent() {
		return parent;
	}

	@Override
	public void setParent(Menu parent) {
		this.parent = parent;
	}

	@Length(min=0, max=2000)
	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	@Length(min=0, max=20)
	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	@Length(min=0, max=100)
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	@Length(min=1, max=1)
	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	@Length(min=0, max=200)
	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	@Override
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}

	@JsonIgnore
	public static String getRootId(){
		return "1";
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return name;
	}
}