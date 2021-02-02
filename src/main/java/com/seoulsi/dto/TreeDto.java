package com.seoulsi.dto;

import java.util.List;

import lombok.Data;

@Data
public class TreeDto {
	private int id;
	private String text;
	private List<TreeNodeDto> children;
}
