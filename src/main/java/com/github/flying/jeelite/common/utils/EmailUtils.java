package com.github.flying.jeelite.common.utils;

import java.net.URL;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.HtmlEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 发送电子邮件
 */
public class EmailUtils {

	private final static Logger logger = LoggerFactory.getLogger(EmailUtils.class);
	private final static String FROM_ADDRESS = "XXX";// 发送人邮箱
	private final static String FROM_PASSWORD = "XXX";// 发送人邮箱密码
	private final static String FROM_HOSTNAME = "XXX";// 发送人smtp服务器
	private final static boolean SSL_ON_CONNECT = false;// 是否启用SSL传输
	private final static String SSL_SMTP_PORT = "993";// SSL端口

	/**
	 * 发送纯文本邮件
	 * 
	 * @param toAddress 收件人地址
	 * @param subject 标题
	 * @param content 内容
	 */
	public static boolean sendText(String toAddress, String subject, String content) {
		return send(FROM_ADDRESS, FROM_PASSWORD, FROM_HOSTNAME, SSL_ON_CONNECT, SSL_SMTP_PORT, toAddress, subject, content, null, null);
	}

	/**
	 * 发送带附件的邮件
	 * 
	 * @param toAddress 收件人地址
	 * @param subject 标题
	 * @param content 内容
	 */
	public static boolean sendAttachment(String toAddress, String subject, String content, String attachmentName, String attachmentUrl) {
		return send(FROM_ADDRESS, FROM_PASSWORD, FROM_HOSTNAME, SSL_ON_CONNECT, SSL_SMTP_PORT, toAddress, subject, content, attachmentName, attachmentUrl);
	}

	/**
	 * 发送邮件
	 * 
	 * @param fromAddress 发送人邮箱
	 * @param fromPassword 发送人邮箱密码
	 * @param fromHostName 发送人smtp服务器
	 * @param sslOnConnect 是否启用SSL传输
	 * @param sslSmtpPort SSL端口
	 * @param toAddress 收件人地址
	 * @param subject 标题
	 * @param content 内容
	 */
	public static boolean send(String fromAddress, String fromPassword, String fromHostName, boolean sslOnConnect,
			String sslSmtpPort, String toAddress, String subject, String content, String attachmentName, String attachmentUrl) {
		try {
			HtmlEmail htmlEmail = new HtmlEmail();
			// 发送地址
			htmlEmail.setFrom(fromAddress);
			// 密码校验
			htmlEmail.setAuthentication(fromAddress, fromPassword);
			// 发送服务器协议
			htmlEmail.setHostName(fromHostName);

			// SSL
			if (sslOnConnect) {
				htmlEmail.setSSLOnConnect(true);
				htmlEmail.setSslSmtpPort(sslSmtpPort);
			}

			// 接收地址
			htmlEmail.addTo(toAddress);

			// 标题
			htmlEmail.setSubject(subject);
			// 内容
			htmlEmail.setMsg(content);

			// 其他信息
			htmlEmail.setCharset("utf-8");
			
			// 附件
			if (attachmentName != null) {
				EmailAttachment attachment = new EmailAttachment();
				attachment.setURL(new URL(attachmentUrl));
				attachment.setDisposition(EmailAttachment.ATTACHMENT);
				attachment.setName(attachmentName);
				htmlEmail.attach(attachment);
			}
			
			// 发送
			htmlEmail.send();
			return true;
		} catch (Exception ex) {
			logger.error(ex.getMessage(), ex);
		}
		return false;
	}
}