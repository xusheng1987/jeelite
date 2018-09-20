/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.dao;

import com.github.flying.jeelite.common.persistence.TreeDao;
import com.github.flying.jeelite.common.persistence.annotation.MyBatisDao;
import com.github.flying.jeelite.modules.sys.entity.Office;

/**
 * 机构DAO接口
 * @author flying
 * @version 2014-05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {

}