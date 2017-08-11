/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.thinkgem.jeesite.common.persistence.TreeEntity;

/**
 * 区域Entity
 * @author ThinkGem
 * @version 2013-05-15
 */
@TableName("sys_area")
public class Area extends TreeEntity<Area> {

	private static final long serialVersionUID = 1L;
	@TableField(value="parent_id", el = "parent, typeHandler=com.thinkgem.jeesite.common.persistence.typeHandler.EntityTypeHandler")
	private Area parent;	// 父级编号
	private String code; 	// 区域编码
	private String type; 	// 区域类型（1：国家；2：省份、直辖市；3：地市；4：区县）
	
	public Area(){
		super();
		this.sort = 30;
	}

	public Area(String id){
		super(id);
	}
	
	public Area getParent() {
		return parent;
	}

	public void setParent(Area parent) {
		this.parent = parent;
	}

	@Length(min=1, max=1)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Length(min=0, max=100)
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
	
	@Override
	public String toString() {
		return name;
	}

}