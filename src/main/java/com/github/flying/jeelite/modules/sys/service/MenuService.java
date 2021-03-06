/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.service.TreeService;
import com.github.flying.jeelite.common.utils.CacheUtils;
import com.github.flying.jeelite.modules.sys.dao.MenuDao;
import com.github.flying.jeelite.modules.sys.entity.Menu;
import com.github.flying.jeelite.modules.sys.utils.LogUtils;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;

/**
 * 菜单管理
 *
 * @author flying
 * @version 2013-12-05
 */
@Service
@Transactional(readOnly = true)
public class MenuService extends TreeService<MenuDao, Menu> {

	public List<Menu> findAllMenu() {
		List<Menu> list = UserUtils.getMenuList();
		return buildTree(list);
	}

	@Transactional(readOnly = false)
	public void saveMenu(Menu menu) {
		super.save(menu);
		// 清除用户菜单缓存
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
		// 清除权限缓存
		// UserUtils.removeCache(UserUtils.CACHE_AUTH_INFO);
		// 清除日志相关缓存
		CacheUtils.remove(LogUtils.CACHE_MENU_NAME_PATH_MAP);
	}

	@Transactional(readOnly = false)
	public void updateMenuSort(Menu menu) {
		dao.updateSort(menu);
		// 清除用户菜单缓存
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
		// 清除日志相关缓存
		CacheUtils.remove(LogUtils.CACHE_MENU_NAME_PATH_MAP);
	}

	@Transactional(readOnly = false)
	public void deleteMenu(Menu menu) {
		super.delete(menu);
		// 清除用户菜单缓存
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
		// 清除权限缓存
		// UserUtils.removeCache(UserUtils.CACHE_AUTH_INFO);
		// 清除日志相关缓存
		CacheUtils.remove(LogUtils.CACHE_MENU_NAME_PATH_MAP);
	}

}