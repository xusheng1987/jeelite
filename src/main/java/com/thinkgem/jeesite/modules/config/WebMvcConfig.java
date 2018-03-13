package com.thinkgem.jeesite.modules.config;

import java.nio.charset.Charset;
import java.util.List;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.google.common.collect.Lists;
import com.opensymphony.sitemesh.webapp.SiteMeshFilter;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.servlet.ValidateCodeServlet;
import com.thinkgem.jeesite.modules.sys.interceptor.LogInterceptor;

@Configuration
public class WebMvcConfig extends WebMvcConfigurerAdapter {

	@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
		// 将StringHttpMessageConverter的默认编码设为UTF-8
		StringHttpMessageConverter stringHttpMessageConverter = new StringHttpMessageConverter(
				Charset.forName("UTF-8"));
		// 将Jackson2HttpMessageConverter的默认格式化输出为false
		MappingJackson2HttpMessageConverter jackson2HttpMessageConverter = new MappingJackson2HttpMessageConverter();
		jackson2HttpMessageConverter.setSupportedMediaTypes(Lists.newArrayList(MediaType.APPLICATION_JSON_UTF8));
		jackson2HttpMessageConverter.setPrettyPrint(false);
		jackson2HttpMessageConverter.setObjectMapper(JsonMapper.getInstance());
		converters.add(stringHttpMessageConverter);
		converters.add(jackson2HttpMessageConverter);
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new LogInterceptor()).addPathPatterns("/a/**").excludePathPatterns("/a/")
				.excludePathPatterns("/a/login").excludePathPatterns("/a/sys/menu/tree")
				.excludePathPatterns("/a/sys/menu/treeData");
	}

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("redirect:/a");
	}

	@Bean
	public FilterRegistrationBean delegatingFilterProxy() {
		FilterRegistrationBean filterRegistration = new FilterRegistrationBean();
		DelegatingFilterProxy shiroFilter = new DelegatingFilterProxy("shiroFilter");
		shiroFilter.setTargetFilterLifecycle(true);
		filterRegistration.setFilter(shiroFilter);
		return filterRegistration;
	}

	@Bean
	public FilterRegistrationBean sitemeshFilter() {
		FilterRegistrationBean filterRegistration = new FilterRegistrationBean();
		SiteMeshFilter sitemeshFilter = new SiteMeshFilter();
		filterRegistration.setFilter(sitemeshFilter);
		filterRegistration.addUrlPatterns("/a/*");
		return filterRegistration;
	}

	@Bean
	public ServletRegistrationBean servletRegistration() {
		ServletRegistrationBean registration = new ServletRegistrationBean(new ValidateCodeServlet(),
				"/servlet/validateCodeServlet");
		return registration;
	}

}