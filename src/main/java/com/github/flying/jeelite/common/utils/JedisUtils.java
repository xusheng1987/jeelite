/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.utils;

/**
 * Jedis Cache 工具类
 *
 * @author flying
 * @version 2014-6-29
 */
public class JedisUtils {

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