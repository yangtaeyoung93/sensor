package com.seoulsi.dto;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class PropertiesDto {
	
	@Value("${aes.passPhrase}")
	private String passPhrase;
	
	@Value("${aes.passPhraseDB}")
	private String passPhraseDB;
	
	@Value("${aes.keySize}")
	private int keySize;
	
	@Value("${aes.iterationCount}")
	private int iterationCount;
}
