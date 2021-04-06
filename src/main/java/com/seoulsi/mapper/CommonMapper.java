package com.seoulsi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.seoulsi.dto.CommonDto;
import com.seoulsi.dto.DailySenDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.MenuDto;
import com.seoulsi.dto.SensorDto;
import com.seoulsi.dto.extend.ParamDto;

@Mapper
public interface CommonMapper {
	public List<CommonDto> guList() throws Exception;

	public List<CommonDto> getCCList(String sortCd) throws Exception;

	public List<CommonDto> partList() throws Exception;

	public List<CommonDto> codeList() throws Exception;

	public List<CommonDto> codeListOne(String sortCd) throws Exception;

	public List<MenuDto> getGrantMenu(String userId) throws Exception;

	public List<MemberDto> getGrantMenuRequest(MemberDto mdto) throws Exception;

	public List<MenuDto> getMenuId() throws Exception;

	public void insertGrantMenu(MenuDto mdto) throws Exception;

	public void insertGrantMenuN(MenuDto mdto) throws Exception;

	public List<MenuDto> getMenu(String userId) throws Exception;

	public void codeListUpdate(CommonDto cdto) throws Exception;

	public void codeListRemove(CommonDto cdto) throws Exception;

	public void codeListSave(CommonDto cdto) throws Exception;

	public List<DailySenDto> getDailySenForDate(ParamDto paramDto) throws Exception;

	public List<DailySenDto> getDailyCntForEqui(ParamDto paramDto) throws Exception;

	public List<SensorDto> getDailyCntForEquiSensor(ParamDto paramDto) throws Exception;

	public List<SensorDto> getDailyCntForEquiSensorWind(ParamDto paramDto) throws Exception;

	public List<DailySenDto> getDailyCntForData(ParamDto paramDto) throws Exception;

	public List<DailySenDto> getDailyCntForDataForPastToday(ParamDto paramDto) throws Exception;

	public List<DailySenDto> getDailyCntForDataForToday(ParamDto paramDto) throws Exception;

	public List<DailySenDto> getDailyCntForMoveEqui(ParamDto paramDto) throws Exception;

	public double getNormalCntRealTime(ParamDto paramDto) throws Exception;

}
