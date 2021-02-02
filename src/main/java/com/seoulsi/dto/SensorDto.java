package com.seoulsi.dto;

import com.seoulsi.dto.extend.ParamDto;

import org.eclipse.jdt.internal.compiler.ast.Javadoc;

import lombok.Data;

@Data
public class SensorDto extends ParamDto {
	private String dotDataKey;
	private String equiInfoKey;
	private String equiInfoKeyHan;
	private String instLoc;
	private String addSeri;
	private String corrVer;
	private String tm10;
	private String tm8;
	private String tm6;
	private String pm25;
	private String pm10;
	private String pm25Han;
	private String pm10Han;
	private String pm1;
	private String temp;
	private String humi;
	private String windDire;
	private String windSpeed;
	private String gustDire;
	private String gustSpeed;
	private String inteIllu;
	private String ultraRays;
	private String noise;
	private String vibrX;
	private String vibrY;
	private String vibrZ;
	private String vibrXMax;
	private String vibrYMax;
	private String vibrZMax;
	private String effeTemp;
	private String senStat;
	private String etc1;
	private String etc2;
	private String etc3;
	private String pm25Std;
	private String pm10Std;
	private String pm1Std;
	private String regDate;
	private String gpsAbb;
	private String gpsLat;
	private String vistorSenId;
	private String vistorSenViewNm;
	private String vistorTm10;
	private String vistorTm8;
	private String vistorTm4;
	private int vistorCnt;
	private int timeCheck;
	private String guTp;
	private String baramYn;
	private String baramMngNum;
	private String airYn;
	private String airMngNum;
	private String senseTp;

	/**
	 * 20201005 요소 추가
	 */
	private String co;
	private String no2;
	private String so2;
	private String nh3;
	private String h2s;
	private String o3;

}
