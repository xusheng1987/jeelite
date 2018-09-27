/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.utils;

import java.util.Iterator;
import java.util.Set;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Cache工具类
 * @author flying
 * @version 2013-5-29
 */
public class CacheUtils {

	private static Logger logger = LoggerFactory.getLogger(CacheUtils.class);
	private static CacheManager cacheManager = SpringContextHolder.getBean(CacheManager.class);

	private static final String SYS_CACHE = "sysCache";

	/**
	 * 获取SYS_CACHE缓存
	 */
	public static Object get(String key) {
		return get(SYS_CACHE, key);
	}

	/**
	 * 获取SYS_CACHE缓存
	 */
	public static Object get(String key, Object defaultValue) {
		Object value = get(key);
		return value != null ? value : defaultValue;
	}

	/**
	 * 写入SYS_CACHE缓存
	 */
	public static void put(String key, Object value) {
		put(SYS_CACHE, key, value);
	}

	/**
	 * 从SYS_CACHE缓存中移除
	 */
	public static void remove(String key) {
		remove(SYS_CACHE, key);
	}

	/**
	 * 获取缓存
	 */
	public static Object get(String cacheName, String key) {
		return getCache(cacheName).get(key);
	}

	/**
	 * 获取缓存
	 */
	public static Object get(String cacheName, String key, Object defaultValue) {
		Object value = get(cacheName, key);
		return value != null ? value : defaultValue;
	}

	/**
	 * 写入缓存
	 */
	public static void put(String cacheName, String key, Object value) {
		getCache(cacheName).put(key, value);
	}

	/**
	 * 从缓存中移除
	 */
	public static void remove(String cacheName, String key) {
		getCache(cacheName).remove(key);
	}

	/**
	 * 从缓存中移除所有
	 */
	public static void removeAll(String cacheName) {
		Cache<String, Object> cache = getCache(cacheName);
		Set<String> keys = cache.keys();
		for (Iterator<String> it = keys.iterator(); it.hasNext();){
			cache.remove(it.next());
		}
		logger.info("清理缓存： {} => {}", cacheName, keys);
	}

	/**
	 * 获得一个Cache，没有则显示日志。
	 */
	private static Cache<String, Object> getCache(String cacheName){
		Cache<String, Object> cache = cacheManager.getCache(cacheName);
		if (cache == null){
			throw new RuntimeException("当前系统中没有定义“"+cacheName+"”这个缓存。");
		}
		return cache;
	}

}
