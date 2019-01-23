/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.utils;

import java.io.File;

import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;

/**
 * ZIP操作工具类
 * 实现文件的压缩和解压缩，并支持加密解密
 * 
 * @author flying
 */
public class ZipUtils {

	/**
	 * 压缩文件或目录
	 * 
	 * @param srcDirName 压缩的根目录
	 * @param fileName 根目录下的待压缩的文件名或文件夹名，其中*或""表示跟目录下的全部文件
	 * @param descFileName 目标zip文件
	 * @param password 解压密码
	 * @throws ZipException
	 */
	public static void zipFile(String srcDirName, String fileName, String descFileName, String password)
			throws ZipException {
		// 生成的压缩文件
		ZipFile zipFile = new ZipFile(descFileName);
		ZipParameters parameters = new ZipParameters();
		// 压缩方式
		parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE);// 0:仅打包，不压缩,8:默认，99：加密压缩
		// 压缩级别
		parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);
		// 如果压缩需要密码
		if (StringUtils.isNotEmpty(password)) {
			parameters.setEncryptFiles(true);
			parameters.setEncryptionMethod(Zip4jConstants.ENC_METHOD_STANDARD);
			parameters.setPassword(password);
		}
		if ("*".equals(fileName) || "".equals(fileName)) {// 压缩目录
			// 要打包的文件夹
			File currentFile = new File(srcDirName);
			File[] fs = currentFile.listFiles();
			// 遍历test文件夹下所有的文件、文件夹
			for (File f : fs) {
				if (f.isDirectory()) {
					zipFile.addFolder(f.getPath(), parameters);
				} else {
					zipFile.addFile(f, parameters);
				}
			}
		} else {// 压缩文件
			zipFile.addFile(new File(srcDirName + File.separator + fileName), parameters);
		}
	}

	/**
	 * 解压缩ZIP文件，将ZIP文件里的内容解压到descFileName目录下
	 * 
	 * @param zipFileName 需要解压的ZIP文件
	 * @param descFileName 目标目录
	 * @param password 解压密码
	 */
	public static void unzipFile(String zipFileName, String descFileName, String password) {
		try {
			ZipFile zipFile = new ZipFile(zipFileName);
			if (!zipFile.isValidZipFile()) { // 验证zip文件是否合法，包括文件是否存在、是否为zip文件、是否被损坏等
				throw new ZipException("压缩文件不合法,可能被损坏.");
			}
			File destDir = new File(descFileName); // 解压目录
			if (destDir.isDirectory() && !destDir.exists()) {
				destDir.mkdir();
			}
			if (zipFile.isEncrypted()) {
				zipFile.setPassword(password); // 设置密码
			}
			zipFile.extractAll(descFileName);
		} catch (ZipException e) {
			e.printStackTrace();
		}
	}
}