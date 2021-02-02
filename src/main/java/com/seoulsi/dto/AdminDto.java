package com.seoulsi.dto;

import com.seoulsi.dto.extend.ParamDto;

import lombok.Data;

@Data
public class AdminDto extends ParamDto{
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
