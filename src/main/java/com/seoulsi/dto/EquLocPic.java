package com.seoulsi.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
public class EquLocPic {
	private String equiInfoKey;

	private String equiArdWest;
	private String equiArdWestTp;

	private String equiArdEast;
	private String equiArdEastTp;

	private String equiArdSouth;
	private String equiArdSouthTp;

	private String equiArdNorth;
	private String equiArdNorthTp;

	private String instBefFrt;
	private String instBefFrtTp;

	private String instBefBack;
	private String instBefBackTp;

	private String instAftFrt;
	private String instAftFrtTp;

	private String instAftBack;
	private String instAftBackTp;

	private String equiInsLoc;
	private String equiInsLocTp;

	private String gpsAbb;
	private String gpsLat;

}
