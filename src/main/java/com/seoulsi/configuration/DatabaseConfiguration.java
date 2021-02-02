package com.seoulsi.configuration;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.context.ApplicationContext;

@Configuration
@MapperScan(basePackages = {"com.seoulsi.mapper"})
@PropertySource("classpath:/application.properties")
public class DatabaseConfiguration {

	@Autowired
  private ApplicationContext applicationContext;
  
  @Bean
  public SqlSessionFactory sqlSessionFactory(DataSource datasource) throws Exception {
    final SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
    sessionFactory.setDataSource(datasource);

    sessionFactory
    .setConfigLocation(applicationContext.getResource("classpath:/mybatis/mybatis-config.xml"));

    PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
    sessionFactory.setMapperLocations(resolver.getResources("classpath:/mapper/**/*.xml"));
    return sessionFactory.getObject();
  }
  
}