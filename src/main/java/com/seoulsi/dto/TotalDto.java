package com.seoulsi.dto;

import lombok.Data;

@Data
public class TotalDto {

	private String wareTp;
	private String timeCheck;
	private String dataCheck;
	private int wareCnt;

	private String wareName;
	private String lastDate;
}
