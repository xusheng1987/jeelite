/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.gen.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.service.BaseService;
import com.github.flying.jeelite.modules.gen.dao.GenSchemeDao;
import com.github.flying.jeelite.modules.gen.dao.GenTableColumnDao;
import com.github.flying.jeelite.modules.gen.dao.GenTableDao;
import com.github.flying.jeelite.modules.gen.entity.GenConfig;
import com.github.flying.jeelite.modules.gen.entity.GenScheme;
import com.github.flying.jeelite.modules.gen.entity.GenTable;
import com.github.flying.jeelite.modules.gen.entity.GenTableColumn;
import com.github.flying.jeelite.modules.gen.entity.GenTemplate;
import com.github.flying.jeelite.modules.gen.util.GenUtils;

/**
 * 生成方案Service
 *
 * @author flying
 * @version 2013-10-15
 */
@Service
@Transactional(readOnly = true)
public class GenSchemeService extends BaseService<GenSchemeDao, GenScheme> {

	@Autowired
	private GenTableDao genTableDao;
	@Autowired
	private GenTableColumnDao genTableColumnDao;

	@Transactional(readOnly = false)
	public String saveScheme(GenScheme genScheme) {
		super.save(genScheme);
		// 生成代码
		if ("1".equals(genScheme.getFlag())) {
			return generateCode(genScheme);
		}
		return "";
	}

	private String generateCode(GenScheme genScheme) {

		StringBuilder result = new StringBuilder();

		// 查询主表及字段列
		GenTable genTable = genTableDao.selectById(genScheme.getGenTable().getId());
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