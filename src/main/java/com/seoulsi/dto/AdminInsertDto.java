package com.seoulsi.dto;

import lombok.Data;

@Data
public class AdminInsertDto {
	private String obstMgrKey;
	private String equiInfoKey;
	private String userId;
	private String obstText;
	private String obstDate;
	private String obstModel;
	private String obstRecoDate;
	private String obstRecoText;
	private String obstRecoComp;
	private String obstRecoMan;
	private String obstFileFlag;
	private String obstFileRoot;
	private String obstUseFlag;
	private String regDate;
}
