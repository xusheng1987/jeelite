/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.persistence;

import java.util.List;

/**
 * DAO支持类实现
 * @author flying
 * @version 2014-05-16
 */
public interface TreeDao<T extends TreeEntity<T>> extends CrudDao<T> {

	/**
	 * 找到所有子节点
	 */
	List<T> findByParentIdsLike(T entity);

	/**
	 * 更新所有父节点字段
	 */
	int updateParentIds(T entity);

}