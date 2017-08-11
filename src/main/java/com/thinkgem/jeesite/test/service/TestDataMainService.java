/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.plugins.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.test.dao.TestDataChildDao;
import com.thinkgem.jeesite.test.dao.TestDataMainDao;
import com.thinkgem.jeesite.test.entity.TestDataChild;
import com.thinkgem.jeesite.test.entity.TestDataMain;

/**
 * 主子表生成Service
 * 
 * @author ThinkGem
 * @version 2015-04-06
 */
@Service
@Transactional(readOnly = true)
public class TestDataMainService extends BaseService<TestDataMainDao, TestDataMain> {

	@Autowired
	private TestDataChildDao testDataChildDao;

	public TestDataMain get(String id) {
		TestDataMain testDataMain = super.get(id);
		testDataMain.setTestDataChildList(testDataChildDao.findList(new TestDataChild(testDataMain)));
		return testDataMain;
	}

	public List<TestDataMain> findList(TestDataMain testDataMain) {
		return super.findList(testDataMain);
	}

	public Page<TestDataMain> findPage(Page<TestDataMain> page, TestDataMain testDataMain) {
		return super.findPage(page, testDataMain);
	}

	@Transactional(readOnly = false)
	public void save(TestDataMain testDataMain) {
		super.insertOrUpdate(testDataMain);
		for (TestDataChild testDataChild : testDataMain.getTestDataChildList()) {
			// if (StringUtils.isEmpty(testDataChild.getId())) {
			// continue;
			// }
			if (TestDataChild.DEL_FLAG_NORMAL.equals(testDataChild.getDelFlag())) {
				if (StringUtils.isBlank(testDataChild.getId())) {
					testDataChild.setTestDataMain(testDataMain);
					testDataChildDao.insert(testDataChild);
				} else {
					testDataChildDao.updateById(testDataChild);
				}
			} else {
				testDataChildDao.delete(testDataChild);
			}
		}
	}

	@Transactional(readOnly = false)
	public void delete(TestDataMain testDataMain) {
		super.delete(testDataMain);
		testDataChildDao.delete(new TestDataChild(testDataMain));
	}

}