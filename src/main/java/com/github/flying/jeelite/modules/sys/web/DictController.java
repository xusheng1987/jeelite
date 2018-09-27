/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.sys.web;

import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.plugins.Page;
import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.persistence.PageFactory;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.web.BaseController;
import com.github.flying.jeelite.modules.sys.entity.Dict;
import com.github.flying.jeelite.modules.sys.service.DictService;

/**
 * 字典Controller
 *
 * @author flying
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/dict")
public class DictController extends BaseController {

	@Autowired
	private DictService dictService;

	@ModelAttribute
	public Dict get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return dictService.selectById(id);
		} else {
			return new Dict();
		}
	}

	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = { "list", "" })
	public String list(Model model) {
		List<String> typeList = dictService.findTypeList();
		model.addAttribute("typeList", typeList);
		return "modules/sys/dictList";
	}

	@ResponseBody
	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = "data")
	public Map listData(Dict dict) {
		Page<Dict> page = dictService.findPage(new PageFactory<Dict>().defaultPage(), dict);
		return jsonPage(page);
	}

	@ResponseBody
	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = "query")
	public List<Dict> query(@RequestParam(required=false) String type) {
		Dict dict = new Dict();
		dict.setType(type);
		return dictService.findList(dict);
	}

	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = "form")
	public String form(Dict dict, Model model) {
		model.addAttribute("dict", dict);
		return "modules/sys/dictForm";
	}

	@ResponseBody
	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "save")
	public ResponseEntity save(Dict dict) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		beanValidator(dict);
		
		dictService.save(dict);
		return renderSuccess("保存字典'" + dict.getLabel() + "'成功");
	}

	@ResponseBody
	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "delete")
	public ResponseEntity delete(Dict dict) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		dictService.delete(dict);
		return renderSuccess("删除字典成功");
	}

	@ResponseBody
	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "batchDelete")
	public ResponseEntity batchDelete(String ids) {
		if (Global.isDemoMode()) {
			return renderError("演示模式，不允许操作！");
		}
		dictService.batchDelete(ids);
		return renderSuccess("批量删除字典成功");
	}

}