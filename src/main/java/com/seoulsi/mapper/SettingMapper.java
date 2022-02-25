package com.seoulsi.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.seoulsi.dto.CommonDto;
import com.seoulsi.dto.EquiDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.MenuDto;
import com.seoulsi.dto.ResultDto;
import com.seoulsi.dto.SettingDto;

@Mapper
public interface SettingMapper {
  public List<SettingDto> getGuEquiList() throws Exception;


  public List<CommonDto> getCommList() throws Exception;

  public List<EquiDto> getEquiInfo(String equiInfoKey) throws Exception;

  public void saveEquiInfo(EquiDto edto) throws Exception;

  public void insertEquiInfo(EquiDto edto) throws Exception;

  public void deleteEquiByEquiInfoKey(EquiDto edto) throws Exception;

  public void deleteCardByEquiInfoKey(EquiDto edto) throws Exception;

  public void deleteLocByEquiInfoKey(EquiDto edto) throws Exception;

  public void deleteLocDetailByEquiInfoKey(EquiDto edto) throws Exception;

  public void deleteLocPicByEquiInfoKey(EquiDto edto) throws Exception;

  public List<MemberDto> getUserCode() throws Exception;

  public List<MemberDto> getUserByCode(String code) throws Exception;

  public List<MemberDto> getUserInfo(String user) throws Exception;

  public void clearUser(MemberDto memberDto) throws Exception;

  public void updateUser(MemberDto memberDto) throws Exception;

  public void insertUser(MemberDto memberDto) throws Exception;

  public void deleteUser(MemberDto memberDto) throws Exception;

  public void deleteUserGrant(MemberDto memberDto) throws Exception;

  public void updateUserGrant(MenuDto menuDto) throws Exception;

  /**
   * 2022-02-17 년도 선택 추가
   */
  public List<SettingDto> getInstYear() throws Exception;

}