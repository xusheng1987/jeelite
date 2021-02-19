/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.security;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.utils.useragent.UserAgent;
import com.github.flying.jeelite.common.utils.useragent.UserAgentUtils;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.utils.Encodes;
import com.github.flying.jeelite.common.utils.IPUtils;
import com.github.flying.jeelite.common.web.Servlets;
import com.github.flying.jeelite.modules.sys.entity.Menu;
import com.github.flying.jeelite.modules.sys.entity.User;
import com.github.flying.jeelite.modules.sys.service.UserService;
import com.github.flying.jeelite.modules.sys.utils.LogUtils;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;
import com.github.flying.jeelite.modules.sys.web.ValidateCodeController;

/**
 * 系统安全认证实现类
 * 
 * @author flying
 * @version 2014-7-5
 */
public class SystemAuthorizingRealm extends AuthorizingRealm {

	@Autowired
	private UserService userService;

	public SystemAuthorizingRealm() {
		this.setCachingEnabled(false);
	}

	/**
	 * 认证回调函数, 登录时调用
	 * Authentication 是用来验证用户身份
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		// 校验登录验证码
		if (Global.TRUE.equals(Global.getCaptchaEnabled())) {
			Session session = UserUtils.getSession();
			String code = (String) session.getAttribute(ValidateCodeController.VALIDATE_CODE);
			if (token.getCaptcha() == null || !token.getCaptcha().toUpperCase().equals(code)) {
				throw new AuthenticationException("msg:验证码错误，请重试");
			}
		}

		// 校验用户名密码
		User user = userService.getUserByLoginName(token.getUsername());
		if (user != null) {
			if (Global.NO.equals(user.getLoginFlag())) {
				throw new AuthenticationException("msg:该已帐号禁止登录");
			}
			byte[] salt = Encodes.decodeHex(user.getPassword().substring(0, 16));
			
			HttpServletRequest request = Servlets.getRequest();
			Principal principal = new Principal(user);
			principal.setHost(StringUtils.getRemoteAddr(request));//主机
			principal.setIpAddress(IPUtils.getIpInfo(principal.getHost()));//IP地址
			UserAgent ua = UserAgentUtils.parse(request);
			principal.setBrowser(ua.getBrowser().toString() + " " + ua.getVersion());//浏览器类型
			principal.setOs(ua.getOs().toString());//操作系统
			return new SimpleAuthenticationInfo(principal, user.getPassword().substring(16),
					ByteSource.Util.bytes(salt), getName());
		} else {
			return null;
		}
	}

	/**
	 * 获取权限授权信息，如果缓存中存在，则直接从缓存中获取，否则就重新获取， 登录成功后调用
	 */
	@Override
	protected AuthorizationInfo getAuthorizationInfo(PrincipalCollection principals) {
		if (principals == null) {
			return null;
		}
		AuthorizationInfo info = (AuthorizationInfo) UserUtils.getCache(UserUtils.CACHE_AUTH_INFO);
		if (info == null) {
			info = doGetAuthorizationInfo(principals);
			if (info != null) {
				UserUtils.putCache(UserUtils.CACHE_AUTH_INFO, info);
			}
		}
		return info;
	}

	/**
	 * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用
	 * Authorization 是授权访问控制，用于对用户进行的操作授权，证明该用户是否允许进行当前操作，如访问某个链接，某个资源文件等。
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		Principal principal = (Principal) getAvailablePrincipal(principals);
		// 获取当前已登录的用户
		if (!Global.TRUE.equals(Global.getMultiAccountLogin())) {
			Collection<Session> sessions = userService.getSessionDao().getActiveSessions(true, principal,
					UserUtils.getSession());
			if (sessions.size() > 0) {
				// 如果是登录进来的，则踢出已在线用户
				if (UserUtils.getSubject().isAuthenticated()) {
					for (Session session : sessions) {
						userService.getSessionDao().delete(session);
					}
				}
				// 记住我进来的，并且当前用户已登录，则退出当前用户提示信息。
				else {
					UserUtils.getSubject().logout();
					throw new AuthenticationException("msg:账号已在其它地方登录，请重新登录");
				}
			}
		}
		User user = userService.getUserByLoginName(principal.getLoginName());
		if (user != null) {
			SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
			List<Menu> list = UserUtils.getMenuList();
			for (Menu menu : list) {
				if (StringUtils.isNotBlank(menu.getPermission())) {
					// 添加基于Permission的权限信息
					for (String permission : StringUtils.split(menu.getPermission(), ",")) {
						info.addStringPermission(permission);
					}
				}
			}
			// 添加用户权限
			info.addStringPermission("user");
			// 更新登录IP和时间
			userService.updateUserLoginInfo(user);
			// 记录登录日志
			LogUtils.saveLog(Servlets.getRequest(), "系统登录");
			return info;
		} else {
			return null;
		}
	}

	/**
	 * 授权用户信息
	 */
	public static class Principal implements Serializable {

		private static final long serialVersionUID = 1L;

		private String id; // 编号
		private String loginName; // 登录名
		private String name; // 姓名
		private String host; // 主机
		private String ipAddress; // IP对应的地址
		private String browser; // 浏览器类型
		private String os; // 操作系统

		public Principal(User user) {
			this.id = user.getId();
			this.loginName = user.getLoginName();
			this.name = user.getName();
		}

		public String getId() {
			return id;
		}

		public String getLoginName() {
			return loginName;
		}

		public String getName() {
			return name;
		}

		public String getHost() {
			return host;
		}

		public void setHost(String host) {
			this.host = host;
		}

		public String getIpAddress() {
			return ipAddress;
		}

		public void setIpAddress(String ipAddress) {
			this.ipAddress = ipAddress;
		}

		public String getBrowser() {
			return browser;
		}

		public void setBrowser(String browser) {
			this.browser = browser;
		}

		public String getOs() {
			return os;
		}

		public void setOs(String os) {
			this.os = os;
		}

		@Override
		public String toString() {
			return id;
		}

	}
}