/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.utils.excel.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Excel注解定义
 * @author flying
 * @version 2013-03-10
 */
@Target({ElementType.METHOD, ElementType.FIELD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface ExcelField {

	/**
	 * 字段标题
	 */
	String title() default "";

	/**
	 * 字段排序（升序）
	 */
	int sort() default 0;

	/**
	 * 如果是字典类型，请设置字典的type值
	 */
	String dictType() default "";
}