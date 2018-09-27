/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.flying.jeelite.common.utils.CacheUtils;
import com.github.flying.jeelite.common.utils.CookieUtils;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.common.web.Servlets;
import com.github.flying.jeelite.modules.sys.security.FormAuthenticationFilter;
import com.github.flying.jeelite.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;
import com.google.common.collect.Maps;

/**
 * 登录Controller
 *
 * @author flying
 */
@Controller
@RequestMapping(value = "${adminPath}")
public class LoginController extends BaseController {

	/**
	 * 管理登录
	 */
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response) {
		Principal principal = UserUtils.getPrincipal();

		// 默认不显示页签
		String tabmode = CookieUtils.getCookie(request, "tabmode");
		if (tabmode == null){
			CookieUtils.setCookie(response, "tabmode", "0");
		}

		// 如果已经登录，则跳转到管理首页
		if (principal != null) {
			return "redirect:" + adminPath;
		}
		return "modules/sys/sysLogin";
	}

	/**
	 * 登录失败，真正登录的POST请求由Filter完成
	 */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginFail(HttpServletRequest request, HttpServletResponse response, Model model) {
		Principal principal = UserUtils.getPrincipal();

		// 如果已经登录，则跳转到管理首页
		if (principal != null) {
			return "redirect:" + adminPath;
		}

		String message = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM);
		if (StringUtils.isBlank(message) || StringUtils.equals(message, "null")) {
			message = "用户名或密码错误，请重试";
		}
		model.addAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM, message);
		// 登录失败，验证码加1。
		// String username = WebUtils.getCleanParam(request, FormAuthenticationFilter.DEFAULT_USERNAME_PARAM);
		// model.addAttribute("isValidateCodeLogin", isValidateCodeLogin(username, true, false));

		// 登录操作如果是Ajax操作，直接返回登录信息字符串。
		if (Servlets.isAjaxRequest(request)) {
			return renderString(response, model);
		}
		return "modules/sys/sysLogin";
	}

	/**
	 * 登录成功，进入管理首页
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "")
	public String index(HttpServletRequest request, HttpServletResponse response) {
		Principal principal = UserUtils.getPrincipal();

		// 登录成功后，验证码计算器清零
		// isValidateCodeLogin(principal.getLoginName(), false, true);

		// 登录操作如果是Ajax操作，直接返回登录信息字符串。
		if (Servlets.isAjaxRequest(request)) {
			return renderString(response, principal);
		}

		return "modules/sys/sysIndex";
	}

	/**
	 * 是否是验证码登录
	 *
	 * @param useruame 用户名
	 * @param isFail 计数加1
	 * @param clean 计数清零
	 */
	public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean) {
		Map<String, Integer> loginFailMap = (Map<String, Integer>) CacheUtils.get("loginFailMap");
		if (loginFailMap == null) {
			loginFailMap = Maps.newHashMap();
			CacheUtils.put("loginFailMap", loginFailMap);
		}
		Integer loginFailNum = loginFailMap.get(useruame);
		if (loginFailNum == null) {
			loginFailNum = 0;
		}
		if (isFail) {
			loginFailNum++;
			loginFailMap.put(useruame, loginFailNum);
		}
		if (clean) {
			loginFailMap.remove(useruame);
		}
		return loginFailNum >= 3;
	}
}