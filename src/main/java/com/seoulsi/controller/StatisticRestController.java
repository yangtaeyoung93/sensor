package com.seoulsi.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.seoulsi.dto.ResultDto;
import com.seoulsi.dto.SensorDto;
import com.seoulsi.service.StatisticService;

/**
 * VisitorController
 */
@RestController
@RequestMapping("/api/statistic")
public class StatisticRestController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private StatisticService statisticService;

	// 실시간 체류 인원 조회
	@GetMapping("/getSensId")
	public Map<String, Object> visitorPerson() throws Exception {
		Map<String, Object> data = new HashMap<>();
		data.put("data", statisticService.getSensId());
		return data;
	}

	@PostMapping("/setSensId")
	public void visitorPersonSet(SensorDto sdto) throws Exception {
		logger.info("{}", sdto);
		statisticService.setSensId(sdto);
	}

	@GetMapping("/getSensData")
	public Map<String, Object> getSensData() throws Exception {
		Map<String, Object> data = new HashMap<>();
		data.put("data", statisticService.getSensData());

		return data;
	}

	@GetMapping("/getEquiPerson")
	public Map<String, Object> getEquiPerson(SensorDto sdto) throws Exception {

		Map<String, Object> data = new HashMap<>();
		data.put("data", statisticService.getEquiPerson(sdto));
		data.put("hourData", statisticService.getEquiPersonHour(sdto));
		return data;

	}

	@GetMapping("/getSensorList")
	public Map<String, Object> getSensorList() throws Exception {
		Map<String, Object> data = new HashMap<>();
		data.put("data", statisticService.getSensorList());

		return data;
	}

	// @ExceptionHandler(value = Exception.class)
	// public ResponseEntity<ResultDto> nfeHandler(Exception e){
	// ResultDto rdto = new ResultDto();
	// rdto.setMsg("fail");
	// rdto.setResult("fail");
	// logger.info("{}", e);
	// return new ResponseEntity<ResultDto>(rdto, HttpStatus.INTERNAL_SERVER_ERROR);
	// }
}
