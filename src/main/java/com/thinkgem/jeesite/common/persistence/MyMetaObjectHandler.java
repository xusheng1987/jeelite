package com.thinkgem.jeesite.common.persistence;

import java.util.Date;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.reflection.MetaObject;

import com.baomidou.mybatisplus.mapper.MetaObjectHandler;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 公共字段自动填充处理器
 */
public class MyMetaObjectHandler extends MetaObjectHandler {

	@Override
	public void insertFill(MetaObject metaObject) {
		if (isDataEntity(metaObject)) {
			User user = UserUtils.getUser();
			if (StringUtils.isNotBlank(user.getId())) {
				setFieldValByName("updateBy", user, metaObject);
				setFieldValByName("createBy", user, metaObject);
			}
			Date date = new Date();
			setFieldValByName("updateDate", date, metaObject);
			setFieldValByName("createDate", date, metaObject);
		}
	}

	@Override
	public void updateFill(MetaObject metaObject) {
		if (isDataEntity(metaObject)) {
			User user = UserUtils.getUser();
			if (StringUtils.isNotBlank(user.getId())) {
				setFieldValByName("updateBy", user, metaObject);
			}
			setFieldValByName("updateDate", new Date(), metaObject);
		}
	}
	
	private boolean isDataEntity(MetaObject metaObject) {
		Object originalObject = metaObject.getOriginalObject();
		// 是否是DataEntity的子类
		boolean isDataEntity = false;
		if (originalObject instanceof DataEntity) {
			isDataEntity = true;
		} else if (originalObject instanceof Map) {
			Map map = (Map) originalObject;
			Object obj = map.get("et");
			if (obj instanceof DataEntity) {
				isDataEntity = true;
			}
		}
		return isDataEntity;
	}
}