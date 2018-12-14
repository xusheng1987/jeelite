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

import com.baomidou.mybatisplus.plugins.Page;
import com.github.flying.jeelite.common.persistence.PageFactory;
import com.github.flying.jeelite.common.rest.Result;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.modules.test.entity.TestData;
import com.github.flying.jeelite.modules.test.service.TestDataService;

/**
 * 单表生成Controller
 *
 * @author flying
 */
@Controller
@RequestMapping(value = "${adminPath}/test/testData")
public class TestDataController extends BaseController {

	@Autowired
	private TestDataService testDataService;

	@ModelAttribute
	public TestData get(@RequestParam(required = false) String id) {
		TestData entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = testDataService.get(id);
		}
		if (entity == null) {
			entity = new TestData();
		}
		return entity;
	}

	@RequiresPermissions("test:testData:view")
	@RequestMapping(value = { "list", "" })
	public String list() {
		return "modules/test/testDataList";
	}

	@ResponseBody
	@RequiresPermissions("test:testData:view")
	@RequestMapping(value = "data")
	public Map listData(TestData testData) {
		Page<TestData> page = testDataService.findPage(new PageFactory<TestData>().defaultPage(), testData);
		return jsonPage(page);
	}

	@RequiresPermissions("test:testData:view")
	@RequestMapping(value = "form")
	public String form(TestData testData, Model model) {
		model.addAttribute("testData", testData);
		return "modules/test/testDataForm";
	}

	@ResponseBody
	@RequiresPermissions("test:testData:edit")
	@RequestMapping(value = "save")
	public Result save(TestData testData) {
		beanValidator(testData);
		
		testDataService.save(testData);
		return renderSuccess("保存单表成功");
	}

	@ResponseBody
	@RequiresPermissions("test:testData:edit")
	@RequestMapping(value = "delete")
	public Result delete(TestData testData) {
		testDataService.delete(testData);
		return renderSuccess("删除单表成功");
	}

}