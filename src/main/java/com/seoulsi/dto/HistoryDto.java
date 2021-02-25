package com.seoulsi.dto;

import lombok.Data;

@Data
public class HistoryDto extends EquLoc {
	private String userId;
	private String userName;
	private String userAction;
	private String userReason;
	private String regDate;
}
