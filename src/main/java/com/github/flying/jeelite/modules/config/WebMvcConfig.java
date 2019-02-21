package com.github.flying.jeelite.modules.config;

import java.nio.charset.Charset;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.github.flying.jeelite.common.mapper.JsonMapper;
import com.github.flying.jeelite.modules.sys.interceptor.AuthInterceptor;
import com.github.flying.jeelite.modules.sys.interceptor.LogInterceptor;
import com.google.common.collect.Lists;

@Configuration
public class WebMvcConfig extends WebMvcConfigurerAdapter {

	@Value("${adminPath}")
	private String adminPath;

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

	/**
	 * 配置拦截器
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new AuthInterceptor())
				.addPathPatterns("/api/**")
				.excludePathPatterns("/api/user/login");
		registry.addInterceptor(new LogInterceptor())
				.addPathPatterns(adminPath + "/**", "/api/**")
				.excludePathPatterns(adminPath + "/")
				.excludePathPatterns(adminPath + "/login")
				.excludePathPatterns(adminPath + "/sys/menu/tree")
				.excludePathPatterns(adminPath + "/sys/menu/treeData");
	}

	/**
	 * 定义无Controller的path<->view直接映射
	 */
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("redirect:" + adminPath);
	}

}