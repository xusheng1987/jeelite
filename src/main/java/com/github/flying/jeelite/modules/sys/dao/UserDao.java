/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.dao;

import java.util.List;

import com.github.flying.jeelite.common.persistence.CrudDao;
import com.github.flying.jeelite.common.persistence.annotation.MyBatisDao;
import com.github.flying.jeelite.modules.sys.entity.User;

/**
 * 用户DAO接口
 * @author flying
 * @version 2014-05-16
 */
@MyBatisDao
public interface UserDao extends CrudDao<User> {

	/**
	 * 根据登录名称查询用户
	 */
	User getByLoginName(User user);

	/**
	 * 通过OfficeId获取用户列表，仅返回用户id和name（树查询用户时用）
	 */
	List<User> findUserByOfficeId(User user);

	/**
	 * 更新用户密码
	 */
	int updatePasswordById(User user);

	/**
	 * 更新登录信息，如：登录IP、登录时间
	 */
	int updateLoginInfo(User user);

	/**
	 * 删除用户角色关联数据
	 */
	int deleteUserRole(User user);

	/**
	 * 插入用户角色关联数据
	 */
	int insertUserRole(User user);

	/**
	 * 更新用户信息
	 */
	int updateUserInfo(User user);

}