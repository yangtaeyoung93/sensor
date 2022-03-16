package com.seoulsi.dto;

import lombok.Data;

@Data
public class WareDto {

   private String workDt;
   private String workTm;
   private String swHwTp;
   private String chgTp;
   private String chgReason;
   private String bigo;
   private String workYmd;
   private String equiInfoKey;

   private String toDate;
   private String fromDate;

   /**
    * 2022-03-10 요소추가
    */
   private Long id;
}