/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.gen.web;

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
import com.github.flying.jeelite.modules.gen.entity.GenScheme;
import com.github.flying.jeelite.modules.gen.service.GenSchemeService;
import com.github.flying.jeelite.modules.gen.service.GenTableService;
import com.github.flying.jeelite.modules.gen.util.GenUtils;

/**
 * 生成方案Controller
 *
 * @author flying
 * @version 2013-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/gen/genScheme")
public class GenSchemeController extends BaseController {

	@Autowired
	private GenSchemeService genSchemeService;

	@Autowired
	private GenTableService genTableService;

	@ModelAttribute
	public GenScheme get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return genSchemeService.get(id);
		} else {
			return new GenScheme();
		}
	}

	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = { "list", "" })
	public String list() {
		return "modules/gen/genSchemeList";
	}

	@ResponseBody
	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = "data")
	public Map data(GenScheme genScheme) {
		Page<GenScheme> page = genSchemeService.findPage(new PageFactory<GenScheme>().defaultPage(), genScheme);
		return jsonPage(page);
	}

	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = "form")
	public String form(GenScheme genScheme, Model model) {
		if (StringUtils.isBlank(genScheme.getPackageName())) {
			genScheme.setPackageName("com.github.flying.jeelite.modules");
		}
		model.addAttribute("genScheme", genScheme);
		model.addAttribute("config", GenUtils.getConfig());
		model.addAttribute("tableList", genTableService.findAll());
		return "modules/gen/genSchemeForm";
	}

	@ResponseBody
	@RequiresPermissions("gen:genScheme:edit")
	@RequestMapping(value = "save")
	public Result save(GenScheme genScheme) {
		beanValidator(genScheme);

		String result = genSchemeService.saveScheme(genScheme);
		return renderSuccess("操作生成方案'" + genScheme.getName() + "'成功<br/>" + result);
	}

	@ResponseBody
	@RequiresPermissions("gen:genScheme:edit")
	@RequestMapping(value = "delete")
	public Result delete(GenScheme genScheme) {
		genSchemeService.delete(genScheme);
		return renderSuccess("删除生成方案成功");
	}

}