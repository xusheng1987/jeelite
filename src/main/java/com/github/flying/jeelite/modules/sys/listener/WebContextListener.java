package com.github.flying.jeelite.modules.sys.listener;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;

import javax.servlet.ServletContext;

import org.springframework.web.context.WebApplicationContext;

import com.github.flying.jeelite.common.config.Global;
import com.github.flying.jeelite.common.utils.SystemPath;
import com.google.common.io.Files;

public class WebContextListener extends org.springframework.web.context.ContextLoaderListener {

	@Override
	public WebApplicationContext initWebApplicationContext(ServletContext servletContext) {
		if (!printKeyLoadMessage()){
			return null;
		}
		return super.initWebApplicationContext(servletContext);
	}

	/**
	 * 获取Key加载信息
	 */
	private boolean printKeyLoadMessage(){
		String banner = "";
		try {
			banner = Files.toString(new File(SystemPath.getSysPath() + "src\\main\\webapp\\static\\common\\banner.txt"), Charset.forName("UTF-8"));
		} catch (IOException e) {
		}
		System.out.println(banner);
		
		StringBuilder sb = new StringBuilder();
		sb.append("\r\n======================================================================\r\n");
		sb.append("\r\n    欢迎使用 "+Global.getConfig("productName")+"  - Powered By https://github.com/xusheng1987/jeelite\r\n");
		sb.append("\r\n======================================================================\r\n");
		System.out.println(sb.toString());
		return true;
	}
}