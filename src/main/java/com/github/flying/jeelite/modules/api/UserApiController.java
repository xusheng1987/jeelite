package com.github.flying.jeelite.modules.api;

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
import com.github.flying.jeelite.modules.api.dto.UserDto;
import com.github.flying.jeelite.modules.sys.entity.User;
import com.github.flying.jeelite.modules.sys.service.UserService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@Api(tags = "用户信息接口")
@RestController
@RequestMapping(value = "/api/user")
public class UserApiController extends BaseController {
	
	@Autowired
	private UserService userService;

	@ApiOperation(value = "登录", notes = "输入用户名和密码登录", produces = "application/json")
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public Result<UserDto> login(@ApiParam(value = "用户名", required = true) @RequestParam String username,
			@ApiParam(value = "密码", required = true) @RequestParam String password) {
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
		UserDto dto = new UserDto();
		dto.setUserId(user.getId());
		dto.setCompanyName(user.getCompany().getName());
		dto.setOfficeName(user.getOffice().getName());
		dto.setNo(user.getNo());
		dto.setName(user.getName());
		dto.setEmail(user.getEmail());
		dto.setPhone(user.getPhone());
		dto.setMobile(user.getMobile());
		return renderSuccess(dto);
	}

	@ApiOperation(value = "获取用户信息", notes = "根据userId获取用户信息", produces = "application/json")
	@RequestMapping(value = "{userId}", method = RequestMethod.GET)
	public Result<UserDto> userInfo(@ApiParam(value = "用户Id", required = true) @PathVariable String userId) {
		User user = userService.getUser(userId);
		if (user == null) {
			throw new RestException("用户不存在");
		}
		UserDto dto = new UserDto();
		dto.setUserId(user.getId());
		dto.setCompanyName(user.getCompany().getName());
		dto.setOfficeName(user.getOffice().getName());
		dto.setNo(user.getNo());
		dto.setName(user.getName());
		dto.setEmail(user.getEmail());
		dto.setPhone(user.getPhone());
		dto.setMobile(user.getMobile());
		return renderSuccess(dto);
	}
}