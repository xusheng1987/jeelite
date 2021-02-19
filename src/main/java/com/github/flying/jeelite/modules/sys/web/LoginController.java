/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.utils.CookieUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.common.web.Servlets;
import com.github.flying.jeelite.modules.sys.security.FormAuthenticationFilter;
import com.github.flying.jeelite.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;

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
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		Principal principal = UserUtils.getPrincipal();

		// 默认不显示页签
		String tabmode = CookieUtils.getCookie(request, "tabmode");
		if (tabmode == null){
			CookieUtils.setCookie(response, "tabmode", "0");
		}

		model.addAttribute("productName", Global.getProductName());
		model.addAttribute("captchaEnabled", Global.getCaptchaEnabled());
		model.addAttribute("copyrightYear", Global.getCopyrightYear());
		model.addAttribute("version", Global.getVersion());
		// 如果已经登录，则跳转到管理首页
		if (principal != null) {
			return "redirect:" + adminPath;
		}
		return "modules/sys/sysLogin";
	}

	/**
	 * 登录失败，真正登录的POST请求由FormAuthenticationFilter完成
	 */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginFail(HttpServletRequest request, HttpServletResponse response, Model model) {
		Principal principal = UserUtils.getPrincipal();

		model.addAttribute("productName", Global.getProductName());
		model.addAttribute("captchaEnabled", Global.getCaptchaEnabled());
		model.addAttribute("copyrightYear", Global.getCopyrightYear());
		model.addAttribute("version", Global.getVersion());
		// 如果已经登录，则跳转到管理首页
		if (principal != null) {
			return "redirect:" + adminPath;
		}

		// 错误信息
		String message = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM);
		model.addAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM, message);

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
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		Principal principal = UserUtils.getPrincipal();

		// 登录操作如果是Ajax操作，直接返回登录信息字符串。
		if (Servlets.isAjaxRequest(request)) {
			return renderString(response, principal);
		}

		model.addAttribute("productName", Global.getProductName());
		return "modules/sys/sysIndex";
	}
}