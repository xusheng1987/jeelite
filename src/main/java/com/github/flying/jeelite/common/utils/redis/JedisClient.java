package com.github.flying.jeelite.common.utils.redis;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.github.flying.jeelite.common.utils.JedisUtils;

public interface JedisClient {
    /**
     * 缓存是否存在
     *
     * @param key 键
     */
    boolean exists(String key);
    boolean existsObject(String key);
    /**
     * 获取缓存
     *
     * @param key 键
     */
    String get(String key);
    Object getObject(String key);
    /**
     * 设置缓存
     *
     * @param key 键
     * @param value 值
     * @param cacheSeconds 超时时间，0为不超时
     */
    String set(String key, String value, int cacheSeconds);
    String setObject(String key, Object value, int cacheSeconds);
    /**
     * 返回Hash表中元素的数量
     *
     * @param key 键
     */
    int getHashSize(String key);
    int getHashObjectSize(String key);
    /**
     * 返回Hash表中所有的域field
     *
     * @param key 键
     */
    Set<String> getHashKeys(String key);
    Set<byte[]> getHashObjectKeys(String key);
    /**
     * 返回Hash表中所有的值value
     *
     * @param key 键
     */
    Collection<String> getHashValues(String key);
    Collection<byte[]> getHashObjectValues(String key);
    /**
     * 返回Hash表中所有的域field和值value
     *
     * @param key 键
     */
    Map<String, String> getHashAll(String key);
    /**
     * 获取Hash表key中的域field的值
     *
     * @param key 键
     * @param field 域
     */
    String getHash(String key, String field);
    Object getHashObject(String key, Object field);
    /**
     * Hash表key中的域field的值设为value
     *
     * @param key Hash表
     * @param field 域
     * @param value 值
     */
    long setHash(String key, String field, String value);
    long setHashObject(String key, Object field, Object value);
    /**
     * 获取List缓存
     *
     * @param key 键
     */
    List<String> getList(String key);
    List<Object> getObjectList(String key);
    /**
     * 设置List缓存
     *
     * @param key 键
     * @param value 值
     * @param cacheSeconds 超时时间，0为不超时
     */
    long setList(String key, List<String> value, int cacheSeconds);
    long setObjectList(String key, List<Object> value, int cacheSeconds);
    /**
     * 向List缓存中添加值
     *
     * @param key 键
     * @param value 值
     */
    long listAdd(String key, String... value);
    long listObjectAdd(String key, Object... value);
    /**
     * 获取Set缓存
     *
     * @param key 键
     */
    Set<String> getSet(String key);
    Set<Object> getObjectSet(String key);
    /**
     * 设置Set缓存
     *
     * @param key 键
     * @param value 值
     * @param cacheSeconds 超时时间，0为不超时
     */
    long setSet(String key, Set<String> value, int cacheSeconds);
    long setObjectSet(String key, Set<Object> value, int cacheSeconds);
    /**
     * 向Set缓存中添加值
     *
     * @param key 键
     * @param value 值
     */
    long setSetAdd(String key, String... value);
    long setSetObjectAdd(String key, Object... value);
    /**
     * 获取Map缓存
     *
     * @param key 键
     */
    Map<String, String> getMap(String key);
    Map<String, Object> getObjectMap(String key);
    /**
     * 设置Map缓存
     *
     * @param key 键
     * @param value 值
     * @param cacheSeconds 超时时间，0为不超时
     */
    String setMap(String key, Map<String, String> value, int cacheSeconds);
    String setObjectMap(String key, Map<String, Object> value, int cacheSeconds);
    /**
     * 向Map缓存中添加值
     *
     * @param key 键
     * @param value 值
     */
    String mapPut(String key, Map<String, String> value);
    String mapObjectPut(String key, Map<String, Object> value);
    /**
     * 移除Map缓存中的值
     *
     * @param key 键
     * @param value 值
     */
    long mapRemove(String key, String mapKey);
    long mapObjectRemove(String key, Object mapKey);
    /**
     * 清空Map缓存中的值
     *
     * @param key 键
     */
    long mapClear(String key);
    long mapObjectClear(String key);
    /**
     * 判断Map缓存中的Key是否存在
     *
     * @param key 键
     * @param value 值
     */
    boolean mapExists(String key, String mapKey);
    boolean mapObjectExists(String key, Object mapKey);
    /**
     * 删除缓存
     *
     * @param key 键
     */
    long del(String key);
    long delObject(String key);

    /**
     * 获取byte[]类型Key
     */
    default byte[] getBytesKey(Object object) {
        return JedisUtils.getBytesKey(object);
    }

    /**
     * 获取byte[]类型Key
     */
    default Object getObjectKey(byte[] key) {
        return JedisUtils.getObjectKey(key);
    }

    /**
     * Object转换byte[]类型
     */
    default byte[] toBytes(Object object) {
        return JedisUtils.toBytes(object);
    }

    /**
     * byte[]型转换Object
     */
    default Object toObject(byte[] bytes) {
        return JedisUtils.toObject(bytes);
    }
}