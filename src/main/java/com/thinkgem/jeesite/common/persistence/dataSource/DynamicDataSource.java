package com.thinkgem.jeesite.common.persistence.dataSource;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

/**
 * 动态数据源
  * 
 * @author flying
 * @version 2017-08-15
*/
public class DynamicDataSource extends AbstractRoutingDataSource {

	/**
	 * 取得当前使用哪个数据源
	 */
	@Override
	protected Object determineCurrentLookupKey() {
		return DbContextHolder.getDbType();
	}

}