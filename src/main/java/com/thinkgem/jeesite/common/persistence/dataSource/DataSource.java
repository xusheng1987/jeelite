package com.thinkgem.jeesite.common.persistence.dataSource;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 动态数据源注解，写在service层中需要切换数据源的方法上
 * 
 * @author flying
 * @version 2017-08-15
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ ElementType.METHOD, ElementType.TYPE })
@Documented
public @interface DataSource {
	DBTypeEnum value() default DBTypeEnum.one;
}