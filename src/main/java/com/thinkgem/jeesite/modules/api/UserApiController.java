package com.thinkgem.jeesite.modules.api;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.UserService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

@Api(tags = "用户信息接口")
@RestController
@RequestMapping(value = "/api/user")
public class UserApiController extends BaseController {

	@Autowired
	private UserService userService;

	@ApiOperation(value = "登录", notes = "输入用户名和密码登录")
	@ApiImplicitParams({
			@ApiImplicitParam(name = "username", value = "用户名", required = true, paramType = "query", dataType = "String"),
			@ApiImplicitParam(name = "password", value = "密码", required = true, paramType = "query", dataType = "String") })
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public Map login(@RequestParam String username, @RequestParam String password) {
		User user = userService.getUserByLoginName(username);
		if (user != null) {
			if (Global.NO.equals(user.getLoginFlag())) {
				return null;// 该已帐号禁止登录
			}
			boolean isCorrect = UserService.validatePassword(password, user.getPassword());
			if (!isCorrect) {
				return null;// 用户名或密码错误
			}
			Map map = new HashMap();
			map.put("userId", user.getId());
			return map;
		} else {
			return null;
		}
	}

	@ApiOperation(value = "获取用户信息", notes = "根据userId获取用户信息")
	@ApiImplicitParam(name = "userId", value = "用户Id", required = true, paramType = "path", dataType = "String")
	@RequestMapping(value = "{userId}", method = RequestMethod.GET)
	public User userInfo(@PathVariable String userId) {
		User user = userService.getUser(userId);
		return user;
	}
}