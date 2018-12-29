package com.github.flying.jeelite.modules.config;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.Filter;

import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.apache.shiro.mgt.RememberMeManager;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import com.github.flying.jeelite.common.filter.ForceLogoutFilter;
import com.github.flying.jeelite.common.security.shiro.cache.JedisCacheManager;
import com.github.flying.jeelite.common.security.shiro.session.CacheSessionDAO;
import com.github.flying.jeelite.common.security.shiro.session.JedisSessionDAO;
import com.github.flying.jeelite.common.security.shiro.session.SessionDAO;
import com.github.flying.jeelite.common.security.shiro.session.SessionManager;
import com.github.flying.jeelite.common.utils.Encodes;
import com.github.flying.jeelite.common.utils.IdGen;
import com.github.flying.jeelite.modules.sys.security.FormAuthenticationFilter;
import com.github.flying.jeelite.modules.sys.security.SystemAuthorizingRealm;

@Configuration
public class ShiroConfig {

	@Value("${adminPath}")
	private String adminPath;
	@Value("${session.sessionTimeout}")
	private Long sessionTimeout;
	@Value("${session.sessionTimeoutClean}")
	private Long sessionTimeoutClean;
	@Value("${redis.keyPrefix}")
	private String redisKeyPrefix;

	/**
	 * shiro认证过滤器
	 */
	@Bean(name = "shiroFilter")
	public ShiroFilterFactoryBean shiroFilter(SecurityManager securityManager) {
		ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
		shiroFilterFactoryBean.setSecurityManager(securityManager);
		// 过滤器
		Map<String, Filter> filtersMap = shiroFilterFactoryBean.getFilters();
		FormAuthenticationFilter formAuthenticationFilter = new FormAuthenticationFilter();
		filtersMap.put("authc", formAuthenticationFilter);
		// 强制用户下线过滤器
		ForceLogoutFilter forceLogoutFilter = new ForceLogoutFilter();
		filtersMap.put("forceLogout", forceLogoutFilter);
		shiroFilterFactoryBean.setFilters(filtersMap);
		// 配置登录的url和登录成功的url
		shiroFilterFactoryBean.setLoginUrl(adminPath + "/login");
		shiroFilterFactoryBean.setSuccessUrl(adminPath);
		// 配置访问权限
		Map<String, String> filterChainDefinitionMap = new LinkedHashMap<String, String>();
		filterChainDefinitionMap.put("/static/**", "anon");
		filterChainDefinitionMap.put("/userfiles/**", "anon");
		filterChainDefinitionMap.put(adminPath + "/login", "authc");
		filterChainDefinitionMap.put(adminPath + "/logout", "logout");
		filterChainDefinitionMap.put(adminPath + "/**", "forceLogout,user");
		shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
		return shiroFilterFactoryBean;
	}

	/**
	 * 配置核心安全管理器
	 */
	@Bean
	public SecurityManager securityManager(SystemAuthorizingRealm systemAuthorizingRealm, SessionManager sessionManager,
			CacheManager cacheManager, RememberMeManager rememberMeManager) {
		DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
		securityManager.setRealm(systemAuthorizingRealm);
		securityManager.setSessionManager(sessionManager);
		securityManager.setCacheManager(cacheManager);
		securityManager.setRememberMeManager(rememberMeManager);
		return securityManager;
	}

	/**
	 * 系统安全认证
	 */
	@Bean
	public SystemAuthorizingRealm systemAuthorizingRealm() {
		SystemAuthorizingRealm systemAuthorizingRealm = new SystemAuthorizingRealm();
		// 设定密码校验的Hash算法与迭代次数
		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher("SHA-1");
		matcher.setHashIterations(1024);
		systemAuthorizingRealm.setCredentialsMatcher(matcher);
		return systemAuthorizingRealm;
	}

	/**
	 *  shiro生命周期处理器，实现初始化和销毁回调
	 */
//	@Bean(name = "lifecycleBeanPostProcessor")
//	public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
//		return new LifecycleBeanPostProcessor();
//	}

	/**
	 * shiro过滤器代理配置
	 */
//	@Bean
//	@DependsOn("lifecycleBeanPostProcessor")
//	public DefaultAdvisorAutoProxyCreator getDefaultAdvisorAutoProxyCreator() {
//		DefaultAdvisorAutoProxyCreator proxyCreator = new DefaultAdvisorAutoProxyCreator();
//		proxyCreator.setProxyTargetClass(true);
//		return proxyCreator;
//	}

	/**
	 *  启用Shrio授权注解拦截方式，AOP式方法级权限检查
	 */
	@Bean
	public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(SecurityManager securityManager) {
		AuthorizationAttributeSourceAdvisor advisor = new AuthorizationAttributeSourceAdvisor();
		advisor.setSecurityManager(securityManager);
		return advisor;
	}

	/**
	 * 自定义会话管理配置
	 */
	@Bean
	public SessionManager sessionManager(SessionDAO sessionDAO) {
		SessionManager sessionManager = new SessionManager();
		sessionManager.setSessionDAO(sessionDAO);
		sessionManager.setGlobalSessionTimeout(sessionTimeout);
		// url中是否显示session Id
		sessionManager.setSessionIdUrlRewritingEnabled(false);
		// 定时清理失效会话, 清理用户直接关闭浏览器造成的孤立会话
		sessionManager.setSessionValidationInterval(sessionTimeoutClean);
		sessionManager.setSessionValidationSchedulerEnabled(true);
		// 指定本系统SESSIONID, 默认为: JSESSIONID 问题: 与SERVLET容器名冲突, 如JETTY, TOMCAT 等默认JSESSIONID,
		// 当跳出SHIRO SERVLET时如ERROR-PAGE容器会为JSESSIONID重新分配值导致登录会话丢失
		SimpleCookie sessionIdCookie = new SimpleCookie("jeelite.session.id");
		sessionManager.setSessionIdCookie(sessionIdCookie);
		return sessionManager;
	}

	/**
	 * 自定义Session存储容器(ehcache)
	 */
	@Bean
	@ConditionalOnProperty(name = "redis.enabled", havingValue = "false", matchIfMissing = true)
	public SessionDAO cacheSessionDAO(CacheManager cacheManager) {
		CacheSessionDAO sessionDAO = new CacheSessionDAO();
		sessionDAO.setSessionIdGenerator(new IdGen());
		sessionDAO.setCacheManager(cacheManager);
		sessionDAO.setActiveSessionsCacheName("activeSessionsCache");
		return sessionDAO;
	}

	/**
	 * 自定义Session存储容器(redis)
	 */
	@Bean
	@ConditionalOnProperty(name = "redis.enabled", havingValue = "true", matchIfMissing = false)
	public SessionDAO jedisSessionDAO() {
		JedisSessionDAO sessionDAO = new JedisSessionDAO();
		sessionDAO.setSessionIdGenerator(new IdGen());
		sessionDAO.setSessionKeyPrefix(redisKeyPrefix + "_session_");
		return sessionDAO;
	}
	
	/**
	 * shiro缓存管理器(ehcache)
	 */
	@Bean
	@ConditionalOnProperty(name = "redis.enabled", havingValue = "false", matchIfMissing = true)
	public CacheManager ehCacheManager(EhCacheManagerFactoryBean ehCache) {
		EhCacheManager cacheManager = new EhCacheManager();
		cacheManager.setCacheManager(ehCache.getObject());
		return cacheManager;
	}

	/**
	 * shiro缓存管理器(redis)
	 */
	@Bean
	@ConditionalOnProperty(name = "redis.enabled", havingValue = "true", matchIfMissing = false)
	public CacheManager jedisCacheManager() {
		JedisCacheManager cacheManager = new JedisCacheManager();
		cacheManager.setCacheKeyPrefix(redisKeyPrefix + "_cache_");
		return cacheManager;
	}

	/**
	 * rememberMe管理器
	 */
	@Bean
	public CookieRememberMeManager rememberMeManager() {
		CookieRememberMeManager cookieRememberMeManager = new CookieRememberMeManager();
		// 加密密钥，算法:AES,通过代码获取Encodes.encodeBase64(Cryptos.generateAesKey())
		cookieRememberMeManager.setCipherKey(Encodes.decodeBase64("EdMJnZKDsTGfz3OecEuGaA=="));
		// 这个参数是cookie的名称，对应前端的checkbox的name = rememberMe
		SimpleCookie rememberMeCookie = new SimpleCookie("rememberMe");
		// 记住我cookie生效时间7天 ,单位秒
		rememberMeCookie.setMaxAge(604800);
		cookieRememberMeManager.setCookie(rememberMeCookie);
		return cookieRememberMeManager;
	}
}