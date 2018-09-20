/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.dao;

import java.util.List;

import com.github.flying.jeelite.common.persistence.CrudDao;
import com.github.flying.jeelite.common.persistence.annotation.MyBatisDao;
import com.github.flying.jeelite.modules.sys.entity.Dict;

/**
 * 字典DAO接口
 * @author flying
 * @version 2014-05-16
 */
@MyBatisDao
public interface DictDao extends CrudDao<Dict> {

	List<String> findTypeList(Dict dict);

}