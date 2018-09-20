/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.web;

import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.utils.Collections3;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.modules.sys.entity.Office;
import com.github.flying.jeelite.modules.sys.entity.Role;
import com.github.flying.jeelite.modules.sys.entity.User;
import com.github.flying.jeelite.modules.sys.service.MenuService;
import com.github.flying.jeelite.modules.sys.service.OfficeService;
import com.github.flying.jeelite.modules.sys.service.RoleService;
import com.github.flying.jeelite.modules.sys.service.UserService;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 角色Controller
 *
 * @author flying
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/role")
public class RoleController extends BaseController {

	@Autowired
	private RoleService roleService;
	@Autowired
	private UserService userService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private OfficeService officeService;

	@ModelAttribute("role")
	public Role get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return roleService.get(id);
		} else {
			return new Role();
		}
	}

	@RequiresPermissions("sys:role:view")
	@RequestMapping(value = { "list", "" })
	public String list() {
		return "modules/sys/roleList";
	}

	@ResponseBody
	@RequiresPermissions("sys:role:view")
	@RequestMapping(value = "data")
	public Map listData() {
		List<Role> list = roleService.findAllRole();
		return jsonPage(list.size(), list);
	}

	@RequiresPermissions("sys:role:view")
	@RequestMapping(value = "form")
	public String form(Role role, Model model) {
		if (role.getOffice() == null) {
			role.setOffice(UserUtils.getUser().getOffice());
		}
		model.addAttribute("role", role);
		model.addAttribute("menuList", menuService.findAllMenu());
		model.addAttribute("officeList", officeService.findAll());
		return "modules/sys/roleForm";
	}

	@ResponseBody
	@RequiresPermissions("sys:role:edit")
	@RequestMapping(value = "save")
	public ResponseEntity save(Role role) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		beanValidator(role);
		
		if (!"true".equals(checkName(role.getOldName(), role.getName()))) {
			return renderError("保存角色'" + role.getName() + "'失败, 角色名已存在");
		}
		roleService.saveRole(role);
		return renderSuccess("保存角色'" + role.getName() + "'成功");
	}

	@ResponseBody
	@RequiresPermissions("sys:role:edit")
	@RequestMapping(value = "delete")
	public ResponseEntity delete(Role role) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		roleService.deleteRole(role);
		return renderSuccess("删除角色成功");
	}

	/**
	 * 角色分配页面
	 */
	@RequiresPermissions("sys:role:edit")
	@RequestMapping(value = "assign")
	public String assign() {
		return "modules/sys/roleAssign";
	}

	/**
	 * 角色分配页面数据
	 */
	@ResponseBody
	@RequiresPermissions("sys:role:edit")
	@RequestMapping(value = "assign/data")
	public Map assignData(Role role) {
		List<User> userList = userService.findUser(new User(new Role(role.getId())));
		return jsonPage(userList.size(), userList);
	}

	/**
	 * 角色分配 -- 打开角色分配对话框
	 */
	@RequiresPermissions("sys:role:view")
	@RequestMapping(value = "usertorole")
	public String selectUserToRole(Role role, Model model) {
		List<User> userList = userService.findUser(new User(new Role(role.getId())));
		model.addAttribute("role", role);
		model.addAttribute("userList", userList);
		model.addAttribute("selectIds", Collections3.extractToString(userList, "id", ","));
		model.addAttribute("officeList", officeService.findAll());
		return "modules/sys/selectUserToRole";
	}

	/**
	 * 角色分配 -- 根据部门编号获取用户列表
	 */
	@RequiresPermissions("sys:role:view")
	@ResponseBody
	@RequestMapping(value = "users")
	public List<Map<String, Object>> users(String officeId) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		User user = new User();
		user.setOffice(new Office(officeId));
		List<User> userList = userService.findUser(user);
		for (User e : userList) {
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", 0);
			map.put("name", e.getName());
			mapList.add(map);
		}
		return mapList;
	}

	/**
	 * 角色分配 -- 从角色中移除用户
	 */
	@ResponseBody
	@RequiresPermissions("sys:role:edit")
	@RequestMapping(value = "outrole")
	public ResponseEntity outrole(String userId, String roleId) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		Role role = roleService.get(roleId);
		User user = userService.getUser(userId);
		if (UserUtils.getUser().getId().equals(userId)) {
			return renderError("无法从角色【" + role.getName() + "】中移除用户【" + user.getName() + "】自己！");
		}
		if (user.getRoleList().size() <= 1) {
			return renderError("用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除失败！这已经是该用户的唯一角色，不能移除。");
		}
		Boolean flag = roleService.outUserInRole(role, user);
		if (!flag) {
			return renderError("用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除失败！");
		}
		return renderSuccess("用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除成功！");
	}

	/**
	 * 角色分配
	 */
	@ResponseBody
	@RequiresPermissions("sys:role:edit")
	@RequestMapping(value = "assignrole")
	public ResponseEntity assignRole(Role role, String[] idsArr) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		StringBuilder msg = new StringBuilder();
		int newNum = 0;
		for (int i = 0; i < idsArr.length; i++) {
			User user = roleService.assignUserToRole(role, userService.getUser(idsArr[i]));
			if (null != user) {
				msg.append("<br/>新增用户【" + user.getName() + "】到角色【" + role.getName() + "】！");
				newNum++;
			}
		}
		return renderSuccess("已成功分配 " + newNum + " 个用户" + msg);
	}

	/**
	 * 验证角色名是否有效
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "checkName")
	public String checkName(String oldName, String name) {
		if (name != null && name.equals(oldName)) {
			return "true";
		} else if (name != null && roleService.getRoleByName(name) == null) {
			return "true";
		}
		return "false";
	}

}