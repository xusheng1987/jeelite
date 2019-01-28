package com.github.flying.jeelite.modules.monitor.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * 定时任务测试
 *
 */
@Component("testTask")
public class TestTask {
	private Logger logger = LoggerFactory.getLogger(getClass());

	public void test1(String params) {
		logger.info("正在执行带参数的test1方法，参数为：" + params);
	}

	public void test2() {
		logger.info("正在执行不带参数的test2方法");
	}
}