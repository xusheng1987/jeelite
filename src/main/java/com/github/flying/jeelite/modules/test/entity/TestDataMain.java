/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.test.entity;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.google.common.collect.Lists;
import com.github.flying.jeelite.common.persistence.DataEntity;
import com.github.flying.jeelite.modules.sys.entity.Office;
import com.github.flying.jeelite.modules.sys.entity.User;

/**
 * 主子表生成Entity
 *
 * @author flying
 * @version 2015-04-06
 */
@TableName("test_data_main")
public class TestDataMain extends DataEntity<TestDataMain> {

	private static final long serialVersionUID = 1L;
	@TableField(value = "user_id", el = "user.id")
	private User user; // 归属用户
	@TableField(value = "office_id", el = "office.id")
	private Office office; // 归属部门
	private String name; // 名称
	private String sex; // 性别
	private Date inDate; // 加入日期
	@TableField(exist = false)
	private List<TestDataChild> testDataChildList = Lists.newArrayList(); // 子表列表

	public TestDataMain() {
		super();
	}

	public TestDataMain(String id) {
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	@Length(min = 0, max = 100, message = "名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Length(min = 0, max = 1, message = "性别长度必须介于 0 和 1 之间")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Date getInDate() {
		return inDate;
	}

	public void setInDate(Date inDate) {
		this.inDate = inDate;
	}

	public List<TestDataChild> getTestDataChildList() {
		return testDataChildList;
	}

	public void setTestDataChildList(List<TestDataChild> testDataChildList) {
		this.testDataChildList = testDataChildList;
	}
}