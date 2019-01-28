package com.github.flying.jeelite.common.utils;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.lionsoul.ip2region.DataBlock;
import org.lionsoul.ip2region.DbConfig;
import org.lionsoul.ip2region.DbSearcher;

public class IPUtils {
	/**
	 * IP地址定位
	 */
	public static String getIpInfo(String ip) {
		String dbPath = IPUtils.class.getResource("/ip2region.db").getPath();
		try {
			DbConfig config = new DbConfig();
			DbSearcher searcher = new DbSearcher(config, dbPath);

			DataBlock dataBlock = searcher.btreeSearch(ip);
			String[] region = dataBlock.getRegion().split("\\|");
			if (!"0".equals(region[2])) {
				return region[2] + region[3] + region[4];
			} else {
				return region[3];
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获得本地Ip地址
	 */
	public static String getHostIp() {
		try {
			return InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
		}
		return "127.0.0.1";
	}

	/**
	 * 获得本地HostName
	 */
	public static String getHostName() {
		try {
			return InetAddress.getLocalHost().getCanonicalHostName();
		} catch (UnknownHostException e) {
		}
		return "未知";
	}

	public static void main(String[] args) throws Exception {
		System.out.println(getHostIp());
		System.out.println(getHostName());
	}
}