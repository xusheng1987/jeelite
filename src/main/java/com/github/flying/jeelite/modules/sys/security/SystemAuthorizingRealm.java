/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.security;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.stereotype.Service;

import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.servlet.ValidateCodeServlet;
import com.github.flying.jeelite.common.utils.Encodes;
import com.github.flying.jeelite.common.utils.SpringContextHolder;
import com.github.flying.jeelite.common.web.Servlets;
import com.github.flying.jeelite.modules.sys.entity.Menu;
import com.github.flying.jeelite.modules.sys.entity.User;
import com.github.flying.jeelite.modules.sys.service.UserService;
import com.github.flying.jeelite.modules.sys.utils.LogUtils;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;
import com.github.flying.jeelite.modules.sys.web.LoginController;

/**
 * 系统安全认证实现类
 * @author flying
 * @version 2014-7-5
 */
@Service
public class SystemAuthorizingRealm extends AuthorizingRealm {

	private UserService userService;

	public SystemAuthorizingRealm() {
		this.setCachingEnabled(false);
	}

	/**
	 * 认证回调函数, 登录时调用
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		// 校验登录验证码
//		if (LoginController.isValidateCodeLogin(token.getUsername(), false, false)){
//			Session session = UserUtils.getSession();
//			String code = (String)session.getAttribute(ValidateCodeServlet.VALIDATE_CODE);
//			if (token.getCaptcha() == null || !token.getCaptcha().toUpperCase().equals(code)){
//				throw new AuthenticationException("msg:验证码错误，请重试");
//			}
//		}

		// 校验用户名密码
		User user = getUserService().getUserByLoginName(token.getUsername());
		if (user != null) {
			if (Global.NO.equals(user.getLoginFlag())){
				throw new AuthenticationException("msg:该已帐号禁止登录");
			}
			byte[] salt = Encodes.decodeHex(user.getPassword().substring(0,16));
			return new SimpleAuthenticationInfo(new Principal(user),
					user.getPassword().substring(16), ByteSource.Util.bytes(salt), getName());
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

        AuthorizationInfo info = null;

        info = (AuthorizationInfo)UserUtils.getCache(UserUtils.CACHE_AUTH_INFO);

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
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		Principal principal = (Principal) getAvailablePrincipal(principals);
		// 获取当前已登录的用户
		if (!Global.TRUE.equals(Global.getConfig("user.multiAccountLogin"))){
			Collection<Session> sessions = getUserService().getSessionDao().getActiveSessions(true, principal, UserUtils.getSession());
			if (sessions.size() > 0){
				// 如果是登录进来的，则踢出已在线用户
				if (UserUtils.getSubject().isAuthenticated()){
					for (Session session : sessions){
						getUserService().getSessionDao().delete(session);
					}
				}
				// 记住我进来的，并且当前用户已登录，则退出当前用户提示信息。
				else{
					UserUtils.getSubject().logout();
					throw new AuthenticationException("msg:账号已在其它地方登录，请重新登录");
				}
			}
		}
		User user = getUserService().getUserByLoginName(principal.getLoginName());
		if (user != null) {
			SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
			List<Menu> list = UserUtils.getMenuList();
			for (Menu menu : list){
				if (StringUtils.isNotBlank(menu.getPermission())){
					// 添加基于Permission的权限信息
					for (String permission : StringUtils.split(menu.getPermission(),",")){
						info.addStringPermission(permission);
					}
				}
			}
			// 添加用户权限
			info.addStringPermission("user");
			// 更新登录IP和时间
			getUserService().updateUserLoginInfo(user);
			// 记录登录日志
			LogUtils.saveLog(Servlets.getRequest(), "系统登录");
			return info;
		} else {
			return null;
		}
	}

	/**
	 * 设定密码校验的Hash算法与迭代次数
	 */
	@PostConstruct
	public void initCredentialsMatcher() {
		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher(UserService.HASH_ALGORITHM);
		matcher.setHashIterations(UserService.HASH_INTERATIONS);
		setCredentialsMatcher(matcher);
	}

	/**
	 * 获取系统业务对象
	 */
	public UserService getUserService() {
		if (userService == null){
			userService = SpringContextHolder.getBean(UserService.class);
		}
		return userService;
	}

	/**
	 * 授权用户信息
	 */
	public static class Principal implements Serializable {

		private static final long serialVersionUID = 1L;

		private String id; // 编号
		private String loginName; // 登录名
		private String name; // 姓名

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

		@Override
		public String toString() {
			return id;
		}

	}
}