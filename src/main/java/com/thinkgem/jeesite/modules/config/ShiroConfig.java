package com.thinkgem.jeesite.modules.config;

import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.Filter;

import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.security.shiro.session.CacheSessionDAO;
import com.thinkgem.jeesite.common.security.shiro.session.SessionManager;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.security.FormAuthenticationFilter;
import com.thinkgem.jeesite.modules.sys.security.SystemAuthorizingRealm;

@Configuration
public class ShiroConfig {

	@Bean(name = "shiroFilter")
	public ShiroFilterFactoryBean shiroFilter(SecurityManager securityManager) {
		ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
		shiroFilterFactoryBean.setSecurityManager(securityManager);
		// 过滤器
		Map<String, Filter> filtersMap = shiroFilterFactoryBean.getFilters();
		FormAuthenticationFilter formAuthenticationFilter = new FormAuthenticationFilter();
		filtersMap.put("authc", formAuthenticationFilter);
		shiroFilterFactoryBean.setFilters(filtersMap);
		// 配置登录的url和登录成功的url
		String adminPath = Global.getAdminPath();
		shiroFilterFactoryBean.setLoginUrl(adminPath + "/login");
		shiroFilterFactoryBean.setSuccessUrl(adminPath);
		// 配置访问权限
		LinkedHashMap<String, String> filterChainDefinitionMap = new LinkedHashMap<>();
		filterChainDefinitionMap.put("/static/**", "anon");
		filterChainDefinitionMap.put("/userfiles/**", "anon");
		filterChainDefinitionMap.put(adminPath + "/login", "authc");
		filterChainDefinitionMap.put(adminPath + "/logout", "logout");
		filterChainDefinitionMap.put(adminPath + "/**", "user");
		shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
		return shiroFilterFactoryBean;
	}

	// 配置核心安全事务管理器
	@Bean
	public SecurityManager securityManager(SystemAuthorizingRealm systemAuthorizingRealm,
			SessionManager sessionManager) {
		DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
		securityManager.setRealm(systemAuthorizingRealm);
		securityManager.setSessionManager(sessionManager);
		securityManager.setCacheManager(ehCacheManager());
		securityManager.setRememberMeManager(rememberMeManager());
		return securityManager;
	}

	/**
	 * 身份认证realm
	 */
	@Bean
	public SystemAuthorizingRealm systemAuthorizingRealm() {
		SystemAuthorizingRealm systemAuthorizingRealm = new SystemAuthorizingRealm();
		systemAuthorizingRealm.setCredentialsMatcher(hashedCredentialsMatcher());
		return systemAuthorizingRealm;
	}

	/**
	 * 设定密码校验的Hash算法与迭代次数
	 */
	@Bean
	public HashedCredentialsMatcher hashedCredentialsMatcher() {
		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher("SHA-1");
		matcher.setHashIterations(1024);
		return matcher;
	}

	// @Bean(name="lifecycleBeanPostProcessor")
	// public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
	// return new LifecycleBeanPostProcessor();
	// }
	//
	// @Bean
	// @DependsOn({ "lifecycleBeanPostProcessor" })
	// public DefaultAdvisorAutoProxyCreator getDefaultAdvisorAutoProxyCreator() {
	// DefaultAdvisorAutoProxyCreator bean = new DefaultAdvisorAutoProxyCreator();
	// bean.setProxyTargetClass(true);
	// return bean;
	// }

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
	public SessionManager sessionManager(CacheSessionDAO sessionDAO) {
		SessionManager sessionManager = new SessionManager();
		sessionManager.setSessionDAO(sessionDAO);
		sessionManager.setGlobalSessionTimeout(1800000);
		// url中是否显示session Id
		sessionManager.setSessionIdUrlRewritingEnabled(false);
		sessionManager.setSessionValidationInterval(120000);
		sessionManager.setSessionValidationSchedulerEnabled(true);
		SimpleCookie sessionIdCookie = new SimpleCookie("jeesite.session.id");
		sessionManager.setSessionIdCookie(sessionIdCookie);
		return sessionManager;
	}

	/**
	 * 自定义Session存储容器
	 */
	@Bean
	public CacheSessionDAO sessionDAO() {
		CacheSessionDAO sessionDAO = new CacheSessionDAO();
		sessionDAO.setCacheManager(ehCacheManager());
		sessionDAO.setActiveSessionsCacheName("activeSessionsCache");
		return sessionDAO;
	}

	/**
	 * shiro缓存管理器;
	 */
	@Bean
	public EhCacheManager ehCacheManager() {
		EhCacheManager cacheManager = new EhCacheManager();
		cacheManager.setCacheManagerConfigFile("classpath:cache/ehcache-local.xml");
		return cacheManager;
	}

	/**
	 * cookie对象;
	 *
	 * @return
	 */
	@Bean
	public SimpleCookie rememberMeCookie() {
		// 这个参数是cookie的名称，对应前端的checkbox的name = rememberMe
		SimpleCookie simpleCookie = new SimpleCookie("rememberMe");
		// <!-- 记住我cookie生效时间7天 ,单位秒;-->
		simpleCookie.setMaxAge(604800);
		return simpleCookie;
	}

	/**
	 * cookie管理对象;
	 *
	 * @return
	 */
	@Bean
	public CookieRememberMeManager rememberMeManager() {
		CookieRememberMeManager cookieRememberMeManager = new CookieRememberMeManager();
		cookieRememberMeManager.setCipherKey(Arrays.copyOf(StringUtils.getBytes("jeesite"), 16));
		cookieRememberMeManager.setCookie(rememberMeCookie());
		return cookieRememberMeManager;
	}
}