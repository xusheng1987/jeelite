package com.thinkgem.jeesite.common.persistence.dataSource;

/**
 * 动态数据源操作工具类
  * 
 * @author flying
 * @version 2017-08-15
*/
public class DbContextHolder {
	private static final ThreadLocal<String> contextHolder = new ThreadLocal<String>();

	/**
	 * 设置数据源
	 */
	public static void setDbType(DBTypeEnum dbTypeEnum) {
		contextHolder.set(dbTypeEnum.getValue());
	}

	/**
	 * 取得当前数据源
	 */
	public static String getDbType() {
		return contextHolder.get();
	}

	/**
	 * 清除上下文数据
	 */
	public static void clearDbType() {
		contextHolder.remove();
	}
}