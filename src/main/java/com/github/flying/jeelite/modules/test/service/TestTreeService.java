/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.test.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.service.TreeService;
import com.github.flying.jeelite.modules.test.dao.TestTreeDao;
import com.github.flying.jeelite.modules.test.entity.TestTree;

/**
 * 树结构生成Service
 *
 * @author flying
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