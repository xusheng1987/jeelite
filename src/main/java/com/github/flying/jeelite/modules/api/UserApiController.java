package com.github.flying.jeelite.modules.api;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.rest.RestException;
import com.github.flying.jeelite.common.rest.Result;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.modules.sys.entity.User;
import com.github.flying.jeelite.modules.sys.service.UserService;
import com.google.common.collect.Maps;

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
			@ApiImplicitParam(name = "username", value = "用户名", required = true, paramType = "form", dataType = "String"),
			@ApiImplicitParam(name = "password", value = "密码", required = true, paramType = "form", dataType = "String") })
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public Result<Map<String, String>> login(@RequestParam String username, @RequestParam String password) {
		User user = userService.getUserByLoginName(username);
		if (user == null) {
			throw new RestException("用户不存在");
		}
		if (Global.NO.equals(user.getLoginFlag())) {
			throw new RestException(HttpStatus.FORBIDDEN, "该帐号已禁止登录");
		}
		boolean isCorrect = UserService.validatePassword(password, user.getPassword());
		if (!isCorrect) {
			throw new RestException("用户名或密码错误");
		}
		Map<String, String> map = Maps.newHashMap();
		map.put("userId", user.getId());
		return renderSuccess(map);
	}

	@ApiOperation(value = "获取用户信息", notes = "根据userId获取用户信息")
	@ApiImplicitParam(name = "userId", value = "用户Id", required = true, paramType = "path", dataType = "String")
	@RequestMapping(value = "{userId}", method = RequestMethod.GET)
	public Result<User> userInfo(@PathVariable String userId) {
		User user = userService.getUser(userId);
		if (user == null) {
			throw new RestException("用户不存在");
		}
		return renderSuccess(user);
	}
}