package com.thinkgem.jeesite.common.persistence.dataSource;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

/**
 * 使用AOP实现数据源的动态切换
 * 
 * @author flying
 * @version 2017-08-15
 */
@Component
@Aspect
@Order(1)
@EnableAspectJAutoProxy(proxyTargetClass = true)
public class DynamicDataSourceAspectAdvice {

	@Pointcut("@within(org.springframework.transaction.annotation.Transactional)") // 拦截含有Transactional注解的类中所有方法
	public void aspect() {
	}

	/**
	 * 配置前置通知,使用在方法aspect()上注册的切入点
	 */
	@Before("aspect()")
	public void before(JoinPoint point) {
		DataSource dataSource = point.getTarget().getClass().getAnnotation(DataSource.class);
		if (dataSource != null) {
			DbContextHolder.setDbType(dataSource.value());
		}
	}

	@After("aspect()")
	public void after() {
		DbContextHolder.clearDbType();
	}
}