/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.security.shiro.session;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.SimpleSession;
import org.apache.shiro.session.mgt.eis.AbstractSessionDAO;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.utils.DateUtils;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.utils.redis.JedisClient;
import com.github.flying.jeelite.common.web.Servlets;
import com.google.common.collect.Sets;

/**
 * 自定义授权会话管理类
 *
 * @author flying
 * @version 2014-7-20
 */
public class JedisSessionDAO extends AbstractSessionDAO implements SessionDAO {
	
	@Value("${spring.mvc.view.prefix}")
	private String viewPrefix;
	@Value("${spring.mvc.view.suffix}")
	private String viewSuffix;
    @Autowired
    private JedisClient jedisClient;

	private String sessionKeyPrefix = "shiro_session_";

	@Override
	public void update(Session session) throws UnknownSessionException {
		if (session == null || session.getId() == null) {
			return;
		}

		HttpServletRequest request = Servlets.getRequest();
		if (request != null) {
			String uri = request.getServletPath();
			// 如果是静态文件，则不更新SESSION
			if (Servlets.isStaticFile(uri)) {
				return;
			}
			// 如果是视图文件，则不更新SESSION
			if (StringUtils.startsWith(uri, viewPrefix) && StringUtils.endsWith(uri, viewSuffix)) {
				return;
			}
			// 手动控制不更新SESSION
			if (Global.NO.equals(request.getParameter("updateSession"))) {
				return;
			}
		}

        // 获取登录者编号
        PrincipalCollection pc = (PrincipalCollection) session
                .getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
        String principalId = pc != null ? pc.getPrimaryPrincipal().toString() : StringUtils.EMPTY;

        jedisClient.setHash(sessionKeyPrefix, session.getId().toString(),
                principalId + "|" + session.getTimeout() + "|" + session.getLastAccessTime().getTime());
        // 设置超期时间
        int timeoutSeconds = (int) (session.getTimeout() / 1000);
        jedisClient.setObject(sessionKeyPrefix + session.getId(), session, timeoutSeconds);
	}

	@Override
	public void delete(Session session) {
		if (session == null || session.getId() == null) {
			return;
		}

        jedisClient.mapObjectRemove(sessionKeyPrefix, session.getId().toString());
        jedisClient.delObject(sessionKeyPrefix + session.getId());
	}

	@Override
	public Collection<Session> getActiveSessions() {
		return getActiveSessions(true);
	}

	/**
	 * 获取活动会话
	 *
	 * @param includeLeave 是否包括离线（最后访问时间大于3分钟为离线会话）
	 */
	@Override
	public Collection<Session> getActiveSessions(boolean includeLeave) {
		return getActiveSessions(includeLeave, null, null);
	}

	/**
	 * 获取活动会话
	 *
	 * @param includeLeave 是否包括离线（最后访问时间大于3分钟为离线会话）
	 * @param principal 根据登录者对象获取活动会话
	 * @param filterSession 不为空，则过滤掉（不包含）这个会话。
	 */
	@Override
	public Collection<Session> getActiveSessions(boolean includeLeave, Object principal, Session filterSession) {
		Set<Session> sessions = Sets.newHashSet();

        Map<String, String> map = jedisClient.getHashAll(sessionKeyPrefix);
        for (Map.Entry<String, String> e : map.entrySet()) {
            if (StringUtils.isNotBlank(e.getKey()) && StringUtils.isNotBlank(e.getValue())) {
                String[] ss = StringUtils.split(e.getValue(), "|");
                if (ss != null && ss.length == 3) {
                    SimpleSession session = new SimpleSession();
                    session.setId(e.getKey());
                    session.setAttribute("principalId", ss[0]);
                    session.setTimeout(Long.valueOf(ss[1]));
                    session.setLastAccessTime(new Date(Long.valueOf(ss[2])));
                    try {
                        // 验证SESSION
                        session.validate();

                        boolean isActiveSession = false;
                        // 不包括离线并符合最后访问时间小于等于3分钟条件。
                        if (includeLeave || DateUtils.pastMinutes(session.getLastAccessTime()) <= 3) {
                            isActiveSession = true;
                        }
                        // 符合登陆者条件。
                        if (principal != null) {
                            PrincipalCollection pc = (PrincipalCollection) session
                                    .getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
                            if (principal.toString()
                                    .equals(pc != null ? pc.getPrimaryPrincipal().toString() : StringUtils.EMPTY)) {
                                isActiveSession = true;
                            }
                        }
                        // 过滤掉的SESSION
                        if (filterSession != null && filterSession.getId().equals(session.getId())) {
                            isActiveSession = false;
                        }
                        if (isActiveSession) {
                            sessions.add(session);
                        }

                    }
                    // SESSION验证失败
                    catch (Exception e2) {
                        jedisClient.mapRemove(sessionKeyPrefix, e.getKey());
                    }
                }
                // 存储的SESSION不符合规则
                else {
                    jedisClient.mapRemove(sessionKeyPrefix, e.getKey());
                }
            }
            // 存储的SESSION无Value
            else if (StringUtils.isNotBlank(e.getKey())) {
                jedisClient.mapRemove(sessionKeyPrefix, e.getKey());
            }
        }
		return sessions;
	}

	@Override
	protected Serializable doCreate(Session session) {
		HttpServletRequest request = Servlets.getRequest();
		if (request != null) {
			String uri = request.getServletPath();
			// 如果是静态文件，则不创建SESSION
			if (Servlets.isStaticFile(uri)) {
				return null;
			}
		}
		Serializable sessionId = this.generateSessionId(session);
		this.assignSessionId(session, sessionId);
		this.update(session);
		return sessionId;
	}

	@Override
	protected Session doReadSession(Serializable sessionId) {

		Session s = null;
		HttpServletRequest request = Servlets.getRequest();
		if (request != null) {
			String uri = request.getServletPath();
			// 如果是静态文件，则不获取SESSION
			if (Servlets.isStaticFile(uri)) {
				return null;
			}
			s = (Session) request.getAttribute("session_" + sessionId);
		}
		if (s != null) {
			return s;
		}

		Session session = (Session) jedisClient.getObject(sessionKeyPrefix + sessionId);

		if (request != null && session != null) {
			request.setAttribute("session_" + sessionId, session);
		}

		return session;
	}

	@Override
	public Session readSession(Serializable sessionId) throws UnknownSessionException {
		try {
			return super.readSession(sessionId);
		} catch (UnknownSessionException e) {
			return null;
		}
	}

	public String getSessionKeyPrefix() {
		return sessionKeyPrefix;
	}

	public void setSessionKeyPrefix(String sessionKeyPrefix) {
		this.sessionKeyPrefix = sessionKeyPrefix;
	}

}