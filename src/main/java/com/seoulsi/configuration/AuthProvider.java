package com.seoulsi.configuration;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Component;

import com.seoulsi.dto.AuthenticationDto;
import com.seoulsi.dto.LoginDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.MenuDto;
import com.seoulsi.dto.PropertiesDto;
import com.seoulsi.service.CommonService;
import com.seoulsi.service.LoginService;
import com.seoulsi.service.MemberService;
import com.seoulsi.util.AES256Util;
import com.seoulsi.util.HashUtil;

@Component("authProvider")
public class AuthProvider implements AuthenticationProvider {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private Log log = LogFactory.getLog(this.getClass());
	private final String LOGIN_FAIL = "loginFail";
	private final String LOGIN_STATUS = "01";
	private final String ADMIN = "ADMIN";
	@Autowired
	private MemberService memberService;

	@Autowired
	private CommonService commonService;

	@Autowired
	private LoginService loginService;

	@Autowired
	private PropertiesDto pdto;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		try {
			logger.info("{}", authentication);
			String enc = authentication.getCredentials().toString();
			WebAuthenticationDetails details = (WebAuthenticationDetails) authentication.getDetails();

			String[] credentials = enc.split(" ");
			String name = authentication.getName();
			String ciphertext = credentials[0];
			String iv = credentials[0];
			String salt = credentials[0];
			if (name == null || ciphertext.equals("")) {
				return null;
			}
			logger.info(ciphertext, iv, salt);
			int keySize = pdto.getKeySize();
			int iterationCount = pdto.getIterationCount();
			String passPhrase = pdto.getPassPhrase();

			AES256Util aes = new AES256Util(pdto.getPassPhraseDB());
			String id = aes.encrypt(name);
			String password = HashUtil.sha256(HashUtil.decryptAES(salt, iv, passPhrase, ciphertext, iterationCount, keySize));
			//UserRole ur = new UserRole();
			MemberDto mdto = memberService.getDetailByUserName(id);
			int count = loginService.selectLoginHistory(new LoginDto(id, LOGIN_FAIL));

			logger.warn("{} / {} / {}", id, password, mdto.getUserPw());
			if (null == mdto || !mdto.getUserPw().equals(password) || count > 5) {
				logger.warn("fail");
				return null;
			} else {
				String regDate = loginService.getChangeDate(id).getRegDate();
				if (regDate != null) {
					if (Float.parseFloat(regDate) > 90) {
						return null;
					}
				}
			}
			mdto.setLoginStatus(LOGIN_STATUS);
			memberService.loginSuccess(mdto);

			String userRole = "";

			if (mdto.getRole() != null && mdto.getRole().equals(ADMIN)) {
				userRole = "ROLE_" + mdto.getRole();
			} else {
				userRole = "ROLE_USER";
			}

			List<GrantedAuthority> grantedAuthorityList = new ArrayList();
			grantedAuthorityList.add(new SimpleGrantedAuthority(userRole));

			// 메뉴권한
			List<MenuDto> menuGrant = commonService.getGrantMenu(mdto.getUserId());
			mdto.setMenuGrant(menuGrant);

			// 로그인 기록
			LoginDto ldto = new LoginDto(id, "LoginSuccess", details.getRemoteAddress());
			//ldto.setUserStatus(0);
			loginService.insertLoginHistory(ldto);
			ldto.setUserAction(LOGIN_FAIL);
			//ldto.setUserStatus(0);
			loginService.updateLoginHistoryStatus(ldto);
			//
			mdto.setUserName(aes.decrypt(mdto.getUserName()));

			log.warn("로그인 성공 / 접속 ID : " + authentication.getName() + " / 접속 IP : " + details.getRemoteAddress());

			return new AuthenticationDto(mdto, mdto.getUserPw(), grantedAuthorityList, mdto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
}
