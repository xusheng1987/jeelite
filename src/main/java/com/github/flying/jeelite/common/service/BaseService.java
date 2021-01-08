/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.persistence.Page;
import com.google.common.collect.Lists;
import com.github.flying.jeelite.common.persistence.BaseEntity;
import com.github.flying.jeelite.common.persistence.CrudDao;
import com.github.flying.jeelite.common.persistence.PageFactory;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.modules.sys.entity.Role;
import com.github.flying.jeelite.modules.sys.entity.User;

/**
 * Service基类
 *
 * @author flying
 * @version 2014-05-16
 */
@Transactional(readOnly = true)
public abstract class BaseService<M extends CrudDao<T>, T extends BaseEntity<T>> {

	/**
	 * 持久层对象
	 */
	@Autowired
	protected M dao;

	/**
	 * 日志对象
	 */
	protected Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * 数据范围过滤
	 *
	 * @param user 当前用户对象，通过“entity.getCurrentUser()”获取
	 * @param officeAlias 机构表别名
	 * @param userAlias 用户表别名，传递空，忽略此参数
	 * @return 需要拼接在原sql里的过滤条件sql片段
	 */
	public static String dataScopeFilter(User user, String officeAlias, String userAlias) {

		StringBuilder sqlString = new StringBuilder();

		// 进行权限过滤，多个角色权限范围之间为或者关系。
		List<String> dataScope = Lists.newArrayList();

		// 超级管理员，跳过权限过滤
		if (!user.isAdmin()) {
			boolean isDataScopeAll = false;
			for (Role r : user.getRoleList()) {
				if (!dataScope.contains(r.getDataScope()) && StringUtils.isNotBlank(officeAlias)) {
					if (Role.DATA_SCOPE_ALL.equals(r.getDataScope())) {
						isDataScopeAll = true;
						break;
					} else if (Role.DATA_SCOPE_COMPANY_AND_CHILD.equals(r.getDataScope())) {
						sqlString.append(" OR " + officeAlias + ".id = '" + user.getCompany().getId() + "'");
						sqlString.append(" OR " + officeAlias + ".parent_ids LIKE '" + user.getCompany().getParentIds()
								+ user.getCompany().getId() + ",%'");
					} else if (Role.DATA_SCOPE_COMPANY.equals(r.getDataScope())) {
						sqlString.append(" OR " + officeAlias + ".id = '" + user.getCompany().getId() + "'");
						// 包括本公司下的部门 （type=1:公司；type=2：部门）
						sqlString.append(" OR (" + officeAlias + ".parent_id = '" + user.getCompany().getId() + "' AND " + officeAlias
								+ ".type = '2')");
					} else if (Role.DATA_SCOPE_OFFICE_AND_CHILD.equals(r.getDataScope())) {
						sqlString.append(" OR " + officeAlias + ".id = '" + user.getOffice().getId() + "'");
						sqlString.append(" OR " + officeAlias + ".parent_ids LIKE '" + user.getOffice().getParentIds()
								+ user.getOffice().getId() + ",%'");
					} else if (Role.DATA_SCOPE_OFFICE.equals(r.getDataScope())) {
						sqlString.append(" OR " + officeAlias + ".id = '" + user.getOffice().getId() + "'");
					} else if (Role.DATA_SCOPE_CUSTOM.equals(r.getDataScope())) {
						sqlString.append(
								" OR EXISTS (SELECT 1 FROM sys_role_office WHERE role_id = '" + r.getId() + "'");
						sqlString.append(" AND office_id = " + officeAlias + ".id)");
					}
					dataScope.add(r.getDataScope());
				}
			}
			// 如果没有全部数据权限，并设置了用户别名，则当前权限为本人
			if (!isDataScopeAll) {
				if (StringUtils.isNotBlank(userAlias)) {
					sqlString.append(" OR " + userAlias + ".id = '" + user.getId() + "'");
				}
			} else {
				// 如果包含全部权限，则去掉之前添加的所有条件，并跳出循环。
				sqlString = new StringBuilder();
			}
		}
		if (StringUtils.isNotBlank(sqlString.toString())) {
			return " AND (" + sqlString.substring(4) + ")";
		}
		return "";
	}

	/**
	 * 根据主键获取单表数据
	 */
	public T getById(String id) {
		return dao.selectById(id);
	}

	/**
	 * 获取单条数据
	 */
	public T get(String id) {
		return dao.get(id);
	}

	/**
	 * 查询列表数据
	 */
	public List<T> findList(T entity) {
		return dao.findList(entity);
	}

	/**
	 * 查询分页数据
	 */
	public Page<T> findPage(T entity) {
		Page page = new PageFactory<T>().defaultPage();
		return dao.findList(page, entity);
	}

	/**
	 * 保存数据
	 */
	@Transactional(readOnly = false)
	public int save(T entity) {
		if (StringUtils.isEmpty(entity.getId())) {
			return dao.insert(entity);
		} else {
			return dao.updateById(entity);
		}
	}

	/**
	 * 删除数据（逻辑删除，更新del_flag字段为1）
	 */
	@Transactional(readOnly = false)
	public int delete(T entity) {
		return dao.deleteById(entity.getId());// 使用mybatis-plus自带的逻辑删除
	}

}