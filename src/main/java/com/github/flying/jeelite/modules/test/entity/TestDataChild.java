/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.test.entity;

import org.hibernate.validator.constraints.Length;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.github.flying.jeelite.common.persistence.DataEntity;

/**
 * 主子表生成Entity
 *
 * @author flying
 * @version 2015-04-06
 */
@TableName("test_data_child")
public class TestDataChild extends DataEntity<TestDataChild> {

	private static final long serialVersionUID = 1L;
	@TableField(value = "test_data_main_id", el = "testDataMain.id")
	private TestDataMain testDataMain; // 业务主表 父类
	private String name; // 名称

	public TestDataChild() {
		super();
	}

	public TestDataChild(String id) {
		super(id);
	}

	public TestDataChild(TestDataMain testDataMain) {
		this.testDataMain = testDataMain;
	}

	@Length(min = 0, max = 64, message = "业务主表长度必须介于 0 和 64 之间")
	public TestDataMain getTestDataMain() {
		return testDataMain;
	}

	public void setTestDataMain(TestDataMain testDataMain) {
		this.testDataMain = testDataMain;
	}

	@Length(min = 0, max = 100, message = "名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}