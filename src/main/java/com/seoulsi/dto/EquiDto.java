package com.seoulsi.dto;

import lombok.Data;

@Data
public class EquiDto extends EquLoc{
	private String equiInfoKey;
	private String equiType;
	private String staName;
	private String instLoc;
	private String instLoc2;
	private String locInfo;
	private String gpsAbb;
	private String gpsLat;
	private String senseTp;
	private String useTp1;
	private String useTp2;
	private String useTp3;
	private String guTp;
	private String instYear;
	private String instMonth;
	private String mngNum;
	private String etc;
	private String setYn;
	private String useYn;
	private String baramYn;
	private String baramMngNum;
	private String baramNm;
	private String airYn;
	private String airMngNum;
	private String regDate;
	private String vistorSenId;
	private String vistorSenViewNm;

	/**
	 * 2022-03-07 요소추가
	 */

	private String adminDong;
	private String courtDong;
	private String cctvNumber;
	private String instPlace;
}
