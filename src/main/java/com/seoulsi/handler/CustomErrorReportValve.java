package com.seoulsi.handler;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.logging.Logger;

import org.apache.catalina.connector.Request;
import org.apache.catalina.connector.Response;
import org.apache.catalina.valves.ErrorReportValve;

public class CustomErrorReportValve extends ErrorReportValve {

    // Create a simple logger
    private static final Logger logger = Logger.getLogger(CustomErrorReportValve.class.getName());


    @Override
    protected void report(Request request, Response response, Throwable t) {
        try {
            BufferedWriter out = new BufferedWriter(new OutputStreamWriter(response.getOutputStream(), "UTF8"));
            out.write("<html lang=\"en\">");
            out.write("    <head>");
            out.write("        <title></title>");
            out.write("        <meta charset=\"UTF-8\">");
            out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
            out.write("        <!-- CSS & JS ADD -->");
            out.write("        <link rel=\"stylesheet\" href=\"/share/css/common.css\">");
            out.write("        <link rel=\"stylesheet\" href=\"/share/css/login.css\">");
            out.write("        ");
            out.write("		<link rel=\"stylesheet\" type=\"text/css\" href=\"/share/alertifyjs/css/bootstrap.min.css\"/>");
            out.write("		<style>");
            out.write("			@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);");
            out.write("			body {");
            out.write("			    font-family: \"Nanum Gothic\", sans-serif;");
            out.write("			}");
            out.write("		</style>");
            out.write("    </head>");
            out.write("    <body>");
            out.write("        <div id=\"login\" class=\"container\">");
            out.write("            <div class=\"row\">");
            out.write("                <img src=\"/img/common/seoul_login_logo1.png\"/>");
            out.write("            </div>");
            out.write("            <div class=\"row\">");
            out.write("                <h1 style=\"font-size:60px; color: red;\">400!</h1>");
            out.write("                <h3>잘못된 요청입니다.</h3>");
            out.write("                <button href=\"/\" type=\"submit\" class=\"submit common-btn\" style=\"margin-top:30px;\" onclick=\"location.href='/'\">홈으로 돌아가기</button>");
            out.write("            </div>");
            out.write("            ");
            out.write("            <div class=\"row\">");
            out.write("                <img src=\"/img/common/seoul_login_logo2.png\"/>");
            out.write("            </div>");
            out.write("        </div>");
            out.write("    </body>");
            out.write("</html>");
            out.close();

            // Log the error with your favorite logging framework...
            logger.severe("Uncaught throwable was thrown: " + t.getMessage());

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
