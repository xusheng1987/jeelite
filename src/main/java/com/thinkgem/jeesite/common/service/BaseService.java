/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.common.service;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * Service基类
 * 
 * @author ThinkGem
 * @version 2014-05-16
 */
@Transactional(readOnly = true)
public abstract class BaseService<M extends CrudDao<T>, T extends BaseEntity<T>> extends ServiceImpl<M, T> {
	
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
	 * @param officeAlias 机构表别名，多个用“,”逗号隔开。
	 * @param userAlias 用户表别名，多个用“,”逗号隔开，传递空，忽略此参数
	 * @return 标准连接条件对象
	 */
	public static String dataScopeFilter(User user, String officeAlias, String userAlias) {

		StringBuilder sqlString = new StringBuilder();

		// 进行权限过滤，多个角色权限范围之间为或者关系。
		List<String> dataScope = Lists.newArrayList();

		// 超级管理员，跳过权限过滤
		if (!user.isAdmin()) {
			boolean isDataScopeAll = false;
			for (Role r : user.getRoleList()) {
				for (String oa : StringUtils.split(officeAlias, ",")) {
					if (!dataScope.contains(r.getDataScope()) && StringUtils.isNotBlank(oa)) {
						if (Role.DATA_SCOPE_ALL.equals(r.getDataScope())) {
							isDataScopeAll = true;
						} else if (Role.DATA_SCOPE_COMPANY_AND_CHILD.equals(r.getDataScope())) {
							sqlString.append(" OR " + oa + ".id = '" + user.getCompany().getId() + "'");
							sqlString.append(" OR " + oa + ".parent_ids LIKE '" + user.getCompany().getParentIds()
									+ user.getCompany().getId() + ",%'");
						} else if (Role.DATA_SCOPE_COMPANY.equals(r.getDataScope())) {
							sqlString.append(" OR " + oa + ".id = '" + user.getCompany().getId() + "'");
							// 包括本公司下的部门 （type=1:公司；type=2：部门）
							sqlString.append(" OR (" + oa + ".parent_id = '" + user.getCompany().getId() + "' AND " + oa
									+ ".type = '2')");
						} else if (Role.DATA_SCOPE_OFFICE_AND_CHILD.equals(r.getDataScope())) {
							sqlString.append(" OR " + oa + ".id = '" + user.getOffice().getId() + "'");
							sqlString.append(" OR " + oa + ".parent_ids LIKE '" + user.getOffice().getParentIds()
									+ user.getOffice().getId() + ",%'");
						} else if (Role.DATA_SCOPE_OFFICE.equals(r.getDataScope())) {
							sqlString.append(" OR " + oa + ".id = '" + user.getOffice().getId() + "'");
						} else if (Role.DATA_SCOPE_CUSTOM.equals(r.getDataScope())) {
							sqlString.append(
									" OR EXISTS (SELECT 1 FROM sys_role_office WHERE role_id = '" + r.getId() + "'");
							sqlString.append(" AND office_id = " + oa + ".id)");
						}
						dataScope.add(r.getDataScope());
					}
				}
			}
			// 如果没有全部数据权限，并设置了用户别名，则当前权限为本人；如果未设置别名，当前无权限为已植入权限
			if (!isDataScopeAll) {
				if (StringUtils.isNotBlank(userAlias)) {
					for (String ua : StringUtils.split(userAlias, ",")) {
						sqlString.append(" OR " + ua + ".id = '" + user.getId() + "'");
					}
				} else {
					for (String oa : StringUtils.split(officeAlias, ",")) {
						sqlString.append(" OR " + oa + ".id IS NULL");
					}
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
	 * 获取单条数据
	 * @param id
	 */
	public T get(String id) {
		return dao.get(id);
	}

	/**
	 * 查询列表数据
	 * 
	 * @param entity
	 */
	public List<T> findList(T entity) {
		return dao.findList(entity);
	}

	/**
	 * 查询所有数据列表
	 * 
	 * @param entity
	 */
	public List<T> findAllList(T entity) {
		return dao.findAllList(entity);
	}

	/**
	 * 查询分页数据
	 * 
	 * @param page 分页对象
	 * @param entity
	 */
	public Page<T> findPage(Page<T> page, T entity) {
		entity.setPage(page);
		page.setRecords(dao.findList(page, entity));
		return page;
	}

	@Transactional(readOnly = false)
	public boolean insertOrUpdate(T entity) {
		if (entity instanceof DataEntity) {
			DataEntity de = (DataEntity) entity;
			Date date = new Date();
			User user = UserUtils.getUser();
			if (StringUtils.isBlank(de.getId())) {// 插入之前执行操作
				if (StringUtils.isNotBlank(user.getId())){
					de.setCreateBy(user);
				}
				de.setCreateDate(date);
			}
			if (StringUtils.isNotBlank(user.getId())){
				de.setUpdateBy(user);
			}
			de.setUpdateDate(date);
		}
		return super.insertOrUpdate(entity);
	}

	/**
	 * 删除数据（逻辑删除，更新del_flag字段为1）
	 * 
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public void delete(T entity) {
		super.deleteById(entity.getId());// 使用mybatis-plus自带的逻辑删除
	}

}