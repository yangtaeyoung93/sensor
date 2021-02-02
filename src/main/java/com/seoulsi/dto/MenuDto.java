package com.seoulsi.dto;

import java.io.UnsupportedEncodingException;

import com.seoulsi.util.AES256Util;

import lombok.Data;

@Data
public class MenuDto {
	private final String passPhrase = "seoulsiDBEncrypt";
	
	private String userId;
	private String step;
	private String menuId;
	private String caption;
	private String workTime;
	private String useYn;
	private String path;
	private String grantYn;
	private String writeGrantYn;
	
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
}
