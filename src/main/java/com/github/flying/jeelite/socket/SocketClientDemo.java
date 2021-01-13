package com.github.flying.jeelite.socket;

import java.net.URISyntaxException;
import java.util.Arrays;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.github.flying.jeelite.common.mapper.JsonMapper;
import com.github.flying.jeelite.socket.model.LoginRequest;

import io.socket.client.Ack;
import io.socket.client.IO;
import io.socket.client.Socket;
import io.socket.emitter.Emitter;

public class SocketClientDemo {
	private static Socket socket;
	private static final Logger logger = LoggerFactory.getLogger(SocketClientDemo.class);

	public static void main(String[] args0) throws URISyntaxException {
		IO.Options options = new IO.Options();
		options.transports = new String[] { "websocket" };
		// 断线重连时，重连机制是重新建立一个链接，而不会重用原先的链接
		options.reconnection = true;
		options.reconnectionAttempts = 2; // 重连尝试次数
		options.reconnectionDelay = 1000; // 失败重连的时间间隔(ms)
		options.timeout = 20000; // 连接超时时间(ms)
		options.forceNew = true;
		options.query = "username=test&password=test";
		socket = IO.socket("http://localhost:9092/", options);
		socket.on(Socket.EVENT_CONNECT, new Emitter.Listener() {
			@Override
			public void call(Object... args) {
				// 客户端一旦连接成功，开始发起登录请求
				LoginRequest message = new LoginRequest(12, "这是客户端消息体");
				try {
					socket.emit("login", new JSONObject(JsonMapper.toJsonString(message)), new Ack() {
						@Override
						public void call(Object... args1) {
							logger.info("回执消息=" + Arrays.toString(args1));
						}
					});
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}).on("login", new Emitter.Listener() {
			@Override
			public void call(Object... args) {
				logger.info("接受到服务器发送的登录消息：" + Arrays.toString(args));
			}
		}).on(Socket.EVENT_CONNECT_ERROR, new Emitter.Listener() {
			@Override
			public void call(Object... args) {
				logger.info("Socket.EVENT_CONNECT_ERROR");
				//socket.disconnect();
			}
		}).on(Socket.EVENT_CONNECT_TIMEOUT, new Emitter.Listener() {
			@Override
			public void call(Object... args) {
				logger.info("Socket.EVENT_CONNECT_TIMEOUT");
				//socket.disconnect();
			}
		}).on(Socket.EVENT_PING, new Emitter.Listener() {
			@Override
			public void call(Object... args) {
				logger.info("Socket.EVENT_PING");
			}
		}).on(Socket.EVENT_PONG, new Emitter.Listener() {
			@Override
			public void call(Object... args) {
				logger.info("Socket.EVENT_PONG");
			}
		}).on(Socket.EVENT_MESSAGE, new Emitter.Listener() {
			@Override
			public void call(Object... args) {
				logger.info("-----------接受到消息啦--------" + Arrays.toString(args));
			}
		}).on(Socket.EVENT_DISCONNECT, new Emitter.Listener() {
			@Override
			public void call(Object... args) {
				logger.info("客户端断开连接啦。。。");
				//socket.disconnect();
			}
		});
		socket.connect();
	}
}