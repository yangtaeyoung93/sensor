package com.seoulsi.dto;

import lombok.Data;

@Data
public class CardDto {
	private String equiInfoKey;
	private String equiKey;
	private String serialNm;
	private String manuCom;
	private String instYear;
	private String instMonth;
	private String sizeWidth;
	private String sizeHeight;
	private String sizeThick;
	private String sensorPm10;
	private String sensorPm25;
	private String sensorWind;
	private String sensorWindSp;
	private String sensorTemp;
	private String sensorHumi;
	private String sensorIllu;
	private String sensorNoise;
	private String sensorUv;
	private String sensorVisitor;
	private String sensorEtc;
	private String commTp;
	private String elecTp;
	private String swVersion;
	private String picFront;
	private String picSide;
	private String picBack;
	private String picFrontTp;
	private String picSideTp;
	private String picBackTp;
	private String workId;
	private String workTm;

	private String sensorCo;
	private String sensorNo2;
	private String sensorSo2;
	private String sensorNh3;
	private String sensorH2S;
	private String sensorO3;
	private String sensorEffeTemp;
	private String sensorVibr;

	private String guTp;
}
