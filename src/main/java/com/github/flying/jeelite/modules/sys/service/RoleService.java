/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.rest.RestException;
import com.github.flying.jeelite.common.service.BaseService;
import com.github.flying.jeelite.common.utils.CacheUtils;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.modules.sys.dao.RoleDao;
import com.github.flying.jeelite.modules.sys.dao.UserDao;
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
	private UserDao userDao;

	public Role getRoleByName(String name) {
		Role r = new Role();
		r.setName(name);
		return dao.getByName(r);
	}

	public List<Role> findAllRole() {
		return UserUtils.getRoleList();
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
				saveUser(user);
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
		saveUser(user);
		return user;
	}

	@Transactional(readOnly = false)
	public void saveUser(User user) {
		if (StringUtils.isBlank(user.getId())) {
			userDao.insert(user);
		} else {
			// 清除原用户机构用户缓存
			User oldUser = userDao.get(user.getId());
			if (oldUser.getOffice() != null && oldUser.getOffice().getId() != null) {
				CacheUtils.remove(UserUtils.USER_CACHE,
						UserUtils.USER_CACHE_LIST_BY_OFFICE_ID_ + oldUser.getOffice().getId());
			}
			// 更新用户数据
			userDao.updateById(user);
		}
		if (StringUtils.isNotBlank(user.getId())) {
			// 更新用户与角色关联
			userDao.deleteUserRole(user);
			if (user.getRoleList() != null && user.getRoleList().size() > 0) {
				userDao.insertUserRole(user);
			} else {
				throw new RestException(user.getLoginName() + "没有设置角色！");
			}
			// 清除用户缓存
			UserUtils.clearCache(user);
		}
	}

}