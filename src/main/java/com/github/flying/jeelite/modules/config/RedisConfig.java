package com.github.flying.jeelite.modules.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

@Configuration
@ConditionalOnProperty(name = "redis.enabled", havingValue = "true")
public class RedisConfig {

	@Value("${redis.host}")
	private String host;
	@Value("${redis.port}")
	private int port;
	@Value("${redis.timeout}")
	private int timeout;
	@Value("${redis.password}")
	private String password;

	@Bean
	public JedisPool jedisPool() {
		JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
		// 最大能够保持idle状态的对象数
		jedisPoolConfig.setMaxIdle(20);
		// 最大分配的对象数
		jedisPoolConfig.setMaxTotal(100);
		// borrow一个jedis实例时，最大的等待时间(毫秒)
		jedisPoolConfig.setMaxWaitMillis(3000L);
		// 当调用borrow Object方法时，是否进行有效性检查
		jedisPoolConfig.setTestOnBorrow(true);
		return new JedisPool(jedisPoolConfig, host, port, timeout, password);
	}

}