/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.config;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.stereotype.Component;

import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.web.Servlets;

/**
 * 全局配置类，注意@Value注解要放在set方法上，并且去掉static修饰符
 *
 * @author flying
 * @version 2014-06-25
 */
@Component
public class Global {
	private static String adminPath;// 管理后台基础路径
	private static String version;// 版本
	private static String demoMode;// 是否演示模式
	private static String captchaEnabled;// 是否启用验证码
	private static String multiAccountLogin;// 是否允许多账号同时登录
	private static String jdbcType;// 数据库类型
	private static String staticFile;// 静态文件后缀
	private static String sessionForceLogoutKey;// 会话强制退出标记key
	private static String userfilesBaseDir;// 上传文件绝对路径
	private static String projectPath;// 工程路径

	/**
	 * 是/否
	 */
	public static final String YES = "1";
	public static final String NO = "0";

	/**
	 * 对/错
	 */
	public static final String TRUE = "true";
	public static final String FALSE = "false";

	/**
	 * 上传文件基础虚拟路径
	 */
	public static final String USERFILES_BASE_URL = "/userfiles/";

	public static String getAdminPath() {
		return adminPath;
	}

	@Value("${adminPath}")
	public void setAdminPath(String adminPath) {
		Global.adminPath = adminPath;
	}

	public static String getVersion() {
		return version;
	}

	@Value("${version}")
	public void setVersion(String version) {
		Global.version = version;
	}

	/**
	 * 是否是演示模式，演示模式下不能修改用户、角色、密码、菜单、授权
	 */
	public static Boolean isDemoMode() {
		return "true".equals(demoMode) || "1".equals(demoMode);
	}

	@Value("${demoMode}")
	public void setDemoMode(String demoMode) {
		Global.demoMode = demoMode;
	}

	public static String getCaptchaEnabled() {
		return captchaEnabled;
	}

	@Value("${captchaEnabled}")
	public void setCaptchaEnabled(String captchaEnabled) {
		Global.captchaEnabled = captchaEnabled;
	}

	public static String getMultiAccountLogin() {
		return multiAccountLogin;
	}

	@Value("${user.multiAccountLogin}")
	public void setMultiAccountLogin(String multiAccountLogin) {
		Global.multiAccountLogin = multiAccountLogin;
	}

	public static String getJdbcType() {
		return jdbcType;
	}

	@Value("${jdbc.type}")
	public void setJdbcType(String jdbcType) {
		Global.jdbcType = jdbcType;
	}

	public static String getStaticFile() {
		return staticFile;
	}

	@Value("${web.staticFile}")
	public void setStaticFile(String staticFile) {
		Global.staticFile = staticFile;
	}

	public static String getSessionForceLogoutKey() {
		return sessionForceLogoutKey;
	}

	@Value("${session.forceLogoutKey}")
	public void setSessionForceLogoutKey(String sessionForceLogoutKey) {
		Global.sessionForceLogoutKey = sessionForceLogoutKey;
	}

	/**
	 * 获取上传文件的根目录
	 */
	public static String getUserfilesBaseDir() {
		if (StringUtils.isBlank(userfilesBaseDir)) {
			userfilesBaseDir = Servlets.getRequest().getSession().getServletContext().getRealPath("/");
		}
		return userfilesBaseDir;
	}

	@Value("${userfiles.basedir}")
	public void setUserfilesBaseDir(String userfilesBaseDir) {
		Global.userfilesBaseDir = userfilesBaseDir;
	}

	/**
	 * 获取工程路径
	 */
	public static String getProjectPath() {
		// 如果配置了工程路径，则直接返回，否则自动获取。
		if (StringUtils.isNotBlank(projectPath)) {
			return projectPath;
		}
		try {
			File file = new DefaultResourceLoader().getResource("").getFile();
			if (file != null) {
				while (true) {
					File f = new File(file.getPath() + File.separator + "src" + File.separator + "main");
					if (f == null || f.exists()) {
						break;
					}
					if (file.getParentFile() != null) {
						file = file.getParentFile();
					} else {
						break;
					}
				}
				projectPath = file.toString();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return projectPath;
	}

	@Value("${projectPath}")
	public void setProjectPath(String projectPath) {
		Global.projectPath = projectPath;
	}

}