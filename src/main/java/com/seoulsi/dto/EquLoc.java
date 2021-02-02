package com.seoulsi.dto;

import lombok.Data;

@Data
public class EquLoc extends EquLocDetail{
	private String equiInfoKey;
	private String equiStru;
	private String superDeptCd;
	private String deptCd;
	private String mngNmJung;
	private String mngNmJungTel;
	private String mngNmBu;
	private String totOpin;
	private int instMoney;
	private String workYmd;
}
