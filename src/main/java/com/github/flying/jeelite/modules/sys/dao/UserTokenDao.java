/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.dao;

import com.github.flying.jeelite.common.persistence.CrudDao;
import com.github.flying.jeelite.common.persistence.annotation.MyBatisDao;
import com.github.flying.jeelite.modules.sys.entity.UserToken;

/**
 * 用户TokenDAO接口
 * @author flying
 * @version 2019-02-21
 */
@MyBatisDao
public interface UserTokenDao extends CrudDao<UserToken> {
	
	/**
	 * 根据token查询
	 */
	UserToken getByToken(String token);
	
	/**
	 * 根据用户ID查询
	 */
	UserToken getByUserId(String userId);

}