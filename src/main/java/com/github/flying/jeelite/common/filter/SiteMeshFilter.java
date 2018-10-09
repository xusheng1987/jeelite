package com.github.flying.jeelite.common.filter;

import java.io.IOException;

import org.sitemesh.DecoratorSelector;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.content.Content;
import org.sitemesh.webapp.WebAppContext;

import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.utils.StringUtils;

public class SiteMeshFilter extends ConfigurableSiteMeshFilter {
	
	private final String DECORATOR_PREFIX = Global.getConfig("web.view.prefix");
	private final String DECORATOR_SUFFIX = Global.getConfig("web.view.suffix");

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
					return new String[] { DECORATOR_PREFIX + "layouts/" + decoratorPath.trim() + DECORATOR_SUFFIX };
				}
			}
		});
	}
}