package com.github.flying.jeelite.modules.config;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import redis.clients.jedis.HostAndPort;
import redis.clients.jedis.JedisCluster;
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
    @Value("${redis.cluster.nodes:}")
    private String nodes;

	@Bean
	@ConditionalOnProperty(name = "redis.cluster.enabled", havingValue = "false")
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

    @Bean
    @ConditionalOnProperty(name = "redis.cluster.enabled", havingValue = "true")
    public JedisCluster jedisCluster() {
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        // 最大能够保持idle状态的对象数
        jedisPoolConfig.setMaxIdle(20);
        // 最大分配的对象数
        jedisPoolConfig.setMaxTotal(100);
        // borrow一个jedis实例时，最大的等待时间(毫秒)
        jedisPoolConfig.setMaxWaitMillis(3000L);
        // 当调用borrow Object方法时，是否进行有效性检查
        jedisPoolConfig.setTestOnBorrow(true);
        // redis集群节点
        Set<HostAndPort> nodes = new HashSet<HostAndPort>();
        HostAndPort hostAndPort = new HostAndPort(host, port);
        nodes.add(hostAndPort);
        JedisCluster jedisCluster = new JedisCluster(nodes, timeout, timeout, 10, password, jedisPoolConfig);
        return jedisCluster;
    }

}