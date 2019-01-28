package com.github.flying.jeelite.modules.monitor.entity;

import java.io.Serializable;
import java.util.List;

import com.google.common.collect.Lists;

/**
 * 系统信息
 */
public class SysInfo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	/**
	 * CPU相关信息
	 * 
	 */
	private int cpuCoreNum;// CPU核心数
	private double cpuSysUsage;// CPU系统使用率
	private double cpuUserUsage;// CPU用户使用率
	private double cpuWaitRate;// CPU当前等待率
	private double cpuFreeRate;// CPU当前空闲率

	/**
	 * 內存相关信息
	 * 
	 */
	private double memoryTotal;// 内存总量(G)
	private double memoryUsed;// 已用内存(G)
	private double memoryFree;// 剩余内存(G)
	private double memoryUsage;// 内存使用率

	/**
	 * 服务器信息
	 * 
	 */
	private String serverName;// 服务器名称
	private String serverIp;// 服务器Ip
	private String projectPath;// 项目路径
	private String osName;// 操作系统
	private String osArch;// 系统架构

	/**
	 * JVM相关信息
	 * 
	 */
	private double jvmTotal;// 当前JVM占用的内存总数(M)
	private double jvmMax;// JVM最大可用内存总数(M)
	private double jvmFree;// JVM空闲内存(M)
	private double jvmUsed;// JVM已用内存(M)
	private double jvmUsage;// JVM使用率
	private String jdkVersion;// JDK版本
	private String jdkHome;// JDK路径
	private String jvmStartTime;// JVM启动时间
	private String jvmRunTime;// JVM运行时间
	
    /**
     * 磁盘相关信息
     */
    private List<DiskInfo> diskInfos = Lists.newArrayList();

	public int getCpuCoreNum() {
		return cpuCoreNum;
	}

	public void setCpuCoreNum(int cpuCoreNum) {
		this.cpuCoreNum = cpuCoreNum;
	}

	public double getCpuSysUsage() {
		return cpuSysUsage;
	}

	public void setCpuSysUsage(double cpuSysUsage) {
		this.cpuSysUsage = cpuSysUsage;
	}

	public double getCpuUserUsage() {
		return cpuUserUsage;
	}

	public void setCpuUserUsage(double cpuUserUsage) {
		this.cpuUserUsage = cpuUserUsage;
	}

	public double getCpuWaitRate() {
		return cpuWaitRate;
	}

	public void setCpuWaitRate(double cpuWaitRate) {
		this.cpuWaitRate = cpuWaitRate;
	}

	public double getCpuFreeRate() {
		return cpuFreeRate;
	}

	public void setCpuFreeRate(double cpuFreeRate) {
		this.cpuFreeRate = cpuFreeRate;
	}

	public double getMemoryTotal() {
		return memoryTotal;
	}

	public void setMemoryTotal(double memoryTotal) {
		this.memoryTotal = memoryTotal;
	}

	public double getMemoryUsed() {
		return memoryUsed;
	}

	public void setMemoryUsed(double memoryUsed) {
		this.memoryUsed = memoryUsed;
	}

	public double getMemoryFree() {
		return memoryFree;
	}

	public void setMemoryFree(double memoryFree) {
		this.memoryFree = memoryFree;
	}

	public double getMemoryUsage() {
		return memoryUsage;
	}

	public void setMemoryUsage(double memoryUsage) {
		this.memoryUsage = memoryUsage;
	}

	public String getServerName() {
		return serverName;
	}

	public void setServerName(String serverName) {
		this.serverName = serverName;
	}

	public String getServerIp() {
		return serverIp;
	}

	public void setServerIp(String serverIp) {
		this.serverIp = serverIp;
	}

	public String getProjectPath() {
		return projectPath;
	}

	public void setProjectPath(String projectPath) {
		this.projectPath = projectPath;
	}

	public String getOsName() {
		return osName;
	}

	public void setOsName(String osName) {
		this.osName = osName;
	}

	public String getOsArch() {
		return osArch;
	}

	public void setOsArch(String osArch) {
		this.osArch = osArch;
	}

	public double getJvmTotal() {
		return jvmTotal;
	}

	public void setJvmTotal(double jvmTotal) {
		this.jvmTotal = jvmTotal;
	}

	public double getJvmMax() {
		return jvmMax;
	}

	public void setJvmMax(double jvmMax) {
		this.jvmMax = jvmMax;
	}

	public double getJvmFree() {
		return jvmFree;
	}

	public void setJvmFree(double jvmFree) {
		this.jvmFree = jvmFree;
	}

	public double getJvmUsed() {
		return jvmUsed;
	}

	public void setJvmUsed(double jvmUsed) {
		this.jvmUsed = jvmUsed;
	}

	public double getJvmUsage() {
		return jvmUsage;
	}

	public void setJvmUsage(double jvmUsage) {
		this.jvmUsage = jvmUsage;
	}

	public String getJdkVersion() {
		return jdkVersion;
	}

	public void setJdkVersion(String jdkVersion) {
		this.jdkVersion = jdkVersion;
	}

	public String getJdkHome() {
		return jdkHome;
	}

	public void setJdkHome(String jdkHome) {
		this.jdkHome = jdkHome;
	}
	
	public String getJvmStartTime() {
		return jvmStartTime;
	}

	public void setJvmStartTime(String jvmStartTime) {
		this.jvmStartTime = jvmStartTime;
	}

	public String getJvmRunTime() {
		return jvmRunTime;
	}

	public void setJvmRunTime(String jvmRunTime) {
		this.jvmRunTime = jvmRunTime;
	}

	public List<DiskInfo> getDiskInfos() {
		return diskInfos;
	}

	public void setDiskInfos(List<DiskInfo> diskInfos) {
		this.diskInfos = diskInfos;
	}

	/**
	 * 磁盘相关信息
	 * 
	 */
	public static class DiskInfo implements Serializable {
		private static final long serialVersionUID = 1L;
		private String drivePath;// 盘符路径
		private String fileSystem;// 文件系统
		private String diskTotal;// 磁盘总大小
		private String diskFree;// 磁盘剩余大小
		private String diskUsed;// 磁盘使用量
		private double diskUsage;// 磁盘使用率

		public String getDrivePath() {
			return drivePath;
		}

		public void setDrivePath(String drivePath) {
			this.drivePath = drivePath;
		}

		public String getFileSystem() {
			return fileSystem;
		}

		public void setFileSystem(String fileSystem) {
			this.fileSystem = fileSystem;
		}

		public String getDiskTotal() {
			return diskTotal;
		}

		public void setDiskTotal(String diskTotal) {
			this.diskTotal = diskTotal;
		}

		public String getDiskFree() {
			return diskFree;
		}

		public void setDiskFree(String diskFree) {
			this.diskFree = diskFree;
		}

		public String getDiskUsed() {
			return diskUsed;
		}

		public void setDiskUsed(String diskUsed) {
			this.diskUsed = diskUsed;
		}

		public double getDiskUsage() {
			return diskUsage;
		}

		public void setDiskUsage(double diskUsage) {
			this.diskUsage = diskUsage;
		}
	}
}