package com.github.flying.jeelite.common.persistence;

import javax.servlet.http.HttpServletRequest;

import com.baomidou.mybatisplus.plugins.Page;
import com.github.flying.jeelite.common.utils.StringUtils;
import com.github.flying.jeelite.common.web.Servlets;

/**
 * layui table默认的分页参数创建
 */
public class PageFactory<T> {

	public Page<T> defaultPage() {
		HttpServletRequest request = Servlets.getRequest();
		int limit = Integer.valueOf(request.getParameter("limit"));//每页数据量
		int pageNo = Integer.valueOf(request.getParameter("pageNo"));//当前页码
		String field = StringUtils.toUnderScoreCase(request.getParameter("field"));//排序字段(需要驼峰命名转换)
		String order = request.getParameter("order");//排序方式(asc,desc)
		if (StringUtils.isEmpty(field)) {
			Page<T> page = new Page<>(pageNo, limit);
			page.setOpenSort(false);
			return page;
		} else {
			Page<T> page = new Page<>(pageNo, limit, field);
			if ("asc".equals(order)) {
				page.setAsc(true);
			} else {
				page.setAsc(false);
			}
			return page;
		}
	}
}