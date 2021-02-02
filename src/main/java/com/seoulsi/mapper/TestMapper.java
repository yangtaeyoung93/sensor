package com.seoulsi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.seoulsi.dto.CardDto;
import com.seoulsi.dto.EquLocPic;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.TestDto;
import com.seoulsi.dto.extend.ParamDto;

@Mapper
public interface TestMapper {
  public List<TestDto> getDual() throws Exception;
  public List<MemberDto> getUserCode() throws Exception;
  public void testFile(TestDto tdto) throws Exception;
  public List<CardDto> getTestFile(ParamDto pdto);
}