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

    @Value("${spring.process.log.path}")
    private String processLogPath;

    @Value("${spring.mail.source.path}")
    private String mailSourcePath;

    @Value("${spring.mail.spool.path}")
    private String mailSpoolPath;

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
        String logMsg = "[" + fullDate + "] ?????? ?????? ?????? => " + mail;

        String filePath = logPath + "/mail-log-" + halfDate + ".log";

        if (logEnable.equals("true")) {
            if (!new File(logPath).isDirectory()) {
                new File(logPath).mkdirs();
            }

            try {
                if (flush.equals("end")) {
                    FileWriter fw = new FileWriter(filePath, true);
                    fw.write("[" + fullDate + "] ?????? ?????? ???????????? ??????");
                    fw.write("\r\n\r\n");
                    fw.flush();
                } else if (flush.equals("start")) {
                    FileWriter fw = new FileWriter(filePath, true);
                    fw.write("[" + fullDate + "] ?????? ?????? ???????????? ??????");
                    fw.write("\r\n");
                    fw.flush();
                } else if (flush.equals("fail")) {
                    FileWriter fw = new FileWriter(filePath, true);
                    fw.write("[" + fullDate + "] ?????? ?????? ??????!! => " + mail);
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
        mimeMessageHelper.setSubject("S-DoT ??????????????? ?????? ?????????_" + sdf.format(calendar.getTime()));
        mimeMessageHelper.setText(contents.toString(), true);

        javaMailSender.send(message);
    }

    public String getHtml(String type, int value) {

        String typeChar = "";
        if (type.equals("pm10")) {
            typeChar = "????????????";
        }
        if (type.equals("pm25")) {
            typeChar = "???????????????";
        }
        if (type.equals("temp")) {
            typeChar = "??????";
        }
        if (type.equals("humi")) {
            typeChar = "??????";
        }
        if (type.equals("noise")) {
            typeChar = "??????";
        }
        if (type.equals("vibr")) {
            typeChar = "??????";
        }
        if (type.equals("inte_illu")) {
            typeChar = "??????";
        }
        if (type.equals("ultra_rays")) {
            typeChar = "?????????";
        }
        if (type.equals("wind_dire")) {
            typeChar = "??????";
        }
        if (type.equals("wind_speed")) {
            typeChar = "??????";
        }
        if (type.equals("co")) {
            typeChar = "???????????????";
        }
        if (type.equals("no2")) {
            typeChar = "???????????????";
        }
        if (type.equals("so2")) {
            typeChar = "????????????";
        }
        if (type.equals("nh3")) {
            typeChar = "????????????";
        }
        if (type.equals("h2s")) {
            typeChar = "????????????";
        }
        if (type.equals("o3")) {
            typeChar = "??????";
        }
        if (type.equals("effe_temp")) {
            typeChar = "??????";
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

    @Scheduled(cron = "0 00 08 * * *")
    public void task1() throws Exception {
        // ?????? ???????????? ?????? ??????
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

        String header = "<!DOCTYPE html>" + "<html lang='ko-KR'>" + "<head>" + "<title>???????????? ?????? ??????</title>"
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
                + "		<a href='#' style='color: #000000;text-decoration: none;'><img src='img/logo.png' alt='?????????????????????'/></a>"
                + "	</div>"
                + "	<div class='wrap_bg' style='width: 780px;height: 750px;background: #fff;margin: auto;padding-top: 20px;'>"
                + "		<div class='mailtt' style='width: 700px;height: 40px;background: #0c82e9;border-radius: 5px; margin: auto;'>"
                + "			<div class='tt' style='float: left;width: 465px;height: 40px;color: #fff;font-size: 1em;padding-top: 9px;padding-left: 15px;'>"
                + "			????????? ????????????????????? ???????????? ?????? ??????" + "			</div>"
                + "			<div class='date' style='float: left;width: 200px;height: 40px;color: #fff;font-size: 0.875em;text-align: right;padding-top: 10px;padding-right: 15px;'>"
                + year.format(cal.getTime()) + "??? " + month.format(cal.getTime()) + "??? " + day.format(cal.getTime())
                + "??? ?????????" + "			</div>" + "		</div>" + "	<!-- ????????? ?????? ?????? ?????? -->"
                + "		<div class='mailcon' style='margin-top: 18px;width: 700px;height: 380px; margin: auto;'>"
                + "			<div class='mailcon_title' style='float: left;width: 340px;height: 380px;'>"
                + "				<div class='mailcon_tt' style='width: 340px;height: 37px;font-size: 1.125em;padding-top: 9px;font-weight: 500;'>"
                + "				????????? ?????? ?????? ??????" + "				</div>"
                + "				<div class='thead_tr' style='width: 340px;height: 35px;background: #f3f9fe;border-top: 1px solid #0c82e9;border-bottom: 1px solid #0c82e9;'>"
                + "					<div class='thead_td' style='float: left;width: 50%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                + "					??????" + "					</div>"
                + "					<div class='thead_td' style='float: left;width: 50%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                + "					?????? ??????" + "					</div>" + "				</div>";
        body.append(header);
        DailySenDto all = new DailySenDto();
        int count = 0;
        for (DailySenDto dto : daily) {
            if (dto.getEquiType().equals("all")) {
                all.setBadEquiCnt(dto.getBadEquiCnt());
            } else {
                if (count == 9) {
                    // ????????????
                    String middle = "</div>"
                            + "	<div class='mailcon_title_right' style='float: right;width: 340px;height: 380px;'>"
                            + "		<div class='mailcon_tt2' style='width: 340px;height: 37px;font-size: 1em;padding-top: 9px;font-weight: 500;text-align: right;'>"
                            + "		?????? ?????? :<span class='tt_point' style='color: #e9160c;'> " + all.getBadEquiCnt()
                            + "??? </span> " + "		</div>"
                            + "		<div class='thead_tr' style='width: 340px;height: 35px;background: #f3f9fe;border-top: 1px solid #0c82e9;border-bottom: 1px solid #0c82e9;'>"
                            + "			<div class='thead_td' style='float: left;width: 50%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                            + "			??????" + "			</div>"
                            + "			<div class='thead_td' style='float: left;width: 50%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                            + "			?????? ??????" + "			</div>" + "		</div>";
                    body.append(middle);
                    body.append(getHtml(dto.getEquiType(), dto.getBadEquiCnt()));
                } else {
                    body.append(getHtml(dto.getEquiType(), dto.getBadEquiCnt()));
                }
                count++;
            }
        }

        String footer = "	</div>" + "		</div>" + "	<!-- ????????? ?????? ?????? ?????? -->"
                + "		<div class='mailcon2' style='margin-top: 18px;width: 700px;height: 280px; margin: auto; margin-top: 40px;'>"
                + "			<div class='mailcon2_tt' style='width: 700px;height: 37px;font-size: 1.125em;padding-top: 9px;font-weight: 500;'>"
                + "				?????? ?????? ?????? <span style='font-weight: bold;font-size: 0.875em;float: right;'>(????????? ?????? ????????? ?????????????????? ?????? ???????????????.)</span>"
                + "			</div>"
                + "			<div class='thead_tr2' style='width: 700px;height: 35px;background: #f3f9fe;border-top: 1px solid #0c82e9;border-bottom: 1px solid #0c82e9;'>"
                + "				<div class='thead_td2' style='float: left;width: 33.3%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                + "				??????" + "				</div>"
                + "				<div class='thead_td2' style='float: left;width: 33.3%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                + "				????????????" + "				</div>"
                + "				<div class='thead_td2' style='float: left;width: 33.3%;text-align: center;font-size: 0.875em;color: #0c82e9;padding-top: 9px;'>"
                + "				?????????" + "				</div>" + "			</div>" + getEquiHtml(sdto) + "		</div>"
                + "	</div>"
                + "	<div class='footer' style='width: 780px;height: 60px;padding: 20px;text-align: center;font-size: 0.75em; margin: auto;'>"
                + "	??? ????????? ???????????? ?????????. ????????? ????????? ??????????????? ????????? ????????? ????????????.	" + "	</div>" + "</body>" + "</html>";
        body.append(footer);

        String from = "sdotmailtest@gmail.com";
        List<String> mailList = new ArrayList<>();

        // ClassPathResource resource = new ClassPathResource("mailList.txt");
        // File file = resource.getFile();
        // Scanner scan = new Scanner(file);

        // while (scan.hasNextLine()) {
        // mailList.add(scan.nextLine());
        // }

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

        // html to pdf
        makepdf(BODY, today);

        // makeLogFile("", "end");

    }

    public void makepdf(String BODY, String today) throws IOException {

        String FONT = mailSourcePath + "malgun.ttf";
        String DST = mailSourcePath + today + "_report.pdf";

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
        String type = "report";
        String msgBody = "S-DOT Report Mail";
        makeMsg(type, msgBody);
        // HtmlConverter.convertToPdf(new File(src), new File(dest), properties);
    }

    // mail ?????? ??????
    public void makeMsg(String type, String msgBody) throws IOException {
        List<String> mailList = new ArrayList<>();
        ClassPathResource resource = new ClassPathResource("mailList.txt");
        File file = resource.getFile();
        Scanner scan = new Scanner(file);

        while (scan.hasNextLine()) {
            mailList.add(scan.nextLine());
        }

        String txt;
        String fileName;

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat format2 = new SimpleDateFormat("yyyyMMddHHmm");
        String date = format.format(cal.getTime());
        String date2 = format2.format(cal.getTime());

        // ?????? ??????????????????
        if (type.equals("report")) {
            int Cnt = 0;
            for (String mail : mailList) {
                txt = "CLIENT_KEY:600e5c813fb457b41756bab8\n" + "MAIL_FROM:iotadmin@seoul.go.kr\n" + "RCPT_TO:" + mail
                        + "\nTO_HEADER:" + mail + "\nSUBJECT:[S-DOT] " + date + " S-DOT Report Mail\n" + "ATTACH:"
                        + mailSourcePath + date + "_report.pdf\n" + "ISSECURITY:0\n" + "SECU_HINT:\n" + "SECU_KEY:\n\n"
                        + msgBody;
                fileName = mailSpoolPath + date + "_REPORT_Mail" + Cnt + ".msg";
                ++Cnt;
                File mailFile = new File(fileName);
                FileWriter fw = new FileWriter(mailFile);
                fw.write(txt);
                fw.flush();
                fw.close();
            }
            // ?????? ????????? ??????
        } else {
            int errCnt = 0;
            for (String mail : mailList) {
                txt = "CLIENT_KEY:600e5c813fb457b41756bab8\n" + "MAIL_FROM:iotadmin@seoul.go.kr\n" + "RCPT_TO:" + mail
                        + "\nTO_HEADER:" + mail + "\nSUBJECT:[S-DOT] " + date + " S-DOT ERROR ALRAM MAIL\n"
                        + "ATTACH:\n" + "ISSECURITY:0\n" + "SECU_HINT:\n" + "SECU_KEY:\n\n"
                        + date2 + " S-DOT ERROR OCCURED \n" + msgBody;
                fileName = mailSpoolPath + date2 + "_ERROR_ALRAM_MAIL" + errCnt + ".msg";
                ++errCnt;
                File mailFile = new File(fileName);
                FileWriter fw = new FileWriter(mailFile);
                fw.write(txt);
                fw.flush();
                fw.close();
            }
        }

    }

    // // WAS???????????? ??????, ??? 5?????????
    // @Scheduled(cron = "0 0/5 * * * *")
    // public void checkProcess() throws Exception {

    // int result = 0;
    // boolean flag = false;

    // String log = "";

    // try {
    // // dotapi ??????
    // if ((result = api()) == 6) {
    // log += "dotapi process check : OK \n";
    // flag = true;
    // } else {
    // log += "dotapi process check : ERROR(COUNT: " + result + ")\n";
    // }

    // // dotmtr ??????
    // if ((result = mtr()) == 4) {
    // log += "dotmtr process check : OK \n";
    // flag = true;
    // } else {
    // log += "dotmtr process check : ERROR(COUNT: " + result + ")\n";
    // }

    // // batch??????
    // if ((result = batch()) == 2) {
    // log += "batch process check : OK \n";
    // flag = true;
    // } else {
    // log += "batch process error : ERROR(COUNT: " + result + ")\n";
    // }

    // // kafka ??????
    // if ((result = kafka()) == 1) {
    // log += "kafka process check : OK \n";
    // flag = true;
    // } else {
    // log += "kafka process check : ERROR(COUNT: " + result + ")\n";
    // }

    // String type = "alram";
    // if (flag) {
    // makeMsg(type, log);
    // }

    // makeProcessCheckLog(log);

    // } catch (Exception e) {

    // }

    // }

    // ????????? ??????, 24?????? ??? 10?????????(9?????????)
    @Scheduled(cron = "0 9/10 * * * *")
    public void checkReceive() throws Exception {
        Calendar cal = Calendar.getInstance();
        //?????? ??????
        SimpleDateFormat hourM = new SimpleDateFormat("HHmm");
        String hourMM = hourM.format(cal.getTime());
  
       
        //????????? ????????? 
        double receive_rate = commonService.getNormalCntRealTime();

        
        
        String type = "alram";

        String log = "";

        //???????????? 0??? 9?????? ?????? 80??? ???????????? ?????? 
        if(hourMM.equals("0009")){
            if (receive_rate <= 80) {
                log = "RECEIVE RATE CHECK : UNDER 80% (CURRENT : " + receive_rate + "%)";
               makeMsg(type, log);
            } else {
                log = "RECEIVE RATE CHECK : OK (" + receive_rate + "%)";
            }


        }else{
            if (receive_rate <= 90) {
                log = "RECEIVE RATE CHECK : UNDER 90% (CURRENT : " + receive_rate + "%)";
               makeMsg(type, log);
            } else {
                log = "RECEIVE RATE CHECK : OK (" + receive_rate + "%)";
            }

        }



        makeProcessCheckLog(log);

    }

    // check ?????? ??????
    public void makeProcessCheckLog(String log) throws Exception {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
        SimpleDateFormat logformat = new SimpleDateFormat("yyyyMMdd");
        String Date = format.format(cal.getTime());
        String logformatDate = logformat.format(cal.getTime());

        String content = Date + "\n" + log + "\n================================================\n";

        String fileName = processLogPath + logformatDate;
        File logFile = new File(fileName);
        FileWriter fw = new FileWriter(logFile, true);
        fw.write(content);
        fw.flush();
        fw.close();
    }

    public static int api() throws Exception {
        String s;
        Process p;
        int apiCnt = 0;

        String[] cmd = { "/bin/sh", "-c", "ps -ef | grep python|grep -v grep|grep dotapi" };
        p = Runtime.getRuntime().exec(cmd);
        BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
        while ((s = br.readLine()) != null) {
            System.out.println(s);
            apiCnt++;
        }

        p.waitFor();

        p.destroy();

        return apiCnt;

    }

    public static int mtr() throws Exception {
        String s;
        Process p;
        int mtrCnt = 0;

        String[] cmd = { "/bin/sh", "-c", "ps -ef | grep python|grep -v grep|grep dotmtr" };
        p = Runtime.getRuntime().exec(cmd);
        BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
        while ((s = br.readLine()) != null) {
            System.out.println(s);
            mtrCnt++;
        }
        p.waitFor();
        p.destroy();

        return mtrCnt;
    }

    public static int batch() throws Exception {
        String s;
        Process p;
        int batchCnt = 0;

        String[] cmd = { "/bin/sh", "-c", "ps -ef | grep python|grep -v grep|grep seoul_batch" };
        p = Runtime.getRuntime().exec(cmd);
        BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
        while ((s = br.readLine()) != null) {
            System.out.println(s);
            batchCnt++;
        }

        p.waitFor();
        p.destroy();

        return batchCnt;

    }

    public static int kafka() throws Exception {
        String s;
        Process p;
        int kafkaCnt = 0;

        String[] cmd = { "/bin/sh", "-c", "ps -ef | grep python|grep -v grep|grep seoul_http_was_kafka.py" };
        p = Runtime.getRuntime().exec(cmd);
        BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
        while ((s = br.readLine()) != null) {
            System.out.println(s);
            kafkaCnt++;
        }

        p.waitFor();
        p.destroy();

        return kafkaCnt;

    }

}
