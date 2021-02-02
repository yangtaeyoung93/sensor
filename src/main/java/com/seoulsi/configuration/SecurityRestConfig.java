package com.seoulsi.configuration;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import com.seoulsi.dto.MemberDto;

@Component
public class SecurityRestConfig implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException, ServletException {
		// TODO Auto-generated method stub
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			MemberDto mdto = (MemberDto) authentication.getPrincipal();
			System.out.println(mdto);
		} catch(Exception e) {
			response.sendError(response.SC_UNAUTHORIZED);
		}
	}

}
