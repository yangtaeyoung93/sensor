package com.seoulsi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seoulsi.dto.LoginDto;
import com.seoulsi.mapper.LoginMapper;

@Service
public class LoginService implements LoginMapper {

	@Autowired
	private LoginMapper loginMapper;
	
	@Override
	public void insertLoginHistory(LoginDto ldto) throws Exception {
		// TODO Auto-generated method stub
		loginMapper.insertLoginHistory(ldto);
	}

	@Override
	public void updateLoginHistoryStatus(LoginDto ldto) throws Exception {
		// TODO Auto-generated method stub
		loginMapper.updateLoginHistoryStatus(ldto);
	}

	@Override
	public int selectLoginHistory(LoginDto ldto) throws Exception {
		// TODO Auto-generated method stub
		return loginMapper.selectLoginHistory(ldto);
	}

	@Override
	public LoginDto getChangeDate(String userId) throws Exception {
		// TODO Auto-generated method stub
		return loginMapper.getChangeDate(userId);
	}

}
