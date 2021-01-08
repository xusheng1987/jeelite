/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.test.web;

import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.flying.jeelite.common.persistence.Page;
import com.github.flying.jeelite.common.rest.Result;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.modules.test.entity.TestDataMain;
import com.github.flying.jeelite.modules.test.service.TestDataMainService;

/**
 * 主子表生成Controller
 *
 * @author flying
 */
@Controller
@RequestMapping(value = "${adminPath}/test/testDataMain")
public class TestDataMainController extends BaseController {

	@Autowired
	private TestDataMainService testDataMainService;

	@ModelAttribute
	public TestDataMain get(@RequestParam(required = false) String id) {
		TestDataMain entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = testDataMainService.get(id);
		}
		if (entity == null) {
			entity = new TestDataMain();
		}
		return entity;
	}

	@RequiresPermissions("test:testDataMain:view")
	@RequestMapping(value = { "list", "" })
	public String list() {
		return "modules/test/testDataMainList";
	}

	@ResponseBody
	@RequiresPermissions("test:testDataMain:view")
	@RequestMapping(value = "data")
	public Map listData(TestDataMain testDataMain) {
		Page<TestDataMain> page = testDataMainService.findPage(testDataMain);
		return jsonPage(page);
	}

	@RequiresPermissions("test:testDataMain:view")
	@RequestMapping(value = "form")
	public String form(TestDataMain testDataMain, Model model) {
		model.addAttribute("testDataMain", testDataMain);
		return "modules/test/testDataMainForm";
	}

	@ResponseBody
	@RequiresPermissions("test:testDataMain:edit")
	@RequestMapping(value = "save")
	public Result save(TestDataMain testDataMain) {
		beanValidator(testDataMain);
		
		testDataMainService.save(testDataMain);
		return renderSuccess("保存主子表成功");
	}

	@ResponseBody
	@RequiresPermissions("test:testDataMain:edit")
	@RequestMapping(value = "delete")
	public Result delete(TestDataMain testDataMain) {
		testDataMainService.delete(testDataMain);
		return renderSuccess("删除主子表成功");
	}

}