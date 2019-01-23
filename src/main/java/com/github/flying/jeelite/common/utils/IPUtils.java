package com.github.flying.jeelite.common.utils;

import org.lionsoul.ip2region.DataBlock;
import org.lionsoul.ip2region.DbConfig;
import org.lionsoul.ip2region.DbSearcher;

/**
 * IP地址定位
 */
public class IPUtils {
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

	public static void main(String[] args) throws Exception {
		System.err.println(getIpInfo("10.23.49.236"));
		System.err.println(getIpInfo("101.105.35.57"));
	}
}