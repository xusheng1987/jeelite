package com.github.flying.jeelite.modules.sys.web;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.rest.Result;
import com.github.flying.jeelite.common.security.shiro.session.SessionDAO;
import com.github.flying.jeelite.common.utils.DateUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 在线用户Controller
 *
 * @author flying
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/online")
public class OnlineController extends BaseController {
	
	@Autowired
	private SessionDAO sessionDAO;
	
	/**
	 * 在线用户列表
	 */
	@RequiresPermissions("sys:online:view")
	@RequestMapping(value = "")
	public String list() {
		return "modules/sys/onlineList";
	}
	
	/**
	 * 在线用户列表数据
	 */
	@RequiresPermissions("sys:online:view")
	@RequestMapping(value = "data")
	@ResponseBody
	public Map listData() {
		List<Map<String, String>> list = Lists.newArrayList();
		Collection<Session> sessions = sessionDAO.getActiveSessions(false);
		for (Session session : sessions) {
			// 已强制下线的用户不出现在列表中
			if (session.getAttribute(Global.getSessionForceLogoutKey()) != null) {
				continue;
			}
			PrincipalCollection pc = (PrincipalCollection)session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
			if (pc == null) {
				continue;
			}
			Map<String, String> map = Maps.newLinkedHashMap();
			map.put("id", session.getId().toString()); //会话编号
			map.put("startTimestamp", DateUtils.formatDateTime(session.getStartTimestamp())); //创建时间
			map.put("lastAccessTime", DateUtils.formatDateTime(session.getLastAccessTime())); //最后访问时间
			Principal principal = (Principal)pc.getPrimaryPrincipal();
			map.put("loginName", principal.getLoginName()); //登录名
			map.put("name", principal.getName()); //姓名
			map.put("host", principal.getHost()); //主机
			map.put("browser", principal.getBrowser()); //浏览器类型
			map.put("os", principal.getOs()); //操作系统
			list.add(map);
		}
		return jsonPage(list.size(), list);
	}
	
	/**
	 * 强制下线用户
	 */
	@RequiresPermissions("sys:online:edit")
	@RequestMapping(value = "tickOut")
	@ResponseBody
	public Result tickOut(String sessionId) {
		Session session = sessionDAO.readSession(sessionId);
		if (session != null) {
			// 获取当前会话
			Session currentSession = UserUtils.getSession();
			if (session.getId().equals(currentSession.getId())) {
				return renderError("操作失败，不允许下线当前用户");
			}
			session.setAttribute(Global.getSessionForceLogoutKey(), Boolean.TRUE);
			return renderSuccess("已强制下线该用户");
		}
		return renderError("操作失败，没有找到该在线用户");
	}
	
}