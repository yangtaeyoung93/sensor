package com.seoulsi.dto;

import com.seoulsi.dto.extend.ParamDto;

import lombok.Data;

@Data
public class StatDto extends ParamDto {

	private String equiInfoKey;
	private String equiInfoKeyHan;
	private String firmVer;
	private String senStat;
	private String imei;
	private String ctn;
	private String rebootDate;
	private String resetOpt;
	private String fotaOpt;
	private String currVer;
	private String currFirmVer;
	private String pm25Stat;
	private String pm10Stat;
	private String pm1Stat;
	private String tempStat;
	private String humiStat;
	private String windDireStat;
	private String windSpeedStat;
	private String gustDireStat;
	private String gustSpeedStat;
	private String inteIlluStat;
	private String ultraRaysStat;
	private String noiseStat;
	private String vibrXStat;
	private String vibrYStat;
	private String vibrZStat;
	private String vibrXMaxStat;
	private String vibrYMaxStat;
	private String vibrZMaxStat;
	private String effeTempStat;
	private String etc1Stat;
	private String etc2Stat;
	private String etc3Stat;
	private String tm8;
	private String tm6;
	private String regDate;
	private String upDate;
	private String guTp;

	private String co;
	private String no2;
	private String so2;
	private String nh3;
	private String h2s;
	private String o3;

}
