package com.seoulsi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

// War
@SpringBootApplication
public class ServletInitializer extends SpringBootServletInitializer {

    // DevTool
    // @Override
    // protected SpringApplicationBuilder configure(SpringApplicationBuilder
    // application) {
    // return application.sources(SpringBootTestApplication.class);
    // }

    // War Packaging
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(ServletInitializer.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(ServletInitializer.class, args);
    }

}