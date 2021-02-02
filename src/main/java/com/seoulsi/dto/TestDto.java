package com.seoulsi.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TestDto {
	private int dbId;
	private String dbName;
	private String category;
	private String dbQuery;
	private String fnName;
	private String regDate;
	private byte[] picFront;
	private byte[] picBack;
	private byte[] picSide;
	private String picFrontType;
	private String picBackType;
	private String picSideType;
	public int getDb_id() {
		return dbId;
	}
	public void setDb_id(int db_id) {
		this.dbId = db_id;
	}
	public String getDbName() {
		return dbName;
	}
	public void setDbName(String dbName) {
		this.dbName = dbName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDbQuery() {
		return dbQuery;
	}
	public void setDbQuery(String dbQuery) {
		this.dbQuery = dbQuery;
	}
	public String getFnName() {
		return fnName;
	}
	public void setFnName(String fnName) {
		this.fnName = fnName;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
	
	
}
