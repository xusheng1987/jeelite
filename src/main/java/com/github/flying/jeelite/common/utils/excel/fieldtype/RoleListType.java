/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.utils.excel.fieldtype;

import java.util.List;

import com.google.common.collect.Lists;
import com.github.flying.jeelite.common.utils.Collections3;
import com.github.flying.jeelite.common.utils.SpringContextHolder;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.modules.sys.entity.Role;
import com.github.flying.jeelite.modules.sys.service.RoleService;

/**
 * 字段类型转换
 *
 * @author flying
 * @version 2013-5-29
 */
public class RoleListType {

	private static RoleService roleService = SpringContextHolder.getBean(RoleService.class);

	/**
	 * 获取对象值（导入）
	 */
	public static Object getValue(String val) {
		List<Role> roleList = Lists.newArrayList();
		List<Role> allRoleList = roleService.findAllRole();
		for (String s : StringUtils.split(val, ",")) {
			for (Role e : allRoleList) {
				if (StringUtils.trimToEmpty(s).equals(e.getName())) {
					roleList.add(e);
				}
			}
		}
		return roleList.size() > 0 ? roleList : null;
	}

	/**
	 * 设置对象值（导出）
	 */
	public static String setValue(Object val) {
		if (val != null) {
			List<Role> roleList = (List<Role>) val;
			return Collections3.extractToString(roleList, "name", ", ");
		}
		return "";
	}

}
