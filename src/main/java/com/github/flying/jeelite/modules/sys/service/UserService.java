/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.persistence.Page;
import com.github.flying.jeelite.common.rest.RestException;
import com.github.flying.jeelite.common.security.Digests;
import com.github.flying.jeelite.common.service.BaseService;
import com.github.flying.jeelite.common.utils.CacheUtils;
import com.github.flying.jeelite.common.utils.Encodes;
import com.github.flying.jeelite.common.utils.IdGen;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.web.Servlets;
import com.github.flying.jeelite.modules.sys.dao.UserDao;
import com.github.flying.jeelite.modules.sys.dao.UserTokenDao;
import com.github.flying.jeelite.modules.sys.entity.Office;
import com.github.flying.jeelite.modules.sys.entity.User;
import com.github.flying.jeelite.modules.sys.entity.UserToken;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;

/**
 * 用户管理
 * @author flying
 * @version 2013-12-05
 */
@Service
@Transactional(readOnly = true)
public class UserService extends BaseService<UserDao, User> {

	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	public static final int SALT_SIZE = 8;

	@Autowired
	private UserTokenDao userTokenDao;

	public Page<User> findPage(User user) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		user.getSqlMap().put("dsf", dataScopeFilter(user.getCurrentUser(), "o", "a"));
		return super.findPage(user);
	}

	/**
	 * 无分页查询人员列表
	 */
	public List<User> findUser(User user){
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		user.getSqlMap().put("dsf", dataScopeFilter(user.getCurrentUser(), "o", "a"));
		List<User> list = super.findList(user);
		return list;
	}

	/**
	 * 通过部门ID获取用户列表，仅返回用户id和name（树查询用户时用）
	 */
	public List<User> findUserByOfficeId(String officeId) {
		List<User> list = (List<User>)CacheUtils.get(UserUtils.USER_CACHE, UserUtils.USER_CACHE_LIST_BY_OFFICE_ID_ + officeId);
		if (list == null){
			User user = new User();
			user.setOffice(new Office(officeId));
			list = dao.findUserByOfficeId(user);
			CacheUtils.put(UserUtils.USER_CACHE, UserUtils.USER_CACHE_LIST_BY_OFFICE_ID_ + officeId, list);
		}
		return list;
	}

	@Transactional(readOnly = false)
	public void saveUser(User user) {
		if (StringUtils.isBlank(user.getId())){
			dao.insert(user);
		}else{
			// 清除原用户机构用户缓存
			User oldUser = super.get(user.getId());
			if (oldUser.getOffice() != null && oldUser.getOffice().getId() != null){
				CacheUtils.remove(UserUtils.USER_CACHE, UserUtils.USER_CACHE_LIST_BY_OFFICE_ID_ + oldUser.getOffice().getId());
			}
			// 更新用户数据
			dao.updateById(user);
		}
		if (StringUtils.isNotBlank(user.getId())){
			// 更新用户与角色关联
			dao.deleteUserRole(user);
			if (user.getRoleList() != null && user.getRoleList().size() > 0){
				dao.insertUserRole(user);
			}else{
				throw new RestException(user.getLoginName() + "没有设置角色！");
			}
			// 清除用户缓存
			UserUtils.clearCache(user);
		}
	}

	@Transactional(readOnly = false)
	public void updateUserInfo(User user) {
		dao.updateUserInfo(user);
		// 清除用户缓存
		UserUtils.clearCache(user);
	}

	@Transactional(readOnly = false)
	public void deleteUser(User user) {
		super.delete(user);
		// 清除用户缓存
		UserUtils.clearCache(user);
	}

	@Transactional(readOnly = false)
	public void batchDelete(List<String> idList) {
		dao.deleteBatchIds(idList);
		for(String id:idList) {
			// 清除用户缓存
			UserUtils.clearCache(UserUtils.get(id));
		}
	}

	@Transactional(readOnly = false)
	public void updatePasswordById(String id, String loginName, String newPassword) {
		User user = new User(id);
		user.setPassword(entryptPassword(newPassword));
		dao.updatePasswordById(user);
		// 清除用户缓存
		user.setLoginName(loginName);
		UserUtils.clearCache(user);
	}

	@Transactional(readOnly = false)
	public void updateUserLoginInfo(User user) {
		// 保存上次登录信息
		user.setOldLoginIp(user.getLoginIp());
		user.setOldLoginDate(user.getLoginDate());
		// 更新本次登录信息
		user.setLoginIp(StringUtils.getRemoteAddr(Servlets.getRequest()));
		user.setLoginDate(new Date());
		dao.updateLoginInfo(user);
	}

	/**
	 * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
	 */
	public static String entryptPassword(String plainPassword) {
		String plain = Encodes.unescapeHtml(plainPassword);
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		byte[] hashPassword = Digests.sha1(plain.getBytes(), salt, HASH_INTERATIONS);
		return Encodes.encodeHex(salt)+Encodes.encodeHex(hashPassword);
	}

	/**
	 * 验证密码
	 * @param plainPassword 明文密码
	 * @param password 密文密码
	 * @return 验证成功返回true
	 */
	public static boolean validatePassword(String plainPassword, String password) {
		String plain = Encodes.unescapeHtml(plainPassword);
		byte[] salt = Encodes.decodeHex(password.substring(0,16));
		byte[] hashPassword = Digests.sha1(plain.getBytes(), salt, HASH_INTERATIONS);
		return password.equals(Encodes.encodeHex(salt)+Encodes.encodeHex(hashPassword));
	}

	/**
	 * 根据token查询
	 */
	public UserToken getByToken(String token) {
		return userTokenDao.getByToken(token);
	}

	/**
	 * 保存token
	 */
	@Transactional(readOnly = false)
	public UserToken createToken(String userId) {
		//当前时间
		Date nowDate = new Date();
		//过期时间
		Date expireDate = new Date(nowDate.getTime() + 12 * 3600 * 1000);//12小时后过期
		String token = IdGen.uuid();
		UserToken userToken = userTokenDao.getByUserId(userId);
		if (userToken == null) {
			userToken = new UserToken();
			userToken.setUserId(userId);
			userToken.setToken(token);
			userToken.setUpdateDate(nowDate);
			userToken.setExpireDate(expireDate);
			userTokenDao.insert(userToken);
		} else {
			userToken.setToken(token);
			userToken.setUpdateDate(nowDate);
			userToken.setExpireDate(expireDate);
			userTokenDao.updateById(userToken);
		}
		return userToken;
	}

	/**
	 * 过期token
	 */
	@Transactional(readOnly = false)
	public int expireToken(String userId) {
		//当前时间
		Date nowDate = new Date();
		UserToken userToken = userTokenDao.getByUserId(userId);
		userToken.setUpdateDate(nowDate);
		userToken.setExpireDate(nowDate);
		return userTokenDao.updateById(userToken);
	}

}