/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.test.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.modules.test.dao.TestTreeDao;
import com.thinkgem.jeesite.modules.test.entity.TestTree;

/**
 * 树结构生成Service
 *
 * @author ThinkGem
 * @version 2015-04-06
 */
@Service
@Transactional(readOnly = true)
public class TestTreeService extends TreeService<TestTreeDao, TestTree> {

	public List<TestTree> findAll() {
		List<TestTree> list = dao.findAllList(new TestTree());
		return buildTree(list);
	}

}