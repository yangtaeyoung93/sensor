package com.seoulsi.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.seoulsi.handler.TestInterceptor;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {

	@Autowired
	private TestInterceptor testInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(testInterceptor).addPathPatterns("/**").excludePathPatterns("/api/**/**")
				.excludePathPatterns("/js/**") // resource
				.excludePathPatterns("/img/**") // resource
				.excludePathPatterns("/locimg/**/**") // resource
				.excludePathPatterns("/css/**") // resource
				.excludePathPatterns("/share/**") // resource
				.excludePathPatterns("/file/**") // resource
				.excludePathPatterns("/") //
				.excludePathPatterns("/login") //
				.excludePathPatterns("/logout") //
				.excludePathPatterns("/test") //
				.excludePathPatterns("/error") //
				.excludePathPatterns("/ziptest") //
				.excludePathPatterns("/userAuth") //
				.excludePathPatterns("/sensor/map2") //
				.excludePathPatterns("/not-auth") //
				.excludePathPatterns("/excelTest/**") //
				.excludePathPatterns("/api/admin/mngDept/excel") //
				.excludePathPatterns("/api/admin/ware/excel") //
				.excludePathPatterns("/admin/equi/excel/**") //
				.excludePathPatterns("/admin/card/excel/**") //
				.excludePathPatterns("/admin/cardLoc/excel/**") //
				.excludePathPatterns("/popup01").excludePathPatterns("/popup02").excludePathPatterns("/popup03");
		WebMvcConfigurer.super.addInterceptors(registry);
	}

	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**").allowedMethods("GET", "POST");
	}
}
