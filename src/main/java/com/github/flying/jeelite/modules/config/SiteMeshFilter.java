package com.github.flying.jeelite.modules.config;

import java.io.IOException;

import org.sitemesh.DecoratorSelector;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.content.Content;
import org.sitemesh.webapp.WebAppContext;

import com.github.flying.jeelite.common.utils.StringUtils;

public class SiteMeshFilter extends ConfigurableSiteMeshFilter {
	
	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		// 为sitemesh3 添加meta装饰
		builder.setCustomDecoratorSelector(new DecoratorSelector<WebAppContext>() {
			@Override
			public String[] selectDecoratorPaths(Content content, WebAppContext context) throws IOException {
				String decoratorPath = content.getExtractedProperties().getChild("meta").getChild("decorator").getValue();
				if (StringUtils.isBlank(decoratorPath)) {
					return new String[] {};
				} else {
					return new String[] { "/WEB-INF/views/layouts/" + decoratorPath.trim() + ".jsp" };
				}
			}
		});
	}
}