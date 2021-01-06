package com.github.flying.jeelite.common.utils.useragent;

import javax.servlet.http.HttpServletRequest;

/**
 * User-Agent工具类
 * 
 */
public class UserAgentUtils {

	/**
	 * 解析User-Agent
	 * 
	 * @param userAgentString User-Agent字符串
	 * @return {@link UserAgent}
	 */
	public static UserAgent parse(HttpServletRequest request) {
		return parse(request.getHeader("User-Agent"));
	}

	public static UserAgent parse(String userAgentString) {
		return UserAgentParser.parse(userAgentString);
	}

}