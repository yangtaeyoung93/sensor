package com.seoulsi;

import java.nio.charset.Charset;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;


@SpringBootApplication
//AOP 활성화
@EnableAspectJAutoProxy
//config 암호화 활설
@EnableEncryptableProperties
// 스케줄러 활성화
@EnableScheduling
@ComponentScan("com.seoulsi")
@MapperScan(basePackages = "com.seoulsi.mapper")
public class seoulsiApplication {

  public static void main(String[] args) {
    SpringApplication.run(seoulsiApplication.class, args);
  }

  @Bean
  public HttpMessageConverter<String> responseBodyConverter() {
    return new StringHttpMessageConverter(Charset.forName("UTF-8"));
  }

}
