package com.seoulsi.controller;

import java.security.Principal;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.seoulsi.dto.AuthenticationDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.service.MemberService;

@Controller
public class LoginController {

	@Autowired
	private MemberService memberService;

	Logger logger = LoggerFactory.getLogger(LoginController.class);

	public String logout(HttpServletRequest request, HttpServletResponse response, Principal principal)
			throws Exception {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		AuthenticationDto adto = (AuthenticationDto) principal;
		MemberDto mdto = adto.getUser();
		mdto.setLoginStatus("00");
		memberService.loginSuccess(mdto);
		logger.warn("로그인 만료 / 접속 ID : " + mdto.getUserId() + " / 접속 IP : " + request.getRemoteAddr());
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}

		return "redirect:/login";
	}

	@GetMapping("/login")
	public String sensorMap() throws Exception {

		return "redirect:/";
	}

}
