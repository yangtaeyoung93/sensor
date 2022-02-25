package com.seoulsi.controller;

import java.util.List;

import com.seoulsi.dto.SdotDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.seoulsi.dto.CommonDto;
import com.seoulsi.dto.SettingDto;
import com.seoulsi.service.CommonService;
import com.seoulsi.service.SensorService;
import com.seoulsi.service.SettingService;

/**
 * SensorController
 */
@Controller
@RequestMapping("/sensor")
public class SensorController {

    @Autowired
    SensorService sensorService;

    @Autowired
    CommonService commonService;

    @Autowired
    SettingService settingService;

    // 수치 농도 현황 조회
    @GetMapping("/index")
    public String sensorIndex(Model model) throws Exception {
        // List<SensorDto> lists = sensorService.sensorList();

        // model.addAttribute("lists", lists);
        List<CommonDto> gus = commonService.guList();
        model.addAttribute("gus", gus);

        return "/sensor/index";
    }

    // 실시간 수치 농도 지도 조회
    private static final int initYear = 2019;
    @GetMapping("/map")
    public String sensorMap(Model model) throws Exception {
        List<SettingDto> lists = settingService.getGuEquiList();
        List<SettingDto> instYear = settingService.getInstYear();
        for (SettingDto dto : instYear) {
            dto.setInstYear(dto.getInstYear() + initYear);
        }
        model.addAttribute("gu", lists);
        model.addAttribute("instYear", instYear);
        SdotDTO sdotDTO = new SdotDTO();
        sdotDTO.setTarget("");
        model.addAttribute("totalCount", sensorService.getEquiCount(sdotDTO));
        return "/sensor/map";
    }

    @GetMapping("/map2")
    public String sensorMap2(Model model) throws Exception {
        List<SettingDto> lists = settingService.getGuEquiList();
        model.addAttribute("gu", lists);
        return "/sensor/map";
    }

    // 항목별 측정자료 조회
    @GetMapping("/item")
    public String sensorItem() {
        return "/sensor/item";
    }

    // 장비 상태 정보 조회
    @GetMapping("/state")
    public String sensorState(Model model) throws Exception {
        List<CommonDto> gus = commonService.guList();
        model.addAttribute("gus", gus);
        return "/sensor/state";
    }

    // 실시간 기기 정보 모니터링
    @GetMapping("/ware")
    public String sensorWare(Model model) {
        return "/sensor/ware";
    }

    // 토탈 조회
    @GetMapping("/total")
    public String sensorTotal(Model model) {
        return "/sensor/total";
    }

    // 수치농도 통계 조회
    @GetMapping("/statistic")
    public String sensorStatistic(Model model) throws Exception {
        // List<SensorDto> lists = sensorService.sensorList();

        // model.addAttribute("lists", lists);
        List<CommonDto> gus = commonService.guList();
        model.addAttribute("gus", gus);

        return "/sensor/statistic";
    }

    // 수치/농도 지역별 평균 조회
    @GetMapping("/itemVisual")
    public String itemVisual(Model model) throws Exception {
        return "/sensor/itemVisual";
    }
}