package com.github.flying.jeelite.modules.api.dto;

import java.io.Serializable;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 用户信息
 */
@ApiModel(description = "用户信息")
public class UserDto implements Serializable {
	private static final long serialVersionUID = 1L;
	@ApiModelProperty(value = "用户ID", example = "1")
	private String userId; // 用户ID
	@ApiModelProperty(value = "归属公司", example = "河南省总公司")
	private String companyName; // 归属公司
	@ApiModelProperty(value = "归属部门", example = "技术部")
	private String officeName; // 归属部门
	@ApiModelProperty(value = "工号", example = "0001")
	private String no; // 工号
	@ApiModelProperty(value = "姓名", example = "系统管理员")
	private String name; // 姓名
	@ApiModelProperty(value = "邮箱", example = "admin@163.com")
	private String email; // 邮箱
	@ApiModelProperty(value = "电话", example = "8675")
	private String phone; // 电话
	@ApiModelProperty(value = "手机", example = "13011111111")
	private String mobile; // 手机

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

}