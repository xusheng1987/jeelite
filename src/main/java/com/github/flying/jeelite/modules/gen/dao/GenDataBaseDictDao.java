/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.gen.dao;

import java.util.List;

import com.github.flying.jeelite.common.persistence.CrudDao;
import com.github.flying.jeelite.common.persistence.annotation.MyBatisDao;
import com.github.flying.jeelite.modules.gen.entity.GenTable;
import com.github.flying.jeelite.modules.gen.entity.GenTableColumn;

/**
 * 业务表字段DAO接口
 * @author flying
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenDataBaseDictDao extends CrudDao<GenTableColumn> {

	/**
	 * 查询表列表
	 */
	List<GenTable> findTableList(GenTable genTable);

	/**
	 * 获取数据表字段
	 */
	List<GenTableColumn> findTableColumnList(GenTable genTable);

	/**
	 * 获取数据表主键
	 */
	List<String> findTablePK(GenTable genTable);

}
