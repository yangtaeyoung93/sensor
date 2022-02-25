package com.seoulsi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.seoulsi.dto.CommonDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.MenuDto;
import com.seoulsi.dto.PropertiesDto;
import com.seoulsi.dto.ResultDto;
import com.seoulsi.service.CommonService;
import com.seoulsi.service.SettingService;
import com.seoulsi.util.AES256Util;

@RestController
@RequestMapping("/api/setting")
public class SettingRestController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	SettingService settingService;
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	private PropertiesDto pdto;
	
	@GetMapping("/user/code/{code}")
	public Map<String, Object> getMemberByCode(@PathVariable String code) throws Exception {
		Map<String, Object> info = new HashMap<>();
		List<MemberDto> lm = new ArrayList<>();
		AES256Util aes = new AES256Util(pdto.getPassPhraseDB());
		
		for(MemberDto memberdto:settingService.getUserByCode(code)) {
			//MemberDto mdto = new MemberDto();
			memberdto.setUserId(aes.decrypt(memberdto.getUserId()));
			memberdto.setUserName(aes.decrypt(memberdto.getUserName()));
			memberdto.setEmailAddr(aes.decrypt(memberdto.getEmailAddr()));
			memberdto.setHandPhone(aes.decrypt(memberdto.getHandPhone()));
			memberdto.setTelNo(aes.decrypt(memberdto.getTelNo()));
			//mdto.setCode(memberdto.getCode());
			//mdto.setEtc(memberdto.getEtc());
			
			lm.add(memberdto);
		}
		
		info.put("data", lm);
		return info;
	}
	@GetMapping("/menu/info/{userId}")
	public Map<String, Object> getMenuInfo(@PathVariable String userId) throws Exception {
		Map<String, Object> info = new HashMap<>();
		AES256Util aes = new AES256Util(pdto.getPassPhraseDB());
		info.put("data", commonService.getMenu(aes.encrypt(userId)));
		
		return info;
	}

	@PostMapping("/menu/save")
	public ResultDto saveUser(@RequestBody Map<String, Object> json) throws Exception {
		ResultDto rdto = new ResultDto();
		json.forEach((k,v) -> System.out.println("key : " + k + ", value : " + v));
		
		json.forEach((k,v) -> {
			try {
					String userId = (String) json.get("userId");
					MenuDto mdto = new MenuDto();
					if(k.indexOf("m") != -1) {
						String[] valueArray = ((String) v).split("_");
						String[] karr = k.split("m");
						mdto.setUserId(userId);
						mdto.setMenuId(karr[1]);
						mdto.setGrantYn(valueArray[0]); 
						mdto.setWriteGrantYn(valueArray[1]); 
						settingService.updateUserGrant(mdto);
					}
					rdto.setMsg("추가되었습니다");
					rdto.setResult("success");
				} catch(Exception e) {
					rdto.setMsg(e.getMessage());
					rdto.setResult("fail");
				}
				
			}
		);

		return rdto;
	}
	
	@GetMapping("/code/list/{sortCd}")
	public Map<String, Object> getCodeOne(@PathVariable String sortCd) throws Exception {
		Map<String, Object> info = new HashMap<>();
		
		info.put("data", commonService.codeListOne(sortCd));
		return info;
	}
	
	@PostMapping("/code/list/{sortCd}")
	public Map<String, Object> getCodeOnePost(@PathVariable String sortCd) throws Exception {
		Map<String, Object> info = new HashMap<>();
		info.put("rows", commonService.codeListOne(sortCd));
		return info;
	}
	
	@PostMapping("/code/update")
	public ResultDto codeListUpdate(CommonDto cdto) throws Exception {
		ResultDto rdto = new ResultDto();
		try {
			commonService.codeListUpdate(cdto);
			rdto.setMsg("수정되었습니다");
			rdto.setResult("success");
		} catch(Exception e) {
			rdto.setMsg(e.getMessage());
			rdto.setResult("fail");
		}
		
		return rdto;
	}
	
	@PostMapping("/code/save/{codeNm}")
	public ResultDto codeListSave(CommonDto cdto, @PathVariable String codeNm) throws Exception {
		ResultDto rdto = new ResultDto();
		try {
			cdto.setSortCd(codeNm);
			cdto.setSortNm(codeNm);
			commonService.codeListSave(cdto);
			rdto.setMsg("저장되었습니다");
			rdto.setResult("success");
		} catch(Exception e) {
			rdto.setMsg(e.getMessage());
			rdto.setResult("fail");
		}
		
		return rdto;
	}
	
	@PostMapping("/code/remove")
	public ResultDto codeListRemove(CommonDto cdto) throws Exception {
		ResultDto rdto = new ResultDto();
		try {
			String split = cdto.getId();
			String[] sarr = split.split(",");
			cdto.setCode(sarr[1]);
			cdto.setSortCd(sarr[0]);
			commonService.codeListRemove(cdto);
			rdto.setMsg("삭제되었습니다");
			rdto.setResult("success");
		} catch(Exception e) {
			rdto.setMsg(e.getMessage());
			rdto.setResult("fail");
		}
		
		return rdto;
	}
	@ExceptionHandler(value = Exception.class)  
	 public ResponseEntity<ResultDto> nfeHandler(Exception e){
		ResultDto rdto = new ResultDto();
		rdto.setMsg("fail");
		rdto.setResult("fail");
	     return new ResponseEntity<ResultDto>(rdto, HttpStatus.INTERNAL_SERVER_ERROR);  
	 }
}
