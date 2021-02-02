package com.seoulsi.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class AuthLoginSuccess extends SimpleUrlAuthenticationSuccessHandler{
	public final Integer SESSION_TIMEOUT_IN_SECONDS = 60 * 60;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		WebAuthenticationDetails details = (WebAuthenticationDetails) authentication.getDetails();
		
		
		request.getSession().setMaxInactiveInterval(SESSION_TIMEOUT_IN_SECONDS);
		HttpSession session = request.getSession();
		System.out.println(session.getAttribute("prevPage"));
		super.onAuthenticationSuccess(request, response, authentication);
		
	}
}
