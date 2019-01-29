package com.github.flying.jeelite.common.rest;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 接口统一返回结果
 *
 */
@ApiModel(description = "API接口统一返回对象")
public class Result<T> {
	
	@ApiModelProperty(value="状态码；200：成功，非200：业务错误")
	private int code;
	@ApiModelProperty(value="返回消息")
	private String msg;
	@ApiModelProperty(value="返回数据")
	private T data;

	public Result() {
	}
	
	public Result(int code, String msg) {
		super();
		this.code = code;
		this.msg = msg;
	}

	public Result(int code, String msg, T data) {
		super();
		this.code = code;
		this.msg = msg;
		this.data = data;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

}