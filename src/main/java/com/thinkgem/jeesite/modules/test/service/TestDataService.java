/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.test.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.plugins.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.test.dao.TestDataDao;
import com.thinkgem.jeesite.modules.test.entity.TestData;

/**
 * 单表生成Service
 * 
 * @author ThinkGem
 * @version 2015-04-06
 */
@Service
@Transactional(readOnly = true)
public class TestDataService extends BaseService<TestDataDao, TestData> {

	public TestData get(String id) {
		return super.get(id);
	}

	public List<TestData> findList(TestData testData) {
		return super.findList(testData);
	}

	public Page<TestData> findPage(Page<TestData> page, TestData testData) {
		return super.findPage(page, testData);
	}

	@Transactional(readOnly = false)
	public void save(TestData testData) {
		super.insertOrUpdate(testData);
	}

	@Transactional(readOnly = false)
	public void delete(TestData testData) {
		super.delete(testData);
	}

}