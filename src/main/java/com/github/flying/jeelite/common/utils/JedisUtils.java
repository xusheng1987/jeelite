/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.utils;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * Jedis Cache 工具类
 *
 * @author flying
 * @version 2014-6-29
 */
public class JedisUtils {

	private static Logger logger = LoggerFactory.getLogger(JedisUtils.class);

	private static JedisPool jedisPool = SpringContextHolder.getBean(JedisPool.class);

	/**
	 * 获取缓存
	 *
	 * @param key 键
	 */
	public static String get(String key) {
		String value = null;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(key)) {
				value = jedis.get(key);
				value = StringUtils.isNotBlank(value) && !"nil".equalsIgnoreCase(value) ? value : null;
			}
		} catch (Exception e) {
			logger.warn("get {}", key, e);
		}
		return value;
	}

	/**
	 * 获取缓存
	 *
	 * @param key 键
	 */
	public static Object getObject(String key) {
		Object value = null;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(getBytesKey(key))) {
				value = toObject(jedis.get(getBytesKey(key)));
			}
		} catch (Exception e) {
			logger.warn("getObject {}", key, e);
		}
		return value;
	}

	/**
	 * 设置缓存
	 *
	 * @param key 键
	 * @param value 值
	 * @param cacheSeconds 超时时间，0为不超时
	 */
	public static String set(String key, String value, int cacheSeconds) {
		String result = null;
		try (Jedis jedis = getResource()) {
			result = jedis.set(key, value);
			if (cacheSeconds != 0) {
				jedis.expire(key, cacheSeconds);
			}
		} catch (Exception e) {
			logger.warn("set {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 设置缓存
	 *
	 * @param key 键
	 * @param value 值
	 * @param cacheSeconds 超时时间，0为不超时
	 */
	public static String setObject(String key, Object value, int cacheSeconds) {
		String result = null;
		try (Jedis jedis = getResource()) {
			result = jedis.set(getBytesKey(key), toBytes(value));
			if (cacheSeconds != 0) {
				jedis.expire(key, cacheSeconds);
			}
		} catch (Exception e) {
			logger.warn("setObject {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 获取List缓存
	 *
	 * @param key 键
	 */
	public static List<String> getList(String key) {
		List<String> value = null;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(key)) {
				value = jedis.lrange(key, 0, -1);
			}
		} catch (Exception e) {
			logger.warn("getList {} = {}", key, value, e);
		}
		return value;
	}

	/**
	 * 获取List缓存
	 *
	 * @param key 键
	 */
	public static List<Object> getObjectList(String key) {
		List<Object> value = null;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(getBytesKey(key))) {
				List<byte[]> list = jedis.lrange(getBytesKey(key), 0, -1);
				value = Lists.newArrayList();
				for (byte[] bs : list) {
					value.add(toObject(bs));
				}
			}
		} catch (Exception e) {
			logger.warn("getObjectList {} = {}", key, value, e);
		}
		return value;
	}

	/**
	 * 设置List缓存
	 *
	 * @param key 键
	 * @param value 值
	 * @param cacheSeconds 超时时间，0为不超时
	 */
	public static long setList(String key, List<String> value, int cacheSeconds) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(key)) {
				jedis.del(key);
			}
			result = jedis.rpush(key, value.toArray(new String[value.size()]));
			if (cacheSeconds != 0) {
				jedis.expire(key, cacheSeconds);
			}
		} catch (Exception e) {
			logger.warn("setList {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 设置List缓存
	 *
	 * @param key 键
	 * @param value 值
	 * @param cacheSeconds 超时时间，0为不超时
	 */
	public static long setObjectList(String key, List<Object> value, int cacheSeconds) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(getBytesKey(key))) {
				jedis.del(key);
			}
			List<byte[]> list = Lists.newArrayList();
			for (Object o : value) {
				list.add(toBytes(o));
			}
			result = jedis.rpush(getBytesKey(key), list.toArray(new byte[list.size()][]));
			if (cacheSeconds != 0) {
				jedis.expire(key, cacheSeconds);
			}
		} catch (Exception e) {
			logger.warn("setObjectList {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 向List缓存中添加值
	 *
	 * @param key 键
	 * @param value 值
	 */
	public static long listAdd(String key, String... value) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			result = jedis.rpush(key, value);
		} catch (Exception e) {
			logger.warn("listAdd {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 向List缓存中添加值
	 *
	 * @param key 键
	 * @param value 值
	 */
	public static long listObjectAdd(String key, Object... value) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			List<byte[]> list = Lists.newArrayList();
			for (Object o : value) {
				list.add(toBytes(o));
			}
			result = jedis.rpush(getBytesKey(key), list.toArray(new byte[list.size()][]));
		} catch (Exception e) {
			logger.warn("listObjectAdd {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 获取缓存
	 *
	 * @param key 键
	 */
	public static Set<String> getSet(String key) {
		Set<String> value = null;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(key)) {
				value = jedis.smembers(key);
			}
		} catch (Exception e) {
			logger.warn("getSet {} = {}", key, value, e);
		}
		return value;
	}

	/**
	 * 获取缓存
	 *
	 * @param key 键
	 */
	public static Set<Object> getObjectSet(String key) {
		Set<Object> value = null;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(getBytesKey(key))) {
				value = Sets.newHashSet();
				Set<byte[]> set = jedis.smembers(getBytesKey(key));
				for (byte[] bs : set) {
					value.add(toObject(bs));
				}
			}
		} catch (Exception e) {
			logger.warn("getObjectSet {} = {}", key, value, e);
		}
		return value;
	}

	/**
	 * 设置Set缓存
	 *
	 * @param key 键
	 * @param value 值
	 * @param cacheSeconds 超时时间，0为不超时
	 */
	public static long setSet(String key, Set<String> value, int cacheSeconds) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(key)) {
				jedis.del(key);
			}
			result = jedis.sadd(key, value.toArray(new String[value.size()]));
			if (cacheSeconds != 0) {
				jedis.expire(key, cacheSeconds);
			}
		} catch (Exception e) {
			logger.warn("setSet {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 设置Set缓存
	 *
	 * @param key 键
	 * @param value 值
	 * @param cacheSeconds 超时时间，0为不超时
	 */
	public static long setObjectSet(String key, Set<Object> value, int cacheSeconds) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(getBytesKey(key))) {
				jedis.del(key);
			}
			Set<byte[]> set = Sets.newHashSet();
			for (Object o : value) {
				set.add(toBytes(o));
			}
			result = jedis.sadd(getBytesKey(key), set.toArray(new byte[set.size()][]));
			if (cacheSeconds != 0) {
				jedis.expire(key, cacheSeconds);
			}
		} catch (Exception e) {
			logger.warn("setObjectSet {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 向Set缓存中添加值
	 *
	 * @param key 键
	 * @param value 值
	 */
	public static long setSetAdd(String key, String... value) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			result = jedis.sadd(key, value);
		} catch (Exception e) {
			logger.warn("setSetAdd {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 向Set缓存中添加值
	 *
	 * @param key 键
	 * @param value 值
	 */
	public static long setSetObjectAdd(String key, Object... value) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			Set<byte[]> set = Sets.newHashSet();
			for (Object o : value) {
				set.add(toBytes(o));
			}
			result = jedis.rpush(getBytesKey(key), set.toArray(new byte[set.size()][]));
		} catch (Exception e) {
			logger.warn("setSetObjectAdd {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 获取Map缓存
	 *
	 * @param key 键
	 */
	public static Map<String, String> getMap(String key) {
		Map<String, String> value = null;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(key)) {
				value = jedis.hgetAll(key);
			}
		} catch (Exception e) {
			logger.warn("getMap {} = {}", key, value, e);
		}
		return value;
	}

	/**
	 * 获取Map缓存
	 *
	 * @param key 键
	 */
	public static Map<String, Object> getObjectMap(String key) {
		Map<String, Object> value = null;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(getBytesKey(key))) {
				value = Maps.newHashMap();
				Map<byte[], byte[]> map = jedis.hgetAll(getBytesKey(key));
				for (Map.Entry<byte[], byte[]> e : map.entrySet()) {
					value.put(StringUtils.toString(e.getKey()), toObject(e.getValue()));
				}
			}
		} catch (Exception e) {
			logger.warn("getObjectMap {} = {}", key, value, e);
		}
		return value;
	}

	/**
	 * 设置Map缓存
	 *
	 * @param key 键
	 * @param value 值
	 * @param cacheSeconds 超时时间，0为不超时
	 */
	public static String setMap(String key, Map<String, String> value, int cacheSeconds) {
		String result = null;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(key)) {
				jedis.del(key);
			}
			result = jedis.hmset(key, value);
			if (cacheSeconds != 0) {
				jedis.expire(key, cacheSeconds);
			}
		} catch (Exception e) {
			logger.warn("setMap {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 设置Map缓存
	 *
	 * @param key 键
	 * @param value 值
	 * @param cacheSeconds 超时时间，0为不超时
	 */
	public static String setObjectMap(String key, Map<String, Object> value, int cacheSeconds) {
		String result = null;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(getBytesKey(key))) {
				jedis.del(key);
			}
			Map<byte[], byte[]> map = Maps.newHashMap();
			for (Map.Entry<String, Object> e : value.entrySet()) {
				map.put(getBytesKey(e.getKey()), toBytes(e.getValue()));
			}
			result = jedis.hmset(getBytesKey(key), map);
			if (cacheSeconds != 0) {
				jedis.expire(key, cacheSeconds);
			}
		} catch (Exception e) {
			logger.warn("setObjectMap {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 向Map缓存中添加值
	 *
	 * @param key 键
	 * @param value 值
	 */
	public static String mapPut(String key, Map<String, String> value) {
		String result = null;
		try (Jedis jedis = getResource()) {
			result = jedis.hmset(key, value);
		} catch (Exception e) {
			logger.warn("mapPut {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 向Map缓存中添加值
	 *
	 * @param key 键
	 * @param value 值
	 */
	public static String mapObjectPut(String key, Map<String, Object> value) {
		String result = null;
		try (Jedis jedis = getResource()) {
			Map<byte[], byte[]> map = Maps.newHashMap();
			for (Map.Entry<String, Object> e : value.entrySet()) {
				map.put(getBytesKey(e.getKey()), toBytes(e.getValue()));
			}
			result = jedis.hmset(getBytesKey(key), map);
		} catch (Exception e) {
			logger.warn("mapObjectPut {} = {}", key, value, e);
		}
		return result;
	}

	/**
	 * 移除Map缓存中的值
	 *
	 * @param key 键
	 * @param value 值
	 */
	public static long mapRemove(String key, String mapKey) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			result = jedis.hdel(key, mapKey);
		} catch (Exception e) {
			logger.warn("mapRemove {}  {}", key, mapKey, e);
		}
		return result;
	}

	/**
	 * 移除Map缓存中的值
	 *
	 * @param key 键
	 * @param value 值
	 */
	public static long mapObjectRemove(String key, String mapKey) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			result = jedis.hdel(getBytesKey(key), getBytesKey(mapKey));
		} catch (Exception e) {
			logger.warn("mapObjectRemove {}  {}", key, mapKey, e);
		}
		return result;
	}

	/**
	 * 判断Map缓存中的Key是否存在
	 *
	 * @param key 键
	 * @param value 值
	 */
	public static boolean mapExists(String key, String mapKey) {
		boolean result = false;
		try (Jedis jedis = getResource()) {
			result = jedis.hexists(key, mapKey);
		} catch (Exception e) {
			logger.warn("mapExists {}  {}", key, mapKey, e);
		}
		return result;
	}

	/**
	 * 判断Map缓存中的Key是否存在
	 *
	 * @param key 键
	 * @param value 值
	 */
	public static boolean mapObjectExists(String key, String mapKey) {
		boolean result = false;
		try (Jedis jedis = getResource()) {
			result = jedis.hexists(getBytesKey(key), getBytesKey(mapKey));
		} catch (Exception e) {
			logger.warn("mapObjectExists {}  {}", key, mapKey, e);
		}
		return result;
	}

	/**
	 * 删除缓存
	 *
	 * @param key 键
	 */
	public static long del(String key) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(key)) {
				result = jedis.del(key);
			}
		} catch (Exception e) {
			logger.warn("del {}", key, e);
		}
		return result;
	}

	/**
	 * 删除缓存
	 *
	 * @param key 键
	 */
	public static long delObject(String key) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			if (jedis.exists(getBytesKey(key))) {
				result = jedis.del(getBytesKey(key));
			}
		} catch (Exception e) {
			logger.warn("delObject {}", key, e);
		}
		return result;
	}

	/**
	 * 缓存是否存在
	 *
	 * @param key 键
	 */
	public static boolean exists(String key) {
		boolean result = false;
		try (Jedis jedis = getResource()) {
			result = jedis.exists(key);
		} catch (Exception e) {
			logger.warn("exists {}", key, e);
		}
		return result;
	}

	/**
	 * 缓存是否存在
	 *
	 * @param key 键
	 */
	public static boolean existsObject(String key) {
		boolean result = false;
		try (Jedis jedis = getResource()) {
			result = jedis.exists(getBytesKey(key));
		} catch (Exception e) {
			logger.warn("existsObject {}", key, e);
		}
		return result;
	}

	/**
	 * 获取资源
	 */
	public static Jedis getResource() {
		Jedis jedis = jedisPool.getResource();
		return jedis;
	}

	/**
	 * 释放资源
	 */
	public static void returnResource(Jedis jedis) {
		if (jedis != null) {
			jedis.close();
		}
	}

	/**
	 * 获取byte[]类型Key
	 */
	public static byte[] getBytesKey(Object object) {
		if (object instanceof String) {
			return StringUtils.getBytes((String) object);
		} else {
			return ObjectUtils.serialize(object);
		}
	}

	/**
	 * 获取byte[]类型Key
	 */
	public static Object getObjectKey(byte[] key) {
		try {
			return StringUtils.toString(key);
		} catch (UnsupportedOperationException uoe) {
			try {
				return JedisUtils.toObject(key);
			} catch (UnsupportedOperationException uoe2) {
				uoe2.printStackTrace();
			}
		}
		return null;
	}

	/**
	 * Object转换byte[]类型
	 */
	public static byte[] toBytes(Object object) {
		return ObjectUtils.serialize(object);
	}

	/**
	 * byte[]型转换Object
	 */
	public static Object toObject(byte[] bytes) {
		return ObjectUtils.unserialize(bytes);
	}

}