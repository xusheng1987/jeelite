/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.test.web;

import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.baomidou.mybatisplus.plugins.Page;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.PageFactory;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.test.entity.TestData;
import com.thinkgem.jeesite.modules.test.service.TestDataService;

/**
 * 单表生成Controller
 *
 * @author ThinkGem
 * @version 2015-04-06
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

	@RequiresPermissions("test:testData:edit")
	@RequestMapping(value = "save")
	public String save(TestData testData, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, testData)) {
			return form(testData, model);
		}
		testDataService.save(testData);
		addMessage(redirectAttributes, "保存单表成功");
		return "redirect:" + Global.getAdminPath() + "/test/testData";
	}

	@RequiresPermissions("test:testData:edit")
	@RequestMapping(value = "delete")
	public String delete(TestData testData, RedirectAttributes redirectAttributes) {
		testDataService.delete(testData);
		addMessage(redirectAttributes, "删除单表成功");
		return "redirect:" + Global.getAdminPath() + "/test/testData";
	}

}