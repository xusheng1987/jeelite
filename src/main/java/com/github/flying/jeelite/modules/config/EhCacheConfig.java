package com.github.flying.jeelite.modules.config;

import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

@Configuration
public class EhCacheConfig {
	
	@Bean(name = "ehCache")
	public EhCacheManagerFactoryBean ehCache() {
		EhCacheManagerFactoryBean cacheManager = new EhCacheManagerFactoryBean();
		cacheManager.setConfigLocation(new ClassPathResource("cache/ehcache-local.xml"));
		return cacheManager;
	}

}