/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.gen.web;

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

import com.github.flying.jeelite.common.persistence.Page;
import com.github.flying.jeelite.common.rest.Result;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.modules.gen.entity.GenTable;
import com.github.flying.jeelite.modules.gen.service.GenTableService;
import com.github.flying.jeelite.modules.gen.util.GenUtils;

/**
 * 业务表Controller
 *
 * @author flying
 * @version 2013-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/gen/genTable")
public class GenTableController extends BaseController {

	@Autowired
	private GenTableService genTableService;

	@ModelAttribute
	public GenTable get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return genTableService.get(id);
		} else {
			return new GenTable();
		}
	}

	@RequiresPermissions("gen:genTable:view")
	@RequestMapping(value = { "list", "" })
	public String list() {
		return "modules/gen/genTableList";
	}

	@ResponseBody
	@RequiresPermissions("gen:genTable:view")
	@RequestMapping(value = "data")
	public Map data(GenTable genTable) {
		Page<GenTable> page = genTableService.findPage(genTable);
		return jsonPage(page);
	}

	@RequiresPermissions("gen:genTable:view")
	@RequestMapping(value = "form")
	public String form(Model model) {
		// 获取物理表列表
		List<GenTable> tableList = genTableService.findTableListFormDb(new GenTable());
		model.addAttribute("tableList", tableList);
		return "modules/gen/genTableForm";
	}

	@ResponseBody
	@RequiresPermissions("gen:genTable:view")
	@RequestMapping(value = "next")
	public Result next(GenTable genTable) {
		// 验证表是否存在
		if (StringUtils.isBlank(genTable.getId()) && !genTableService.checkTableName(genTable.getName())) {
			return renderError("下一步失败！" + genTable.getName() + " 表已经添加！");
		}
		return renderSuccess();
	}

	@RequiresPermissions("gen:genTable:view")
	@RequestMapping(value = "next/form")
	public String nextform(GenTable genTable, Model model) {
		// 获取物理表列表
		List<GenTable> tableList = genTableService.findTableListFormDb(new GenTable());
		model.addAttribute("tableList", tableList);
		// 获取物理表字段
		genTable = genTableService.getTableFormDb(genTable);
		model.addAttribute("genTable", genTable);
		model.addAttribute("config", GenUtils.getConfig());
		return "modules/gen/genTableNextForm";
	}

	@ResponseBody
	@RequiresPermissions("gen:genTable:edit")
	@RequestMapping(value = "save")
	public Result save(GenTable genTable) {
		beanValidator(genTable);
		
		// 验证表是否已经存在
		if (StringUtils.isBlank(genTable.getId()) && !genTableService.checkTableName(genTable.getName())) {
			return renderError("保存失败！" + genTable.getName() + " 表已经存在！");
		}
		genTableService.save(genTable);
		return renderSuccess("保存业务表'" + genTable.getName() + "'成功");
	}

	@ResponseBody
	@RequiresPermissions("gen:genTable:edit")
	@RequestMapping(value = "delete")
	public Result delete(GenTable genTable) {
		genTableService.delete(genTable);
		return renderSuccess("删除业务表成功");
	}

	@ResponseBody
	@RequiresPermissions("gen:genTable:edit")
	@RequestMapping(value = "batchDelete")
	public Result batchDelete(String ids) {
		genTableService.batchDelete(ids);
		return renderSuccess("批量删除业务表成功");
	}

}