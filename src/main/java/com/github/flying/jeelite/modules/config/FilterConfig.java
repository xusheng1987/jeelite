package com.github.flying.jeelite.modules.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.DelegatingFilterProxy;

import com.github.flying.jeelite.common.config.Global;
import com.opensymphony.sitemesh.webapp.SiteMeshFilter;

@Configuration
public class FilterConfig {

	/**
	 * shiro filter
	 */
	@Bean
	public FilterRegistrationBean delegatingFilterProxy() {
		FilterRegistrationBean filterRegistration = new FilterRegistrationBean();
		DelegatingFilterProxy shiroFilter = new DelegatingFilterProxy("shiroFilter");
		shiroFilter.setTargetFilterLifecycle(true);
		filterRegistration.setFilter(shiroFilter);
		filterRegistration.addUrlPatterns("/*");
		return filterRegistration;
	}

	/**
	 * sitemesh filter
	 */
	@Bean
	public FilterRegistrationBean sitemeshFilter() {
		FilterRegistrationBean filterRegistration = new FilterRegistrationBean();
		SiteMeshFilter sitemeshFilter = new SiteMeshFilter();
		filterRegistration.setFilter(sitemeshFilter);
		filterRegistration.addUrlPatterns(Global.getAdminPath() + "/*");
		return filterRegistration;
	}

}