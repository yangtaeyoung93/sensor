package com.seoulsi.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.seoulsi.dto.AdminDto;
import com.seoulsi.dto.AdminInsertDto;
import com.seoulsi.dto.CardDto;
import com.seoulsi.dto.EquLoc;
import com.seoulsi.dto.EquLocDetail;
import com.seoulsi.dto.EquLocPic;
import com.seoulsi.dto.EquiDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.MenuDto;
import com.seoulsi.dto.MngDeptDto;
import com.seoulsi.dto.extend.ParamDto;
import com.seoulsi.dto.PropertiesDto;
import com.seoulsi.dto.ResultDto;
import com.seoulsi.dto.SettingDto;
import com.seoulsi.dto.WareDto;
import com.seoulsi.service.AdminService;
import com.seoulsi.service.CommonService;
import com.seoulsi.service.LoginService;
import com.seoulsi.service.SettingService;
import com.seoulsi.util.AES256Util;
import com.seoulsi.util.DateUtil;
import com.seoulsi.util.HashUtil;
import com.seoulsi.util.MybatisUtil;

@RequestMapping("/api/admin")
@RestController
public class AdminRestController {
	Logger logger = LoggerFactory.getLogger(AdminRestController.class);

	@Autowired
	AdminService adminService;

	@Autowired
	SettingService settingService;

	@Autowired
	CommonService commonService;

	@Autowired
	LoginService loginService;

	@Autowired
	private PropertiesDto pdto;

	@Value("${file.upload-path}")
	private String path;

	@Value("${init.passwd}")
	private String passwd;

	@GetMapping("/guEqui")
	public List<Map<String, Object>> getGuEqui() throws Exception {
		List<SettingDto> lists = settingService.getGuEquiList();
		List<Map<String, Object>> trees = new ArrayList<>();

		for (SettingDto sdto : lists) {
			String equiList = sdto.getEqui();
			String[] equiArr = equiList.split(",");
			System.out.println(equiArr);
			Map<String, Object> equi = new HashMap<>();

			equi.put("text", sdto.getGu());
			equi.put("state", "closed");
			List<Map<String, Object>> children = new ArrayList<>();
			for (String equiChild : equiArr) {
				Map<String, Object> child = new HashMap<>();
				child.put("text", equiChild);
				children.add(child);
			}
			equi.put("children", children);

			trees.add(equi);

		}

		return trees;
	}

	@GetMapping("/getUser")
	@CrossOrigin(methods = { RequestMethod.GET })
	public List<Map<String, Object>> getUser() throws Exception {
		List<MemberDto> lists = settingService.getUserCode();
		List<Map<String, Object>> trees = new ArrayList<>();
		AES256Util aes = new AES256Util(pdto.getPassPhraseDB());

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

				child.put("text", aes.decrypt(equiChild) + "(" + aes.decrypt(userId[count]) + ")");
				att.put("userId", aes.decrypt(userId[count]));
				child.put("attributes", att);
				children.add(child);
				count++;
			}
			user.put("children", children);

			trees.add(user);

		}

		return trees;
	}

	@GetMapping("/equiCommon")
	public Map<String, Object> equiCommon() throws Exception {

		Map<String, Object> list = new HashMap<>();

		list.put("data", settingService.getCommList());

		return list;
	}

	@PostMapping("/adminList")
	public Map<String, Object> adminList(@RequestParam(value = "toDate") String toDate,
			@RequestParam(value = "fromDate") String fromDate, @RequestParam(value = "pageStart") String pageStart)
			throws Exception {

		AdminDto data = new AdminDto();
		data.setToDate(toDate);
		data.setFromDate(fromDate);

		data.setPageStart(String.valueOf(pageStart));
		int pageCount = 50;
		int startPage = (Integer.parseInt(pageStart) - 1) * pageCount + 1;
		int pageEnd = Integer.parseInt(pageStart) * pageCount;

		data.setPageStart(String.valueOf(startPage));
		data.setPageEnd(String.valueOf(pageEnd));

		Map<String, Object> json = new HashMap<>();
		json.put("data", adminService.adminList(data));
		return json;
	}

	@PostMapping("/modal")
	public Map<String, Object> modal(@RequestParam(value = "obst_text") String obsttext,
			@RequestParam(value = "obst_mgr_key") String obstmgr, @RequestParam(value = "obst_model") String obstmodel,
			@RequestParam(value = "obst_reco_date") String obstrecodate,
			@RequestParam(value = "obst_reco_text") String obstrecotext,
			@RequestParam(value = "obst_reco_comp") String obstrecocomp,
			@RequestParam(value = "obst_reco_man") String obstrecoman,
			@RequestParam(value = "obst_file_root") String obstfileroot,
			@RequestParam(value = "obst_date") String obstdate) throws Exception {

		AdminInsertDto data = new AdminInsertDto();
		data.setObstText(obsttext);
		data.setObstMgrKey(obstmgr);
		data.setObstModel(obstmodel);
		data.setObstRecoDate(obstrecodate);
		data.setObstRecoText(obstrecotext);
		data.setObstRecoComp(obstrecocomp);
		data.setObstRecoMan(obstrecoman);
		data.setObstFileRoot(obstfileroot);
		data.setObstDate(obstdate);

		Map<String, Object> json = new HashMap<>();
		json.put("data", adminService.modal(data));
		return json;
	}

	@GetMapping("/equi/info/{equiInfoKey}")
	public Map<String, Object> equiInfo(@PathVariable String equiInfoKey) throws Exception {

		Map<String, Object> info = new HashMap<>();

		info.put("data", settingService.getEquiInfo(equiInfoKey));
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		System.out.println(authentication);
		return info;
	}

	@PostMapping("/equi/save")
	public ResultDto equiInfoSave(EquiDto edto) throws Exception {

		System.out.println(edto);
		ResultDto rdto = new ResultDto();
		try {
			settingService.saveEquiInfo(edto);
			rdto.setMsg("저장되었습니다");
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setMsg("실패하였습니다");
			rdto.setResult("fail");
		}

		return rdto;
	}

	@PostMapping("/equi/insert")
	public ResultDto insertEquiInfo(EquiDto edto) throws Exception {
		ResultDto rdto = new ResultDto();

		try {
			settingService.insertEquiInfo(edto);
			rdto.setMsg("추가되었습니다");
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setMsg(e.getMessage());
			rdto.setResult("fail");
		}

		return rdto;
	}

	@PostMapping("/equi/remove")
	public ResultDto deleteEquiByEquiInfoKey(EquiDto edto) throws Exception {
		ResultDto rdto = new ResultDto();

		try {
			settingService.deleteEquiByEquiInfoKey(edto);
			settingService.deleteCardByEquiInfoKey(edto);
			settingService.deleteLocByEquiInfoKey(edto);
			settingService.deleteLocDetailByEquiInfoKey(edto);
			settingService.deleteLocPicByEquiInfoKey(edto);
			rdto.setMsg("삭제되었습니다");
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setMsg(e.getMessage());
			rdto.setResult("fail");
		}

		return rdto;
	}

	@GetMapping("/user/info/{user}")
	public Map<String, Object> getUserInfo(@PathVariable String user) throws Exception {

		Map<String, Object> info = new HashMap<>();
		AES256Util aes = new AES256Util(pdto.getPassPhraseDB());
		List<MemberDto> lm = new ArrayList<>();
		for (MemberDto memberdto : settingService.getUserInfo(aes.encrypt(user))) {
			MemberDto mdto = new MemberDto();
			if (Float.parseFloat(loginService.getChangeDate(memberdto.getUserId()).getRegDate()) > 90) {
				mdto.setRegDate("change");
			}
			mdto.setUserId(aes.decrypt(memberdto.getUserId()));
			mdto.setUserName(aes.decrypt(memberdto.getUserName()));
			mdto.setEmailAddr(aes.decrypt(memberdto.getEmailAddr()));
			mdto.setHandPhone(aes.decrypt(memberdto.getHandPhone()));
			mdto.setTelNo(aes.decrypt(memberdto.getTelNo()));
			mdto.setDeptCd(memberdto.getDeptCd());
			mdto.setEtc(memberdto.getEtc());

			lm.add(mdto);
		}

		info.put("data", lm);

		System.out.println("data 값 : " + info);

		return info;
	}

	@PostMapping("/user/save")
	public ResultDto saveUser(MemberDto memberdto) throws Exception {
		ResultDto rdto = new ResultDto();
		AES256Util aes = new AES256Util(pdto.getPassPhraseDB());
		try {
			MemberDto mdto = new MemberDto();
			mdto.setUserId(aes.encrypt(memberdto.getUserId()));
			mdto.setEmailAddr(aes.encrypt(memberdto.getEmailAddr()));
			mdto.setHandPhone(aes.encrypt(memberdto.getHandPhone()));
			mdto.setTelNo(aes.encrypt(memberdto.getTelNo()));
			mdto.setDeptCd(memberdto.getDeptCd());
			mdto.setEtc(memberdto.getEtc());
			settingService.updateUser(mdto);
			rdto.setMsg("저장되었습니다");
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setMsg(e.getMessage());
			rdto.setResult("fail");
		}

		return rdto;
	}

	@GetMapping("/user/clear/{userId}")
	public ResultDto clearUser(@PathVariable String userId, HttpServletRequest req) throws Exception {
		ResultDto rdto = new ResultDto();
		AES256Util aes = new AES256Util(pdto.getPassPhraseDB());
		MemberDto mdto = new MemberDto();

		try {
			mdto.setUserId(aes.encrypt(userId));
			mdto.setUserPw(HashUtil.sha256(userId + passwd));
			settingService.clearUser(mdto);
			rdto.setMsg("초기화되었습니다");
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setMsg(e.getMessage());
			rdto.setResult("fail");
		}

		return rdto;
	}

	@GetMapping("/user/code/{code}")
	public Map<String, Object> getMemberByCode(@PathVariable String code) throws Exception {
		Map<String, Object> info = new HashMap<>();
		List<MemberDto> lm = new ArrayList<>();
		AES256Util aes = new AES256Util(pdto.getPassPhraseDB());

		for (MemberDto memberdto : settingService.getUserByCode(code)) {
			MemberDto mdto = new MemberDto();
			mdto.setUserId(aes.decrypt(memberdto.getUserId()));
			mdto.setUserName(aes.decrypt(memberdto.getUserName()));
			mdto.setEmailAddr(aes.decrypt(memberdto.getEmailAddr()));
			mdto.setHandPhone(aes.decrypt(memberdto.getHandPhone()));
			mdto.setTelNo(aes.decrypt(memberdto.getTelNo()));
			mdto.setCode(memberdto.getCode());
			mdto.setEtc(memberdto.getEtc());

			lm.add(mdto);
		}

		info.put("data", lm);
		return info;
	}

	@PostMapping("/user/insert")
	public ResultDto insertUser(MemberDto memberdto) throws Exception {
		ResultDto rdto = new ResultDto();
		MemberDto mdto = new MemberDto();

		AES256Util aes = new AES256Util(pdto.getPassPhraseDB());

		mdto.setUserId(aes.encrypt(memberdto.getUserId()));
		mdto.setUserName(aes.encrypt(memberdto.getUserName()));
		mdto.setEmailAddr(aes.encrypt(memberdto.getEmailAddr()));
		mdto.setHandPhone(aes.encrypt(memberdto.getHandPhone()));
		mdto.setTelNo(aes.encrypt(memberdto.getTelNo()));
		mdto.setUserPw(HashUtil.sha256(memberdto.getUserPw()));
		mdto.setDeptCd(memberdto.getDeptCd());
		mdto.setEtc(memberdto.getEtc());

		logger.info("{}/ {}", mdto, mdto.getUserName(), mdto.getHandPhone());
		try {
			settingService.insertUser(mdto);
			for (MenuDto medto : commonService.getMenuId()) {
				medto.setUserId(mdto.getUserId());
				logger.info("{}", medto);

				commonService.insertGrantMenu(medto);
			}
			rdto.setMsg("추가되었습니다");
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setMsg(e.getMessage());
			rdto.setResult("fail");
		}
		//
		return rdto;
	}

	@PostMapping("/user/delete")
	public ResultDto deleteUser(MemberDto memberDto) throws Exception {
		ResultDto rdto = new ResultDto();
		AES256Util aes = new AES256Util(pdto.getPassPhraseDB());
		memberDto.setUserId(aes.encrypt(memberDto.getUserId()));
		try {
			settingService.deleteUser(memberDto);
			settingService.deleteUserGrant(memberDto);
			rdto.setResult("success");
			rdto.setMsg("삭제되었습니다");
		} catch (Exception e) {
			rdto.setResult("fail");
			rdto.setMsg("오류가 발생하였습니다.");
		}

		return rdto;
	}

	@PostMapping("/card/update")
	public ResultDto cardUpdate(CardDto cdto) throws Exception {
		ResultDto rdto = new ResultDto();
		logger.info(":::::::::::::::::::{}", cdto);
		cdto.setEquiInfoKey(cdto.getSerialNm());
		adminService.cardInfoUpdate(cdto);
		return rdto;
	}

	@PostMapping("/cardExcel")
	public Boolean cardExcel(@RequestParam("filename") MultipartFile mFile) throws Exception {
		try {
			XSSFWorkbook workbook = new XSSFWorkbook(mFile.getInputStream());

			int rowindex = 0;
			int columnindex = 0;
			// 시트 수 (첫번째에만 존재하므로 0을 준다)
			// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
			XSSFSheet sheet = workbook.getSheetAt(0);
			// 행의 수
			int rows = sheet.getPhysicalNumberOfRows();
			List<CardDto> wlist = new ArrayList<>();
			for (rowindex = 0; rowindex < rows; rowindex++) {
				// 행을읽는다
				XSSFRow row = sheet.getRow(rowindex);
				CardDto cdto = new CardDto();
				if (row != null) {
					// 셀의 수
					int cells = sheet.getRow(0).getPhysicalNumberOfCells();
					;
					for (columnindex = 0; columnindex <= cells; columnindex++) {
						// 셀값을 읽는다
						XSSFCell cell = row.getCell(columnindex);
						String value = "";
						// 셀이 빈값일경우를 위한 널체크

						if (cell == null) {
							value = "";
						} else {
							// 타입별로 내용 읽기
							switch (cell.getCellType()) {
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								if (columnindex == 3 || columnindex == 4) {
									value = cell.getNumericCellValue() + "";
								} else {
									value = (int) cell.getNumericCellValue() + "";
								}
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = cell.getBooleanCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = cell.getErrorCellValue() + "";
								break;
							}
						}
						if (rowindex != 0) {
							switch (columnindex) {
							case 0:
								cdto.setEquiInfoKey(value);
								break;
							case 1:
								cdto.setManuCom(value);
								break;
							case 2:
								cdto.setSizeWidth(value);
								break;
							case 3:
								cdto.setSizeHeight(value);
								break;
							case 4:
								cdto.setSizeThick(value);
								break;
							case 5:
								cdto.setSensorPm10(value);
								break;
							case 6:
								cdto.setSensorPm25(value);
								break;
							case 7:
								cdto.setSensorWind(value);
								break;
							case 8:
								cdto.setSensorWindSp(value);
								break;
							case 9:
								cdto.setSensorTemp(value);
								break;
							case 10:
								cdto.setSensorHumi(value);
								break;
							case 11:
								cdto.setSensorCo(value);
								break;
							case 12:
								cdto.setSensorNo2(value);
								break;
							case 13:
								cdto.setSensorSo2(value);
								break;
							case 14:
								cdto.setSensorNh3(value);
								break;
							case 15:
								cdto.setSensorH2S(value);
								break;
							case 16:
								cdto.setSensorO3(value);
								break;
							case 17:
								cdto.setSensorIllu(value);
								break;
							case 18:
								cdto.setSensorEffeTemp(value);
								break;
							case 19:
								cdto.setSensorVibr(value);
								break;
							case 20:
								cdto.setSensorNoise(value);
								break;
							case 21:
								cdto.setSensorUv(value);
								break;
							case 22:
								cdto.setSensorVisitor(value);
								break;
							case 23:
								cdto.setSensorEtc(value);
								break;
							case 24:
								cdto.setCommTp(value);
								break;
							case 25:
								cdto.setElecTp(value);
								break;
							case 26:
								cdto.setSwVersion(value);
								break;
							}

							System.out.println(rowindex + "번 행 : " + columnindex + "값은: " + value + " / ");
						}
					}

				}
				if (rowindex != 0) {
					logger.warn("{}", cdto);
					wlist.add(cdto);
				}
			}
			adminService.cardInfoUpdateExcel(wlist);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@GetMapping("/card/info/{equiInfoKey}")
	public Map<String, Object> cardInfo(@PathVariable String equiInfoKey) throws Exception {

		Map<String, Object> info = new HashMap<>();
		CardDto cdto = adminService.cardInfo(equiInfoKey);
		info.put("data", cdto);
		return info;
	}
	// @GetMapping("/card/file/{id}/{type}")
	// public void getFileImage(@PathVariable("id") String id, @PathVariable("type")
	// String type, HttpServletResponse response) throws Exception {
	// InputStream is = null;
	//
	// CardDto tdto = adminService.getCardFile(id);
	// byte[] file = null;
	// String contentType = null;
	//
	// switch(type) {
	// case "back" : file = tdto.getPicBack(); contentType= tdto.getPicBackTp();
	// break;
	// case "front" : file = tdto.getPicFront(); contentType= tdto.getPicFrontTp();
	// break;
	// case "side" : file = tdto.getPicSide(); contentType= tdto.getPicSideTp();
	// break;
	// }
	// is = new ByteArrayInputStream(file);
	// response.setContentType(contentType);
	//
	// ServletOutputStream os = response.getOutputStream();
	// int binaryRead;
	//
	// while ((binaryRead = is.read()) != -1) {
	// os.write(binaryRead);
	// }
	// }

	@PostMapping("/card/file")
	public void getFile(@RequestPart String serialNm, @RequestPart MultipartFile picFront,
			@RequestPart MultipartFile picBack, @RequestPart MultipartFile picSide) throws Exception {
		CardDto cdto = new CardDto();
		System.out.println(serialNm);
		cdto.setEquiInfoKey(serialNm);
		String pathSet = path + "/" + serialNm;

		String PicFront = "";
		String PicSide = "";
		String PicBack = "";
		Boolean flag = false;
		if (picFront != null) {
			PicFront = "PicFront";
			MybatisUtil.saveFile(picFront.getBytes(),
					pathSet + "/PicFront." + MybatisUtil.splitFileName(picFront.getContentType()));
			cdto.setPicFront(PicFront);
			cdto.setPicFrontTp(MybatisUtil.splitFileName(picFront.getContentType()));
			flag = true;
		}
		if (picSide != null) {
			PicSide = "PicFront";
			MybatisUtil.saveFile(picSide.getBytes(),
					pathSet + "/PicSide." + MybatisUtil.splitFileName(picSide.getContentType()));
			cdto.setPicSide(PicSide);
			cdto.setPicSideTp(MybatisUtil.splitFileName(picSide.getContentType()));
			flag = true;
		}
		if (picBack != null) {
			PicBack = "PicBack";
			MybatisUtil.saveFile(picBack.getBytes(),
					pathSet + "/PicBack." + MybatisUtil.splitFileName(picBack.getContentType()));
			cdto.setPicBack(PicBack);
			cdto.setPicBackTp(MybatisUtil.splitFileName(picBack.getContentType()));
			flag = true;
		}
		System.out.println(flag);
		if (flag) {
			adminService.cardFileSide(cdto);
		}
	}

	@PostMapping("/cardLoc/file")
	public ResultDto getCardLocFile(@RequestPart String equiInfoKey, @RequestPart MultipartFile equiInsLoc,
			@RequestPart MultipartFile equiArdWest, @RequestPart MultipartFile equiArdEast,
			@RequestPart MultipartFile equiArdSouth, @RequestPart MultipartFile equiArdNorth,
			@RequestPart MultipartFile instBefFrt, @RequestPart MultipartFile instBefBack,
			@RequestPart MultipartFile instAftFrt, @RequestPart MultipartFile instAftBack) throws Exception {
		String pathSet = path + "/" + equiInfoKey;
		File dir = new File(path);
		if (!dir.isDirectory()) {
			dir.mkdir();
		}

		if (!new File(pathSet).exists()) {
			new File(pathSet).mkdirs();
		}

		String EquiArdWest = "";
		String EquiArdEast = "";
		String EquiArdSouth = "";
		String EquiArdNorth = "";
		String InstBefFrt = "";
		String InstBefBack = "";
		String InstAftFrt = "";
		String InstAftBack = "";
		String EquiInsLoc = "";
		if (equiArdWest != null) {
			EquiArdWest = "EquiArdWest";
			MybatisUtil.saveFile(equiArdWest.getBytes(),
					pathSet + "/EquiArdWest." + MybatisUtil.splitFileName(equiArdWest.getContentType()));
		}
		if (equiArdEast != null) {
			EquiArdEast = "EquiArdEast";
			MybatisUtil.saveFile(equiArdEast.getBytes(),
					pathSet + "/EquiArdEast." + MybatisUtil.splitFileName(equiArdEast.getContentType()));
		}
		if (equiArdSouth != null) {
			EquiArdSouth = "EquiArdSouth";
			MybatisUtil.saveFile(equiArdSouth.getBytes(),
					pathSet + "/EquiArdSouth." + MybatisUtil.splitFileName(equiArdSouth.getContentType()));
		}
		if (equiArdNorth != null) {
			EquiArdNorth = "EquiArdNorth";
			MybatisUtil.saveFile(equiArdNorth.getBytes(),
					pathSet + "/EquiArdNorth." + MybatisUtil.splitFileName(equiArdNorth.getContentType()));
		}
		if (instBefFrt != null) {
			InstBefFrt = "InstBefFrt";
			MybatisUtil.saveFile(instBefFrt.getBytes(),
					pathSet + "/InstBefFrt." + MybatisUtil.splitFileName(instBefFrt.getContentType()));
		}
		if (instBefBack != null) {
			InstBefBack = "InstBefBack";
			MybatisUtil.saveFile(instBefBack.getBytes(),
					pathSet + "/InstBefBack." + MybatisUtil.splitFileName(instBefBack.getContentType()));
		}
		if (instAftFrt != null) {
			InstAftFrt = "InstAftFrt";
			MybatisUtil.saveFile(instAftFrt.getBytes(),
					pathSet + "/InstAftFrt." + MybatisUtil.splitFileName(instAftFrt.getContentType()));
		}
		if (instAftBack != null) {
			InstAftBack = "InstAftBack";
			MybatisUtil.saveFile(instAftBack.getBytes(),
					pathSet + "/InstAftBack." + MybatisUtil.splitFileName(instAftBack.getContentType()));
		}
		if (equiInsLoc != null) {
			EquiInsLoc = "EquiInsLoc";
			MybatisUtil.saveFile(equiInsLoc.getBytes(),
					pathSet + "/EquiInsLoc." + MybatisUtil.splitFileName(equiInsLoc.getContentType()));
		}
		ResultDto rdto = new ResultDto();
		rdto.setResult("success");
		rdto.setMsg("success");
		EquLocPic epdto = new EquLocPic();
		epdto.setEquiInfoKey(equiInfoKey);
		epdto.setEquiInsLoc("EquiInsLoc");
		epdto.setEquiInsLocTp(MybatisUtil.splitFileName(equiInsLoc.getContentType()));
		epdto.setEquiArdWest("EquiArdWest");
		epdto.setEquiArdWestTp(MybatisUtil.splitFileName(equiArdWest.getContentType()));
		epdto.setEquiArdEast("EquiArdEast");
		epdto.setEquiArdEastTp(MybatisUtil.splitFileName(equiArdEast.getContentType()));
		epdto.setEquiArdSouth("EquiArdSouth");
		epdto.setEquiArdSouthTp(MybatisUtil.splitFileName(equiArdSouth.getContentType()));
		epdto.setEquiArdNorth("EquiArdNorth");
		epdto.setEquiArdNorthTp(MybatisUtil.splitFileName(equiArdNorth.getContentType()));
		epdto.setInstBefFrt("InstBefFrt");
		epdto.setInstBefFrtTp(MybatisUtil.splitFileName(instBefFrt.getContentType()));
		epdto.setInstBefBack("InstBefBack");
		epdto.setInstBefBackTp(MybatisUtil.splitFileName(instBefBack.getContentType()));
		epdto.setInstAftFrt("InstAftFrt");
		epdto.setInstAftFrtTp(MybatisUtil.splitFileName(instAftFrt.getContentType()));
		epdto.setInstAftBack("InstAftBack");
		epdto.setInstAftBackTp(MybatisUtil.splitFileName(instAftBack.getContentType()));
		logger.info("{}", epdto);
		adminService.equiCardImgUpdate(epdto);
		return rdto;
	}

	@GetMapping("/cardLoc/img/{equiInfoKey}")
	public Map<String, EquLocPic> getCardImgSelect(@PathVariable String equiInfoKey) throws Exception {
		Map<String, EquLocPic> data = new HashMap<>();
		data.put("data", adminService.equiCardImgSelect(equiInfoKey));
		return data;
	}

	@GetMapping("/cardLoc/img/{equi}/{type}")
	public ResponseEntity<byte[]> getCardImgType(@PathVariable String equi, @PathVariable String type)
			throws IOException {
		InputStream f = new FileInputStream(path + "/" + equi + "/" + type);
		File file = new File(path + "/" + equi + "/" + type);

		HttpHeaders headers = new HttpHeaders();
		String mime = new MimetypesFileTypeMap().getContentType(file);
		MediaType mt = null;
		if (mime.contains("jpeg")) {
			mt = MediaType.IMAGE_JPEG;
		}
		if (mime.contains("png")) {
			mt = MediaType.IMAGE_PNG;
		}
		if (mime.contains("gif")) {
			mt = MediaType.IMAGE_GIF;
		}
		headers.setContentType(mt);

		return new ResponseEntity<byte[]>(IOUtils.toByteArray(f), headers, HttpStatus.CREATED);
	}

	@GetMapping("/cardLoc/{equiInfoKey}")
	public List<EquiDto> equiLoc(@PathVariable("equiInfoKey") String equiInfoKey) throws Exception {
		List<EquiDto> equi = adminService.getCardLoc(equiInfoKey);
		for (EquiDto e : equi) {
			logger.info(e.getEquiInfoKey());
		}
		return equi;
	}

	@PostMapping("/leftCardInsert")
	public ResultDto equiLoc(EquiDto edto) throws Exception {
		ResultDto rdto = new ResultDto();

		try {
			adminService.updateLoc(edto);
			rdto.setMsg("success");
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setResult("fail");
			rdto.setResult("fail");

		}
		return rdto;
	}

	@PostMapping("/rightCardInsert")
	public ResultDto equiLocDetail(EquLoc edto) throws Exception {
		ResultDto rdto = new ResultDto();
		logger.info("{}", edto);
		try {
			adminService.updateLocDetail(edto);
			rdto.setMsg("success");
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setResult("fail");
			rdto.setMsg("fail");

		}
		return rdto;
	}

	// 20201019 Excel test
	@PostMapping("/cardLocExcel")
	public Boolean cardLocExcel(@RequestParam("filename") MultipartFile mFile) throws Exception {
		try {
			XSSFWorkbook workbook = new XSSFWorkbook(mFile.getInputStream());

			int rowindex = 0;
			int columnindex = 0;
			// 시트 수 (첫번째에만 존재하므로 0을 준다)
			// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
			XSSFSheet sheet = workbook.getSheetAt(0);
			// 행의 수
			int rows = sheet.getPhysicalNumberOfRows();

			// child List
			Map<String, EquLocDetail> relMap = new HashMap<>();

			// leftCard + rightCard
			// key = equiInfoKey
			Map<String, Object> resultMap = new HashMap<>();

			for (rowindex = 0; rowindex < rows; rowindex++) {
				// 행을읽는다
				Map<String, Object> listMap = new HashMap<>();
				XSSFRow row = sheet.getRow(rowindex);
				// 0~7까지
				EquiDto equiDto = new EquiDto();
				// 8~51
				EquLocDetail locDto = new EquLocDetail();
				EquLocDetail locDto1 = new EquLocDetail();
				EquLocDetail locDto2 = new EquLocDetail();
				EquLocDetail locDto3 = new EquLocDetail();
				EquLocDetail locDto4 = new EquLocDetail();
				if (row != null) {
					// 셀의 수
					int cells = sheet.getRow(0).getPhysicalNumberOfCells();
					;
					for (columnindex = 0; columnindex <= cells; columnindex++) {
						// 셀값을 읽는다
						XSSFCell cell = row.getCell(columnindex);
						String value = "";
						// 셀이 빈값일경우를 위한 널체크

						if (cell == null) {
							value = "";
						} else {
							// 타입별로 내용 읽기
							switch (cell.getCellType()) {
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								if (columnindex == 3 || columnindex == 4) {
									value = cell.getNumericCellValue() + "";
								} else {
									value = (int) cell.getNumericCellValue() + "";
								}
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = cell.getBooleanCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = cell.getErrorCellValue() + "";
								break;
							}
						}
						if (rowindex != 0) {
							if (value == null || value == "") {
								value = "";
							}
							switch (columnindex) {
							case 0:
								equiDto.setEquiInfoKey(value);
								locDto.setEquiInfoKey(value);
								locDto1.setEquiInfoKey(value);
								locDto2.setEquiInfoKey(value);
								locDto3.setEquiInfoKey(value);
								locDto4.setEquiInfoKey(value);
								break;
							case 1:
								equiDto.setEquiStru(value);
								break;
							case 2:
								equiDto.setSuperDeptCd(value);
								break;
							case 3:
								equiDto.setDeptCd(value);
								break;
							case 4:
								equiDto.setMngNmJung(value);
								break;
							case 5:
								equiDto.setMngNmJungTel(value);
								break;
							case 6:
								equiDto.setMngNmBu(value);
								break;
							case 7:
								equiDto.setTotOpin(value);
								break;

							case 8:
								locDto.setEastRel1(value);
								break;
							case 9:
								locDto.setWestRel1(value);
								break;
							case 10:
								locDto.setSouthRel1(value);
								break;
							case 11:
								locDto.setNorthRel1(value);
								break;
							case 12:
								locDto.setEastRel2(value);
								break;
							case 13:
								locDto.setWestRel2(value);
								break;
							case 14:
								locDto.setSouthRel2(value);
								break;
							case 15:
								locDto.setNorthRel2(value);
								break;

							case 16:
								locDto1.setEastRel1(value);
								break;
							case 17:
								locDto1.setWestRel1(value);
								break;
							case 18:
								locDto1.setSouthRel1(value);
								break;
							case 19:
								locDto1.setNorthRel1(value);
								break;
							case 20:
								locDto1.setEastRel2(value);
								break;
							case 21:
								locDto1.setWestRel2(value);
								break;
							case 22:
								locDto1.setSouthRel2(value);
								break;
							case 23:
								locDto1.setNorthRel2(value);
								break;

							case 24:
								locDto2.setEastRel1(value);
								break;
							case 25:
								locDto2.setWestRel1(value);
								break;
							case 26:
								locDto2.setSouthRel1(value);
								break;
							case 27:
								locDto2.setNorthRel1(value);
								break;
							case 28:
								locDto2.setEastRel2(value);
								break;
							case 29:
								locDto2.setWestRel2(value);
								break;
							case 30:
								locDto2.setSouthRel2(value);
								break;
							case 31:
								locDto2.setNorthRel2(value);
								break;

							case 32:
								locDto3.setEastRel1(value);
								break;
							case 33:
								locDto3.setWestRel1(value);
								break;
							case 34:
								locDto3.setSouthRel1(value);
								break;
							case 35:
								locDto3.setNorthRel1(value);
								break;
							case 36:
								locDto3.setEastRel2(value);
								break;
							case 37:
								locDto3.setWestRel2(value);
								break;
							case 38:
								locDto3.setSouthRel2(value);
								break;
							case 39:
								locDto3.setNorthRel2(value);
								break;

							case 40:
								locDto4.setEastRel1(value);
								break;
							case 41:
								locDto4.setWestRel1(value);
								break;
							case 42:
								locDto4.setSouthRel1(value);
								break;
							case 43:
								locDto4.setNorthRel1(value);
								break;
							case 44:
								locDto4.setEastRel2(value);
								break;
							case 45:
								locDto4.setWestRel2(value);
								break;
							case 46:
								locDto4.setSouthRel2(value);
								break;
							case 47:
								locDto4.setNorthRel2(value);
								break;

							case 48:
								locDto.setBigo(value);
								locDto1.setBigo(value);
								locDto2.setBigo(value);
								locDto3.setBigo(value);
								locDto4.setBigo(value);
								break;

							}

							System.out.println(rowindex + "번 행 : " + columnindex + "값은: " + value + " / ");
						}
						relMap.put("0", locDto);
						relMap.put("1", locDto1);
						relMap.put("2", locDto2);
						relMap.put("3", locDto3);
						relMap.put("4", locDto4);
						if (rowindex != 0) {
							listMap.put("left", equiDto);
							listMap.put("right", relMap);
							resultMap.put(equiDto.getEquiInfoKey(), listMap);
						}
					}

				}
			}
			// adminService.updateLoc(edto);
			// adminService.updateLocDetail(edto);
			adminService.cardLocUpdateExcel(resultMap);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@PostMapping("/mngDept/save")
	public ResultDto mngDeptSave(MngDeptDto mdto) throws Exception {
		ResultDto rdto = new ResultDto();
		logger.info("{}", mdto);
		try {
			adminService.insertMngDept(mdto);
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setResult("fail");

		}
		return rdto;
	}

	@GetMapping("/mngDept/search")
	public List<MngDeptDto> mngDeptSearch(MngDeptDto mdto) throws Exception {

		return adminService.mngDeptSearch(mdto);
	}

	@PostMapping("/mngDept/update")
	public ResultDto mngDeptUpdate(@RequestBody List<MngDeptDto> lists) throws Exception {
		ResultDto rdto = new ResultDto();
		try {
			for (MngDeptDto mdto : lists) {
				adminService.mngDeptUpdate(mdto);
			}
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setResult("fail");

		}
		return rdto;
	}

	@PostMapping("/mngDept/delete")
	public ResultDto mngDeptDelete(@RequestBody List<MngDeptDto> lists) throws Exception {
		ResultDto rdto = new ResultDto();
		try {
			for (MngDeptDto mdto : lists) {
				adminService.mngDeptDelete(mdto);
			}
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setResult("fail");

		}
		return rdto;
	}

	@RequestMapping("/mngDept/excel")
	public void excelPoi(HttpServletRequest request, HttpServletResponse response, Model model, MngDeptDto mngDto)
			throws Exception {
		System.out.println(request.getRequestURI());
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

		String[] title = { "날짜", "관리자(정)", "전화번호", "관리자(부)", "전화번호", "변경내역", "변경사유", "비고" };
		int count = 0;
		for (String i : title) {
			objCell = objRow.createCell(count);
			objCell.setCellStyle(style);
			objCell.setCellValue(i);
			objSheet.setColumnWidth(0, 6800);
			count++;
		}

		List<MngDeptDto> mlist = adminService.mngDeptSearch(mngDto);
		int ecount = 1;
		String guName = "";
		for (MngDeptDto mdto : mlist) {
			objRow = objSheet.createRow(ecount);
			objRow.setHeight((short) 0x150);

			String yyyymmdd = mdto.getWorkDt();
			String hhmm = mdto.getWorkTm();
			String result = yyyymmdd.substring(0, 4) + "년 " + yyyymmdd.substring(4, 6) + "월 " + yyyymmdd.substring(6, 8)
					+ "일 " + hhmm.substring(0, 2) + ":" + hhmm.substring(2, 4);

			objCell = setColumn(objSheet, objRow, result, 0);
			objCell = setColumn(objSheet, objRow, mdto.getMngNmJung(), 1);
			objCell = setColumn(objSheet, objRow, mdto.getMngNmJungTel(), 2);
			objCell = setColumn(objSheet, objRow, mdto.getMngNmBu(), 3);
			objCell = setColumn(objSheet, objRow, mdto.getMngNmBuTel(), 4);
			objCell = setColumn(objSheet, objRow, mdto.getChgContent(), 5);
			objCell = setColumn(objSheet, objRow, mdto.getChgReason(), 6);
			objCell = setColumn(objSheet, objRow, mdto.getBigo(), 7);

			ecount++;
		}

		Date today = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmm");

		response.setContentType("Application/Msexcel");
		response.setHeader("Content-Disposition",
				"ATTachment; Filename=" + URLEncoder.encode("관리부서 관리" + "_" + sf.format(today), "UTF-8") + ".xls");

		OutputStream fileOut = response.getOutputStream();
		objWorkBook2.write(fileOut);
		fileOut.close();
		objWorkBook2.close();
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	@PostMapping("/ware/save")
	public ResultDto wareSave(WareDto wdto) throws Exception {
		ResultDto rdto = new ResultDto();
		logger.info("{}", wdto);

		try {
			adminService.insertWare(wdto);

			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setResult("fail");
		}
		return rdto;
	}

	@GetMapping("/ware/search")
	public List<WareDto> wareSearch(WareDto mdto) throws Exception {
		return adminService.wareSearch(mdto);
	}

	@PostMapping("/ware/update")
	public ResultDto wareUpdate(@RequestBody List<WareDto> lists) throws Exception {
		ResultDto rdto = new ResultDto();
		try {
			for (WareDto mdto : lists) {
				adminService.wareUpdate(mdto);
			}
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setResult("fail");
		}
		return rdto;
	}

	@PostMapping("/ware/delete")
	public ResultDto wareDelete(@RequestBody List<WareDto> lists) throws SQLException {
		ResultDto rdto = new ResultDto();
		try {

			for (WareDto mdto : lists) {
				System.out.println("값 : " + mdto.getEquiInfoKey() + ", " + mdto.getChgTp() + ", " + mdto.getWorkYmd()
						+ ", " + mdto.getWorkDt() + ", " + mdto.getWorkTm());
				adminService.wareDelete(mdto);
			}
			rdto.setResult("success");
		} catch (Exception e) {
			rdto.setResult("fail");

		}
		return rdto;
	}

	public HSSFCell setColumn(HSSFSheet sheet, HSSFRow row, String value, int index) {
		System.out.println(value);
		HSSFCell objCell = row.createCell(index);
		objCell.setCellValue(value);
		sheet.autoSizeColumn(index);
		sheet.setColumnWidth(index, (sheet.getColumnWidth(index)) + 512);

		return objCell;
	}

	// Excel Generator
	@RequestMapping("/ware/excel")
	public void wareExcel(HttpServletResponse response, @RequestParam String title, WareDto wareDto) throws Exception {
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

		String[] titleRow = { "기기명", "변동내용(구분)", "변동내용(일자)", "변동사유", "비고", "등록일자" };
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

			objCell = setColumn(objSheet, objRow, wdto.getEquiInfoKey(), 0);
			objCell = setColumn(objSheet, objRow, wdto.getChgTp(), 1);
			objCell = setColumn(objSheet, objRow, wdto.getWorkDt(), 2);
			objCell = setColumn(objSheet, objRow, wdto.getChgReason(), 3);
			objCell = setColumn(objSheet, objRow, wdto.getBigo(), 4);
			objCell = setColumn(objSheet, objRow, wdto.getWorkYmd(), 5);

			// objCell = objRow.createCell(0);
			// objCell.setCellValue(wdto.getChgTp());
			// objSheet.autoSizeColumn(0);
			// objSheet.setColumnWidth(0, (objSheet.getColumnWidth(0)) + 512);

			// objCell = objRow.createCell(1);
			// objCell.setCellValue(wdto.getWorkDt());
			// objSheet.autoSizeColumn(1);
			// objSheet.setColumnWidth(1, (objSheet.getColumnWidth(1)) + 512);

			// objCell = objRow.createCell(2);
			// objCell.setCellValue(wdto.getChgReason());
			// objSheet.autoSizeColumn(2);
			// objSheet.setColumnWidth(2, (objSheet.getColumnWidth(2)) + 512);

			// objCell = objRow.createCell(3);
			// objCell.setCellValue(wdto.getBigo());
			// objSheet.autoSizeColumn(3);
			// objSheet.setColumnWidth(3, (objSheet.getColumnWidth(3)) + 512);

			// objCell = objRow.createCell(4);
			// objCell.setCellValue(wdto.getWorkYmd());
			// objSheet.autoSizeColumn(4);
			// objSheet.setColumnWidth(4, (objSheet.getColumnWidth(4)) + 512);

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

	// 20201019 Excel test
	@PostMapping("/equiExcel")
	public Boolean equiExcel(@RequestParam("filename") MultipartFile mFile) throws Exception {
		try {
			XSSFWorkbook workbook = new XSSFWorkbook(mFile.getInputStream());

			int rowindex = 0;
			int columnindex = 0;
			// 시트 수 (첫번째에만 존재하므로 0을 준다)
			// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
			XSSFSheet sheet = workbook.getSheetAt(0);
			// 행의 수
			int rows = sheet.getPhysicalNumberOfRows();
			List<EquiDto> elist = new ArrayList<>();
			for (rowindex = 0; rowindex < rows; rowindex++) {
				// 행을읽는다
				XSSFRow row = sheet.getRow(rowindex);
				EquiDto edto = new EquiDto();
				if (row != null) {
					// 셀의 수
					int cells = sheet.getRow(0).getPhysicalNumberOfCells();
					;
					for (columnindex = 0; columnindex <= cells; columnindex++) {
						// 셀값을 읽는다
						XSSFCell cell = row.getCell(columnindex);
						String value = "";
						// 셀이 빈값일경우를 위한 널체크

						if (cell == null) {
							value = "";
						} else {
							// 타입별로 내용 읽기
							switch (cell.getCellType()) {
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								if (columnindex == 3 || columnindex == 4) {
									value = cell.getNumericCellValue() + "";
								} else {
									value = (int) cell.getNumericCellValue() + "";
								}
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = cell.getBooleanCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = cell.getErrorCellValue() + "";
								break;
							}
						}
						if (rowindex != 0) {
							if (value == null || value == "") {
								value = "";
							}
							switch (columnindex) {
							case 0:
								edto.setEquiType(value);
								break;
							case 1:
								edto.setStaName(value);
								break;
							case 2:
								edto.setEquiInfoKey(value);
								break;
							case 3:
								edto.setGpsAbb(value);
								break;
							case 4:
								edto.setGpsLat(value);
								break;
							case 5:
								edto.setSenseTp(value);
								break;
							case 6:
								edto.setUseTp1(value);
								break;
							case 7:
								edto.setUseTp2(value);
								break;
							case 8:
								edto.setUseTp3(value);
								break;
							case 9:
								edto.setInstYear(value);
								break;
							case 10:
								edto.setInstMonth(value);
								break;
							case 11:
								edto.setMngNum(value);
								break;
							case 12:
								edto.setGuTp(value);
								break;
							case 13:
								edto.setInstLoc(value);
								break;
							case 14:
								edto.setInstLoc2(value);
								break;
							case 15:
								if (value.equals("1") || value.equals("Y")) {
									edto.setSetYn("Y");
								} else {
									edto.setSetYn("N");
								}

								break;
							case 16:
								String use = "N";
								if (value.equals("1") || value.equals("Y")) {
									use = "Y";
								}
								edto.setUseYn(use);
								break;
							case 17:
								String baram = "N";
								if (value.equals("1") || value.equals("Y")) {
									baram = "Y";
								}
								edto.setBaramYn(baram);
								break;
							case 18:
								edto.setBaramMngNum(value);
								break;
							case 19:
								edto.setBaramNm(value);
								break;
							case 20:
								if (value.equals("1") || value.equals("Y")) {
									edto.setAirYn("Y");
								} else {
									edto.setAirYn("N");
								}
								break;
							case 21:
								edto.setAirMngNum(value);
								break;
							case 22:
								edto.setVistorSenId(value);
								break;
							case 23:
								edto.setVistorSenViewNm(value);
								break;
							}

							System.out.println(rowindex + "번 행 : " + columnindex + "값은: " + value + " / ");
						}
					}

				}
				if (rowindex != 0) {
					logger.warn("{}", edto);
					elist.add(edto);
				}
			}
			settingService.insertEquiInfoExcel(elist);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@PostMapping("/departExcel")
	public Boolean departExcel(@RequestParam("filename") MultipartFile mFile) throws Exception {
		try {
			XSSFWorkbook workbook = new XSSFWorkbook(mFile.getInputStream());

			int rowindex = 0;
			int columnindex = 0;
			// 시트 수 (첫번째에만 존재하므로 0을 준다)
			// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
			XSSFSheet sheet = workbook.getSheetAt(0);
			// 행의 수
			int rows = sheet.getPhysicalNumberOfRows();
			List<MngDeptDto> mlist = new ArrayList<>();
			for (rowindex = 0; rowindex < rows; rowindex++) {
				// 행을읽는다
				XSSFRow row = sheet.getRow(rowindex);
				MngDeptDto mdto = new MngDeptDto();
				if (row != null) {
					// 셀의 수
					int cells = sheet.getRow(0).getPhysicalNumberOfCells();
					;
					for (columnindex = 0; columnindex <= cells; columnindex++) {
						// 셀값을 읽는다
						XSSFCell cell = row.getCell(columnindex);
						String value = "";
						// 셀이 빈값일경우를 위한 널체크

						if (cell == null) {
							value = "";
						} else {
							// 타입별로 내용 읽기
							switch (cell.getCellType()) {
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								if (columnindex == 3) {
									NumberFormat nf = NumberFormat.getInstance();
									nf.setGroupingUsed(false);

									value = nf.format(cell.getNumericCellValue()) + "";
								} else {
									value = (int) cell.getNumericCellValue() + "";
								}
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = cell.getBooleanCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = cell.getErrorCellValue() + "";
								break;
							}
						}
						if (rowindex != 0) {
							if (value == null || value == "") {
								value = "";
							}
							switch (columnindex) {
							case 0:
								mdto.setInstCd(value);
								break;
							case 1:
								mdto.setSuperDeptCd(value);
								break;
							case 2:
								mdto.setDeptCd(value);
								break;
							case 3:
								mdto.setWorkDt(value);
								break;
							case 4:
								mdto.setWorkTm(value);
								break;
							case 5:
								mdto.setMngNmJung(value);
								break;
							case 6:
								mdto.setMngNmJungTel(value);
								break;
							case 7:
								mdto.setMngNmBu(value);
								break;
							case 8:
								mdto.setMngNmBuTel(value);
								break;
							case 9:
								mdto.setChgContent(value);
								break;
							case 10:
								mdto.setChgReason(value);
								break;
							case 11:
								mdto.setBigo(value);
								break;
							}

							System.out.println(rowindex + "번 행 : " + columnindex + "값은: " + cell + " / ");
						}
					}

				}
				if (rowindex != 0) {
					logger.warn("{}", mdto);
					mlist.add(mdto);
				}
			}
			adminService.insertMngDeptExcel(mlist);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@PostMapping("/wareExcel")
	public Boolean wareExcel(@RequestParam("filename") MultipartFile mFile) throws Exception {
		try {
			XSSFWorkbook workbook = new XSSFWorkbook(mFile.getInputStream());

			int rowindex = 0;
			int columnindex = 0;
			// 시트 수 (첫번째에만 존재하므로 0을 준다)
			// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
			XSSFSheet sheet = workbook.getSheetAt(0);
			// 행의 수
			int rows = sheet.getPhysicalNumberOfRows();
			List<WareDto> wlist = new ArrayList<>();
			for (rowindex = 0; rowindex < rows; rowindex++) {
				// 행을읽는다
				XSSFRow row = sheet.getRow(rowindex);
				WareDto wdto = new WareDto();
				if (row != null) {
					// 셀의 수
					int cells = sheet.getRow(0).getPhysicalNumberOfCells();
					;
					for (columnindex = 0; columnindex <= cells; columnindex++) {
						// 셀값을 읽는다
						XSSFCell cell = row.getCell(columnindex);
						String value = "";
						// 셀이 빈값일경우를 위한 널체크

						if (cell == null) {
							value = "";
						} else {
							// 타입별로 내용 읽기
							switch (cell.getCellType()) {
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								if (columnindex == 4 || columnindex == 5) {
									value = cell.getNumericCellValue() + "";
								} else {
									value = (int) cell.getNumericCellValue() + "";
								}
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = cell.getBooleanCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = cell.getErrorCellValue() + "";
								break;
							}
						}
						if (rowindex != 0) {
							switch (columnindex) {
							case 0:
								wdto.setEquiInfoKey(value);
								break;
							case 1:
								wdto.setSwHwTp(value);
								break;
							case 2:
								wdto.setChgTp(value);
								break;
							case 3:
								wdto.setWorkDt(value);
								break;
							case 4:
								wdto.setWorkTm(value);
								break;
							case 5:
								wdto.setChgReason(value);
								break;
							case 6:
								wdto.setBigo(value);
								break;

							}

							System.out.println(rowindex + "번 행 : " + columnindex + "값은: " + value + " / ");
						}
					}

				}
				if (rowindex != 0) {
					logger.warn("{}", wdto);
					wlist.add(wdto);
				}
			}
			adminService.insertWareExcel(wlist);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@ExceptionHandler(value = Exception.class)
	public ResponseEntity<ResultDto> nfeHandler(Exception e) {
		ResultDto rdto = new ResultDto();
		logger.info(e.getMessage());
		rdto.setMsg("fail");
		rdto.setResult("fail");
		return new ResponseEntity<ResultDto>(rdto, HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping("/user/history")
	public Map<String, Object> getUsersHistory(ParamDto paramDto) throws Exception {
		Map<String, Object> info = new HashMap<>();
		List<MemberDto> lm = new ArrayList<>();
		AES256Util aes = new AES256Util(pdto.getPassPhraseDB());

		for (MemberDto memberdto : adminService.getUserHistory(paramDto)) {
			MemberDto mdto = new MemberDto();

			mdto.setUserId(aes.decrypt(memberdto.getUserId()));
			mdto.setUserName(aes.decrypt(memberdto.getUserName()));
			mdto.setRegDate(memberdto.getRegDate());

			lm.add(mdto);

		}

		info.put("data", lm);

		System.out.println("data 값 : " + info);
		return info;

	}

}