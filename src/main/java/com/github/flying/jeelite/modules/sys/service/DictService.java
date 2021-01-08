/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.service.BaseService;
import com.github.flying.jeelite.common.utils.CacheUtils;
import com.github.flying.jeelite.modules.sys.dao.DictDao;
import com.github.flying.jeelite.modules.sys.entity.Dict;
import com.github.flying.jeelite.modules.sys.utils.DictUtils;

/**
 * 字典Service
 *
 * @author flying
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class DictService extends BaseService<DictDao, Dict> {

	/**
	 * 查询字段类型列表
	 */
	public List<String> findTypeList() {
		return dao.findTypeList(new Dict());
	}

	@Override
	@Transactional(readOnly = false)
	public int save(Dict dict) {
		int row = super.save(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
		return row;
	}

	@Override
	@Transactional(readOnly = false)
	public int delete(Dict dict) {
		int row = super.delete(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
		return row;
	}

	@Transactional(readOnly = false)
	public int batchDelete(List<String> idList) {
		int row = dao.deleteBatchIds(idList);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
		return row;
	}

}