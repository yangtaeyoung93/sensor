package com.seoulsi.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.seoulsi.dto.LoginDto;

@Mapper
public interface LoginMapper {

	public void insertLoginHistory(LoginDto ldto) throws Exception;
	public void updateLoginHistoryStatus(LoginDto ldto) throws Exception;
	public int selectLoginHistory(LoginDto ldto) throws Exception;
	public LoginDto getChangeDate(String userId) throws Exception;
	
	
}
