/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.service.BaseService;
import com.github.flying.jeelite.modules.sys.dao.RoleDao;
import com.github.flying.jeelite.modules.sys.entity.Role;
import com.github.flying.jeelite.modules.sys.entity.User;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;

/**
 * 角色管理
 *
 * @author flying
 * @version 2013-12-05
 */
@Service
@Transactional(readOnly = true)
public class RoleService extends BaseService<RoleDao, Role> {

	@Autowired
	private UserService userService;

	public Role getRoleByName(String name) {
		Role r = new Role();
		r.setName(name);
		return dao.getByName(r);
	}

	@Transactional(readOnly = false)
	public void saveRole(Role role) {
		super.save(role);
		// 更新角色与菜单关联
		dao.deleteRoleMenu(role);
		if (role.getMenuList().size() > 0) {
			dao.insertRoleMenu(role);
		}
		// 更新角色与部门关联
		dao.deleteRoleOffice(role);
		if (role.getOfficeList().size() > 0) {
			dao.insertRoleOffice(role);
		}
		// 清除用户角色缓存
		UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
	}

	@Transactional(readOnly = false)
	public void deleteRole(Role role) {
		super.delete(role);
		// 清除用户角色缓存
		UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
	}

	@Transactional(readOnly = false)
	public Boolean outUserInRole(Role role, User user) {
		List<Role> roles = user.getRoleList();
		for (Role e : roles) {
			if (e.getId().equals(role.getId())) {
				roles.remove(e);
				userService.saveUser(user);
				return true;
			}
		}
		return false;
	}

	@Transactional(readOnly = false)
	public User assignUserToRole(Role role, User user) {
		if (user == null) {
			return null;
		}
		List<String> roleIds = user.getRoleIdList();
		if (roleIds.contains(role.getId())) {
			return null;
		}
		user.getRoleList().add(role);
		userService.saveUser(user);
		return user;
	}

}