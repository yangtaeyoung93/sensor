package com.seoulsi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seoulsi.dto.MemberDto;
import com.seoulsi.mapper.MemberMapper;

@Service
public class MemberService implements MemberMapper {

	@Autowired
	private MemberMapper memberMapper;

	public MemberDto getDetailByUserName(String userId) throws Exception {
		System.out.println("MEMBER" + userId);
		return memberMapper.getDetailByUserName(userId);
	}

	@Override
	public void loginSuccess(MemberDto mdto) throws Exception {
		// TODO Auto-generated method stub
		memberMapper.loginSuccess(mdto);
	}
}
