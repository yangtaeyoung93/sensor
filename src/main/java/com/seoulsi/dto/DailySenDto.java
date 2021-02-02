package com.seoulsi.dto;

import lombok.Data;

@Data
public class DailySenDto {
    private String tm8;
    private String equiType;
    private int equiCnt;
    private int normalEquiCnt;
    private int badEquiCnt;
    private int dataCnt;
    private int normalDataCnt;
    private int badDataCnt;
    private int percent;
}
