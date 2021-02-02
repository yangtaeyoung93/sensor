package com.seoulsi.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LoginDto {
	private String userId;
	private String userAction;
	private String userIp;
	private String userReason;
	private int userStatus;
	private String regDate;
	
	public LoginDto(String userId, String userAction) {
		this.userId=userId;
		this.userAction=userAction;
	}
	public LoginDto(String userId, String userAction, String userIp) {
		this.userId=userId;
		this.userAction=userAction;
		this.userIp=userIp;
	}
}
