package com.seoulsi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.seoulsi.dto.CommonDto;
import com.seoulsi.service.CommonService;

/**
 * VisitorController
 */
@Controller
@RequestMapping("/statistic")
public class StatisticController {

	@Autowired
	private CommonService commonService;
	
    //실시간 체류 인원 조회
    @GetMapping("/person")
    public String visitorPerson() {
        return "statistic/person";
    }
    
    //기간별 방문자 조회
    @GetMapping("/term")
    public String visitorTerm(Model model) throws Exception {
    	List<CommonDto> gus = commonService.guList();
		model.addAttribute("gus", gus);
        return "statistic/term";
    }
    
}