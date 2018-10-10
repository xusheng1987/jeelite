package com.github.flying.jeelite.common.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.security.shiro.session.SessionDAO;

/**
 * 强制用户下线Filter
 *
 * @author flying
 * @version 2018-10-10
 */
public class ForceLogoutFilter extends AccessControlFilter {
	
	@Autowired
	private SessionDAO sessionDAO;

	/**
	 * 是否允许访问，返回true表示允许
	 */
	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue)
			throws Exception {
		Session session = getSubject(request, response).getSession(false);
		if (session == null) {
			return true;
		}
		return session.getAttribute(Global.getSessionForceLogoutKey()) == null;
	}

	/**
	 * 表示访问拒绝时是否自己处理，如果返回true表示自己不处理且继续拦截器链执行，返回false表示自己已经处理了（比如重定向到另一个页面）。
	 */
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
		Subject subject = getSubject(request, response);
		Session session = subject.getSession(false);
		// 强制下线
		sessionDAO.delete(session);
		subject.logout();
		String loginUrl = getLoginUrl() + (getLoginUrl().contains("?") ? "&" : "?") + "forceLogout=1";
		WebUtils.issueRedirect(request, response, loginUrl);
		return false;
	}
}