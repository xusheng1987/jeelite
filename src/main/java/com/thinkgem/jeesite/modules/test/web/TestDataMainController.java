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
import com.thinkgem.jeesite.modules.test.entity.TestDataMain;
import com.thinkgem.jeesite.modules.test.service.TestDataMainService;

/**
 * 主子表生成Controller
 *
 * @author ThinkGem
 * @version 2015-04-06
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
		Page<TestDataMain> page = testDataMainService.findPage(new PageFactory<TestDataMain>().defaultPage(),
				testDataMain);
		return jsonPage(page);
	}

	@RequiresPermissions("test:testDataMain:view")
	@RequestMapping(value = "form")
	public String form(TestDataMain testDataMain, Model model) {
		model.addAttribute("testDataMain", testDataMain);
		return "modules/test/testDataMainForm";
	}

	@RequiresPermissions("test:testDataMain:edit")
	@RequestMapping(value = "save")
	public String save(TestDataMain testDataMain, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, testDataMain)) {
			return form(testDataMain, model);
		}
		testDataMainService.save(testDataMain);
		addMessage(redirectAttributes, "保存主子表成功");
		return "redirect:" + Global.getAdminPath() + "/test/testDataMain";
	}

	@RequiresPermissions("test:testDataMain:edit")
	@RequestMapping(value = "delete")
	public String delete(TestDataMain testDataMain, RedirectAttributes redirectAttributes) {
		testDataMainService.delete(testDataMain);
		addMessage(redirectAttributes, "删除主子表成功");
		return "redirect:" + Global.getAdminPath() + "/test/testDataMain";
	}

}