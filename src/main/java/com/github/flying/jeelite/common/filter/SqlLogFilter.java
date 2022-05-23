package com.github.flying.jeelite.common.filter;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.alibaba.druid.filter.logging.Slf4jLogFilter;
import com.alibaba.druid.proxy.jdbc.JdbcParameter;
import com.alibaba.druid.proxy.jdbc.ResultSetProxy;
import com.alibaba.druid.proxy.jdbc.StatementProxy;
import com.alibaba.druid.sql.SQLUtils;
import com.alibaba.druid.sql.SQLUtils.FormatOption;
import com.github.flying.jeelite.common.utils.DateUtils;

/**
 * 扩展druid连接池，自定义sql打印
 */
@Component
public class SqlLogFilter extends Slf4jLogFilter {

    @Value("${spring.profiles.active}")
    private String profiles;

    public SqlLogFilter() {
        setStatementPrepareAfterLogEnabled(false);
        setStatementParameterClearLogEnable(false);
        setStatementParameterSetLogEnabled(false);
        setStatementCloseAfterLogEnabled(false);
        setStatementExecuteAfterLogEnabled(false);
        setStatementExecutableSqlLogEnable(true);
        setStatementSqlFormatOption(new FormatOption(false, false));
    }

    @Override
    protected void statementExecuteQueryAfter(StatementProxy statement, String sql, ResultSetProxy resultSet) {
        //logExecutableSql(statement, sql);
    }

    @Override
    protected void statementExecuteUpdateAfter(StatementProxy statement, String sql, int updateCount) {
        //logExecutableSql(statement, sql);
    }

    @Override
    protected void statementExecuteAfter(StatementProxy statement, String sql, boolean firstResult) {
        logExecutableSql(statement, sql);
    }

    private void logExecutableSql(StatementProxy statement, String sql) {
        statement.setLastExecuteTimeNano();
        double nanos = statement.getLastExecuteTimeNano();
        double millis = nanos / (1000 * 1000);
        // 开发和测试环境打印所有sql，生产环境只打印慢sql(超过500毫秒)
        if (!StringUtils.equalsAny(profiles, "dev", "test")) {
            if (millis < 500) {
                return;
            }
        }
        // 数据库类型
        String dbType = statement.getConnectionProxy().getDirectDataSource().getDbType();

        DecimalFormat df = new DecimalFormat("0.00");
        String costTime = " cost " + df.format(millis) + "ms ==> ";
        int parametersSize = statement.getParametersSize();
        if (parametersSize == 0) {
            String formattedSql = SQLUtils.format(sql, dbType, getStatementSqlFormatOption());
            System.out.println(DateUtils.getDateTime() + costTime + formattedSql);
            return;
        }

        List<Object> parameters = new ArrayList<Object>(parametersSize);
        for (int i = 0; i < parametersSize; ++i) {
            JdbcParameter jdbcParam = statement.getParameter(i);
            parameters.add(jdbcParam != null
                    ? jdbcParam.getValue()
                    : null);
        }

        String formattedSql = SQLUtils.format(sql, dbType, parameters, getStatementSqlFormatOption());
        System.out.println(DateUtils.getDateTime() + costTime + formattedSql);
    }

}