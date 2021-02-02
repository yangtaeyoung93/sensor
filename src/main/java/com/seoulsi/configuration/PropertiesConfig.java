package com.seoulsi.configuration;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.EnvironmentPBEConfig;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class PropertiesConfig {

	@Bean("jasyptStringEncryptor")
	static public StandardPBEStringEncryptor stringEncryptor() {
		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		EnvironmentPBEConfig config = new EnvironmentPBEConfig();
		config.setPassword("seoulsi");
		config.setAlgorithm("PBEWITHMD5ANDDES");
		encryptor.setConfig(config);
		return encryptor;
	}
}
