package com.github.flying.jeelite.common.utils.redis;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.stereotype.Component;

import com.github.flying.jeelite.common.utils.StringUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * Redis单机模式
 */
@Component
@ConditionalOnExpression("${redis.enabled} && !${redis.cluster.enabled}")
public class JedisClientPool implements JedisClient {
    private Logger logger = LoggerFactory.getLogger(JedisClientPool.class);
    @Autowired
    private JedisPool jedisPool;

	/**
	 * 获取缓存
	 *
	 * @param key 键
	 */
    @Override
	public String get(String key) {
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
    @Override
	public Object getObject(String key) {
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
    @Override
	public String set(String key, String value, int cacheSeconds) {
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
    @Override
	public String setObject(String key, Object value, int cacheSeconds) {
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
     * 返回Hash表中元素的数量
     *
     * @param key 键
     */
    @Override
    public int getHashSize(String key) {
        int result = 0;
        try (Jedis jedis = getResource()) {
            result = jedis.hlen(key).intValue();
        } catch (Exception e) {
            logger.warn("getHashSize {}", key, e);
        }
        return result;
    }

    /**
     * 返回Hash表中元素的数量
     *
     * @param key 键
     */
    @Override
    public int getHashObjectSize(String key) {
        int result = 0;
        try (Jedis jedis = getResource()) {
            result = jedis.hlen(getBytesKey(key)).intValue();
        } catch (Exception e) {
            logger.warn("getHashObjectSize {}", key, e);
        }
        return result;
    }

    /**
     * 返回Hash表中所有的域field
     *
     * @param key 键
     */
    @Override
    public Set<String> getHashKeys(String key) {
        Set<String> result = Sets.newHashSet();
        try (Jedis jedis = getResource()) {
            result = jedis.hkeys(key);
        } catch (Exception e) {
            logger.warn("getHashKeys {}", key, e);
        }
        return result;
    }

    /**
     * 返回Hash表中所有的域field
     *
     * @param key 键
     */
    @Override
    public Set<byte[]> getHashObjectKeys(String key) {
        Set<byte[]> result = Sets.newHashSet();
        try (Jedis jedis = getResource()) {
            result = jedis.hkeys(getBytesKey(key));
        } catch (Exception e) {
            logger.warn("getHashObjectKeys {}", key, e);
        }
        return result;
    }

    /**
     * 返回Hash表中所有的值value
     *
     * @param key 键
     */
    @Override
    public Collection<String> getHashValues(String key) {
        Collection<String> result = CollectionUtils.EMPTY_COLLECTION;
        try (Jedis jedis = getResource()) {
            result = jedis.hvals(key);
        } catch (Exception e) {
            logger.warn("getHashValues {}", key, e);
        }
        return result;
    }

    /**
     * 返回Hash表中所有的值value
     *
     * @param key 键
     */
    @Override
    public Collection<byte[]> getHashObjectValues(String key) {
        Collection<byte[]> result = CollectionUtils.EMPTY_COLLECTION;
        try (Jedis jedis = getResource()) {
            result = jedis.hvals(getBytesKey(key));
        } catch (Exception e) {
            logger.warn("getHashValues {}", key, e);
        }
        return result;
    }

    /**
     * 返回Hash表中所有的域field和值value
     *
     * @param key 键
     */
    @Override
    public Map<String, String> getHashAll(String key) {
        Map<String, String> result = Maps.newHashMap();
        try (Jedis jedis = getResource()) {
            result = jedis.hgetAll(key);
        } catch (Exception e) {
            logger.warn("getHashAll {}", key, e);
        }
        return result;
    }

    /**
     * 获取Hash表key中的域field的值
     *
     * @param key 键
     * @param field 域
     */
    @Override
    public String getHash(String key, String field) {
        String result = null;
        try (Jedis jedis = getResource()) {
            result = jedis.hget(key, field);
        } catch (Exception e) {
            logger.warn("getHash {} = {}", key, field, e);
        }
        return result;
    }

    /**
     * 获取Hash表key中的域field的值
     *
     * @param key 键
     * @param field 域
     */
    @Override
    public Object getHashObject(String key, Object field) {
        Object result = null;
        try (Jedis jedis = getResource()) {
            result = toObject(jedis.hget(getBytesKey(key), getBytesKey(field)));
        } catch (Exception e) {
            logger.warn("getHash {} = {}", key, field, e);
        }
        return result;
    }

    /**
     * Hash表key中的域field的值设为value
     *
     * @param key Hash表
     * @param field 域
     * @param value 值
     */
    @Override
    public long setHash(String key, String field, String value) {
        long result = 0L;
        try (Jedis jedis = getResource()) {
            result = jedis.hset(key, field, value);
        } catch (Exception e) {
            logger.warn("setHash {} : {} = {}", key, field, value, e);
        }
        return result;
    }

    /**
     * Hash表key中的域field的值设为value
     *
     * @param key Hash表
     * @param field 域
     * @param value 值
     */
    @Override
    public long setHashObject(String key, Object field, Object value) {
        long result = 0L;
        try (Jedis jedis = getResource()) {
            result = jedis.hset(getBytesKey(key), getBytesKey(field), toBytes(value));
        } catch (Exception e) {
            logger.warn("setHash {} : {} = {}", key, field, value, e);
        }
        return result;
    }

	/**
	 * 获取List缓存
	 *
	 * @param key 键
	 */
    @Override
	public List<String> getList(String key) {
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
    @Override
	public List<Object> getObjectList(String key) {
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
    @Override
	public long setList(String key, List<String> value, int cacheSeconds) {
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
    @Override
	public long setObjectList(String key, List<Object> value, int cacheSeconds) {
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
    @Override
	public long listAdd(String key, String... value) {
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
    @Override
	public long listObjectAdd(String key, Object... value) {
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
    @Override
	public Set<String> getSet(String key) {
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
    @Override
	public Set<Object> getObjectSet(String key) {
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
    @Override
	public long setSet(String key, Set<String> value, int cacheSeconds) {
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
    @Override
	public long setObjectSet(String key, Set<Object> value, int cacheSeconds) {
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
    @Override
	public long setSetAdd(String key, String... value) {
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
    @Override
	public long setSetObjectAdd(String key, Object... value) {
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
    @Override
	public Map<String, String> getMap(String key) {
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
    @Override
	public Map<String, Object> getObjectMap(String key) {
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
    @Override
	public String setMap(String key, Map<String, String> value, int cacheSeconds) {
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
    @Override
	public String setObjectMap(String key, Map<String, Object> value, int cacheSeconds) {
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
    @Override
	public String mapPut(String key, Map<String, String> value) {
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
    @Override
	public String mapObjectPut(String key, Map<String, Object> value) {
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
    @Override
	public long mapRemove(String key, String mapKey) {
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
    @Override
	public long mapObjectRemove(String key, Object mapKey) {
		long result = 0;
		try (Jedis jedis = getResource()) {
			result = jedis.hdel(getBytesKey(key), getBytesKey(mapKey));
		} catch (Exception e) {
			logger.warn("mapObjectRemove {}  {}", key, mapKey, e);
		}
		return result;
	}

    /**
     * 清空Map缓存中的值
     *
     * @param key 键
     */
    @Override
    public long mapClear(String key) {
        long result = 0;
        try (Jedis jedis = getResource()) {
            result = jedis.hdel(key);
        } catch (Exception e) {
            logger.warn("mapClear {}", key,e);
        }
        return result;
    }

    /**
     * 清空Map缓存中的值
     *
     * @param key 键
     */
    @Override
    public long mapObjectClear(String key) {
        long result = 0;
        try (Jedis jedis = getResource()) {
            result = jedis.hdel(getBytesKey(key));
        } catch (Exception e) {
            logger.warn("mapObjectClear {}", key, e);
        }
        return result;
    }

	/**
	 * 判断Map缓存中的Key是否存在
	 *
	 * @param key 键
	 * @param value 值
	 */
    @Override
	public boolean mapExists(String key, String mapKey) {
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
    @Override
	public boolean mapObjectExists(String key, Object mapKey) {
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
    @Override
	public long del(String key) {
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
    @Override
	public long delObject(String key) {
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
    @Override
	public boolean exists(String key) {
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
    @Override
	public boolean existsObject(String key) {
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
	private Jedis getResource() {
		Jedis jedis = jedisPool.getResource();
		return jedis;
	}

}