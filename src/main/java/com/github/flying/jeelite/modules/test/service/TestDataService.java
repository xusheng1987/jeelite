/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.test.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.flying.jeelite.common.service.BaseService;
import com.github.flying.jeelite.modules.test.dao.TestDataDao;
import com.github.flying.jeelite.modules.test.entity.TestData;

/**
 * 单表生成Service
 *
 * @author flying
 * @version 2015-04-06
 */
@Service
@Transactional(readOnly = true)
public class TestDataService extends BaseService<TestDataDao, TestData> {

}