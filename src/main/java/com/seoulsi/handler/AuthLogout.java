package com.seoulsi.handler;

import java.io.IOException;
import java.security.Principal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

@Component
public class AuthLogout implements LogoutSuccessHandler {
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		 if (authentication != null && authentication.getDetails() != null) {
	            try {
	                 request.getSession().invalidate();
	                 logger.warn("로그아웃 / 접속 ID : "+request.getParameter("userId")+" / 접속 IP : "+request.getRemoteAddr());
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        } 
	        response.setStatus(HttpServletResponse.SC_OK);
	        response.sendRedirect("/login");
	    }
	}
