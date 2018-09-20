/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.utils;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.collect.Lists;

/**
 * 文件操作工具类
 * 实现文件的创建、删除、复制以及目录的创建、删除、复制等功能
 * @author flying
 * @version 2015-3-16
 */
public class FileUtils extends org.apache.commons.io.FileUtils {

	private static Logger logger = LoggerFactory.getLogger(FileUtils.class);

	/**
	 * 复制单个文件，如果目标文件存在，则不覆盖
	 * @param srcFileName 待复制的文件名
	 * @param descFileName 目标文件名
	 * @return 如果复制成功，则返回true，否则返回false
	 */
	public static boolean copyFile(String srcFileName, String descFileName) {
		return FileUtils.copyFileCover(srcFileName, descFileName, false);
	}

	/**
	 * 复制单个文件
	 * @param srcFileName 待复制的文件名
	 * @param descFileName 目标文件名
	 * @param coverlay 如果目标文件已存在，是否覆盖
	 * @return 如果复制成功，则返回true，否则返回false
	 */
	public static boolean copyFileCover(String srcFileName,
			String descFileName, boolean coverlay) {
		File srcFile = new File(srcFileName);
		// 判断源文件是否存在
		if (!srcFile.exists()) {
			logger.warn("复制文件失败，源文件 " + srcFileName + " 不存在!");
			return false;
		}
		// 判断源文件是否是合法的文件
		else if (!srcFile.isFile()) {
			logger.warn("复制文件失败，" + srcFileName + " 不是一个文件!");
			return false;
		}
		File descFile = new File(descFileName);
		// 判断目标文件是否存在
		if (descFile.exists()) {
			// 如果目标文件存在，并且允许覆盖
			if (coverlay) {
				if (!FileUtils.delFile(descFileName)) {
					logger.warn("删除目标文件 " + descFileName + " 失败!");
					return false;
				}
			} else {
				logger.warn("复制文件失败，目标文件 " + descFileName + " 已存在!");
				return false;
			}
		} else {
			if (!descFile.getParentFile().exists()) {
				// 如果目标文件所在的目录不存在，则创建目录
				if (!descFile.getParentFile().mkdirs()) {
					logger.warn("创建目标文件所在的目录失败!");
					return false;
				}
			}
		}

		// 准备复制文件
		// 读取的位数
		try (InputStream ins = new FileInputStream(srcFile);// 打开源文件
			OutputStream outs = new FileOutputStream(descFile)) {// 打开目标文件的输出流
			byte[] buf = new byte[1024];
			int readByte = 0;
			// 一次读取1024个字节，当readByte为-1时表示文件已经读取完毕
			while ((readByte = ins.read(buf)) != -1) {
				// 将读取的字节流写入到输出流
				outs.write(buf, 0, readByte);
			}
			return true;
		} catch (Exception e) {
			logger.warn("复制文件失败：" + e.getMessage());
			return false;
		}
	}

	/**
	 * 复制整个目录的内容，如果目标目录存在，则不覆盖
	 * @param srcDirName 源目录名
	 * @param descDirName 目标目录名
	 * @return 如果复制成功返回true，否则返回false
	 */
	public static boolean copyDirectory(String srcDirName, String descDirName) {
		return FileUtils.copyDirectoryCover(srcDirName, descDirName,
				false);
	}

	/**
	 * 复制整个目录的内容
	 * @param srcDirName 源目录名
	 * @param descDirName 目标目录名
	 * @param coverlay 如果目标目录存在，是否覆盖
	 * @return 如果复制成功返回true，否则返回false
	 */
	public static boolean copyDirectoryCover(String srcDirName,
			String descDirName, boolean coverlay) {
		File srcDir = new File(srcDirName);
		// 判断源目录是否存在
		if (!srcDir.exists()) {
			logger.warn("复制目录失败，源目录 " + srcDirName + " 不存在!");
			return false;
		}
		// 判断源目录是否是目录
		else if (!srcDir.isDirectory()) {
			logger.warn("复制目录失败，" + srcDirName + " 不是一个目录!");
			return false;
		}
		// 如果目标文件夹名不以文件分隔符结尾，自动添加文件分隔符
		String descDirNames = descDirName;
		if (!descDirNames.endsWith(File.separator)) {
			descDirNames = descDirNames + File.separator;
		}
		File descDir = new File(descDirNames);
		// 如果目标文件夹存在
		if (descDir.exists()) {
			if (coverlay) {
				// 允许覆盖目标目录
				if (!FileUtils.delFile(descDirNames)) {
					logger.warn("删除目录 " + descDirNames + " 失败!");
					return false;
				}
			} else {
				logger.warn("目标目录复制失败，目标目录 " + descDirNames + " 已存在!");
				return false;
			}
		} else {
			// 创建目标目录
			if (!descDir.mkdirs()) {
				logger.warn("创建目标目录失败!");
				return false;
			}

		}

		boolean flag = true;
		// 列出源目录下的所有文件名和子目录名
		File[] files = srcDir.listFiles();
		for (int i = 0; i < files.length; i++) {
			// 如果是一个单个文件，则直接复制
			if (files[i].isFile()) {
				flag = FileUtils.copyFile(files[i].getAbsolutePath(),
						descDirName + files[i].getName());
				// 如果拷贝文件失败，则退出循环
				if (!flag) {
					break;
				}
			}
			// 如果是子目录，则继续复制目录
			if (files[i].isDirectory()) {
				flag = FileUtils.copyDirectory(files[i]
						.getAbsolutePath(), descDirName + files[i].getName());
				// 如果拷贝目录失败，则退出循环
				if (!flag) {
					break;
				}
			}
		}

		if (!flag) {
			logger.warn("复制目录 " + srcDirName + " 到 " + descDirName + " 失败!");
			return false;
		}
		return true;
	}

	/**
	 *
	 * 删除文件，可以删除单个文件或文件夹
	 *
	 * @param fileName 被删除的文件名
	 * @return 如果删除成功，则返回true，否是返回false
	 */
	public static boolean delFile(String fileName) {
 		File file = new File(fileName);
		if (!file.exists()) {
			logger.warn(fileName + " 文件不存在!");
			return true;
		} else {
			if (file.isFile()) {
				return FileUtils.deleteFile(fileName);
			} else {
				return FileUtils.deleteDirectory(fileName);
			}
		}
	}

	/**
	 *
	 * 删除单个文件
	 *
	 * @param fileName 被删除的文件名
	 * @return 如果删除成功，则返回true，否则返回false
	 */
	public static boolean deleteFile(String fileName) {
		File file = new File(fileName);
		if (file.exists() && file.isFile()) {
			if (file.delete()) {
				return true;
			} else {
				logger.warn("删除文件 " + fileName + " 失败!");
				return false;
			}
		} else {
			logger.warn(fileName + " 文件不存在!");
			return true;
		}
	}

	/**
	 *
	 * 删除目录及目录下的文件
	 *
	 * @param dirName 被删除的目录所在的文件路径
	 * @return 如果目录删除成功，则返回true，否则返回false
	 */
	public static boolean deleteDirectory(String dirName) {
		String dirNames = dirName;
		if (!dirNames.endsWith(File.separator)) {
			dirNames = dirNames + File.separator;
		}
		File dirFile = new File(dirNames);
		if (!dirFile.exists() || !dirFile.isDirectory()) {
			logger.warn(dirNames + " 目录不存在!");
			return true;
		}
		boolean flag = true;
		// 列出全部文件及子目录
		File[] files = dirFile.listFiles();
		for (int i = 0; i < files.length; i++) {
			// 删除子文件
			if (files[i].isFile()) {
				flag = FileUtils.deleteFile(files[i].getAbsolutePath());
				// 如果删除文件失败，则退出循环
				if (!flag) {
					break;
				}
			}
			// 删除子目录
			else if (files[i].isDirectory()) {
				flag = FileUtils.deleteDirectory(files[i]
						.getAbsolutePath());
				// 如果删除子目录失败，则退出循环
				if (!flag) {
					break;
				}
			}
		}

		if (!flag) {
			logger.warn("删除目录失败!");
			return false;
		}
		// 删除当前目录
		if (dirFile.delete()) {
			return true;
		} else {
			logger.warn("删除目录 " + dirName + " 失败!");
			return false;
		}

	}

	/**
	 * 创建单个文件
	 * @param descFileName 文件名，包含路径
	 * @return 如果创建成功，则返回true，否则返回false
	 */
	public static boolean createFile(String descFileName) {
		File file = new File(descFileName);
		if (file.exists()) {
			logger.warn("文件 " + descFileName + " 已存在!");
			return false;
		}
		if (descFileName.endsWith(File.separator)) {
			logger.warn(descFileName + " 为目录，不能创建目录!");
			return false;
		}
		if (!file.getParentFile().exists()) {
			// 如果文件所在的目录不存在，则创建目录
			if (!file.getParentFile().mkdirs()) {
				logger.warn("创建文件所在的目录失败!");
				return false;
			}
		}

		// 创建文件
		try {
			if (file.createNewFile()) {
				return true;
			} else {
				logger.warn(descFileName + " 文件创建失败!");
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn(descFileName + " 文件创建失败!");
			return false;
		}

	}

	/**
	 * 创建目录
	 * @param descDirName 目录名,包含路径
	 * @return 如果创建成功，则返回true，否则返回false
	 */
	public static boolean createDirectory(String descDirName) {
		String descDirNames = descDirName;
		if (!descDirNames.endsWith(File.separator)) {
			descDirNames = descDirNames + File.separator;
		}
		File descDir = new File(descDirNames);
		if (descDir.exists()) {
			logger.warn("目录 " + descDirNames + " 已存在!");
			return false;
		}
		// 创建目录
		if (descDir.mkdirs()) {
			return true;
		} else {
			logger.warn("目录 " + descDirNames + " 创建失败!");
			return false;
		}

	}

	/**
	 * 写入文件
	 * @param file 要写入的文件
	 */
	public static void writeToFile(String fileName, String content, boolean append) {
		try {
			FileUtils.write(new File(fileName), content, "utf-8", append);
		} catch (IOException e) {
			logger.error("文件 " + fileName + " 写入失败! " + e.getMessage());
		}
	}

	/**
	 * 写入文件
	 * @param file 要写入的文件
	 */
	public static void writeToFile(String fileName, String content, String encoding, boolean append) {
		try {
			FileUtils.write(new File(fileName), content, encoding, append);
		} catch (IOException e) {
			logger.error("文件 " + fileName + " 写入失败! " + e.getMessage());
		}
	}

	/**
	 * 根据“文件名的后缀”获取文件内容类型（而非根据File.getContentType()读取的文件类型）
	 * @param returnFileName 带验证的文件名
	 * @return 返回文件类型
	 */
	public static String getContentType(String returnFileName) {
		String contentType = "application/octet-stream";
		if (returnFileName.lastIndexOf(".") < 0) {
			return contentType;
		}
		returnFileName = returnFileName.toLowerCase();
		returnFileName = returnFileName.substring(returnFileName.lastIndexOf(".") + 1);
		if ("html".equals(returnFileName) || "htm".equals(returnFileName) || "shtml".equals(returnFileName)) {
			contentType = "text/html";
		} else if ("apk".equals(returnFileName)) {
			contentType = "application/vnd.android.package-archive";
		} else if ("sis".equals(returnFileName)) {
			contentType = "application/vnd.symbian.install";
		} else if ("sisx".equals(returnFileName)) {
			contentType = "application/vnd.symbian.install";
		} else if ("exe".equals(returnFileName)) {
			contentType = "application/x-msdownload";
		} else if ("msi".equals(returnFileName)) {
			contentType = "application/x-msdownload";
		} else if ("css".equals(returnFileName)) {
			contentType = "text/css";
		} else if ("xml".equals(returnFileName)) {
			contentType = "text/xml";
		} else if ("gif".equals(returnFileName)) {
			contentType = "image/gif";
		} else if ("jpeg".equals(returnFileName) || "jpg".equals(returnFileName)) {
			contentType = "image/jpeg";
		} else if ("js".equals(returnFileName)) {
			contentType = "application/x-javascript";
		} else if ("atom".equals(returnFileName)) {
			contentType = "application/atom+xml";
		} else if ("rss".equals(returnFileName)) {
			contentType = "application/rss+xml";
		} else if ("mml".equals(returnFileName)) {
			contentType = "text/mathml";
		} else if ("txt".equals(returnFileName)) {
			contentType = "text/plain";
		} else if ("jad".equals(returnFileName)) {
			contentType = "text/vnd.sun.j2me.app-descriptor";
		} else if ("wml".equals(returnFileName)) {
			contentType = "text/vnd.wap.wml";
		} else if ("htc".equals(returnFileName)) {
			contentType = "text/x-component";
		} else if ("png".equals(returnFileName)) {
			contentType = "image/png";
		} else if ("tif".equals(returnFileName) || "tiff".equals(returnFileName)) {
			contentType = "image/tiff";
		} else if ("wbmp".equals(returnFileName)) {
			contentType = "image/vnd.wap.wbmp";
		} else if ("ico".equals(returnFileName)) {
			contentType = "image/x-icon";
		} else if ("jng".equals(returnFileName)) {
			contentType = "image/x-jng";
		} else if ("bmp".equals(returnFileName)) {
			contentType = "image/x-ms-bmp";
		} else if ("svg".equals(returnFileName)) {
			contentType = "image/svg+xml";
		} else if ("jar".equals(returnFileName) || "var".equals(returnFileName)
				|| "ear".equals(returnFileName)) {
			contentType = "application/java-archive";
		} else if ("doc".equals(returnFileName)) {
			contentType = "application/msword";
		} else if ("pdf".equals(returnFileName)) {
			contentType = "application/pdf";
		} else if ("rtf".equals(returnFileName)) {
			contentType = "application/rtf";
		} else if ("xls".equals(returnFileName)) {
			contentType = "application/vnd.ms-excel";
		} else if ("ppt".equals(returnFileName)) {
			contentType = "application/vnd.ms-powerpoint";
		} else if ("7z".equals(returnFileName)) {
			contentType = "application/x-7z-compressed";
		} else if ("rar".equals(returnFileName)) {
			contentType = "application/x-rar-compressed";
		} else if ("swf".equals(returnFileName)) {
			contentType = "application/x-shockwave-flash";
		} else if ("rpm".equals(returnFileName)) {
			contentType = "application/x-redhat-package-manager";
		} else if ("der".equals(returnFileName) || "pem".equals(returnFileName)
				|| "crt".equals(returnFileName)) {
			contentType = "application/x-x509-ca-cert";
		} else if ("xhtml".equals(returnFileName)) {
			contentType = "application/xhtml+xml";
		} else if ("zip".equals(returnFileName)) {
			contentType = "application/zip";
		} else if ("mid".equals(returnFileName) || "midi".equals(returnFileName)
				|| "kar".equals(returnFileName)) {
			contentType = "audio/midi";
		} else if ("mp3".equals(returnFileName)) {
			contentType = "audio/mpeg";
		} else if ("ogg".equals(returnFileName)) {
			contentType = "audio/ogg";
		} else if ("m4a".equals(returnFileName)) {
			contentType = "audio/x-m4a";
		} else if ("ra".equals(returnFileName)) {
			contentType = "audio/x-realaudio";
		} else if ("3gpp".equals(returnFileName)
				|| "3gp".equals(returnFileName)) {
			contentType = "video/3gpp";
		} else if ("mp4".equals(returnFileName)) {
			contentType = "video/mp4";
		} else if ("mpeg".equals(returnFileName)
				|| "mpg".equals(returnFileName)) {
			contentType = "video/mpeg";
		} else if ("mov".equals(returnFileName)) {
			contentType = "video/quicktime";
		} else if ("flv".equals(returnFileName)) {
			contentType = "video/x-flv";
		} else if ("m4v".equals(returnFileName)) {
			contentType = "video/x-m4v";
		} else if ("mng".equals(returnFileName)) {
			contentType = "video/x-mng";
		} else if ("asx".equals(returnFileName) || "asf".equals(returnFileName)) {
			contentType = "video/x-ms-asf";
		} else if ("wmv".equals(returnFileName)) {
			contentType = "video/x-ms-wmv";
		} else if ("avi".equals(returnFileName)) {
			contentType = "video/x-msvideo";
		}
		return contentType;
	}

	/**
	 * 向浏览器发送文件下载，支持断点续传
	 * @param file 要下载的文件
	 * @param request 请求对象
	 * @param response 响应对象
	 * @return 返回错误信息，无错误信息返回null
	 */
	public static String downFile(File file, HttpServletRequest request, HttpServletResponse response){
		 return downFile(file, request, response, null);
	}

	/**
	 * 向浏览器发送文件下载，支持断点续传
	 * @param file 要下载的文件
	 * @param request 请求对象
	 * @param response 响应对象
	 * @param fileName 指定下载的文件名
	 * @return 返回错误信息，无错误信息返回null
	 */
	public static String downFile(File file, HttpServletRequest request, HttpServletResponse response, String fileName){
		String error  = null;
		if (file != null && file.exists()) {
			if (file.isFile()) {
				if (file.length() <= 0) {
					error = "该文件是一个空文件。";
				}
				if (!file.canRead()) {
					error = "该文件没有读取权限。";
				}
			} else {
				error = "该文件是一个文件夹。";
			}
		} else {
			error = "文件已丢失或不存在！";
		}
		if (error != null){
			logger.error("---------------" + file + " " + error);
			return error;
		}

		long fileLength = file.length(); // 记录文件大小
		long pastLength = 0; 	// 记录已下载文件大小
		int rangeSwitch = 0; 	// 0：从头开始的全文下载；1：从某字节开始的下载（bytes=27000-）；2：从某字节开始到某字节结束的下载（bytes=27000-39000）
		long toLength = 0; 		// 记录客户端需要下载的字节段的最后一个字节偏移量（比如bytes=27000-39000，则这个值是为39000）
		long contentLength = 0; // 客户端请求的字节总量
		String rangeBytes = ""; // 记录客户端传来的形如“bytes=27000-”或者“bytes=27000-39000”的内容
		byte b[] = new byte[1024]; 	// 暂存容器

		if (request.getHeader("Range") != null) { // 客户端请求的下载的文件块的开始字节
			response.setStatus(javax.servlet.http.HttpServletResponse.SC_PARTIAL_CONTENT);
			rangeBytes = request.getHeader("Range").replaceAll("bytes=", "");
			if (rangeBytes.indexOf('-') == rangeBytes.length() - 1) {// bytes=969998336-
				rangeSwitch = 1;
				rangeBytes = rangeBytes.substring(0, rangeBytes.indexOf('-'));
				pastLength = Long.parseLong(rangeBytes.trim());
				contentLength = fileLength - pastLength; // 客户端请求的是 969998336  之后的字节
			} else { // bytes=1275856879-1275877358
				rangeSwitch = 2;
				String temp0 = rangeBytes.substring(0, rangeBytes.indexOf('-'));
				String temp2 = rangeBytes.substring(rangeBytes.indexOf('-') + 1, rangeBytes.length());
				pastLength = Long.parseLong(temp0.trim()); // bytes=1275856879-1275877358，从第 1275856879 个字节开始下载
				toLength = Long.parseLong(temp2); // bytes=1275856879-1275877358，到第 1275877358 个字节结束
				contentLength = toLength - pastLength; // 客户端请求的是 1275856879-1275877358 之间的字节
			}
		} else { // 从开始进行下载
			contentLength = fileLength; // 客户端要求全文下载
		}

		// 如果设设置了Content-Length，则客户端会自动进行多线程下载。如果不希望支持多线程，则不要设置这个参数。 响应的格式是:
		// Content-Length: [文件的总大小] - [客户端请求的下载的文件块的开始字节]
		// response.setHeader("Content- Length", new Long(file.length() - p).toString());
		response.reset(); // 告诉客户端允许断点续传多线程连接下载,响应的格式是:Accept-Ranges: bytes
		if (pastLength != 0) {
			response.setHeader("Accept-Ranges", "bytes");// 如果是第一次下,还没有断点续传,状态是默认的 200,无需显式设置;响应的格式是:HTTP/1.1 200 OK
			// 不是从最开始下载, 响应的格式是: Content-Range: bytes [文件块的开始字节]-[文件的总大小 - 1]/[文件的总大小]
			logger.debug("---------------不是从开始进行下载！服务器即将开始断点续传...");
			switch (rangeSwitch) {
				case 1: { // 针对 bytes=27000- 的请求
					String contentRange = new StringBuffer("bytes ").append(new Long(pastLength).toString()).append("-")
							.append(new Long(fileLength - 1).toString()).append("/").append(new Long(fileLength).toString()).toString();
					response.setHeader("Content-Range", contentRange);
					break;
				}
				case 2: { // 针对 bytes=27000-39000 的请求
					String contentRange = rangeBytes + "/" + new Long(fileLength).toString();
					response.setHeader("Content-Range", contentRange);
					break;
				}
				default: {
					break;
				}
			}
		} else {
			// 是从开始下载
			logger.debug("---------------是从开始进行下载！");
		}

		try (OutputStream os = response.getOutputStream();// 写出数据
			OutputStream out = new BufferedOutputStream(os);// 缓冲
			RandomAccessFile raf = new RandomAccessFile(file, "r")) {// 负责读取数据
			response.addHeader("Content-Disposition", "attachment; filename=\"" +
					Encodes.urlEncode(StringUtils.isBlank(fileName) ? file.getName() : fileName) + "\"");
			response.setContentType(getContentType(file.getName())); // set the MIME type.
			response.addHeader("Content-Length", String.valueOf(contentLength));
			try {
				switch (rangeSwitch) {
					case 0: // 普通下载，或者从头开始的下载 同1
					case 1: { // 针对 bytes=27000- 的请求
						raf.seek(pastLength); // 形如 bytes=969998336- 的客户端请求，跳过 969998336 个字节
						int n = 0;
						while ((n = raf.read(b, 0, 1024)) != -1) {
							out.write(b, 0, n);
						}
						break;
					}
					case 2: { // 针对 bytes=27000-39000 的请求
						raf.seek(pastLength); // 形如 bytes=1275856879-1275877358 的客户端请求，找到第 1275856879 个字节
						int n = 0;
						long readLength = 0; // 记录已读字节数
						while (readLength <= contentLength - 1024) {// 大部分字节在这里读取
							n = raf.read(b, 0, 1024);
							readLength += 1024;
							out.write(b, 0, n);
						}
						if (readLength <= contentLength) { // 余下的不足 1024 个字节在这里读取
							n = raf.read(b, 0, (int) (contentLength - readLength));
							out.write(b, 0, n);
						}
						break;
					}
					default: {
						break;
					}
				}
				out.flush();
				logger.debug("---------------下载完成！");
			} catch (IOException ie) {
				/**
				 * 在写数据的时候， 对于 ClientAbortException 之类的异常，
				 * 是因为客户端取消了下载，而服务器端继续向浏览器写入数据时， 抛出这个异常，这个是正常的。
				 * 尤其是对于迅雷这种吸血的客户端软件， 明明已经有一个线程在读取 bytes=1275856879-1275877358，
				 * 如果短时间内没有读取完毕，迅雷会再启第二个、第三个。。。线程来读取相同的字节段， 直到有一个线程读取完毕，迅雷会 KILL
				 * 掉其他正在下载同一字节段的线程， 强行中止字节读出，造成服务器抛 ClientAbortException。
				 * 所以，我们忽略这种异常
				 */
				logger.error("提醒：向客户端传输时出现IO异常，但此异常是允许的，有可能客户端取消了下载，导致此异常，不用关心！");
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return null;
	}

	/**
	 * 修正路径，将 \\ 或 / 等替换为 File.separator
	 * @param path 待修正的路径
	 * @return 修正后的路径
	 */
	public static String path(String path){
		String p = StringUtils.replace(path, "\\", "/");
		p = StringUtils.join(StringUtils.split(p, "/"), "/");
		if (!StringUtils.startsWithAny(p, "/") && StringUtils.startsWithAny(path, "\\", "/")){
			p += "/";
		}
		if (!StringUtils.endsWithAny(p, "/") && StringUtils.endsWithAny(path, "\\", "/")){
			p = p + "/";
		}
		if (path != null && path.startsWith("/")){
			p = "/" + p; // linux下路径
		}
		return p;
	}

	/**
	 * 获目录下的文件列表
	 * @param dir 搜索目录
	 * @param searchDirs 是否是搜索目录
	 * @return 文件列表
	 */
	public static List<String> findChildrenList(File dir, boolean searchDirs) {
		List<String> files = Lists.newArrayList();
		for (String subFiles : dir.list()) {
			File file = new File(dir + "/" + subFiles);
			if (((searchDirs) && (file.isDirectory())) || ((!searchDirs) && (!file.isDirectory()))) {
				files.add(file.getName());
			}
		}
		return files;
	}

	/**
	 * 获取文件扩展名(返回小写)
	 * @param fileName 文件名
	 * @return 例如：test.jpg  返回：  jpg
	 */
	public static String getFileExtension(String fileName) {
		if ((fileName == null) || (fileName.lastIndexOf(".") == -1) || (fileName.lastIndexOf(".") == fileName.length() - 1)) {
			return null;
		}
		return StringUtils.lowerCase(fileName.substring(fileName.lastIndexOf(".") + 1));
	}

	/**
	 * 获取文件名，不包含扩展名
	 * @param fileName 文件名
	 * @return 例如：d:\files\test.jpg  返回：d:\files\test
	 */
	public static String getFileNameWithoutExtension(String fileName) {
		if ((fileName == null) || (fileName.lastIndexOf(".") == -1)) {
			return null;
		}
		return fileName.substring(0, fileName.lastIndexOf("."));
	}
}