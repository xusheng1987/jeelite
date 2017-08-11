/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gen.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.plugins.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.gen.dao.GenSchemeDao;
import com.thinkgem.jeesite.modules.gen.dao.GenTableColumnDao;
import com.thinkgem.jeesite.modules.gen.dao.GenTableDao;
import com.thinkgem.jeesite.modules.gen.entity.GenConfig;
import com.thinkgem.jeesite.modules.gen.entity.GenScheme;
import com.thinkgem.jeesite.modules.gen.entity.GenTable;
import com.thinkgem.jeesite.modules.gen.entity.GenTableColumn;
import com.thinkgem.jeesite.modules.gen.entity.GenTemplate;
import com.thinkgem.jeesite.modules.gen.util.GenUtils;

/**
 * 生成方案Service
 * 
 * @author ThinkGem
 * @version 2013-10-15
 */
@Service
@Transactional(readOnly = true)
public class GenSchemeService extends BaseService<GenSchemeDao, GenScheme> {

	@Autowired
	private GenTableDao genTableDao;
	@Autowired
	private GenTableColumnDao genTableColumnDao;

	public GenScheme get(String id) {
		return super.get(id);
	}

	public Page<GenScheme> find(Page<GenScheme> page, GenScheme genScheme) {
		GenUtils.getTemplatePath();
		return super.findPage(page, genScheme);
	}

	@Transactional(readOnly = false)
	public String save(GenScheme genScheme) {
		super.insertOrUpdate(genScheme);
		// 生成代码
		if ("1".equals(genScheme.getFlag())) {
			return generateCode(genScheme);
		}
		return "";
	}

	@Transactional(readOnly = false)
	public void delete(GenScheme genScheme) {
		super.delete(genScheme);
	}

	private String generateCode(GenScheme genScheme) {

		StringBuilder result = new StringBuilder();

		// 查询主表及字段列
		GenTable genTable = genTableDao.get(genScheme.getGenTable().getId());
		genTable.setColumnList(genTableColumnDao.findList(new GenTableColumn(new GenTable(genTable.getId()))));

		// 获取所有代码模板
		GenConfig config = GenUtils.getConfig();

		// 获取模板列表
		List<GenTemplate> templateList = GenUtils.getTemplateList(config, genScheme.getCategory(), false);
		List<GenTemplate> childTableTemplateList = GenUtils.getTemplateList(config, genScheme.getCategory(), true);

		// 如果有子表模板，则需要获取子表列表
		if (childTableTemplateList.size() > 0) {
			GenTable parentTable = new GenTable();
			parentTable.setParentTable(genTable.getName());
			genTable.setChildList(genTableDao.findList(parentTable));
		}

		// 生成子表模板代码
		for (GenTable childTable : genTable.getChildList()) {
			childTable.setParent(genTable);
			childTable.setColumnList(genTableColumnDao.findList(new GenTableColumn(new GenTable(childTable.getId()))));
			genScheme.setGenTable(childTable);
			Map<String, Object> childTableModel = GenUtils.getDataModel(genScheme);
			for (GenTemplate tpl : childTableTemplateList) {
				result.append(GenUtils.generateToFile(tpl, childTableModel, genScheme.getReplaceFile()));
			}
		}

		// 生成主表模板代码
		genScheme.setGenTable(genTable);
		Map<String, Object> model = GenUtils.getDataModel(genScheme);
		for (GenTemplate tpl : templateList) {
			result.append(GenUtils.generateToFile(tpl, model, genScheme.getReplaceFile()));
		}
		return result.toString();
	}
}