/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.web;

import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Validator;

import org.apache.commons.lang3.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.baomidou.mybatisplus.plugins.Page;
import com.github.flying.jeelite.common.beanvalidator.BeanValidators;
import com.github.flying.jeelite.common.mapper.JsonMapper;
import com.github.flying.jeelite.common.utils.DateUtils;
import com.google.common.collect.Maps;

/**
 * 控制器支持类
 * @author flying
 */
public abstract class BaseController {

	/**
	 * 日志对象
	 */
	protected Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * 管理基础路径
	 */
	@Value("${adminPath}")
	protected String adminPath;

	/**
	 * 验证Bean实例对象
	 */
	@Autowired
	protected Validator validator;
	
	/**
	 * 服务端参数有效性验证
	 * @param object 验证的实体对象
	 * @param groups 验证组，不传入此参数时，同@Valid注解验证
	 * @return 验证成功：继续执行；验证失败：抛出异常
	 */
	protected void beanValidator(Object object, Class<?>... groups) {
		BeanValidators.validateWithException(validator, object, groups);
	}

	/**
	 * 设置客户端成功响应
	 */
	protected ResponseEntity<?> renderSuccess() {
		return render(HttpStatus.OK.value(), HttpStatus.OK.getReasonPhrase(), null);
	}

	/**
	 * 设置客户端成功响应
	 */
	protected ResponseEntity<?> renderSuccess(Object data) {
		return render(HttpStatus.OK.value(), HttpStatus.OK.getReasonPhrase(), data);
	}

	/**
	 * 设置客户端成功响应
	 */
	protected ResponseEntity<?> renderSuccess(String msg) {
		return render(HttpStatus.OK.value(), msg, null);
	}

	/**
	 * 设置客户端错误响应
	 */
	protected ResponseEntity<?> renderError(String errorMsg) {
		return render(201, errorMsg, null);
	}

	/**
	 * 设置客户端响应
	 */
	protected ResponseEntity<?> render(int code, String msg, Object data) {
		Map map = Maps.newHashMap();
		if (data != null) {
			map.put("data", data);
		}
		map.put("code", code);
		map.put("msg", msg);
		return ResponseEntity.ok(map);
	}

	/**
	 * 客户端返回JSON字符串
	 */
	protected String renderString(HttpServletResponse response, Object object) {
		try {
			response.reset();
			response.setContentType("application/json");
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(JsonMapper.toJsonString(object));
			return null;
		} catch (IOException e) {
			return null;
		}
	}

	/**
	 * 转换为layui table需要的分页数据格式
	 */
	protected Map jsonPage(Page page) {
		return jsonPage(page.getTotal(), page.getRecords());
	}
	
	protected Map jsonPage(long count, List data) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", count);
		map.put("data", data);
		return map;
	}

	/**
	 * 初始化数据绑定
	 * 1. 将所有传递进来的String进行HTML编码，防止XSS攻击
	 * 2. 将字段中Date类型转换为String类型
	 */
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		// String类型转换，将所有传递进来的String进行HTML编码，防止XSS攻击
		binder.registerCustomEditor(String.class, new PropertyEditorSupport() {
			@Override
			public void setAsText(String text) {
				setValue(text == null ? null : StringEscapeUtils.escapeHtml4(text.trim()));
			}
			@Override
			public String getAsText() {
				Object value = getValue();
				return value != null ? value.toString() : "";
			}
		});
		// Date 类型转换
		binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
			@Override
			public void setAsText(String text) {
				setValue(DateUtils.parseDate(text));
			}
//			@Override
//			public String getAsText() {
//				Object value = getValue();
//				return value != null ? DateUtils.formatDateTime((Date)value) : "";
//			}
		});
	}

}
