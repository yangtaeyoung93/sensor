package com.seoulsi.util;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class CookieLoginUtil {

    /**
     * <PRE>
     * 1. MethodName : expireTime
     * 2. ClassName  : CookieLoginUtil
     * 3. Comment   : 로그인 만료시간 체크
     * </PRE>
     *
     * @param orgnStr
     * @return
     */
    public static Boolean expireTime(Long time) {
        Long cal = Calendar.getInstance().getTimeInMillis();

        // time - cal 음수: 통과, 양수: 실패
        return time - cal > 0;
    }

    /**
     * <PRE>
     * 1. MethodName : cookieParser
     * 2. ClassName  : CookieLoginUtil
     * 3. Comment   : 복호화 후 쿠키값 생성
     * </PRE>
     *
     * @param orgnStr
     * @return
     */
    public static Map<String, String> cookieParser(String enc) {
        String decCookie = SeedScrtyUtil.decryptCBCText(enc);
        String[] decArray = decCookie.split(";");
        Map<String, String> cookieMap = new HashMap<>();

        for (String dec : decArray) {
            String[] decObj = dec.split("=");
            if (decObj.length > 1) {
                cookieMap.put(decObj[0], decObj[1]);
            }
        }

        return cookieMap;
    }

    /**
     * <PRE>
     * 1. MethodName : getValue
     * 2. ClassName  : CookieLoginUtil
     * 3. Comment   : 쿠키를 전부 가져온다.
     * </PRE>
     *
     * @param orgnStr
     * @return
     */
    public static Map<String, String> getCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        Map<String, String> cookieMap = new HashMap<>();
        if (cookies != null && cookies.length != 0) {
            for (Cookie cookie : cookies) {
                cookieMap.put(cookie.getName(), cookie.getValue());
            }
        } else {
            return null;
        }

        return cookieMap;
    }

}
