package com.seoulsi.dto.extend;

import lombok.Data;

@Data
public class ParamDto {
	private String toDate;
	private String fromDate;
	private String total;
	private String pageStart;
	private String pageEnd;
	private int num;
	private String statisticType;
	private String type;
}
