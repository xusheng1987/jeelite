package com.github.flying.jeelite.common.persistence.typeHandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import com.github.flying.jeelite.common.persistence.BaseEntity;

/**
 * 实体类通用类型处理器
 *
 */
public class CommonTypeHandler extends BaseTypeHandler<BaseEntity> {

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, BaseEntity parameter, JdbcType jdbcType)
			throws SQLException {
		ps.setString(i, parameter.getId());
	}

	@Override
	public BaseEntity getNullableResult(ResultSet rs, String columnName) throws SQLException {
		return null;
	}

	@Override
	public BaseEntity getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		return null;
	}

	@Override
	public BaseEntity getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		return null;
	}

}