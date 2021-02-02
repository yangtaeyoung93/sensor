package com.seoulsi.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.seoulsi.dto.CommonDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.MenuDto;
import com.seoulsi.dto.PropertiesDto;
import com.seoulsi.dto.SettingDto;
import com.seoulsi.service.CommonService;
import com.seoulsi.service.SettingService;
import com.seoulsi.util.AES256Util;
import com.seoulsi.util.CookieLoginUtil;
import com.seoulsi.util.SeedScrtyUtil;

@Controller
@RequestMapping("/setting")
public class SettingController {

	@Autowired
	SettingService settingService;

	@Autowired
	CommonService commonService;

	@Autowired
	ResourceLoader resourceLoader;

	@Autowired
	private PropertiesDto pdto;

	// 메뉴 권한 설정
	@GetMapping("menu")
	public String settingMenu(Model model, HttpServletRequest request) throws Exception {
		Map<String, String> cookieMap = CookieLoginUtil.getCookie(request);
		AES256Util aes = new AES256Util(pdto.getPassPhraseDB());
		String id = aes.encrypt(SeedScrtyUtil.decryptCBCText(cookieMap.get("SDOT_ID")));

		List<MemberDto> lists = settingService.getUserCode();
		List<CommonDto> parts = commonService.partList();
		List<MenuDto> menus = commonService.getMenu(id);

		model.addAttribute("lists", lists);
		model.addAttribute("parts", parts);
		model.addAttribute("menus", menus);
		return "setting/menu";
	}

	// 공통 코드설정
	@GetMapping("/code")
	public String settingCode(Model model) throws Exception {
		List<CommonDto> codes = commonService.codeList();
		model.addAttribute("codes", codes);

		return "setting/code";
	}

	@GetMapping("/equiExcel")
	public ResponseEntity<Resource> resourceFileDownload() {
		try {
			Resource resource = resourceLoader.getResource("classpath:static/files/equiExcel.xlsx");
			File file = resource.getFile();

			ResponseEntity<Resource> result = ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, "다중 추가 양식 파일")
					.header(HttpHeaders.CONTENT_LENGTH, String.valueOf(file.length()))
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM.toString()).body(resource);
			return result;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().body(null);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
}
