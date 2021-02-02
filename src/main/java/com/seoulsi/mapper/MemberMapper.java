package com.seoulsi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.seoulsi.dto.MemberDto;

@Mapper
public interface MemberMapper {
  public MemberDto getDetailByUserName(String userId) throws Exception;
  public void loginSuccess(MemberDto mdto) throws Exception;
}