package com.github.flying.jeelite.socket;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.corundumstudio.socketio.*;
import com.corundumstudio.socketio.listener.ConnectListener;
import com.corundumstudio.socketio.listener.DataListener;
import com.corundumstudio.socketio.listener.DisconnectListener;
import com.github.flying.jeelite.socket.model.LoginRequest;
import com.google.common.collect.Maps;

public class SocketServerDemo {
	private static final Logger logger = LoggerFactory.getLogger(SocketServerDemo.class);

	public static void main(String[] args) {
		Map<String, SocketIOClient> clientMap = Maps.newHashMap();
		/*
		 * 创建Socket，并设置监听端口
		 */
		Configuration config = new Configuration();
		// 设置主机名
		config.setHostname("localhost");
		// 设置监听端口
		config.setPort(9092);
		// 协议升级超时时间（毫秒），默认10秒。HTTP握手升级为ws协议超时时间
		config.setUpgradeTimeout(10000);
		// Ping消息超时时间（毫秒），默认60秒，这个时间间隔内没有接收到心跳消息就会发送超时事件
		config.setPingTimeout(180000);
		// Ping消息间隔（毫秒），默认25秒。客户端向服务器发送一条心跳消息间隔
		config.setPingInterval(60000);
		// 连接认证
		config.setAuthorizationListener(new AuthorizationListener() {
			@Override
			public boolean isAuthorized(HandshakeData data) {
				// 验证用户
				// String username = data.getSingleUrlParam("username");
				// String password = data.getSingleUrlParam("password");
				return true;
			}
		});

		final SocketIOServer server = new SocketIOServer(config);

		/*
		 * 添加连接监听事件，监听是否有客户端连接到服务器
		 */
		server.addConnectListener(new ConnectListener() {
			@Override
			public void onConnect(SocketIOClient client) {
				// 判断是否有客户端连接
				if (client != null) {
					logger.info("连接成功。clientId=" + client.getSessionId().toString());
					String username = client.getHandshakeData().getSingleUrlParam("username");
					clientMap.put(username, client);
				} else {
					logger.error("没有客户端连接上。。。");
				}
			}
		});

		/*
		 * 添加连接断开事件
		 */
		server.addDisconnectListener(new DisconnectListener() {
			@Override
			public void onDisconnect(SocketIOClient client) {
				String username = client.getHandshakeData().getSingleUrlParam("username");
				logger.info("服务器收到断线通知... sessionId=" + client.getSessionId());
				clientMap.remove(username);
				client.disconnect();
			}
		});

		/*
		 * 添加监听事件，监听客户端的事件
		 * 1.第一个参数eventName需要与客户端的事件要一致
		 * 2.第二个参数eventClass是传输的数据类型
		 * 3.第三个参数listener是用于接收客户端传的数据，数据类型需要与eventClass一致
		 */
		server.addEventListener("login", LoginRequest.class, new DataListener<LoginRequest>() {
			@Override
			public void onData(SocketIOClient client, LoginRequest data, AckRequest ackRequest) {
				logger.info("接收到客户端login消息：code = " + data.getCode() + ",body = " + data.getBody());
				// check is ack requested by client, but it's not required check
				if (ackRequest.isAckRequested()) {
					// send ack response with data to client
					ackRequest.sendAckData("已成功收到客户端登录请求", "yeah");
				}
				// 向客户端发送消息
				// 第一个参数必须与eventName一致，第二个参数data必须与eventClass一致
				client.sendEvent("login", "登录成功，sessionId=" + client.getSessionId());
				// broadcast messages to all clients
				// server.getBroadcastOperations().sendEvent("login", data);
			}
		});
		// 启动服务
		server.start();
	}
}