package com.seoulsi.controller;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.seoulsi.dto.CardDto;
import com.seoulsi.dto.EquLocPic;
import com.seoulsi.dto.EquiDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.MngDeptDto;
import com.seoulsi.dto.PropertiesDto;
import com.seoulsi.dto.TestDto;
import com.seoulsi.dto.WareDto;
import com.seoulsi.dto.extend.ParamDto;
import com.seoulsi.service.AdminService;
import com.seoulsi.service.MemberService;
import com.seoulsi.service.SettingService;
import com.seoulsi.service.testService;
import com.seoulsi.util.AES256Util;
import com.seoulsi.util.FileCheckUtil;
import com.seoulsi.util.MybatisUtil;
import com.seoulsi.util.UnZipUtil;

@Controller
public class testController {
  @Autowired
  private testService service;

  @Autowired
  private MemberService memberService;

  @Autowired
  private AdminService adminService;

  @Autowired
  private SettingService settingService;

  @Autowired
  private PropertiesDto pdto;

  @Value("${file.upload-path}")
  private String path;

  // @Value("${file.unzip-path}")
  // private String unzipPath;

  Logger logger = LoggerFactory.getLogger(testController.class);

  // @RequestMapping("/")
  // public void index() throws Exception {
  // logger.trace("This is a TRACE message.");
  // logger.debug("This is a DEBUG message.");
  // logger.info("This is an INFO message.");
  // logger.warn("This is a WARN message.");
  // logger.error("You guessed it, an ERROR message.");
  // }

  @GetMapping("/not-auth")
  public String test(HttpServletRequest request) throws IOException {
    Principal p = request.getUserPrincipal();
    logger.warn("{}", p);
    return "noauth";
  }

  @PostMapping("/test")
  @ResponseBody
  public void getDual(@RequestPart MultipartFile instAftFrt, @RequestPart MultipartFile instAftBack) throws Exception {
    MybatisUtil.saveFile(instAftFrt.getBytes(),
        "C:/Users/kweather/Documents/sensor-1/src/main/resources/static/img/equi/" + "asd."
            + MybatisUtil.splitFileName(instAftFrt.getContentType()));
  }

  @GetMapping("/test/json")
  @ResponseBody
  public List<Map<String, Object>> getGuEqui() throws Exception {
    List<MemberDto> lists = settingService.getUserCode();
    List<Map<String, Object>> trees = new ArrayList<>();

    for (MemberDto sdto : lists) {
      String userList = sdto.getUserName();
      String userIdList = sdto.getUserId();
      String[] userArr = userList.split(",");
      String[] userId = userIdList.split(",");
      Map<String, Object> user = new HashMap<>();

      user.put("text", sdto.getCode());
      user.put("state", "closed");
      List<Map<String, Object>> children = new ArrayList<>();
      int count = 0;
      for (String equiChild : userArr) {
        Map<String, Object> child = new HashMap<>();
        Map<String, Object> att = new HashMap<>();

        child.put("text", equiChild);
        att.put("userId", userId[count]);
        child.put("attributes", att);
        children.add(child);
        count++;
      }
      user.put("children", children);

      trees.add(user);

    }

    return trees;
  }

  @PostMapping("/test/file")
  public void getFile(@RequestPart MultipartFile picFront, @RequestPart MultipartFile picBack,
      @RequestPart MultipartFile picSide) throws Exception {
    TestDto tdto = new TestDto();
    tdto.setPicBack(picBack.getBytes());
    tdto.setPicSide(picSide.getBytes());
    tdto.setPicFront(picFront.getBytes());
    System.out.println(picFront.getContentType());
    // service.testFile(tdto);
  }

  @GetMapping("/test/file/{id}/{type}")
  public void getFileImage(@PathVariable("id") String id, @PathVariable("type") String type,
      HttpServletResponse response) throws Exception {

  }

  @RequestMapping("/detail/{username}")
  public void getDetail(@PathVariable("username") String username) throws JsonProcessingException, Exception {
    Logger logger = LoggerFactory.getLogger("getDual");
    ObjectMapper om = new ObjectMapper();
    String json = om.writeValueAsString(memberService.getDetailByUserName(username));

    logger.info(json);
  }

  // Excel Generator
  @RequestMapping("/excelTest/{filename}")
  public void excelPoi(HttpServletResponse response, @RequestParam String title, WareDto wareDto) throws Exception {
    // System.out.println(request.getRequestURI());
    // logger.warn("{}", mdto);
    HSSFWorkbook objWorkBook2 = new HSSFWorkbook();
    HSSFSheet objSheet = null;
    HSSFRow objRow = null;
    HSSFCell objCell = null; // 셀 생성
    HSSFCellStyle style = objWorkBook2.createCellStyle();
    HSSFFont defaultFont = objWorkBook2.createFont();
    defaultFont.setFontHeightInPoints((short) 10);
    defaultFont.setFontName("맑은 고딕");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(true);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);

    objSheet = objWorkBook2.createSheet("관리부서 관리"); // 워크시트 생성
    // 1행
    objRow = objSheet.createRow(0);
    objRow.setHeight((short) 0x150);

    String[] titleRow = { "변동내용(구분)", "변동내용(일자)", "변동사유", "비고", "등록일자" };
    int count = 0;
    for (String i : titleRow) {
      objCell = objRow.createCell(count);
      objCell.setCellStyle(style);
      objCell.setCellValue(i);
      objSheet.setColumnWidth(0, 6800);
      count++;
    }

    List<WareDto> mlist = adminService.wareSearch(wareDto);
    int ecount = 1;
    String guName = "";
    for (WareDto wdto : mlist) {
      objRow = objSheet.createRow(ecount);
      objRow.setHeight((short) 0x150);

      objCell = objRow.createCell(0);

      objCell.setCellValue(wdto.getChgTp());
      objSheet.autoSizeColumn(0);
      objSheet.setColumnWidth(0, (objSheet.getColumnWidth(0)) + 512);

      objCell = objRow.createCell(1);
      objCell.setCellValue(wdto.getWorkDt());

      objSheet.autoSizeColumn(1);
      objSheet.setColumnWidth(1, (objSheet.getColumnWidth(1)) + 512);

      objCell = objRow.createCell(2);
      objCell.setCellValue(wdto.getChgReason());

      objSheet.autoSizeColumn(2);
      objSheet.setColumnWidth(2, (objSheet.getColumnWidth(2)) + 512);

      objCell = objRow.createCell(3);
      objCell.setCellValue(wdto.getBigo());

      objSheet.autoSizeColumn(3);
      objSheet.setColumnWidth(3, (objSheet.getColumnWidth(3)) + 512);

      objCell = objRow.createCell(4);
      objCell.setCellValue(wdto.getWorkYmd());

      objSheet.autoSizeColumn(4);
      objSheet.setColumnWidth(4, (objSheet.getColumnWidth(7)) + 512);

      ecount++;
    }

    Date today = new Date();
    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmm");

    System.out.println(wareDto.getSwHwTp());
    response.setContentType("Application/Msexcel");
    response.setHeader("Content-Disposition",
        "ATTachment; Filename=" + URLEncoder.encode(title + "_" + sf.format(today), "UTF-8") + ".xls");

    OutputStream fileOut = response.getOutputStream();
    objWorkBook2.write(fileOut);
    fileOut.close();
    objWorkBook2.close();
    response.getOutputStream().flush();
    response.getOutputStream().close();
  }

  // @RequestMapping("/ziptest")
  // public void zipTest(@RequestParam("filename") MultipartFile mFile) throws
  // Exception {
  // UnZipUtil unZipUtil = new UnZipUtil();
  // unZipUtil.unZip(unzipPath, mFile);
  // try {
  // new FileCheckUtil().getFile(path, unzipPath, adminService);
  // } catch (Exception e) {
  // System.out.println(e.getMessage());
  // }
  // }

  // json Response
  @ResponseBody
  @RequestMapping("/excelTest/read")
  public Map<String, String> excelRead() throws Exception {
    Map<String, String> json = new HashMap<>();
    json.put("a", "b");
    json.put("c", "d");
    return json;
  }
}