package com.seoulsi.handler;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import com.seoulsi.dto.LoginDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.PropertiesDto;
import com.seoulsi.service.LoginService;
import com.seoulsi.service.MemberService;
import com.seoulsi.util.AES256Util;
import com.seoulsi.util.HashUtil;

@Component
public class AuthLoginFail extends SimpleUrlAuthenticationFailureHandler{
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PropertiesDto pdto;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException {
		
		try {
			AES256Util aes = new AES256Util(pdto.getPassPhraseDB());
			String id = aes.encrypt(request.getParameter("username"));
			String[] credentials = request.getParameter("pass").split(" ");
			
			
			String ciphertext = credentials[0];
			String iv = credentials[1];
			String salt = credentials[2];
			int keySize = pdto.getKeySize();
			int iterationCount = pdto.getIterationCount();
			String passPhrase = pdto.getPassPhrase();
			String password = HashUtil.decryptAES(salt, iv, passPhrase, ciphertext, iterationCount, keySize);
			
			MemberDto mdto = memberService.getDetailByUserName(id);
			Optional<MemberDto> optional = Optional.ofNullable(mdto);
			
			LoginDto ldto = new LoginDto(id, "LoginFail", request.getRemoteAddr());
			String path = "";
			int count = loginService.selectLoginHistory(ldto);
			
			if(request.getParameter("username").isEmpty()) {
				path="/login?empty";
			} 
			
			if(!optional.isPresent()) {
				ldto.setUserReason("userNotFound");
				path="/login?error";
			} 
			else if(!mdto.getUserPw().equals(HashUtil.sha256(password))) {
				ldto.setUserReason("invalid Password");
				path="/login?error";
			}
			else if(count>5){
				ldto.setUserReason("login lock");
				path="/login?lock";
			} 
			else if(Float.parseFloat(loginService.getChangeDate(id).getRegDate()) > 90) {
				ldto.setUserReason("password change required");
				path="/login?change";
			} 
				
			
			ldto.setUserStatus(1);
			loginService.insertLoginHistory(ldto);
			response.sendRedirect(path);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		logger.warn("로그인 실패 / 접속 ID : "+request.getParameter("username")+" / 접속 IP : "+request.getRemoteAddr());
	}
}
