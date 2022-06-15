package com.seoulsi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.seoulsi.dto.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.seoulsi.dto.extend.ParamDto;
import com.seoulsi.service.CommonService;
import com.seoulsi.service.SensorService;
import com.seoulsi.service.SettingService;
import com.seoulsi.util.DateUtil;

@RestController
@RequestMapping("/api")
public class SensorRestController {

	Logger logger = LoggerFactory.getLogger(SensorRestController.class);

	@Autowired
	SensorService sensorService;

	@Autowired
	SettingService settingService;

	@Autowired
	CommonService commonService;

	@Autowired
	private JavaMailSender javaMailSender;

	@GetMapping("/sensor/list/{code}")
	public Object equiList(@PathVariable String code) throws Exception {

		for (SensorDto sdto : sensorService.sensorEquiList(code)) {
			logger.info(sdto.getEquiInfoKey());
		}
		if (code.equals("25")) {
			return sensorService.sensorEquiListBaram();
		}
		if (code.equals("26")) {
			return sensorService.sensorEquiListAir();
		}
		return sensorService.sensorEquiList(code);

	}

	@GetMapping("/sensor/equiCommon")
	public Map<String, Object> equiCommon() throws Exception {

		Map<String, Object> list = new HashMap<>();

		list.put("data", settingService.getCommList());

		return list;
	}

	@GetMapping("/insTempSend")
	public boolean insTempSend(@RequestParam(value="params") String params) throws Exception{
		String[] str = params.split(",");
		logger.info("insTempSend = {}",str[0]);
		if(str[0].equals("connect") || str[0].equals("n_connect") || str[0].equals("dayconnect")|| str[0].equals("users") || str[0].equals("mtr")){
			TempVO vo = new TempVO(str[0],str[1],str[2],str[3]);
			return sensorService.insTempSend(vo);
		}else{
			TempVO vo = new TempVO(str[0],str[1],str[2],str[4],str[3]);
			return sensorService.minsTempSend(vo);
		}
	}

	@GetMapping("/updERRTempSend")
	public void updERRTempSend(@RequestParam(value="params") String params) throws Exception{
		String[] str = params.split(",");
		logger.info("updERRTempSend = {},flag ={}",str[0],str[2]);
		if(str[0].equals("connect") || str[0].equals("n_connect") || str[0].equals("dayconnect") || str[0].equals("users") || str[0].equals("mtr")){
			TempVO vo = new TempVO(str[0],str[1],str[2],str[3]);
			sensorService.updERRTempSend(vo);
		}else{
			TempVO vo = new TempVO(str[0],str[1],str[2],str[4],str[3]);
			sensorService.mupdERRTempSend(vo);
		}
	}

	@GetMapping("/updTempSend")
	public void updTempSend(@RequestParam(value="params") String params) throws Exception{
		String[] str = params.split(",");
		logger.info("updTempSend = {}",str[0]);
		if(str[0].equals("connect") || str[0].equals("n_connect") || str[0].equals("dayconnect")|| str[0].equals("users") || str[0].equals("mtr")){
			TempVO vo = new TempVO(str[0],str[1],str[2],str[3]);
			sensorService.updTempSend(vo);
		}else{
			TempVO vo = new TempVO(str[0],str[1],str[2],str[4],str[3]);
			sensorService.minupdTempSend(vo);
		}

	}

	@PostMapping("/sensor/equiSearchList")
	public Map<String, Object> equiSearchList(@RequestParam(value = "gu") String gu,
			@RequestParam(value = "equiInfoKey") String equi, @RequestParam(value = "toDate") String toDate,
			@RequestParam(value = "fromDate") String fromDate, @RequestParam(value = "pageStart") String pageStart)
			throws Exception {

		SensorDto data = new SensorDto();
		data.setToDate(toDate);
		data.setFromDate(fromDate);
		data.setEquiInfoKey(equi);

		Map<String, Object> json = new HashMap<>();
		json.put("data", sensorService.equiSearchList(data));
		json.put("allData", sensorService.equiSearchAllList(data));
		return json;
	}

	@PostMapping("/sensor/equiSearchListCorrection")
	public Map<String, Object> equiSearchListCorrection(@RequestParam(value = "gu") String gu,
			@RequestParam(value = "equiInfoKey") String equi, @RequestParam(value = "toDate") String toDate,
			@RequestParam(value = "fromDate") String fromDate, @RequestParam(value = "pageStart") String pageStart)
			throws Exception {

		SensorDto data = new SensorDto();
		data.setToDate(toDate);
		data.setFromDate(fromDate);
		data.setEquiInfoKey(equi);

		data.setPageStart(String.valueOf(pageStart));
		int pageCount = 50;
		int startPage = (Integer.parseInt(pageStart) - 1) * pageCount + 1;
		int pageEnd = Integer.parseInt(pageStart) * pageCount;

		data.setPageStart(String.valueOf(startPage));
		data.setPageEnd(String.valueOf(pageEnd));
		for (SensorDto sdto : sensorService.equiSearchList(data)) {
			logger.info(sdto.getEquiInfoKey());
		}
		Map<String, Object> json = new HashMap<>();
		json.put("data", sensorService.equiSearchListCorrection(data));
		json.put("allData", sensorService.equiSearchAllListCorrection(data));
		return json;
	}

	@PostMapping("/sensor/guData")
	public Map<String, Object> guData(@RequestParam(value = "stx") String stx,
			@RequestParam(value = "toDate") String toDate, @RequestParam(value = "fromDate") String fromDate)
			throws Exception {
		String text = "";

		switch (stx) {
			case "0":
				text = "PM10";
				break;
			case "1":
				text = "PM25";
				break;
			case "2":
				text = "NOISE";
				break;
			case "3":
				text = "TEMP";
				break;
		}

		SensorDto sdto = new SensorDto();

		sdto.setType(stx);
		sdto.setToDate(toDate);
		sdto.setFromDate(fromDate);
		Map<String, Object> lists = new HashMap<>();
		Map<String, Object> baramLists = new HashMap<>();
		if (stx.equals("5") || stx.equals("6")) {
			for (int i = 0; i <= Integer.parseInt(fromDate); i++) {
				String date = DateUtil.dateAdd("yyyy/mm/dd", toDate, "DATE", i);
				String[] date_arr = date.split("/");
				date = date_arr[0] + date_arr[1] + date_arr[2];
				logger.warn(date);
				sdto.setToDate(date);
				logger.warn("{}", sensorService.baramGuData(sdto));
				baramLists.put(date, sensorService.baramGuData(sdto));
			}
			lists.put("data", baramLists);
		} else {
			lists.put("data", sensorService.guData(sdto));
		}
		return lists;
	}

	@PostMapping("/sensor/guDataAvg")
	public Map<String, Object> guDataAvg(@RequestParam(value = "stx") String stx,
			@RequestParam(value = "toDate") String toDate, @RequestParam(value = "fromDate") String fromDate)
			throws Exception {
		String text = "";

		switch (stx) {
			case "0":
				text = "PM10";
				break;
			case "1":
				text = "PM25";
				break;
			case "2":
				text = "NOISE";
				break;
			case "3":
				text = "TEMP";
				break;
		}

		SensorDto sdto = new SensorDto();

		sdto.setType(stx);
		sdto.setToDate(toDate);
		sdto.setFromDate(fromDate);
		Map<String, Object> lists = new HashMap<>();
		Map<String, Object> baramLists = new HashMap<>();
		if (stx.equals("5") || stx.equals("6")) {
			for (int i = 0; i <= Integer.parseInt(fromDate); i++) {
				String date = DateUtil.dateAdd("yyyy/mm/dd", toDate, "DATE", i);
				String[] date_arr = date.split("/");
				date = date_arr[0] + date_arr[1] + date_arr[2];
				sdto.setToDate(date);
				baramLists.put(date, sensorService.baramGuData(sdto));
			}
			lists.put("data", baramLists);
		} else {
			lists.put("data", sensorService.guDataAvg(sdto));
		}
		return lists;
	}

	@GetMapping("/equiGps")
	public Map<String, Object> getEquiGpsInfo() throws Exception {
		Map<String, Object> lists = new HashMap<>();
		lists.put("data", sensorService.getEquiGpsInfo());
		return lists;
	}

	@GetMapping("/searEqui")
	public Map<String, Object> getSearEqui(SdotDTO sdotDTO) throws Exception {
		if(sdotDTO.getTp() == null){
			sdotDTO.setTp("");
		}
		Map<String, Object> list = new HashMap<>();
		list.put("data", sensorService.getSearEqui(sdotDTO));
		list.put("totalCount", sensorService.getEquiCount(sdotDTO));
		return list;
	}

	@PostMapping("/sensor/statList")
	public Map<String, Object> getStatList(StatDto sdto) throws Exception {

		int pageCount = 50;
		int startPage = (Integer.parseInt(sdto.getPageStart()) - 1) * pageCount + 1;
		int pageEnd = Integer.parseInt(sdto.getPageStart()) * pageCount;

		sdto.setPageStart(String.valueOf(startPage));
		sdto.setPageEnd(String.valueOf(pageEnd));
		Map<String, Object> json = new HashMap<>();
		json.put("data", sensorService.getStatList(sdto));
		return json;
	}

	@PostMapping("/sensor/statAllList")
	public Map<String, Object> getStatAllList(StatDto sdto) throws Exception {

		int pageCount = 50;
		int startPage = (Integer.parseInt(sdto.getPageStart()) - 1) * pageCount + 1;
		int pageEnd = Integer.parseInt(sdto.getPageStart()) * pageCount;

		sdto.setPageStart(String.valueOf(startPage));
		sdto.setPageEnd(String.valueOf(pageEnd));
		Map<String, Object> json = new HashMap<>();
		json.put("data", sensorService.getStatAllList(sdto));
		return json;
	}

	@PostMapping("/sensor/statLastUpdate")
	public Map<String, Object> getStatLastUpdate(String wareName) throws Exception {

		Map<String, Object> json = new HashMap<>();
		json.put("data", sensorService.getStatLastUpdate(wareName));
		return json;
	}

	@GetMapping("/sensor/totalList")
	public Map<String, Object> getTotalList() throws Exception {

		Map<String, Object> json = new HashMap<>();
		json.put("data", sensorService.getTotalList());

		return json;
	}

	@GetMapping("/sensor/totalWareDataList")
	public Map<String, Object> getTotalWareDataList() throws Exception {

		Map<String, Object> json = new HashMap<>();
		json.put("data", sensorService.getTotalWareDataList());

		return json;
	}

	@GetMapping("/sensor/unreceiveWareList")
	public Map<String, Object> getUnreceiveWareList() throws Exception {

		Map<String, Object> json = new HashMap<>();
		json.put("data", sensorService.getUnreceiveWareList());

		return json;
	}

	@GetMapping("/sensor/receiveWareList")
	public Map<String, Object> getReceiveWareList() throws Exception {

		Map<String, Object> json = new HashMap<>();
		json.put("data", sensorService.getReceiveWareList());

		return json;
	}

	@GetMapping("/sensor/badWareList/{dataCat}/{type}")
	public Map<String, Object> getBadWareList(@PathVariable String dataCat, @PathVariable String type)
			throws Exception {

		Map<String, Object> json = new HashMap<>();
		TotalDto tdto = new TotalDto();
		tdto.setWareName(dataCat);
		tdto.setWareTp(type);
		json.put("data", sensorService.getBadWareList(tdto));

		return json;
	}

	@PostMapping("/sensor/statistic")
	public Map<String, Object> getStatisticData(SensorDto sdto) throws Exception {
		Map<String, Object> data = new HashMap<>();
		logger.info("{}", sdto.getStatisticType());
		logger.info("{}", sdto.getToDate());
		logger.info("{}", sdto.getFromDate());
		logger.info("{}", sdto.getType());
		data.put("allData", sensorService.getStatisticAllData(sdto));
		data.put("data", sensorService.getStatisticData(sdto));
		return data;
	}

	@PostMapping("/sensor/getDailyForDate")
	public Map<String, Object> getDailyForDate(ParamDto paramDto) throws Exception {

		Map<String, Object> data = new HashMap<>();
		data.put("data", commonService.getDailySenForDate(paramDto));
		logger.info("{}", data);
		return data;

	}

	@PostMapping("/sensor/getDailyCntForEqui")
	public Map<String, Object> getDailyCntForEqui(ParamDto paramDto) throws Exception {

		Map<String, Object> data = new HashMap<>();
		data.put("data", commonService.getDailyCntForEqui(paramDto));
		logger.info("{}", data);
		return data;

	}

	@PostMapping("/sensor/getDailyCntForEquiSensor")
	public ResponseEntity<String> getDailyCntForEquiSensor(ParamDto paramDto) throws Exception {

		Gson gson = new Gson();
		List<JsonObject> arr = new ArrayList<>();
		List<CommonDto> gus = commonService.guList();
		List<SensorDto> list = null;
		String type = paramDto.getType();

		if (type.equals("windSpeed") || type.equals("windDire")) {
			list = commonService.getDailyCntForEquiSensorWind(paramDto);
		} else {
			list = commonService.getDailyCntForEquiSensor(paramDto);
		}

		for (SensorDto sdto : list) {
			JsonObject object = new JsonObject();
			object.addProperty("equiInfoKey", sdto.getEquiInfoKey());
			object.addProperty("equiInfoKeyHan", sdto.getEquiInfoKeyHan());
			object.addProperty("guTp", sdto.getGuTp());
			arr.add(object);
		}

		Map<String, Object> data = new HashMap<>();
		data.put("code", gus);
		data.put("list", arr);
		logger.info("DATA ================= {}", gson.toJson(arr));
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "application/json; charset=UTF-8");

		return new ResponseEntity(gson.toJson(data).toString(), responseHeaders, HttpStatus.OK);

	}

	@PostMapping("/sensor/getDailyCntForData")
	public Map<String, Object> getDailyCntForData(ParamDto paramDto) throws Exception {

		Map<String, Object> data = new HashMap<>();
		data.put("data", commonService.getDailyCntForData(paramDto));
		logger.info("{}", data);
		return data;

	}

	@GetMapping("/sensor/getEquiCnt")
	public Map<String, Object> getEquiCnt() throws Exception {
		Map<String, Object> json = new HashMap<>();
		json.put("data", sensorService.getEquiCnt());

		return json;
	}

	@ExceptionHandler(value = Exception.class)
	public ResponseEntity<ResultDto> nfeHandler(Exception e) {
		ResultDto rdto = new ResultDto();
		rdto.setMsg("fail");
		rdto.setResult("fail");
		logger.info("{}", e);
		return new ResponseEntity<ResultDto>(rdto, HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PostMapping("/sensor/getDailyCntForMoveEqui")
	public Map<String, Object> getDailyCntForMoveEqui(ParamDto paramDto) throws Exception {
		Map<String, Object> data = new HashMap<>();
		data.put("data", commonService.getDailyCntForMoveEqui(paramDto));
		logger.info("{}", data);
		return data;
	}

}
