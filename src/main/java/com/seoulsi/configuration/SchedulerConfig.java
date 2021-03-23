package com.seoulsi.configuration;

import java.net.URL;
import java.nio.charset.Charset;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import java.awt.*;
import java.awt.image.*;
import java.io.*;
import java.net.*;
import javax.imageio.*;
import javax.swing.*;
import javax.swing.text.*;
import javax.swing.text.html.*;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.html2pdf.resolver.font.DefaultFontProvider;
import com.itextpdf.io.font.FontProgram;
import com.itextpdf.io.font.FontProgramFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.AreaBreak;
import com.itextpdf.layout.element.IBlockElement;
import com.itextpdf.layout.element.IElement;
import com.itextpdf.layout.font.FontProvider;
import com.seoulsi.dto.CommonDto;
import com.seoulsi.dto.DailySenDto;
import com.seoulsi.dto.SensorDto;
import com.seoulsi.dto.extend.ParamDto;
import com.seoulsi.service.CommonService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.web.util.matcher.IpAddressMatcher;
import org.springframework.stereotype.Component;

// import com.itext.layout.*;
import com.itextpdf.kernel.pdf.PdfWriter;

@Component
public class SchedulerConfig {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    CommonService commonService;

    @Autowired
    private JavaMailSender javaMailSender;

    @Value("${spring.mail.log.path}")
    private String logPath;

    @Value("${spring.mail.log.enable}")
    private String logEnable;

    // @Scheduled(fixedDelay = 3000)
    public void testTask() throws Exception {
        ClassPathResource resource = new ClassPathResource("mailList.txt");
        File file = resource.getFile();
        Scanner scan = new Scanner(file);

        while (scan.hasNextLine()) {
            System.out.println(scan.nextLine());
        }

    }

    public void makeLogFile(String mail, String flush) {
        SimpleDateFormat full = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat half = new SimpleDateFormat("yyyy-MM-dd");
        String fullDate = full.format(new Date());
        String halfDate = half.format(new Date());
        String logMsg = "[" + fullDate + "] 메일 전송 완료 => " + mail;

        String filePath = logPath + "/mail-log-" + halfDate + ".log";

        if (logEnable.equals("true")) {
            if (!new File(logPath).isDirectory()) {
                new File(logPath).mkdirs();
            }

            try {
                if (flush.equals("end")) {
                    FileWriter fw = new FileWriter(filePath, true);
                    fw.write("[" + fullDate + "] 메일 전송 프로세스 종료");
                    fw.write("\r\n\r\n");
                    fw.flush();
                } else if (flush.equals("start")) {
                    FileWriter fw = new FileWriter(filePath, true);
                    fw.write("[" + fullDate + "] 메일 전송 프로세스 시작");
                    fw.write("\r\n");
                    fw.flush();
                } else if (flush.equals("fail")) {
                    FileWriter fw = new FileWriter(filePath, true);
                    fw.write("[" + fullDate + "] 메일 전송 실패!! => " + mail);
                    fw.write("\r\n");
                    fw.flush();
                } else {
                    FileWriter fw = new FileWriter(filePath, true);
                    fw.write(logMsg);
                    fw.write("\r\n");
                    fw.flush();
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }

    }

    public void sendMailAndFile(String to, String from, StringBuilder contents)
            throws MessagingException, UnsupportedEncodingException {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(message, true, "UTF-8");

        mimeMessageHelper.setFrom(from, "S-DoT Report");
        mimeMessageHelper.setTo(to);
        mimeMessageHelper.setSubject("S-DoT 운영시스템 일간 보고서_" + sdf.format(calendar.getTime()));
        mimeMessageHelper.setText(contents.toString(), true);

        javaMailSender.send(message);
    }

    public String getHtml(String type, int value) {

        String typeChar = "";
        if (type.equals("pm10")) {
            typeChar = "미세먼지";
        }
        if (type.equals("pm25")) {
            typeChar = "초미세먼지";
        }
        if (type.equals("temp")) {
            typeChar = "온도";
        }
        if (type.equals("humi")) {
            typeChar = "습도";
        }
        if (type.equals("noise")) {
            typeChar = "소음";
        }
        if (type.equals("vibr")) {
            typeChar = "진동";
        }
        if (type.equals("inte_illu")) {
            typeChar = "조도";
        }
        if (type.equals("ultra_rays")) {
            typeChar = "자외선";
        }
        if (type.equals("wind_dire")) {
            typeChar = "풍향";
        }
        if (type.equals("wind_speed")) {
            typeChar = "풍속";
        }
        if (type.equals("co")) {
            typeChar = "일산화탄소";
        }
        if (type.equals("no2")) {
            typeChar = "이산화질소";
        }
        if (type.equals("so2")) {
            typeChar = "이산화황";
        }
        if (type.equals("nh3")) {
            typeChar = "암모니아";
        }
        if (type.equals("h2s")) {
            typeChar = "황화수소";
        }
        if (type.equals("o3")) {
            typeChar = "오존";
        }
        if (type.equals("effe_temp")) {
            typeChar = "흑구";
        }
        System.out.println(typeChar);
        String html = "<div class='tbody_tr1' style='width: 340px;height: 34px;border-bottom: 1px solid #d7d7d7;'>"
                + "	<div class='tbody_td1' style='float: left;width: 50%;text-align: center;font-size: 0.875em;padding-top: 9px;'>"
                + typeChar + "	</div>"
                + "	<div class='tbody_td2' style='float: left;width: 50%;text-align: center;font-size: 0.875em;color: #e9160c;padding-top: 9px;'>"
                + value + "	</div>" + "</div>";

        return html;
    }

    public String getEquiHtml(List<SensorDto> sensor) throws Exception {

        int count = 0;
        String result = "";
        String gu = "";
        List<CommonDto> gus = commonService.guList();

        for (SensorDto sdto : sensor) {

            if (count < 5) {
                for (CommonDto cdto : gus) {
                    if (sdto.getGuTp().equals(cdto.getCode())) {
                        gu = cdto.getRelCd1();
                    }
                }
                result += "			<div class='tbody_tr2' style='width: 700px;height: 34px;border-bottom: 1px solid #d7d7d7;'>"
                        + "				<div class='tbody_td3' style='float: left;width: 33.3%;text-align: center;font-size: 0.875em;padding-top: 9px;'>"
                        + gu + "				</div>"
                        + "				<div class='tbody_td3' style='float: left;width: 33.3%;text-align: center;font-size: 0.875em;padding-top: 9px;'>"
                        + gu + "-" + sdto.getEquiInfoKeyHan() + "				</div>"
                        + "				<div class='tbody_td3' style='float: left;width: 33.3%;text-align: center;font-size: 0.875em;padding-top: 9px;'>"
                        + sdto.getEquiInfoKey() + "				</div>" + "			</div>";
            }
            count++;
        }

        return result;
    }

    @Scheduled(cron = "0 30 10 * * *")
    public void task1() throws Exception {
        // 전날 데이터를 위한 날짜
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.DATE, -1);
        SimpleDateFormat year = new SimpleDateFormat("yyyy");
        SimpleDateFormat month = new SimpleDateFormat("MM");
        SimpleDateFormat day = new SimpleDateFormat("dd");
        SimpleDateFormat full = new SimpleDateFormat("yyyyMMdd");
        String today = full.format(new Date());

        StringBuilder body = new StringBuilder();

        ParamDto paramDto = new ParamDto();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        paramDto.setToDate(full.format(cal.getTime()));
        paramDto.setFromDate(full.format(cal.getTime()));
        paramDto.setType("pm10");
        List<DailySenDto> daily = commonService.getDailyCntForEqui(paramDto);
        List<SensorDto> sdto = commonService.getDailyCntForEquiSensor(paramDto);

        String header = "<!DOCTYPE html>" + "<html lang='ko-KR'>" + "<head>" + "<title>이상장비 발생 알림</title>"
                + "	<meta charset='UTF-8'/>" + "	<meta name='description' content='Free Web tutorials'/>"
                + "	<meta name='keywords' content='HTML,CSS,XML,JavaScript'/>"
                + "	<meta name='author' content='KimEunjin'/>"
                + "	<meta name='viewport' content='width=device-width, initial-scale=1.0'/>"
                + "	<meta http-equiv='X-UA-Compatible' content='IE=Edge'/>"
                + "	<!-- <link href='css/mail_style.css' rel='stylesheet' type='text/css'> -->" + "<!--[if lt IE 9]>"
                + "<script src='https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js'></script>" + "<![endif]-->"
                + "<script src='https://use.fontawesome.com/releases/v5.2.0/js/all.js'></script>" + "</head>"
                + "<body style='margin:auto; padding: 0;'>"
                + "	<div class='logo' style='width: 780px;height: 40px;padding: 10px; margin: auto;'>"
                + "		<a href='#' style='color: #000000;text-decoration: none;'><img src='img/logo.png' alt='스마트도시서울'/></a>"
                + "	</div>"
                + "	<div class='wrap_bg' style='width: 780px;height: 750px;background: #fff;margin: auto;padding-top: 20px;'>"
                + "		<div class='mailtt' style='width: 700px;height: 40px;background: #0c82e9;border-radius: 5px; margin: auto;'>"
                + "			<div class='tt' style='float: left;width: 465px;height: 40px;color: #fff;font-size: 1em;padding-top: 9px;padding-left: 15px;'>"
                + "			서울시 도시데이터센서 이상장비 발생 알림" + "			</div>"
                + "			<div class='date' style='float: left;width: 200px;height: 40px;color: #fff;font-size: 0.875em;text-align: right;padding-top: 10px;padding-right: 15px;'>"
                + year.format(cal.getTime()) + "년 " + month.format(cal.getTime()) + "월 " + day.format(cal.getTime())
                + "일 데이터" + "			</div>" + "		</div>" + "	<!-- 센서별 장비 이상 현황 -->"
                + "		<div class='mailcon' style='margin-top: 18px;width: 700px;height: 380px; margin: auto;'>"
                + "			<div class='mailcon_title' style='float: left;width: 340px;height: 380px;'>"
                + "				<div class='mailcon_tt' style='width: 340px;height: 37px;font-size: 1.125em;padding-top: 9px;font-weight: 500;'>"
                + "				센서별 장비 이상 현황" + "				</div>"
                + "				<div class='thead_tr' style='width: 340px;height: 35px;background: #f3f9fe;border-top: 1px solid #0c82e9;border-bottom: 1px solid #0c82e9;'>"
                + "					<div class='thead_td' style='float: left;width: 50%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                + "					구분" + "					</div>"
                + "					<div class='thead_td' style='float: left;width: 50%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                + "					이상 장비" + "					</div>" + "				</div>";
        body.append(header);
        DailySenDto all = new DailySenDto();
        int count = 0;
        for (DailySenDto dto : daily) {
            if (dto.getEquiType().equals("all")) {
                all.setBadEquiCnt(dto.getBadEquiCnt());
            } else {
                if (count == 9) {
                    // 다음으로
                    String middle = "</div>"
                            + "	<div class='mailcon_title_right' style='float: right;width: 340px;height: 380px;'>"
                            + "		<div class='mailcon_tt2' style='width: 340px;height: 37px;font-size: 1em;padding-top: 9px;font-weight: 500;text-align: right;'>"
                            + "		이상 장비 :<span class='tt_point' style='color: #e9160c;'> " + all.getBadEquiCnt()
                            + "개 </span> " + "		</div>"
                            + "		<div class='thead_tr' style='width: 340px;height: 35px;background: #f3f9fe;border-top: 1px solid #0c82e9;border-bottom: 1px solid #0c82e9;'>"
                            + "			<div class='thead_td' style='float: left;width: 50%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                            + "			구분" + "			</div>"
                            + "			<div class='thead_td' style='float: left;width: 50%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                            + "			이상 장비" + "			</div>" + "		</div>";
                    body.append(middle);
                    body.append(getHtml(dto.getEquiType(), dto.getBadEquiCnt()));
                } else {
                    body.append(getHtml(dto.getEquiType(), dto.getBadEquiCnt()));
                }
                count++;
            }
        }

        String footer = "	</div>" + "		</div>" + "	<!-- 지역별 장비 이상 현황 -->"
                + "		<div class='mailcon2' style='margin-top: 18px;width: 700px;height: 280px; margin: auto; margin-top: 40px;'>"
                + "			<div class='mailcon2_tt' style='width: 700px;height: 37px;font-size: 1.125em;padding-top: 9px;font-weight: 500;'>"
                + "				장비 이상 현황 <span style='font-weight: bold;font-size: 0.875em;float: right;'>(자세한 기기 목록은 홈페이지에서 확인 가능합니다.)</span>"
                + "			</div>"
                + "			<div class='thead_tr2' style='width: 700px;height: 35px;background: #f3f9fe;border-top: 1px solid #0c82e9;border-bottom: 1px solid #0c82e9;'>"
                + "				<div class='thead_td2' style='float: left;width: 33.3%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                + "				지역" + "				</div>"
                + "				<div class='thead_td2' style='float: left;width: 33.3%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                + "				관리번호" + "				</div>"
                + "				<div class='thead_td2' style='float: left;width: 33.3%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                + "				시리얼" + "				</div>" + "			</div>" + getEquiHtml(sdto) + "		</div>"
                + "	</div>"
                + "	<div class='footer' style='width: 780px;height: 60px;padding: 20px;text-align: center;font-size: 0.75em; margin: auto;'>"
                + "	본 메일은 발신전용 입니다. 자세한 사항은 홈페이지를 확인해 주시기 바랍니다.	" + "	</div>" + "</body>" + "</html>";
        body.append(footer);

        String from = "sdotmailtest@gmail.com";
        List<String> mailList = new ArrayList<>();

        ClassPathResource resource = new ClassPathResource("mailList.txt");
        File file = resource.getFile();
        Scanner scan = new Scanner(file);

        while (scan.hasNextLine()) {
            mailList.add(scan.nextLine());
        }

        // makeLogFile("", "start");

        // for (String mail : mailList) {
        // try {
        // sendMailAndFile(mail, from, body);
        // makeLogFile(mail, "");
        // } catch (Exception e) {
        // makeLogFile(mail, "fail");
        // }
        // }

        String BODY = body.toString();
        String DST;

        InetAddress local = null;
        local = InetAddress.getLocalHost();
        String ip = local.getHostAddress();
        System.out.println("IP : " + ip);

        if (ip.equals("211.219.114.160")) {
            DST = "D:\\" + today + "_sample.pdf";
        } else {
            DST = "/home/isensor/sensrelayclient/source/" + today + "_reportPdf.pdf";
        }

        // html to pdf

        makepdf(BODY, DST, today, ip);

        // makeLogFile("", "end");

    }

    public void makepdf(String BODY, String DST, String today, String ip) throws IOException {
        System.out.println("makepdf");
        String FONT;
        if (ip.equals("211.219.114.160")) {
            FONT = "D:\\malgun.ttf";
        } else {
            FONT = "/home/isensor/sensrelayclient/source/malgun.ttf";
        }

        ConverterProperties properties = new ConverterProperties();

        FontProvider fontProvider = new DefaultFontProvider(false, false, false);
        FontProgram fontProgram = FontProgramFactory.createFont(FONT);
        fontProvider.addFont(fontProgram);
        properties.setFontProvider(fontProvider);
        // properties.setBaseUri("D:\\");

        List<IElement> elements = HtmlConverter.convertToElements(BODY, properties);

        PdfDocument pdf = new PdfDocument(new PdfWriter(DST));
        // pdf.setTagged();
        Document document = new Document(pdf);
        document.setMargins(50, 0, 50, 0);
        for (IElement element : elements) {
            document.add((IBlockElement) element);
        }
        document.close();
        makeMsg(today, ip);
        // HtmlConverter.convertToPdf(new File(src), new File(dest), properties);
    }

    public void makeMsg(String date, String ip) throws IOException {
        System.out.println("makeMsg");
        String txt;
        String fileName;
        if (ip.equals("211.219.114.160")) {
            txt = "CLIENT_KEY:600e5c813fb457b41756bab8\n" + "MAIL_FROM:iotadmin@seoul.go.kr\n"
                    + "RCPT_TO:sh717510@protonmail.com\n" + "TO_HEADER:sh717510@protonmail.com\n"
                    + "SUBJECT:mail test\n" + "ATTACH:D://" + date + "_sample.pdf\n" + "ISSECURITY:0\n" + "SECU_HINT:\n"
                    + "SECU_KEY:\n\n" + "test mail with attch file";
            fileName = "D:\\" + date + "_makeMsg.msg";

        } else {
            txt = "CLIENT_KEY:600e5c813fb457b41756bab8\n" + "MAIL_FROM:iotadmin@seoul.go.kr\n"
                    + "RCPT_TO:sh717510@protonmail.com\n" + "TO_HEADER:sh717510@protonmail.com\n"
                    + "SUBJECT:mail test\n" + "ATTACH:/home/isensor/sensrelayclient/source/" + date + "_reportPdf.pdf\n"
                    + "ISSECURITY:0\n" + "SECU_HINT:\n" + "SECU_KEY:\n\n" + "test mail with attch file";

            fileName = "/home/isensor/sensrelayclient/spool/" + date + "_reportMail.msg";
        }

        File file = new File(fileName);
        FileWriter fw = new FileWriter(file);
        fw.write(txt);
        fw.flush();
        fw.close();

    }

}
