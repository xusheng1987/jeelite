/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.service.BaseService;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.modules.test.dao.TestDataChildDao;
import com.github.flying.jeelite.modules.test.dao.TestDataMainDao;
import com.github.flying.jeelite.modules.test.entity.TestDataChild;
import com.github.flying.jeelite.modules.test.entity.TestDataMain;

/**
 * 主子表生成Service
 *
 * @author flying
 * @version 2015-04-06
 */
@Service
@Transactional(readOnly = true)
public class TestDataMainService extends BaseService<TestDataMainDao, TestDataMain> {

	@Autowired
	private TestDataChildDao testDataChildDao;

	@Override
	public TestDataMain get(String id) {
		TestDataMain testDataMain = super.get(id);
		testDataMain.setTestDataChildList(testDataChildDao.findList(new TestDataChild(testDataMain)));
		return testDataMain;
	}

	@Override
	@Transactional(readOnly = false)
	public int save(TestDataMain testDataMain) {
		int row = super.save(testDataMain);
		for (TestDataChild testDataChild : testDataMain.getTestDataChildList()) {
			if (testDataChild.getId() == null) {
				continue;
			}
			if (TestDataChild.DEL_FLAG_NORMAL.equals(testDataChild.getDelFlag())) {
				if (StringUtils.isBlank(testDataChild.getId())) {
					testDataChild.setTestDataMain(testDataMain);
					row += testDataChildDao.insert(testDataChild);
				} else {
					row += testDataChildDao.updateById(testDataChild);
				}
			} else {
				row += testDataChildDao.delete(testDataChild);
			}
		}
		return row;
	}

	@Override
	@Transactional(readOnly = false)
	public int delete(TestDataMain testDataMain) {
		int row = super.delete(testDataMain);
		row += testDataChildDao.delete(new TestDataChild(testDataMain));
		return row;
	}

}