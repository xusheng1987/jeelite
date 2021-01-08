/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.service.TreeService;
import com.github.flying.jeelite.modules.sys.dao.OfficeDao;
import com.github.flying.jeelite.modules.sys.entity.Office;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;

/**
 * 机构Service
 * @author flying
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class OfficeService extends TreeService<OfficeDao, Office> {

	public List<Office> findAll(){
		List<Office> list = UserUtils.getOfficeList();
		return buildTree(list);
	}

	public List<Office> findList(Boolean isAll){
		if (isAll != null && isAll){
			return UserUtils.getOfficeAllList();
		}else{
			return UserUtils.getOfficeList();
		}
	}

	@Override
	@Transactional(readOnly = false)
	public int save(Office office) {
		int row = super.save(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
		return row;
	}

	@Override
	@Transactional(readOnly = false)
	public int delete(Office office) {
		int row = super.delete(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
		return row;
	}

}