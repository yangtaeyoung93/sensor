package com.seoulsi;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.seoulsi.service.SettingService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes= DemoApplicationTests.class)
public class DemoApplicationTests {

	private static Logger logger = LoggerFactory.getLogger(DemoApplicationTests.class);
	
	@Autowired
	private SettingService settingService;
	
	@Test
	public void test() throws Exception {
	    logger.info("{}",settingService.getUserCode());  
	}
}
