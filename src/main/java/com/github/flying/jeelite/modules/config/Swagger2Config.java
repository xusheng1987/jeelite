package com.github.flying.jeelite.modules.config;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.github.flying.jeelite.common.config.Global;
import com.google.common.collect.Lists;

import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.ApiKey;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
public class Swagger2Config {
    /** 是否开启swagger */
    @Value("${swagger.enabled}")
    private boolean enabled;
	
	@Bean
	public Docket createRestApi() {
		return new Docket(DocumentationType.SWAGGER_2)
		        .enable(enabled)
				.apiInfo(apiInfo())
				.select()
				.apis(RequestHandlerSelectors.basePackage("com.github.flying.jeelite.modules.api"))//包扫描
				//.apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class))//注解扫描
				.paths(PathSelectors.any())
				.build()
				.securitySchemes(security());
	}

	private ApiInfo apiInfo() {
		return new ApiInfoBuilder()
				.title("Jeelite RESTful API文档")
				.contact(new Contact("flying", "", ""))
				.version(Global.getVersion())
				.build();
	}
	
	private List<ApiKey> security() {
		return Lists.newArrayList(new ApiKey("Authorization", "token", "header"));
	}

}