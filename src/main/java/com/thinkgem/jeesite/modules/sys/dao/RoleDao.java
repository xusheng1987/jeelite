/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.Role;

/**
 * 角色DAO接口
 * @author ThinkGem
 * @version 2013-12-05
 */
@MyBatisDao
public interface RoleDao extends CrudDao<Role> {

	Role getByName(Role role);

	/**
	 * 维护角色与菜单权限关系
	 */
	int deleteRoleMenu(Role role);

	int insertRoleMenu(Role role);

	/**
	 * 维护角色与公司部门关系
	 */
	int deleteRoleOffice(Role role);

	int insertRoleOffice(Role role);

}