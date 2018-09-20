/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.test.entity;

import javax.validation.constraints.NotNull;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.github.flying.jeelite.common.persistence.TreeEntity;

/**
 * 树结构生成Entity
 *
 * @author flying
 * @version 2015-04-06
 */
@TableName("test_tree")
public class TestTree extends TreeEntity<TestTree> {

	private static final long serialVersionUID = 1L;
	@TableField(value = "parent_id", el = "parent.id")
	private TestTree parent; // 父级编号

	public TestTree() {
		super();
	}

	public TestTree(String id) {
		super(id);
	}

	@Override
	@JsonBackReference
	@NotNull(message = "父级编号不能为空")
	public TestTree getParent() {
		return parent;
	}

	@Override
	public void setParent(TestTree parent) {
		this.parent = parent;
	}

	@Override
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
}