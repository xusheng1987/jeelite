/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.test.entity;

import javax.validation.constraints.NotNull;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.thinkgem.jeesite.common.persistence.TreeEntity;

/**
 * 树结构生成Entity
 * 
 * @author ThinkGem
 * @version 2015-04-06
 */
@TableName("test_tree")
public class TestTree extends TreeEntity<TestTree> {

	private static final long serialVersionUID = 1L;
	@TableField(value = "parent_id", el = "parent, typeHandler=com.thinkgem.jeesite.common.persistence.typeHandler.EntityTypeHandler")
	private TestTree parent; // 父级编号

	public TestTree() {
		super();
	}

	public TestTree(String id) {
		super(id);
	}

	@JsonBackReference
	@NotNull(message = "父级编号不能为空")
	public TestTree getParent() {
		return parent;
	}

	public void setParent(TestTree parent) {
		this.parent = parent;
	}

	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
}