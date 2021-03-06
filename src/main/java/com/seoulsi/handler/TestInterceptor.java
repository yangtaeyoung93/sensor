package com.seoulsi.handler;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.seoulsi.dto.LoginDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.MenuDto;
import com.seoulsi.dto.PropertiesDto;
import com.seoulsi.service.AdminService;
import com.seoulsi.service.CommonService;
import com.seoulsi.service.LoginService;
import com.seoulsi.service.SettingService;
import com.seoulsi.util.AES256Util;
import com.seoulsi.util.CookieLoginUtil;
import com.seoulsi.util.SeedScrtyUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class TestInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private CommonService commonService;

	@Autowired
	private AdminService adminService;

	@Autowired
	private SettingService settingService;

	@Autowired
	private LoginService loginService;

	@Autowired
	private PropertiesDto pdto;

	@Value("${spring.profiles.active}")
	private String active;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 쿠키값 가져오기
		Optional<Map<String, String>> cOp = Optional.ofNullable(CookieLoginUtil.getCookie(request));
		Map<String, String> cookieMap = null;
		if (cOp.isPresent()) {
			cookieMap = CookieLoginUtil.getCookie(request);
		}
		// 쿠키 유무 확인
		if (!cookieNullCheck(cookieMap)) {

			// 개발서버의 경우
			if (active.equals("local")) {
				devAccount(response);
			} else {
				expiredAccount(request, response);
			}
			return false;
		}

		// cookie expire 체크
		Long loginTime = Long.parseLong(SeedScrtyUtil.decryptCBCText(cookieMap.get("SDOT_LOGIN_DATE")));
		Long expirationTime = Long.parseLong(SeedScrtyUtil.decryptCBCText(cookieMap.get("SDOT_LOGIN_EXPIRATION_TIME")));
		if (active.equals("local")) {
			expirationTime = expirationTime * 10000;
		}

		Long calcTime = loginTime + expirationTime;

		String userName = SeedScrtyUtil.decryptCBCText(cookieMap.get("SDOT_NAME"));
		String userId = SeedScrtyUtil.decryptCBCText(cookieMap.get("SDOT_ID"));
		String email = SeedScrtyUtil.decryptCBCText(cookieMap.get("SDOT_EMAIL"));

		// true 시간안됨 false 시간초과 로그인풀기
		if (CookieLoginUtil.expireTime(calcTime)) {
			AES256Util aes = new AES256Util(pdto.getPassPhraseDB());
			String id = aes.encrypt(userId);

			// 로그인 히스토리 추가 (로그인 쿠키가 없으면)
			if (cookieMap.get("init") == null) {
				log.info("history = {}");
				response.addCookie(new Cookie("init", "true"));
				LoginDto ldto = new LoginDto();
				ldto.setUserId(id);
				ldto.setUserAction("LoginSuccess");
				ldto.setUserIp(request.getRemoteAddr());
				ldto.setUserReason("로그인");
				ldto.setUserStatus(1);
				loginService.insertLoginHistory(ldto);
			}

			// System.out.println("interceptor : " + id);
			MenuDto mdto = new MenuDto();
			mdto.setUserId(id);
			List<MenuDto> menuList = commonService.getMenu(id);
			// 첫로그인 유저를 위해 메뉴 있는지 검색
			if (menuList.size() == 0) {
				// 로그인 성공이지만 메뉴가 없음.
				for (MenuDto medto : commonService.getMenuId()) {
					// 9xx 번대 처리
					if (medto.getMenuId().contains("9")) {
						medto.setUserId(id);
						commonService.insertGrantMenuN(medto);
					} else {
						final String[] defaultMenu = { "sensor/index", "sensor/map", "sensor/item", "sensor/state",
								"sensor/statistic", "statistic/person", "statistic/term", "admin/index", "admin/card",
								"admin/cardLocation", "admin/cardMap" };

						if (Arrays.stream(defaultMenu).anyMatch(medto.getPath()::equals)) {
							// 일반 유저 권한 부여
							medto.setUserId(id);
							commonService.insertGrantMenu(medto);
						} else {
							medto.setUserId(id);
							commonService.insertGrantMenuN(medto);
						}
					}
				}
				// 유저 관리를 위해 유저 등록
				MemberDto member = new MemberDto();
				member.setDeptCd("2");
				member.setUserId(id);
				member.setUserName(aes.encrypt(userName));
				member.setEmailAddr(aes.encrypt(email));
				member.setHandPhone(aes.encrypt(""));
				member.setUserPw(aes.encrypt(""));
				member.setTelNo(aes.encrypt(""));
				member.setEtc("");
				settingService.insertUser(member);
			}
			// 해당 메뉴 권한 확인
			MenuDto menu = new MenuDto();
			menu.setUserId(id);
			menu.setPath(request.getRequestURI().substring(1, request.getRequestURI().length()));
			Optional<MenuDto> grant = Optional.ofNullable(adminService.getWriteGrant(menu));
			if (!grant.isPresent() || grant.get().getGrantYn().equals("N")) {
				if (!menu.getPath().contains("api")) {
					response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
					response.setCharacterEncoding("UTF-8");
					response.setContentType("text/html; charset=UTF-8");
					response.getWriter().print(
							"<script type='text/javascript' src='../../share/js/jquery-1.12.4.min.js'></script>");
					response.getWriter().print("<script src='../../share/alertifyjs/alertify.min.js'></script>");
					response.getWriter().print(
							"<link rel='stylesheet' type='text/css' href='../../share/alertifyjs/css/alertify.min.css'/>");
					response.getWriter().print(
							"<link rel='stylesheet' type='text/css' href='../../share/alertifyjs/css/bootstrap.min.css'/>");
					response.getWriter().print(
							"<body><script>alertify.alert('에러','메뉴 권한이 없습니다.', function(){ location.href='/sensor/index'})</script><body>");
					response.getWriter().flush();
					return false;
				}
			}
			menuList = commonService.getGrantMenu(id);
			List<MenuDto> parseMenu = new ArrayList<>();

			request.setAttribute("userName", userName);
			for (MenuDto medto : menuList) {
				if (medto.getMenuId().contains("9")) {
					request.setAttribute(medto.getMenuId(), true);
				} else {
					parseMenu.add(medto);
				}
			}
			request.setAttribute("menu", parseMenu);
			request.setAttribute("grant", grant.get().getWriteGrantYn());
			request.setAttribute("read", grant.get().getGrantYn());

		} else {
			// 만료됨
			System.out.println("만료됨");
			expiredAccount(request, response);
			return false;
		}

		return true;
	}

	public void expiredAccount(HttpServletRequest request, HttpServletResponse response) throws IOException {
		StringBuffer referer = request.getRequestURL();

		response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter()
				.print("<script type='text/javascript' src='../../share/js/jquery-1.12.4.min.js'></script>");
		response.getWriter().print("<script src='../../share/alertifyjs/alertify.min.js'></script>");
		response.getWriter()
				.print("<link rel='stylesheet' type='text/css' href='../../share/alertifyjs/css/alertify.min.css'/>");
		response.getWriter()
				.print("<link rel='stylesheet' type='text/css' href='../../share/alertifyjs/css/bootstrap.min.css'/>");
		response.getWriter().print(
				"<body><script>alertify.alert('에러','서울시 IoT 도시데이터플랫폼 로그인을 통해 S-DoT 운영시스템에 접속할 수 있습니다.', function(){ location.href='//iothub.eseoul.go.kr/admin/login.do?referer="
						+ URLEncoder.encode(referer.toString(), "UTF-8") + "'})</script><body>");
		response.getWriter().flush();
	}

	public void devAccount(HttpServletResponse response) throws IOException {
		Cookie cookie = new Cookie("SDOT_LOGIN_DATE", "NKzkFdU3BLUhFP7EYmj8gA==");
		Cookie cookie2 = new Cookie("SDOT_NAME", "NQ900k4+E5qf9ldwdgbRNQ==");
		Cookie cookie3 = new Cookie("SDOT_LOGIN_EXPIRATION_TIME", "Kp+tc7FNhuZEeMyNctLDWQ==");
		Cookie cookie4 = new Cookie("SDOT_ID", "nZmONxz1Y7chjz4yA+Q8NQ==");
		Cookie cookie5 = new Cookie("SDOT_EMAIL", "nZmONxz1Y7chjz4yA+Q8NQ==");
		response.addCookie(cookie);
		response.addCookie(cookie2);
		response.addCookie(cookie3);
		response.addCookie(cookie4);
		response.addCookie(cookie5);

		response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter()
				.print("<script type='text/javascript' src='../../share/js/jquery-1.12.4.min.js'></script>");
		response.getWriter().print("<script src='../../share/alertifyjs/alertify.min.js'></script>");
		response.getWriter()
				.print("<link rel='stylesheet' type='text/css' href='../../share/alertifyjs/css/alertify.min.css'/>");
		response.getWriter()
				.print("<link rel='stylesheet' type='text/css' href='../../share/alertifyjs/css/bootstrap.min.css'/>");
		response.getWriter().print(
				"<body><script>alertify.alert('에러','개발 서버 실행중 쿠키가 없어 새로고침됩니다.', function(){ location.reload();})</script><body>");
		response.getWriter().flush();
	}

	public Boolean cookieNullCheck(Map<String, String> cookies) {
		String[] cookieName = { "SDOT_LOGIN_DATE", "SDOT_LOGIN_EXPIRATION_TIME", "SDOT_NAME", "SDOT_ID" ,"SDOT_EMAIL"};
		if (cookies == null) {
			return false;
		}
		for (String name : cookieName) {
			Optional<String> cOp = Optional.ofNullable(cookies.get(name));
			if (!cOp.isPresent()) {
				return false;
			}
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object object, Exception arg3)
			throws Exception {
	}

}
