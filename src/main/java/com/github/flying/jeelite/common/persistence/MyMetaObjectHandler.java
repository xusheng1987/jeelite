package com.github.flying.jeelite.common.persistence;

import java.util.Date;

import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.github.flying.jeelite.modules.sys.entity.User;
import com.github.flying.jeelite.modules.sys.utils.UserUtils;

/**
 * 公共字段自动填充处理器
 */
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

	@Override
	public void insertFill(MetaObject metaObject) {
		User user = UserUtils.getUser();
		setFieldValByName("updateBy", user, metaObject);
		setFieldValByName("createBy", user, metaObject);
		Date date = new Date();
		setFieldValByName("updateDate", date, metaObject);
		setFieldValByName("createDate", date, metaObject);
	}

	@Override
	public void updateFill(MetaObject metaObject) {
		User user = UserUtils.getUser();
		setFieldValByName("updateBy", user, metaObject);
		setFieldValByName("updateDate", new Date(), metaObject);
	}
}