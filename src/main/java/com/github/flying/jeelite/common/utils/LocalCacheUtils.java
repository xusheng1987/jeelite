package com.github.flying.jeelite.common.utils;

import java.util.concurrent.ExecutionException;

import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;

/**
 * 本地缓存工具类demo，使用GuavaCache
 *
 */
public class LocalCacheUtils {

	private static LoadingCache<String, String> loadingCache;

	public static LoadingCache<String, String> getCache() {
		if (loadingCache == null) {// 使用双重校验锁保证只有一个实例,否则在并发环境下会创建多次实例
			synchronized (LocalCacheUtils.class) {
				if (loadingCache == null) {
					// 设置缓存最大个数为200
					loadingCache = CacheBuilder.newBuilder().maximumSize(200).build(new CacheLoader<String, String>() {
							// 缓存不存在时自动加载缓存
							@Override
							public String load(String key) throws Exception {
								// 这里不允许返回null值
								return getDataIfNull(key);
							}
						});
				}
			}
		}
		return loadingCache;
	}
	
	/**
	 * 如果缓存没有，则自动从数据库获取
	 */
	private static String getDataIfNull(String key) {
        return "";
	}
	
	/**
	 * 从缓存获取数据
	 */
	public static String get(String key) {
		try {
			return getCache().get(key);
		} catch (ExecutionException e) {
		}
		return null;
	}
	
	/**
	 * 清除缓存
	 */
	public static void remove(String key) {
		getCache().invalidate(key);
	}
}