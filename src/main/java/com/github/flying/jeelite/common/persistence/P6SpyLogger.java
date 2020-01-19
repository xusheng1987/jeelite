package com.github.flying.jeelite.common.persistence;

import com.p6spy.engine.common.P6Util;
import com.p6spy.engine.spy.appender.MessageFormattingStrategy;

/**
 * p6spy打印日志输出格式修改
 * 1.只打印最终执行的sql.
 * 2.sql单行显示，并去除多余的空格
 */
public class P6SpyLogger implements MessageFormattingStrategy {
	@Override
    public String formatMessage(int connectionId, String now,
                         long elapsed, String category, String prepared, String sql, String url) {
        if (!sql.trim().equals("")) {
            return now + "  耗时" + elapsed + "ms ==> " + P6Util.singleLine(sql).replaceAll("\\s+", " ");
        }
        return "";
    }
}