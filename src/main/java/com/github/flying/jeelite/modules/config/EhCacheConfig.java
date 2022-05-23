package com.github.flying.jeelite.modules.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

@Configuration
@ConditionalOnProperty(name = "redis.enabled", havingValue = "false", matchIfMissing = true)
public class EhCacheConfig {
	
	@Value("${ehcache.configFile}")
	private String configFile;

	@Bean(name = "ehCache")
	public EhCacheManagerFactoryBean ehCache() {
		EhCacheManagerFactoryBean cacheManager = new EhCacheManagerFactoryBean();
		cacheManager.setConfigLocation(new ClassPathResource(configFile));
		return cacheManager;
	}

}