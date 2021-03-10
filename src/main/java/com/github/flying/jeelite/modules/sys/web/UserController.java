/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.web;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.github.flying.jeelite.common.persistence.Page;
import com.github.flying.jeelite.common.beanvalidator.BeanValidators;
import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.rest.Result;
import com.github.flying.jeelite.common.utils.DateUtils;
import com.github.flying.jeelite.common.utils.IdGen;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.utils.excel.ImportExcel;
import com.github.flying.jeelite.common.utils.excel.JxlsUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.modules.sys.entity.Role;
import com.github.flying.jeelite.modules.sys.entity.User;
import com.github.flying.jeelite.modules.sys.service.UserService;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 用户Controller
 *
 * @author flying
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/user")
public class UserController extends BaseController {

	@Autowired
	private UserService userService;

	@ModelAttribute
	public User get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return UserUtils.get(id);
		} else {
			return new User();
		}
	}

	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = { "index" })
	public String index() {
		return "modules/sys/userIndex";
	}

	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = { "list", "" })
	public String list(User user, Model model) {
		model.addAttribute("user", user);
		return "modules/sys/userList";
	}

	@ResponseBody
	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = "data")
	public Map listData(User user) {
		Page<User> page = userService.findPage(user);
		return jsonPage(page);
	}

	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = "form")
	public String form(User user, Model model) {
		if (user.getCompany() == null || StringUtils.isEmpty(user.getCompany().getId())) {
			user.setCompany(UserUtils.getUser().getCompany());
		}
		if (user.getOffice() == null || StringUtils.isEmpty(user.getOffice().getId())) {
			user.setOffice(UserUtils.getUser().getOffice());
		}
		model.addAttribute("user", user);
		model.addAttribute("allRoles", UserUtils.getRoleList());
		return "modules/sys/userForm";
	}

	@ResponseBody
	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "save")
	public Result save(User user) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		// 如果新密码为空，则不更换密码
		if (StringUtils.isNotBlank(user.getNewPassword())) {
			user.setPassword(UserService.entryptPassword(user.getNewPassword()));
		}
		beanValidator(user);
		
		if (!"true".equals(checkLoginName(user.getOldLoginName(), user.getLoginName()))) {
			return renderError("保存用户'" + user.getLoginName() + "'失败，登录名已存在");
		}
		// 角色数据有效性验证，过滤不在授权内的角色
		List<Role> roleList = Lists.newArrayList();
		List<String> roleIdList = user.getRoleIdList();
		for (Role r : UserUtils.getRoleList()) {
			if (roleIdList.contains(r.getId())) {
				roleList.add(r);
			}
		}
		user.setRoleList(roleList);
		// 保存用户信息
		userService.saveUser(user);
		// 清除当前用户缓存
		if (user.getLoginName().equals(UserUtils.getUser().getLoginName())) {
			UserUtils.clearCache();
		}
		return renderSuccess("保存用户'" + user.getLoginName() + "'成功");
	}

	@ResponseBody
	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "batchDelete")
	public Result batchDelete(@RequestBody List<String> idList) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		if (idList.contains(UserUtils.getUser().getId())) {
			return renderError("批量删除用户失败, 不允许删除当前用户");
		}
		if (idList.contains("1")) {
			return renderError("批量删除用户失败, 不允许删除超级管理员用户");
		}
		userService.batchDelete(idList);
		return renderSuccess("批量删除用户成功");
	}

	/**
	 * 导出用户数据
	 */
	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(User user, HttpServletResponse response) {
		try {
			String fileName = "用户数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<User> list = userService.findUser(user);
			Map<String, Object> model = new HashMap<String, Object>();
			model.put("users", list);
			JxlsUtils.exportExcel(response, "export.xlsx", fileName, model);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 导入用户数据
	 */
	@ResponseBody
	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "import", method = RequestMethod.POST)
	public Result importFile(MultipartFile file) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<User> list = ei.getDataList(User.class);
			for (User user : list) {
				try {
					if ("true".equals(checkLoginName("", user.getLoginName()))) {
						// 默认密码：123456，默认角色：普通用户
						user.setPassword(UserService.entryptPassword("123456"));
						user.getRoleList().add(new Role("6"));
						BeanValidators.validateWithException(validator, user);
						userService.saveUser(user);
						successNum++;
					} else {
						failureMsg.append("<br/>登录名 " + user.getLoginName() + " 已存在; ");
						failureNum++;
					}
				} catch (ConstraintViolationException ex) {
					failureMsg.append("<br/>登录名 " + user.getLoginName() + " 导入失败：");
					List<String> messageList = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
					for (String message : messageList) {
						failureMsg.append(message + "; ");
						failureNum++;
					}
				} catch (Exception ex) {
					failureMsg.append("<br/>登录名 " + user.getLoginName() + " 导入失败：" + ex.getMessage());
				}
			}
			if (failureNum > 0) {
				failureMsg.insert(0, "，失败 " + failureNum + " 条用户数据，导入信息如下：");
			}
			return renderSuccess("已成功导入 " + successNum + " 条用户数据" + failureMsg);
		} catch (Exception e) {
			return renderError("导入用户失败！失败信息：" + e.getMessage());
		}
	}

	/**
	 * 下载导入用户数据模板
	 */
	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = "import/template")
	public String importFileTemplate(HttpServletResponse response) {
		try {
			String fileName = "用户数据导入模板.xlsx";
			List<User> list = Lists.newArrayList();
			list.add(UserUtils.getUser());
			Map<String, Object> model = new HashMap<String, Object>();
			model.put("users", list);
			JxlsUtils.exportExcel(response, "import.xlsx", fileName, model);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 验证登录名是否有效
	 */
	@ResponseBody
	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "checkLoginName")
	public String checkLoginName(String oldLoginName, String loginName) {
		if (loginName != null && loginName.equals(oldLoginName)) {
			return "true";
		} else if (loginName != null && UserUtils.getByLoginName(loginName) == null) {
			return "true";
		}
		return "false";
	}

	/**
	 * 用户信息显示
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "info")
	public String info(Model model) {
		User currentUser = UserUtils.getUser();
		model.addAttribute("user", currentUser);
		return "modules/sys/userInfo";
	}

	/**
	 * 用户信息保存
	 */
	@ResponseBody
	@RequiresPermissions("user")
	@RequestMapping(value = "info/save")
	public Result infoSave(User user) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		User currentUser = UserUtils.getUser();
		if (!currentUser.isAdmin()) {
			beanValidator(user);
		}
		
		currentUser.setName(user.getName());
		currentUser.setEmail(user.getEmail());
		currentUser.setPhone(user.getPhone());
		currentUser.setMobile(user.getMobile());
		currentUser.setRemarks(user.getRemarks());
		currentUser.setPhoto(user.getPhoto());
		userService.updateUserInfo(currentUser);
		return renderSuccess("用户信息保存成功");
	}

	/**
	 * 个人密码界面显示
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "modifyPwd")
	public String modifyPwdShow(Model model) {
		User user = UserUtils.getUser();
		model.addAttribute("user", user);
		return "modules/sys/userModifyPwd";
	}

	/**
	 * 修改个人用户密码
	 */
	@ResponseBody
	@RequiresPermissions("user")
	@RequestMapping(value = "modifyPwd/save")
	public Result modifyPwd(String oldPassword, String newPassword) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		if (StringUtils.isBlank(oldPassword)) {
			return renderError("请输入旧密码");
		}
		if (StringUtils.isBlank(newPassword)) {
			return renderError("请输入新密码");
		}
		User user = UserUtils.getUser();
		if (UserService.validatePassword(oldPassword, user.getPassword())) {
			userService.updatePasswordById(user.getId(), user.getLoginName(), newPassword);
		} else {
			return renderError("修改密码失败，旧密码错误");
		}
		return renderSuccess("修改密码成功");
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required = false) String officeId) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<User> list = userService.findUserByOfficeId(officeId);
		for (int i = 0; i < list.size(); i++) {
			User e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", "u_" + e.getId());
			map.put("pId", officeId);
			map.put("name", StringUtils.replace(e.getName(), " ", ""));
			mapList.add(map);
		}
		return mapList;
	}

	/**
	 * 上传头像
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "upload", method = RequestMethod.POST)
	public Map upload(MultipartFile file) {
		String originalFilename = file.getOriginalFilename();
		String fileName = IdGen.uuid() + originalFilename.substring(originalFilename.lastIndexOf("."));
		String src = "";
		try {
			File savefile = new File(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL, fileName);
			if (!savefile.getParentFile().exists()) {
				savefile.getParentFile().mkdirs();
			}
			// 保存
			file.transferTo(savefile);
			src = Global.USERFILES_BASE_URL + fileName;
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map dataMap = new HashMap();
		dataMap.put("src", src);
		return dataMap;
	}
}