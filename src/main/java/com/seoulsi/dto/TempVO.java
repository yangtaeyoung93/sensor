package com.seoulsi.dto;

import lombok.Getter;

@Getter
public class TempVO {
    private String path;
    private String equiInfoKey;
    private String flag;
    private String grpFlag;
    private String regDate;

    public TempVO(){

    }

    public TempVO (String path, String equiInfoKey, String flag,String grpFlag, String regDate){
        this.path = path;
        this.equiInfoKey = equiInfoKey;
        this.flag = flag;
        this.grpFlag = grpFlag;
        this.regDate = regDate;
    }

    public TempVO (String path, String equiInfoKey, String flag, String regDate){
        this.path = path;
        this.equiInfoKey = equiInfoKey;
        this.flag = flag;
        this.regDate = regDate;
    }


}
