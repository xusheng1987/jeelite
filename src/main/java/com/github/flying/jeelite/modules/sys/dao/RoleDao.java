/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.dao;

import com.github.flying.jeelite.common.persistence.CrudDao;
import com.github.flying.jeelite.common.persistence.annotation.MyBatisDao;
import com.github.flying.jeelite.modules.sys.entity.Role;

/**
 * 角色DAO接口
 * @author flying
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