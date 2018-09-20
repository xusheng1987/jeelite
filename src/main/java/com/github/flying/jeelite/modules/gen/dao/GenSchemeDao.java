/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.gen.dao;

import com.github.flying.jeelite.common.persistence.CrudDao;
import com.github.flying.jeelite.common.persistence.annotation.MyBatisDao;
import com.github.flying.jeelite.modules.gen.entity.GenScheme;

/**
 * 生成方案DAO接口
 * @author flying
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenSchemeDao extends CrudDao<GenScheme> {

}