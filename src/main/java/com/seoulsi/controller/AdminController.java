package com.seoulsi.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.html2pdf.resolver.font.DefaultFontProvider;
import com.itextpdf.io.font.FontProgram;
import com.itextpdf.io.font.FontProgramFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.IBlockElement;
import com.itextpdf.layout.element.IElement;
import com.itextpdf.layout.font.FontProvider;
import com.seoulsi.configuration.SchedulerConfig;
import com.seoulsi.dto.CardDto;
import com.seoulsi.dto.CommonDto;
import com.seoulsi.dto.DailySenDto;
import com.seoulsi.dto.EquiDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.SensorDto;
import com.seoulsi.dto.SettingDto;
import com.seoulsi.dto.extend.ParamDto;
import com.seoulsi.service.AdminService;
import com.seoulsi.service.CommonService;
import com.seoulsi.service.SettingService;
import com.seoulsi.util.HashUtil;

/**
 * AdminController
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	SettingService settingService;

	@Autowired
	CommonService commonService;

	@Autowired
	AdminService adminService;

	@GetMapping("/card")
	public String adminIndex(Model model) throws Exception {
		List<SettingDto> lists = settingService.getGuEquiList();
		model.addAttribute("lists", lists);

		List<CommonDto> gus = commonService.guList();
		model.addAttribute("gus", gus);

		return "admin/card";
	}

	public HSSFCell setColumn(HSSFSheet sheet, HSSFRow row, String value, int index, Boolean option) {
		HSSFCell objCell = row.createCell(index);

		if (option) {
			if (index >= 9 && index <= 25) {
				try {
					if (value == "" || value.equals("") || value == null) {
					}
					objCell.setCellValue(value);
				} catch (Exception e) {
					objCell.setCellValue("N");
				}
			} else {
				objCell.setCellValue(value);
			}
		} else {
			String nullCheck = Optional.ofNullable(value).orElse("");

			if (nullCheck.equals("null")) {
				objCell.setCellValue("");
			} else {
				objCell.setCellValue(nullCheck);
			}
		}
		sheet.autoSizeColumn(index);
		sheet.setColumnWidth(index, (sheet.getColumnWidth(index)) + 512);

		return objCell;
	}

	// Excel Generator
	@RequestMapping("/card/excel/{filename}")
	public void excelCard(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("filename") String filename) throws Exception {
		System.out.println(request.getRequestURI());
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

		objSheet = objWorkBook2.createSheet("첫번째 시트"); // 워크시트 생성

		// 1행
		objRow = objSheet.createRow(0);
		objRow.setHeight((short) 0x150);

		String[] title = { "제품명", "관리번호", "센서코드", "제작년도", "제작년월", "제조사", "가로", "세로", "두께", "PM10", "PM2.5", "풍향", "풍속",
				"온도", "습도", "일산화탄소", "이산화질소", "이산화황", "암모니아", "화화수소", "오존", "조도", "흑구", "진동", "소음", "자외선", "방문자수", "기타",
				"통신방법", "전력공급", "SW Version" };
		int count = 0;
		for (String i : title) {
			objCell = objRow.createCell(count);
			objCell.setCellStyle(style);
			objCell.setCellValue(i);
			count++;
		}

		// objCell = objRow.createCell(1);
		// objCell.setCellStyle(style);
		// objCell.setCellValue("이름");
		List<CardDto> clist = adminService.getGuCardList(filename);
		int ecount = 1;
		String guName = "";
		for (CardDto cdto : clist) {

			objRow = objSheet.createRow(ecount);
			objRow.setHeight((short) 0x150);

			objCell = setColumn(objSheet, objRow, cdto.getEquiInfoKey(), 0, true);
			objCell = setColumn(objSheet, objRow, cdto.getEquiKey(), 1, true);
			objCell = setColumn(objSheet, objRow, cdto.getSerialNm(), 2, true);
			objCell = setColumn(objSheet, objRow, cdto.getInstYear(), 3, true);
			objCell = setColumn(objSheet, objRow, cdto.getInstMonth(), 4, true);
			objCell = setColumn(objSheet, objRow, cdto.getManuCom(), 5, true);
			objCell = setColumn(objSheet, objRow, cdto.getSizeWidth(), 6, true);
			objCell = setColumn(objSheet, objRow, cdto.getSizeHeight(), 7, true);
			objCell = setColumn(objSheet, objRow, cdto.getSizeThick(), 8, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorPm10(), 9, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorPm25(), 10, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorWind(), 11, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorWindSp(), 12, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorTemp(), 13, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorHumi(), 14, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorCo(), 15, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorNo2(), 16, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorSo2(), 17, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorNh3(), 18, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorH2S(), 19, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorO3(), 20, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorIllu(), 21, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorEffeTemp(), 22, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorVibr(), 23, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorNoise(), 24, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorUv(), 25, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorVisitor(), 26, true);
			objCell = setColumn(objSheet, objRow, cdto.getSensorEtc(), 27, true);
			objCell = setColumn(objSheet, objRow, cdto.getCommTp(), 28, true);
			objCell = setColumn(objSheet, objRow, cdto.getElecTp(), 29, true);
			objCell = setColumn(objSheet, objRow, cdto.getSwVersion(), 30, true);

			guName = cdto.getGuTp();
			ecount++;
		}
		if (filename.equals("25")) {
			guName = "바람길";
		}

		if (filename.equals("26")) {
			guName = "대기측정소";
		}

		Date today = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmm");
		;

		response.setContentType("Application/Msexcel");
		response.setHeader("Content-Disposition",
				"ATTachment; Filename=" + URLEncoder.encode(guName + "_" + sf.format(today), "UTF-8") + ".xls");

		OutputStream fileOut = response.getOutputStream();
		objWorkBook2.write(fileOut);
		fileOut.close();
		objWorkBook2.close();
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	@GetMapping("/ware")
	public String adminWare(Model model) throws Exception {
		List<CommonDto> one = commonService.getCCList("장비제원");
		List<CommonDto> two = commonService.getCCList("변동구분");
		model.addAttribute("one", one);
		model.addAttribute("two", two);
		return "admin/ware";
	}

	@GetMapping("/depart")
	public String adminRepair(Model model) throws Exception {

		model.addAttribute("orga", commonService.getCCList("기관"));
		model.addAttribute("team", commonService.getCCList("팀"));
		model.addAttribute("dept", commonService.getCCList("부서"));

		return "admin/depart";
	}

	@GetMapping("/cardLocation")
	public String adminCardLocation(Model model) throws Exception {
		List<SettingDto> lists = settingService.getGuEquiList();
		model.addAttribute("lists", lists);

		List<CommonDto> gus = commonService.guList();
		model.addAttribute("gus", gus);

		return "admin/cardLocation";
	}

	@GetMapping("/cardLoc/excel/{guTp}")
	public void equiLocExcel(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("guTp") String guTp) throws Exception {

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

		objSheet = objWorkBook2.createSheet("설치위치 및 주변현황"); // 워크시트 생성
		// 1행
		objRow = objSheet.createRow(0);
		objRow.setHeight((short) 0x150);

		String[] title = { "측정소명", "주소", "위치", "좌표계", "취득방법", "위도", "경도", "지면높이", "전력공급", "전면개방여부", "설치목적", "운영상태",
				"종합의견", "고정오염원 - 동(높이)", "고정오염원 - 동(안전거리)", "고정오염원 - 서(높이)", "고정오염원 - 서(안전거리)", "고정오염원 - 남(높이)",
				"고정오염원 - 남(안전거리)", "고정오염원 - 북(높이)", "고정오염원 - 북(안전거리)", "고층빌딩 - 동(높이)", "고층빌딩 - 동(안전거리)", "고층빌딩 - 서(높이)",
				"고층빌딩 - 서(안전거리)", "고층빌딩 - 남(높이)", "고층빌딩 - 남(안전거리)", "고층빌딩 - 북(높이)", "고층빌딩 - 북(안전거리)", "수목 - 동(높이)",
				"수목 - 동(안전거리)", "수목 - 서(높이)", "수목 - 서(안전거리)", "수목 - 남(높이)", "수목 - 남(안전거리)", "수목 - 북(높이)",
				"수목 - 북(안전거리)", "안전도로 - 동(높이)", "안전도로 - 동(안전거리)", "안전도로 - 서(높이)", "안전도로 - 서(안전거리)", "안전도로 - 남(높이)",
				"안전도로 - 남(안전거리)", "안전도로 - 북(높이)", "안전도로 - 북(안전거리)", "기타장애물 - 동(높이)", "기타장애물 - 동(안전거리)", "기타장애물 - 서(높이)",
				"기타장애물 - 서(안전거리)", "기타장애물 - 남(높이)", "기타장애물 - 남(안전거리)", "기타장애물 - 북(높이)", "기타장애물 - 북(안전거리)", "비고" };
		int count = 0;
		String guTpStr = "";
		for (String i : title) {
			objCell = objRow.createCell(count);
			objCell.setCellStyle(style);
			objCell.setCellValue(i);
			objSheet.setColumnWidth(0, 6800);
			count++;
		}

		List<EquiDto> elist = adminService.getCardLocExcel(guTp);
		int ecount = 1;
		String guName = "";
		String prevEqui = "";
		for (EquiDto edto : elist) {
			guTpStr = edto.getGuTp();
			if (guTp.equals("25")) {
				guTpStr = "바람길";
			}

			if (guTp.equals("26")) {
				guTpStr = "대기측정소";
			}
			String nextEqui = edto.getEquiInfoKey();

			System.out.println(String.format("PREV %s NEXT %s", prevEqui, nextEqui));
			if (!prevEqui.equals(nextEqui)) {
				objRow = objSheet.createRow(ecount);
				objRow.setHeight((short) 0x150);
				prevEqui = edto.getEquiInfoKey();
				ecount++;
			}

			objCell = setColumn(objSheet, objRow, edto.getStaName(), 0, false);
			objCell = setColumn(objSheet, objRow, edto.getInstLoc(), 1, false);
			objCell = setColumn(objSheet, objRow, edto.getEquiStru(), 2, false);
			objCell = setColumn(objSheet, objRow, edto.getSuperDeptCd(), 3, false);
			objCell = setColumn(objSheet, objRow, edto.getDeptCd(), 4, false);
			objCell = setColumn(objSheet, objRow, edto.getGpsAbb(), 5, false);
			objCell = setColumn(objSheet, objRow, edto.getGpsLat(), 6, false);
			objCell = setColumn(objSheet, objRow, edto.getMngNmJung(), 7, false);
			objCell = setColumn(objSheet, objRow, edto.getMngNmJungTel(), 8, false);
			objCell = setColumn(objSheet, objRow, edto.getMngNmBu(), 9, false);
			objCell = setColumn(objSheet, objRow, edto.getUseTp2() + ", " + edto.getUseTp3(), 10, false);
			if (edto.getUseYn().equals("Y")) {
				objCell = setColumn(objSheet, objRow, "정상가동", 11, false);
			} else {
				objCell = setColumn(objSheet, objRow, "시험가동", 11, false);
			}
			objCell = setColumn(objSheet, objRow, edto.getTotOpin(), 12, false);

			if (edto.getLocDetailTp().equals("0")) {
				objCell = setColumn(objSheet, objRow, edto.getEastRel1(), 13, false);
				objCell = setColumn(objSheet, objRow, edto.getEastRel2(), 14, false);
				objCell = setColumn(objSheet, objRow, edto.getWestRel1(), 15, false);
				objCell = setColumn(objSheet, objRow, edto.getWestRel2(), 16, false);
				objCell = setColumn(objSheet, objRow, edto.getSouthRel1(), 17, false);
				objCell = setColumn(objSheet, objRow, edto.getSouthRel2(), 18, false);
				objCell = setColumn(objSheet, objRow, edto.getNorthRel1(), 19, false);
				objCell = setColumn(objSheet, objRow, edto.getNorthRel2(), 20, false);
			}

			if (edto.getLocDetailTp().equals("1")) {
				objCell = setColumn(objSheet, objRow, edto.getEastRel1(), 21, false);
				objCell = setColumn(objSheet, objRow, edto.getEastRel2(), 22, false);
				objCell = setColumn(objSheet, objRow, edto.getWestRel1(), 23, false);
				objCell = setColumn(objSheet, objRow, edto.getWestRel2(), 24, false);
				objCell = setColumn(objSheet, objRow, edto.getSouthRel1(), 25, false);
				objCell = setColumn(objSheet, objRow, edto.getSouthRel2(), 26, false);
				objCell = setColumn(objSheet, objRow, edto.getNorthRel1(), 27, false);
				objCell = setColumn(objSheet, objRow, edto.getNorthRel2(), 28, false);
			}

			if (edto.getLocDetailTp().equals("2")) {
				objCell = setColumn(objSheet, objRow, edto.getEastRel1(), 29, false);
				objCell = setColumn(objSheet, objRow, edto.getEastRel2(), 30, false);
				objCell = setColumn(objSheet, objRow, edto.getWestRel1(), 31, false);
				objCell = setColumn(objSheet, objRow, edto.getWestRel2(), 32, false);
				objCell = setColumn(objSheet, objRow, edto.getSouthRel1(), 33, false);
				objCell = setColumn(objSheet, objRow, edto.getSouthRel2(), 34, false);
				objCell = setColumn(objSheet, objRow, edto.getNorthRel1(), 35, false);
				objCell = setColumn(objSheet, objRow, edto.getNorthRel2(), 36, false);
			}

			if (edto.getLocDetailTp().equals("3")) {
				objCell = setColumn(objSheet, objRow, edto.getEastRel1(), 37, false);
				objCell = setColumn(objSheet, objRow, edto.getEastRel2(), 38, false);
				objCell = setColumn(objSheet, objRow, edto.getWestRel1(), 39, false);
				objCell = setColumn(objSheet, objRow, edto.getWestRel2(), 40, false);
				objCell = setColumn(objSheet, objRow, edto.getSouthRel1(), 41, false);
				objCell = setColumn(objSheet, objRow, edto.getSouthRel2(), 42, false);
				objCell = setColumn(objSheet, objRow, edto.getNorthRel1(), 43, false);
				objCell = setColumn(objSheet, objRow, edto.getNorthRel2(), 44, false);
			}

			if (edto.getLocDetailTp().equals("4")) {
				objCell = setColumn(objSheet, objRow, edto.getEastRel1(), 45, false);
				objCell = setColumn(objSheet, objRow, edto.getEastRel2(), 46, false);
				objCell = setColumn(objSheet, objRow, edto.getWestRel1(), 47, false);
				objCell = setColumn(objSheet, objRow, edto.getWestRel2(), 48, false);
				objCell = setColumn(objSheet, objRow, edto.getSouthRel1(), 49, false);
				objCell = setColumn(objSheet, objRow, edto.getSouthRel2(), 50, false);
				objCell = setColumn(objSheet, objRow, edto.getNorthRel1(), 51, false);
				objCell = setColumn(objSheet, objRow, edto.getNorthRel2(), 52, false);
			}

			objCell = setColumn(objSheet, objRow, edto.getBigo(), 53, false);
		}

		Date today = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmm");

		response.setContentType("Application/Msexcel");
		response.setHeader("Content-Disposition", "ATTachment; Filename="
				+ URLEncoder.encode("설치위치 및 주변 현황" + "_" + guTpStr + "_" + sf.format(today), "UTF-8") + ".xls");

		OutputStream fileOut = response.getOutputStream();
		objWorkBook2.write(fileOut);
		fileOut.close();
		objWorkBook2.close();
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	@GetMapping("/cardMap")
	public String adminCardMap() {

		return "admin/cardMap";
	}

	@GetMapping("/trouble")
	public String adminTrouble() {
		return "admin/trouble";
	}

	@GetMapping("/trouble_write")
	public String adminTroubleWrite() {
		return "admin/trouble_write";
	}

	// 유저등록
	@GetMapping("/user")
	public String settingUser(Model model) throws Exception {
		List<MemberDto> lists = settingService.getUserCode();
		List<CommonDto> parts = commonService.partList();
		model.addAttribute("lists", lists);
		model.addAttribute("parts", parts);
		return "admin/user";
	}

	// 장비등록
	@GetMapping("/equi")
	public String settingEqui(Model model) throws Exception {
		List<CommonDto> gus = commonService.guList();
		model.addAttribute("gus", gus);
		return "admin/equi";
	}

	// Excel Generator
	@RequestMapping("/equi/excel/{filename}")
	public void excelPoi(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("filename") String filename) throws Exception {
		System.out.println(request.getRequestURI());
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

		objSheet = objWorkBook2.createSheet("첫번째 시트"); // 워크시트 생성

		// 1행
		objRow = objSheet.createRow(0);
		objRow.setHeight((short) 0x150);

		String[] title = { "기기종류", "스테이션명", "센서코드", "위도", "경도", "센서타입", "용도1", "용도2", "용도3", "설치년도", "설치월", "관리번호",
				"행정구", "도로명", "행정명", "설치여부", "완료여부", "바람길여부", "관리번호", "센터명", "대기측정소여부", "관리번호", "방문자센서코드", "방문자 센서명" };
		int count = 0;
		for (String i : title) {
			objCell = objRow.createCell(count);
			objCell.setCellStyle(style);
			objCell.setCellValue(i);
			count++;
		}

		// objCell = objRow.createCell(1);
		// objCell.setCellStyle(style);
		// objCell.setCellValue("이름");
		List<EquiDto> elist = adminService.getGuEquiList(filename);
		int ecount = 1;
		String guName = "";
		for (EquiDto edto : elist) {
			System.out.println(edto.getEquiInfoKey());

			objRow = objSheet.createRow(ecount);
			objRow.setHeight((short) 0x150);

			objCell = objRow.createCell(0);
			objCell.setCellValue(edto.getEquiType());
			objCell = objRow.createCell(1);
			objCell.setCellValue(edto.getStaName());
			objCell = objRow.createCell(2);
			objCell.setCellValue(edto.getEquiInfoKey());
			objCell = objRow.createCell(3);
			objCell.setCellValue(edto.getGpsAbb());
			objCell = objRow.createCell(4);
			objCell.setCellValue(edto.getGpsLat());
			objCell = objRow.createCell(5);
			objCell.setCellValue(edto.getSenseTp());
			objCell = objRow.createCell(6);
			objCell.setCellValue(edto.getUseTp1());
			objCell = objRow.createCell(7);
			objCell.setCellValue(edto.getUseTp2());
			objCell = objRow.createCell(8);
			objCell.setCellValue(edto.getUseTp3());
			objCell = objRow.createCell(9);
			objCell.setCellValue(edto.getInstYear());
			objCell = objRow.createCell(10);
			objCell.setCellValue(edto.getInstMonth() + "월");
			objCell = objRow.createCell(11);
			objCell.setCellValue(edto.getMngNum());
			objCell = objRow.createCell(12);
			objCell.setCellValue(edto.getGuTp());

			objCell = objRow.createCell(13);
			objCell.setCellValue(edto.getInstLoc());

			objCell = objRow.createCell(14);
			objCell.setCellValue(edto.getInstLoc2());

			objCell = objRow.createCell(15);
			objCell.setCellValue(edto.getSetYn());
			objCell = objRow.createCell(16);
			objCell.setCellValue(edto.getUseYn());
			objCell = objRow.createCell(17);
			objCell.setCellValue(edto.getBaramYn());
			objCell = objRow.createCell(18);
			objCell.setCellValue(edto.getBaramMngNum());
			objCell = objRow.createCell(19);
			objCell.setCellValue(edto.getBaramNm());
			objCell = objRow.createCell(20);
			objCell.setCellValue(edto.getAirYn());
			objCell = objRow.createCell(21);
			objCell.setCellValue(edto.getAirMngNum());
			objCell = objRow.createCell(22);
			objCell.setCellValue(edto.getVistorSenId());
			objCell = objRow.createCell(23);
			objCell.setCellValue(edto.getVistorSenViewNm());

			guName = edto.getGuTp();
			ecount++;
		}
		if (filename.equals("25")) {
			guName = "바람길";
		}

		if (filename.equals("26")) {
			guName = "대기측정소";
		}

		Date today = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmm");
		;

		response.setContentType("Application/Msexcel");
		response.setHeader("Content-Disposition",
				"ATTachment; Filename=" + URLEncoder.encode(guName + "_" + sf.format(today), "UTF-8") + ".xls");

		OutputStream fileOut = response.getOutputStream();
		objWorkBook2.write(fileOut);
		fileOut.close();
		objWorkBook2.close();
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	// 보정데이터
	@GetMapping("/correction")
	public String correction(Model model) throws Exception {
		List<CommonDto> gus = commonService.guList();

		model.addAttribute("gus", gus);
		return "admin/correction";
	}

}