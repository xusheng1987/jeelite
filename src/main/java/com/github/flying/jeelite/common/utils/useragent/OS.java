package com.github.flying.jeelite.common.utils.useragent;

import java.util.List;

import com.google.common.collect.Lists;

/**
 * 系统对象
 * 
 */
public class OS extends UserAgentInfo {
	
	/** 未知 */
	public static final OS Unknown = new OS(NameUnknown, null);

	/**
	 * 支持的引擎类型
	 */
	public static final List<OS> oses = Lists.newArrayList(
			new OS("Windows 10","windows nt 10\\.0"),
			new OS("Windows 8.1","windows nt 6\\.3"),
			new OS("Windows 8","windows nt 6\\.2"),
			new OS("Windows Vista", "windows nt 6\\.0"),
			new OS("Windows 7", "windows nt 6\\.1"),
			new OS("Windows 2003", "windows nt 5\\.2"),
			new OS("Windows XP", "windows nt 5\\.1"),
			new OS("Windows 2000", "windows nt 5\\.0"),
			new OS("Windows Phone", "windows (ce|phone|mobile)( os)?"),
			new OS("Windows", "windows"),
			new OS("OSX", "os x (\\d+)[._](\\d+)"),
			new OS("Android","Android"),
			new OS("Linux", "linux"),
			new OS("Wii", "wii"),
			new OS("PS3", "playstation 3"),
			new OS("PSP", "playstation portable"),
			new OS("iPad", "\\(iPad.*os (\\d+)[._](\\d+)"),
			new OS("iPhone", "\\(iPhone.*os (\\d+)[._](\\d+)"),
			new OS("YPod", "iPod touch[\\s\\;]+iPhone.*os (\\d+)[._](\\d+)"),
			new OS("YPad", "iPad[\\s\\;]+iPhone.*os (\\d+)[._](\\d+)"),
			new OS("YPhone", "iPhone[\\s\\;]+iPhone.*os (\\d+)[._](\\d+)"),
			new OS("Symbian", "symbian(os)?"),
			new OS("Darwin", "Darwin\\/([\\d\\w\\.\\-]+)"),
			new OS("Adobe Air", "AdobeAir\\/([\\d\\w\\.\\-]+)"),
			new OS("Java", "Java[\\s]+([\\d\\w\\.\\-]+)")
	);

	/**
	 * 构造
	 * 
	 * @param name 系统名称
	 * @param regex 关键字或表达式
	 */
	public OS(String name, String regex) {
		super(name, regex);
	}

}