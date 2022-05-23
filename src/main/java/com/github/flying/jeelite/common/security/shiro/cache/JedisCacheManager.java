/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.security.shiro.cache;

import java.util.Collection;
import java.util.Collections;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.collect.Sets;
import com.github.flying.jeelite.common.utils.JedisUtils;
import com.github.flying.jeelite.common.utils.SpringContextHolder;
import com.github.flying.jeelite.common.utils.redis.JedisClient;
import com.github.flying.jeelite.common.web.Servlets;

/**
 * 自定义授权缓存管理类
 *
 * @author flying
 * @version 2014-7-20
 */
public class JedisCacheManager implements CacheManager {

	private String cacheKeyPrefix = "shiro_cache_";

	@Override
	public <K, V> Cache<K, V> getCache(String name) throws CacheException {
		return new JedisCache<K, V>(cacheKeyPrefix + name);
	}

	public String getCacheKeyPrefix() {
		return cacheKeyPrefix;
	}

	public void setCacheKeyPrefix(String cacheKeyPrefix) {
		this.cacheKeyPrefix = cacheKeyPrefix;
	}

	/**
	 * 自定义授权缓存管理类
	 *
	 * @author flying
	 * @version 2014-7-20
	 */
	public class JedisCache<K, V> implements Cache<K, V> {

		private Logger logger = LoggerFactory.getLogger(getClass());
	    private JedisClient jedisClient = SpringContextHolder.getBean(JedisClient.class);

		private String cacheKeyName = null;

		public JedisCache(String cacheKeyName) {
			this.cacheKeyName = cacheKeyName;
			// if (!jedisClient.exists(cacheKeyName)){
			// Map<String, Object> map = Maps.newHashMap();
			// jedisClient.setObjectMap(cacheKeyName, map, 60 * 60 * 24);
			// }
		}

		@Override
		public V get(K key) throws CacheException {
			if (key == null) {
				return null;
			}

			V v = null;
			HttpServletRequest request = Servlets.getRequest();
			if (request != null) {
				v = (V) request.getAttribute(cacheKeyName);
				if (v != null) {
					return v;
				}
			}

			V value = null;
			try {
				value = (V) jedisClient.getHashObject(cacheKeyName, key);
			} catch (Exception e) {
				logger.error("get {} {} {}", cacheKeyName, key, request != null ? request.getRequestURI() : "", e);
			} finally {
			}

			if (request != null && value != null) {
				request.setAttribute(cacheKeyName, value);
			}

			return value;
		}

		@Override
		public V put(K key, V value) throws CacheException {
			if (key == null) {
				return null;
			}

            jedisClient.setHashObject(cacheKeyName, key, value);
			return value;
		}

		@Override
		public V remove(K key) throws CacheException {
			V value = (V) jedisClient.getHashObject(cacheKeyName, key);
            jedisClient.mapObjectRemove(cacheKeyName, key);
			return value;
		}

		@Override
		public void clear() throws CacheException {
            jedisClient.mapObjectClear(cacheKeyName);
		}

		@Override
		public int size() {
			return jedisClient.getHashObjectSize(cacheKeyName);
		}

		@Override
		public Set<K> keys() {
			Set<K> keys = Sets.newHashSet();
            Set<byte[]> set = jedisClient.getHashObjectKeys(cacheKeyName);
            for (byte[] key : set) {
                Object obj = JedisUtils.getObjectKey(key);
                if (obj != null) {
                    keys.add((K) obj);
                }
            }
            return keys;
		}

		@Override
		public Collection<V> values() {
			Collection<V> vals = Collections.emptyList();
            Collection<byte[]> col = jedisClient.getHashObjectValues(cacheKeyName);
            for (byte[] val : col) {
                Object obj = JedisUtils.toObject(val);
                if (obj != null) {
                    vals.add((V) obj);
                }
            }
            return vals;
		}
	}
}