/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.test.web;

import java.util.List;
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

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.test.entity.TestTree;
import com.thinkgem.jeesite.test.service.TestTreeService;

/**
 * 树结构生成Controller
 * 
 * @author ThinkGem
 * @version 2015-04-06
 */
@Controller
@RequestMapping(value = "${adminPath}/test/testTree")
public class TestTreeController extends BaseController {

	@Autowired
	private TestTreeService testTreeService;

	@ModelAttribute
	public TestTree get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return testTreeService.get(id);
		} else {
			return new TestTree();
		}
	}

	@RequiresPermissions("test:testTree:view")
	@RequestMapping(value = { "list", "" })
	public String list(TestTree testTree, Model model) {
		List<TestTree> list = testTreeService.findList(testTree);
		model.addAttribute("list", list);
		return "jeesite/test/testTreeList";
	}

	@RequiresPermissions("test:testTree:view")
	@RequestMapping(value = "form")
	public String form(TestTree testTree, Model model) {
		if (testTree.getParent() != null && StringUtils.isNotBlank(testTree.getParent().getId())) {
			testTree.setParent(testTreeService.get(testTree.getParent().getId()));
		}
		model.addAttribute("testTree", testTree);
		return "jeesite/test/testTreeForm";
	}

	@RequiresPermissions("test:testTree:edit")
	@RequestMapping(value = "save")
	public String save(TestTree testTree, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, testTree)) {
			return form(testTree, model);
		}
		testTreeService.save(testTree);
		addMessage(redirectAttributes, "保存树结构成功");
		return "redirect:" + Global.getAdminPath() + "/test/testTree";
	}

	@RequiresPermissions("test:testTree:edit")
	@RequestMapping(value = "delete")
	public String delete(TestTree testTree, RedirectAttributes redirectAttributes) {
		testTreeService.delete(testTree);
		addMessage(redirectAttributes, "删除树结构成功");
		return "redirect:" + Global.getAdminPath() + "/test/testTree";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required = false) String extId) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<TestTree> list = testTreeService.findList(new TestTree());
		for (int i = 0; i < list.size(); i++) {
			TestTree e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId != null && !extId.equals(e.getId())
					&& e.getParentIds().indexOf("," + extId + ",") == -1)) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}

}