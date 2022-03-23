/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.persistence;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;


/**
 * DAO支持类实现
 * @author flying
 * @version 2014-05-16
 */
public interface CrudDao<T> extends BaseMapper<T> {

	/**
	 * 获取单条数据
	 */
	T get(String id);

	/**
	 * 查询数据列表
	 */
	List<T> findList(T entity);

	/**
	 * 查询所有数据列表
	 */
	List<T> findAllList(T entity);

	/**
	 * 删除数据
	 */
	int delete(T entity);

}