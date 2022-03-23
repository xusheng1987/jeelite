package com.github.flying.jeelite.modules.config;

import java.util.Properties;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.github.pagehelper.PageInterceptor;

@Configuration
@MapperScan("com.github.flying.jeelite.modules.*.dao")
public class MybatisPlusConfig {

    /**
     * pagehelper的分页插件
     */
    @Bean
    public PageInterceptor pageInterceptor() {
        Properties properties = new Properties();
        properties.setProperty("supportMethodsArguments", "true");//支持通过Mapper接口参数来传递分页参数
        PageInterceptor pageInterceptor = new PageInterceptor();
        pageInterceptor.setProperties(properties);
        return pageInterceptor;
    }
}