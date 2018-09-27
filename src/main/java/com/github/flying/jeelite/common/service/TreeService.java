/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.persistence.TreeDao;
import com.github.flying.jeelite.common.persistence.TreeEntity;
import com.github.flying.jeelite.common.rest.RestException;
import com.github.flying.jeelite.common.utils.Reflections;
import com.github.flying.jeelite.common.utils.StringUtils;

/**
 * Service基类
 *
 * @author flying
 * @version 2014-05-16
 */
@Transactional(readOnly = true)
public abstract class TreeService<M extends TreeDao<T>, T extends TreeEntity<T>> extends BaseService<M, T> {

	@Override
	@Transactional(readOnly = false)
	public void save(T entity) {
		Class<T> entityClass = Reflections.getClassGenricType(getClass(), 1);

		// 如果没有设置父节点，则代表为跟节点，有则获取父节点实体
		if (entity.getParent() == null || StringUtils.isBlank(entity.getParentId())
				|| "0".equals(entity.getParentId())) {
			entity.setParent(null);
		} else {
			entity.setParent(super.get(entity.getParentId()));
		}
		if (entity.getParent() == null) {
			T parentEntity = null;
			try {
				parentEntity = entityClass.getConstructor(String.class).newInstance("0");
			} catch (Exception e) {
				throw new RestException(e.getMessage());
			}
			entity.setParent(parentEntity);
			entity.getParent().setParentIds(StringUtils.EMPTY);
		}

		// 获取修改前的parentIds，用于更新子节点的parentIds
		String oldParentIds = entity.getParentIds();

		// 设置新的父节点串
		entity.setParentIds(entity.getParent().getParentIds() + entity.getParent().getId() + ",");

		// 保存或更新实体
		super.save(entity);

		// 更新子节点 parentIds
		T o = null;
		try {
			o = entityClass.newInstance();
		} catch (Exception e) {
			throw new RestException(e.getMessage());
		}
		o.setParentIds("%," + entity.getId() + ",%");
		List<T> list = dao.findByParentIdsLike(o);
		for (T e : list) {
			if (e.getParentIds() != null && oldParentIds != null) {
				e.setParentIds(e.getParentIds().replace(oldParentIds, entity.getParentIds()));
				dao.updateParentIds(e);
			}
		}

	}

	/**
	 * 删除数据
	 */
	@Override
	@Transactional(readOnly = false)
	public void delete(T entity) {
		dao.delete(entity);
	}

	/**
	 * 构建树形结构list
	 */
	public List<T> buildTree(List<T> sourcelist) {
		List<T> resultList = new ArrayList<T>();
		for (T node : sourcelist) {
			if ("0".equals(node.getParentId())) {// 通过循环一级节点 就可以通过递归获取二级以下节点
				resultList.add(node);// 添加一级节点
				build(node, sourcelist, resultList);// 递归获取二级、三级、。。。节点
			}
		}
		return resultList;
	}

	/**
	 * 递归循环子节点
	 *
	 * @param node 当前节点
	 */
	private void build(T node, List<T> sourcelist, List<T> resultList) {
		List<T> children = getChildren(node, sourcelist);
		if (!children.isEmpty()) {// 如果存在子节点
			for (T child : children) {// 将子节点遍历加入返回值中
				resultList.add(child);
				build(child, sourcelist, resultList);
			}
		}
	}

	private List<T> getChildren(T node, List<T> sourcelist) {
		List<T> children = new ArrayList<T>();
		String id = node.getId();
		for (T child : sourcelist) {
			if (id.equals(child.getParentId())) {// 如果id等于父id
				children.add(child);// 将该节点加入循环列表中
			}
		}
		return children;
	}
}