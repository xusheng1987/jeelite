/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.NamedThreadLocal;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.github.flying.jeelite.modules.sys.utils.LogUtils;

/**
 * 日志拦截器
 *
 * @author flying
 * @version 2014-8-19
 */
public class LogInterceptor implements HandlerInterceptor {

	private static final ThreadLocal<Long> startTimeThreadLocal = new NamedThreadLocal<Long>("ThreadLocal StartTime");

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		startTimeThreadLocal.set(System.currentTimeMillis()); // 线程绑定变量（该数据只有当前请求的线程可见）
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// 请求耗时
		Long costTime = System.currentTimeMillis() - startTimeThreadLocal.get();
		// 保存日志
		LogUtils.saveLog(request, handler, ex == null ? (Exception) request.getAttribute("exception") : ex, null, costTime.intValue());
		// 删除线程变量中的数据，防止内存泄漏
		startTimeThreadLocal.remove();
	}

}