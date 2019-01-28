package com.github.flying.jeelite.modules.monitor.service;

import java.lang.management.ManagementFactory;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.springframework.stereotype.Service;

import com.github.flying.jeelite.common.utils.DateUtils;
import com.github.flying.jeelite.common.utils.IPUtils;
import com.github.flying.jeelite.common.utils.NumberUtils;
import com.github.flying.jeelite.modules.monitor.entity.SysInfo;
import com.github.flying.jeelite.modules.monitor.entity.SysInfo.DiskInfo;

import oshi.SystemInfo;
import oshi.hardware.CentralProcessor;
import oshi.hardware.CentralProcessor.TickType;
import oshi.hardware.GlobalMemory;
import oshi.hardware.HardwareAbstractionLayer;
import oshi.software.os.FileSystem;
import oshi.software.os.OSFileStore;
import oshi.software.os.OperatingSystem;
import oshi.util.Util;

@Service
public class SysInfoService {

	public SysInfo getSysInfo() {
		SystemInfo si = new SystemInfo();
		HardwareAbstractionLayer hal = si.getHardware();
		CentralProcessor processor = hal.getProcessor();

		SysInfo sysInfo = new SysInfo();
		/**
		 * 设置CPU信息
		 */
		long[] prevTicks = processor.getSystemCpuLoadTicks();
		Util.sleep(1000);
		long[] ticks = processor.getSystemCpuLoadTicks();
		long nice = ticks[TickType.NICE.getIndex()] - prevTicks[TickType.NICE.getIndex()];
		long irq = ticks[TickType.IRQ.getIndex()] - prevTicks[TickType.IRQ.getIndex()];
		long softirq = ticks[TickType.SOFTIRQ.getIndex()] - prevTicks[TickType.SOFTIRQ.getIndex()];
		long steal = ticks[TickType.STEAL.getIndex()] - prevTicks[TickType.STEAL.getIndex()];
		long cSys = ticks[TickType.SYSTEM.getIndex()] - prevTicks[TickType.SYSTEM.getIndex()];
		long user = ticks[TickType.USER.getIndex()] - prevTicks[TickType.USER.getIndex()];
		long iowait = ticks[TickType.IOWAIT.getIndex()] - prevTicks[TickType.IOWAIT.getIndex()];
		long idle = ticks[TickType.IDLE.getIndex()] - prevTicks[TickType.IDLE.getIndex()];
		long totalCpu = user + nice + cSys + idle + iowait + irq + softirq + steal;
		sysInfo.setCpuCoreNum(processor.getLogicalProcessorCount());
		sysInfo.setCpuSysUsage(NumberUtils.percent(cSys, totalCpu, 2));
		sysInfo.setCpuUserUsage(NumberUtils.percent(user, totalCpu, 2));
		sysInfo.setCpuWaitRate(NumberUtils.percent(iowait, totalCpu, 2));
		sysInfo.setCpuFreeRate(NumberUtils.percent(idle, totalCpu, 2));
		/**
		 * 设置内存信息(单位GB)
		 */
		GlobalMemory memory = hal.getMemory();
		sysInfo.setMemoryTotal(NumberUtils.div(memory.getTotal(), 1024 * 1024 * 1024, 2));
		sysInfo.setMemoryUsed(NumberUtils.div(memory.getTotal() - memory.getAvailable(), 1024 * 1024 * 1024, 2));
		sysInfo.setMemoryFree(NumberUtils.div(memory.getAvailable(), 1024 * 1024 * 1024, 2));
		sysInfo.setMemoryUsage(NumberUtils.percent(memory.getTotal() - memory.getAvailable(), memory.getTotal(), 2));
		/**
		 * 设置服务器信息
		 */
		Properties props = System.getProperties();
		sysInfo.setServerName(IPUtils.getHostName());
		sysInfo.setServerIp(IPUtils.getHostIp());
		sysInfo.setOsName(props.getProperty("os.name"));
		sysInfo.setOsArch(props.getProperty("os.arch"));
		sysInfo.setProjectPath(props.getProperty("user.dir"));
		/**
		 * 设置JVM相关信息
		 */
		long totalMemory = Runtime.getRuntime().totalMemory();
		long maxMemory = Runtime.getRuntime().maxMemory();
		long freeMemory = Runtime.getRuntime().freeMemory();
		sysInfo.setJvmTotal(NumberUtils.div(totalMemory, 1024 * 1024, 2));
		sysInfo.setJvmMax(NumberUtils.div(maxMemory, 1024 * 1024, 2));
		sysInfo.setJvmFree(NumberUtils.div(freeMemory, 1024 * 1024, 2));
		sysInfo.setJvmUsed(NumberUtils.div(totalMemory - freeMemory, 1024 * 1024, 2));
		sysInfo.setJvmUsage(NumberUtils.percent(totalMemory - freeMemory, totalMemory, 2));
		sysInfo.setJdkVersion(props.getProperty("java.version"));
		sysInfo.setJdkHome(props.getProperty("java.home"));
		// JVM启动时间
		long startTime = ManagementFactory.getRuntimeMXBean().getStartTime();
		sysInfo.setJvmStartTime(DateUtils.formatDateTime(new Date(startTime)));
		sysInfo.setJvmRunTime(DateUtils.getDistanceOfTwoDate(new Date(startTime), new Date()));
		/**
		 * 设置磁盘信息
		 */
		List<DiskInfo> diskInfos = sysInfo.getDiskInfos();
		OperatingSystem os = si.getOperatingSystem();
		FileSystem fileSystem = os.getFileSystem();
		OSFileStore[] fsArray = fileSystem.getFileStores();
		for (OSFileStore fs : fsArray) {
			DiskInfo diskInfo = new DiskInfo();
			long freeSpace = fs.getUsableSpace();
			long totalSpace = fs.getTotalSpace();
			long usedSpace = totalSpace - freeSpace;
			diskInfo.setDrivePath(fs.getMount());
			diskInfo.setFileSystem(fs.getType());
			diskInfo.setDiskTotal(convertFileSize(totalSpace));
			diskInfo.setDiskFree(convertFileSize(freeSpace));
			diskInfo.setDiskUsed(convertFileSize(usedSpace));
			diskInfo.setDiskUsage(NumberUtils.percent(usedSpace, totalSpace, 2));
			diskInfos.add(diskInfo);
		}
		return sysInfo;
	}

	/**
	 * 字节转换
	 * 
	 * @param size 字节大小
	 * @return 转换后值
	 */
	public String convertFileSize(long size) {
		long kb = 1024;
		long mb = kb * 1024;
		long gb = mb * 1024;
		if (size >= gb) {
			return String.format("%.1f GB", (float) size / gb);
		} else if (size >= mb) {
			float f = (float) size / mb;
			return String.format(f > 100 ? "%.0f MB" : "%.1f MB", f);
		} else if (size >= kb) {
			float f = (float) size / kb;
			return String.format(f > 100 ? "%.0f KB" : "%.1f KB", f);
		} else {
			return String.format("%d B", size);
		}
	}

}