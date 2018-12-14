/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.web;

import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.rest.Result;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.modules.sys.entity.Menu;
import com.github.flying.jeelite.modules.sys.service.MenuService;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 菜单Controller
 *
 * @author flying
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/menu")
public class MenuController extends BaseController {

	@Autowired
	private MenuService menuService;

	@ModelAttribute("menu")
	public Menu get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return menuService.get(id);
		} else {
			return new Menu();
		}
	}

	@RequiresPermissions("sys:menu:view")
	@RequestMapping(value = { "list", "" })
	public String list(Model model) {
		model.addAttribute("list", menuService.findAllMenu());
		return "modules/sys/menuList";
	}

	@RequiresPermissions("sys:menu:view")
	@RequestMapping(value = "form")
	public String form(Menu menu, Model model) {
		if (menu.getParent() == null || StringUtils.isEmpty(menu.getParent().getId())) {
			menu.setParent(new Menu(Menu.getRootId()));
		}
		menu.setParent(menuService.get(menu.getParent().getId()));
		model.addAttribute("menu", menu);
		return "modules/sys/menuForm";
	}

	@ResponseBody
	@RequiresPermissions("sys:menu:edit")
	@RequestMapping(value = "save")
	public Result save(Menu menu) {
		if (!UserUtils.getUser().isAdmin()) {
			return renderError("越权操作，只有超级管理员才能添加或修改数据！");
		}
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		beanValidator(menu);
		
		menuService.saveMenu(menu);
		return renderSuccess("保存菜单'" + menu.getName() + "'成功");
	}

	@ResponseBody
	@RequiresPermissions("sys:menu:edit")
	@RequestMapping(value = "delete")
	public Result delete(Menu menu) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		menuService.deleteMenu(menu);
		return renderSuccess("删除菜单成功");
	}

	@RequiresPermissions("user")
	@RequestMapping(value = "tree")
	public String tree() {
		return "modules/sys/menuTree";
	}

	/**
	 * 批量修改菜单排序
	 */
	@ResponseBody
	@RequiresPermissions("sys:menu:edit")
	@RequestMapping(value = "updateSort")
	public Result updateSort(String[] ids, Integer[] sorts) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		for (int i = 0; i < ids.length; i++) {
			Menu menu = new Menu(ids[i]);
			menu.setSort(sorts[i]);
			menuService.updateMenuSort(menu);
		}
		return renderSuccess("保存菜单排序成功!");
	}

	/**
	 * isShowHide是否显示隐藏菜单
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required = false) String extId,
			@RequestParam(required = false) String isShowHide) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Menu> list = menuService.findAllMenu();
		for (int i = 0; i < list.size(); i++) {
			Menu e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId != null && !extId.equals(e.getId())
					&& e.getParentIds().indexOf("," + extId + ",") == -1)) {
				if (isShowHide != null && isShowHide.equals("0") && e.getIsShow().equals("0")) {
					continue;
				}
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
}