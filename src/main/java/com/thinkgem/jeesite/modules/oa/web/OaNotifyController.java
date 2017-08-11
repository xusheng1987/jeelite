/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.oa.web;

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
import com.thinkgem.jeesite.common.persistence.PageFactory;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.oa.entity.OaNotify;
import com.thinkgem.jeesite.modules.oa.service.OaNotifyService;

/**
 * 通知通告Controller
 * 
 * @author ThinkGem
 * @version 2014-05-16
 */
@Controller
@RequestMapping(value = "${adminPath}/oa/oaNotify")
public class OaNotifyController extends BaseController {

	@Autowired
	private OaNotifyService oaNotifyService;

	@ModelAttribute
	public OaNotify get(@RequestParam(required = false) String id) {
		OaNotify entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = oaNotifyService.get(id);
		}
		if (entity == null) {
			entity = new OaNotify();
		}
		return entity;
	}

	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = { "list", "" })
	public String list(OaNotify oaNotify, Model model) {
		model.addAttribute("oaNotify", oaNotify);
		return "modules/oa/oaNotifyList";
	}

	@ResponseBody
	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = "data")
	public Map listData(OaNotify oaNotify) {
		Page<OaNotify> page = oaNotifyService.findPage(new PageFactory<OaNotify>().defaultPage(), oaNotify);
		return jsonPage(page);
	}

	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = "form")
	public String form(OaNotify oaNotify, Model model) {
		if (StringUtils.isNotBlank(oaNotify.getId())) {
			oaNotify = oaNotifyService.getRecordList(oaNotify);
		}
		model.addAttribute("oaNotify", oaNotify);
		return "modules/oa/oaNotifyForm";
	}

	@RequiresPermissions("oa:oaNotify:edit")
	@RequestMapping(value = "save")
	public String save(OaNotify oaNotify, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, oaNotify)) {
			return form(oaNotify, model);
		}
		// 如果是修改，则状态为已发布，则不能再进行操作
		if (StringUtils.isNotBlank(oaNotify.getId())) {
			OaNotify e = oaNotifyService.get(oaNotify.getId());
			if ("1".equals(e.getStatus())) {
				addMessage(redirectAttributes, "已发布，不能操作！");
				return "redirect:" + adminPath + "/oa/oaNotify/form?id=" + oaNotify.getId();
			}
		}
		oaNotifyService.save(oaNotify);
		addMessage(redirectAttributes, "保存通知'" + oaNotify.getTitle() + "'成功");
		return "redirect:" + adminPath + "/oa/oaNotify/?repage";
	}

	@RequiresPermissions("oa:oaNotify:edit")
	@RequestMapping(value = "delete")
	public String delete(OaNotify oaNotify, RedirectAttributes redirectAttributes) {
		oaNotifyService.delete(oaNotify);
		addMessage(redirectAttributes, "删除通知成功");
		return "redirect:" + adminPath + "/oa/oaNotify/?repage";
	}

	/**
	 * 我的通知列表
	 */
	@RequestMapping(value = "self")
	public String selfList(OaNotify oaNotify, Model model) {
		oaNotify.setSelf(true);
		model.addAttribute("oaNotify", oaNotify);
		return "modules/oa/oaNotifyList";
	}

	/**
	 * 我的通知列表-数据
	 */
	@ResponseBody
	@RequestMapping(value = "data/self")
	public Map selfData(OaNotify oaNotify) {
		oaNotify.setSelf(true);
		Page<OaNotify> page = oaNotifyService.findPage(new PageFactory<OaNotify>().defaultPage(), oaNotify);
		return jsonPage(page);
	}

	/**
	 * 查看我的通知
	 */
	@RequestMapping(value = "view")
	public String view(OaNotify oaNotify, Model model) {
		if (StringUtils.isNotBlank(oaNotify.getId())) {
			oaNotifyService.updateReadFlag(oaNotify);
			oaNotify = oaNotifyService.getRecordList(oaNotify);
			model.addAttribute("oaNotify", oaNotify);
			return "modules/oa/oaNotifyForm";
		}
		return "redirect:" + adminPath + "/oa/oaNotify/self?repage";
	}

	/**
	 * 查看我的通知-数据
	 */
	@RequestMapping(value = "viewData")
	@ResponseBody
	public OaNotify viewData(OaNotify oaNotify) {
		if (StringUtils.isNotBlank(oaNotify.getId())) {
			oaNotifyService.updateReadFlag(oaNotify);
			return oaNotify;
		}
		return null;
	}

	/**
	 * 查看我的通知-发送记录
	 */
	@RequestMapping(value = "viewRecordData")
	@ResponseBody
	public OaNotify viewRecordData(OaNotify oaNotify) {
		if (StringUtils.isNotBlank(oaNotify.getId())) {
			oaNotify = oaNotifyService.getRecordList(oaNotify);
			return oaNotify;
		}
		return null;
	}

	/**
	 * 获取我的通知数目
	 */
	@RequestMapping(value = "self/count")
	@ResponseBody
	public String selfCount(OaNotify oaNotify) {
		oaNotify.setSelf(true);
		oaNotify.setReadFlag("0");
		return String.valueOf(oaNotifyService.findCount(oaNotify));
	}
}