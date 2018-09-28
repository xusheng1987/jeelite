package com.github.flying.jeelite.modules.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class SiteMeshFilter extends ConfigurableSiteMeshFilter {

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		// 默认装饰器，当下面的路径都不匹配时，启用该装饰器进行装饰
		builder.addDecoratorPath("/*", "/WEB-INF/views/layouts/default.jsp");
	}

}