/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.github.flying.jeelite.common.rest.RestException;
import com.github.flying.jeelite.common.utils.SpringContextHolder;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.modules.sys.dao.UserTokenDao;
import com.github.flying.jeelite.modules.sys.entity.UserToken;

/**
 * 权限拦截器
 * 
 * 拦截器执行顺序：按照定义的顺序从上到下依次执行preHandle方法，如果碰到某个拦截器的返回值是false，则停止向下执行，然后从这个返回值是false的拦截器开始（不包括该拦截器），
 * 从下到上执行各个拦截器（如果有的话）afterCompletion方法。如果所有拦截器的preHandle方法都返回true，下一步开始处理Controller里的请求，请求处理完成之后按照拦截器
 * 定义的顺序从下到上依次执行postHandle方法，之后再从下到上依次执行afterCompletion方法
 * 
 * @author flying
 * @version 2019-02-21
 */
public class AuthInterceptor implements HandlerInterceptor {

	private static UserTokenDao userTokenDao = SpringContextHolder.getBean(UserTokenDao.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 从header中获取token
		String token = request.getHeader("token");
		// 如果header中不存在token，则从参数中获取token
		if (StringUtils.isBlank(token)) {
			token = request.getParameter("token");
		}

		// token为空
		if (StringUtils.isBlank(token)) {
			throw new RestException("token不能为空");
		}

		// 查询token信息
		UserToken userToken = userTokenDao.getByToken(token);
		if (userToken == null || userToken.getExpireDate().getTime() < System.currentTimeMillis()) {
			throw new RestException(HttpStatus.UNAUTHORIZED.value(), "token失效，请重新登录");
		}

		// 设置userId到request里，后续根据userId，获取用户信息
		request.setAttribute("userId", userToken.getUserId());

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

}