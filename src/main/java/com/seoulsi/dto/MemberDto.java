package com.seoulsi.dto;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.seoulsi.util.AES256Util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
public class MemberDto extends MenuDto {
	private final String passPhrase = "seoulsiDBEncrypt";

	private String userId;
	private String userGrdKey;
	private String userPw;
	private String regDate;
	private String userName;
	private String telNo;
	private String handPhone;
	private String deptCd;
	private String emailAddr;
	private String loginStatus;
	private String etc;
	private String code;
	private List<MenuDto> menuGrant;
	private String role;

	public AES256Util aes() throws UnsupportedEncodingException {
		return new AES256Util(this.passPhrase);
	}

	public String getUserId() {
		try {
			return aes().decrypt(userId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return e.getMessage();
		}
	}

	public void setUserId(String userId) {
		try {
			this.userId = aes().encrypt(userId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getUserGrdKey() {
		return userGrdKey;
	}

	public void setUserGrdKey(String userGrdKey) {
		this.userGrdKey = userGrdKey;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getUserName() {
		try {
			return aes().decrypt(userName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return e.getMessage();
		}
	}

	public void setUserName(String userName) {
		try {
			this.userName = aes().encrypt(userName);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// public String getTelNo() throws NoSuchAlgorithmException,
	// UnsupportedEncodingException, GeneralSecurityException {
	// return aes().decrypt(telNo);

	// }

	// public void setTelNo(String telNo)
	// throws NoSuchAlgorithmException, UnsupportedEncodingException,
	// GeneralSecurityException {
	// this.telNo = aes().encrypt(telNo);

	// }

	public String getTelNo() {
		try {
			return aes().decrypt(telNo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return e.getMessage();
		}
	}

	public void setTelNo(String telNo) {
		try {
			this.telNo = aes().encrypt(telNo);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getHandPhone() {
		try {
			return aes().decrypt(handPhone);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return e.getMessage();
		}
	}

	public void setHandPhone(String handPhone) {
		try {
			this.handPhone = aes().encrypt(handPhone);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getDeptCd() {
		return deptCd;
	}

	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}

	public String getEmailAddr() {
		try {
			return aes().decrypt(emailAddr);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return e.getMessage();
		}
	}

	public void setEmailAddr(String emailAddr) {
		try {
			this.emailAddr = aes().encrypt(emailAddr);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getLoginStatus() {
		return loginStatus;
	}

	public void setLoginStatus(String loginStatus) {
		this.loginStatus = loginStatus;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public List<MenuDto> getMenuGrant() {
		return menuGrant;
	}

	public void setMenuGrant(List<MenuDto> menuGrant) {
		this.menuGrant = menuGrant;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

}
