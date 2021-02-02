package com.seoulsi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seoulsi.dto.CardDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.TestDto;
import com.seoulsi.dto.extend.ParamDto;
import com.seoulsi.mapper.TestMapper;

@Service
public class testService implements TestMapper{
  @Autowired
  private TestMapper testMapper;

  public List<TestDto> getDual() throws Exception {
    return testMapper.getDual();
  }

@Override
public List<MemberDto> getUserCode() throws Exception {
	// TODO Auto-generated method stub
	return testMapper.getUserCode();
}

@Override
public void testFile(TestDto tdto) throws Exception {
	// TODO Auto-generated method stub
	testMapper.testFile(tdto);
}

@Override
public List<CardDto> getTestFile(ParamDto pdto) {
	// TODO Auto-generated method stub
	return testMapper.getTestFile(pdto);
}
}