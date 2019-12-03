package com.github.flying.jeelite.modules.mq;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.github.flying.jeelite.Application;
import com.github.flying.jeelite.modules.mq.service.SenderService;


/**
 * 消息推送测试类
 *
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)
public class SenderServiceTest {
    @Autowired
    private SenderService senderService;

    @Test
    public void testMq() {
        // 测试广播模式
        senderService.broadcast("测试广播模式");
        // 测试Direct模式
        senderService.direct("测试Direct模式");
        // 测试Topic模式1
        senderService.topic1("测试Topic模式1");
        // 测试Topic模式2
        senderService.topic2("测试Topic模式2");
    }
}