package com.github.flying.jeelite.common.persistence;

/**
 * 分页类
 */
public class Page<T> extends com.baomidou.mybatisplus.extension.plugins.pagination.Page<T> {
	private String orderBy = "";//排序字段 例：name asc

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	
}