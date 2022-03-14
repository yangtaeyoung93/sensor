package com.seoulsi.util;

import com.seoulsi.dto.CardDto;
import com.seoulsi.dto.EquListExcelDTO;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.springframework.core.io.ClassPathResource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Optional;

public class ExcelUtil {

    public void download(HttpServletRequest request, HttpServletResponse response, List<EquListExcelDTO> lists)  {

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
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setWrapText(true);

        objSheet = objWorkBook2.createSheet("통합본"); // 워크시트 생성
        objSheet.setDefaultColumnWidth(12);

        // 1행
        objRow = objSheet.createRow(0);
        objRow.setHeight((short) 0x200);
        String[] title = { "순번" , "수요처", "관리번호", "시리얼번호", "지번주소","행정동","법정동","구분","CCTV 고유번호", "설치장소","용도1","용도2","경도","위도","초미세먼지","미세먼지","온/습도","소음",
                "조도","진동","자외선","풍향/풍속","유동인구","흑구","대기오염(CO/NO2/SO2)","악취(NH3/H2S)"};
        int count = 0;

        for (String i : title) {
            objCell = objRow.createCell(count);
            objCell.setCellStyle(style);
            objCell.setCellValue(i);
            count++;
        }

        int ecount = 1;
        for (EquListExcelDTO edto : lists) {
            objRow = objSheet.createRow(ecount);
            objRow.setHeight((short) 0x150);
            int lastCellNum = objRow.getLastCellNum();
            objCell = objRow.createCell(0);
            objCell.setCellValue(edto.getId());
            objCell = objRow.createCell(1);
            objCell.setCellValue(edto.getGu());

            objCell = objRow.createCell(2);
            objCell.setCellValue(edto.getEquiInfoKeyHan());

            objCell = objRow.createCell(3);
            objCell.setCellValue(edto.getEquiInfoKey());

            objCell = objRow.createCell(4);
            objCell.setCellValue(edto.getInstLoc());

            objCell = objRow.createCell(5);
            objCell.setCellValue(edto.getAdminDong());

            objCell = objRow.createCell(6);
            objCell.setCellValue(edto.getCourtDong());

            objCell = objRow.createCell(7);
            objCell.setCellValue(edto.getGuBun());

            objCell = objRow.createCell(8);
            objCell.setCellValue(edto.getCctvNumber());

            objCell = objRow.createCell(9);
            objCell.setCellValue(edto.getInstPlace());

            //objCell.setCellValue(edto.getCctyNumber());
            objCell = objRow.createCell(10);
            objCell.setCellValue(edto.getUseTp1());

            objCell = objRow.createCell(11);
            objCell.setCellValue(edto.getUseTp2());

            objCell = objRow.createCell(12);
            objCell.setCellValue(edto.getGpsLat());

            objCell = objRow.createCell(13);
            objCell.setCellValue(edto.getGpsAbb());

            objCell = objRow.createCell(14);
            objCell.setCellValue(edto.getSensorPm25());

            objCell = objRow.createCell(15);
            objCell.setCellValue(edto.getSensorPm10());

            objCell = objRow.createCell(16);
            objCell.setCellValue(edto.getSensorTemp());

            objCell = objRow.createCell(17);
            objCell.setCellValue(edto.getSensorNoise());

            objCell = objRow.createCell(18);
            objCell.setCellValue(edto.getSensorIllu());

            objCell = objRow.createCell(19);
            objCell.setCellValue(edto.getSensorVibr());

            objCell = objRow.createCell(20);
            objCell.setCellValue(edto.getSensorUv());

            objCell = objRow.createCell(21);
            objCell.setCellValue(edto.getSensorWind());

            objCell = objRow.createCell(22);
            objCell.setCellValue(edto.getSensorVisitor());

            objCell = objRow.createCell(23);
            objCell.setCellValue(edto.getSensorEffeTemp());

            objCell = objRow.createCell(24);
            objCell.setCellValue(edto.getSensorCo());

            objCell = objRow.createCell(25);
            objCell.setCellValue(edto.getSensorNh3());

            ecount++;
        }
                objSheet.setColumnWidth(4,10000);
        try {
            response.setContentType("Application/Msexcel");
            response.setHeader("Content-Disposition",
                    "ATTachment; Filename=" + URLEncoder.encode( "전체장비리스트_" + LocalDateTime.now(), "UTF-8") + ".xls");

            OutputStream fileOut = response.getOutputStream();
            objWorkBook2.write(fileOut);
            fileOut.close();
            objWorkBook2.close();
            response.getOutputStream().flush();
            response.getOutputStream().close();
        }catch (Exception e){
            e.printStackTrace();
        }
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
}
