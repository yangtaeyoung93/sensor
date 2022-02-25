package com.seoulsi.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SdotDTO {
    private String target;
    private String tp;
    private int instYear = -1;
}
