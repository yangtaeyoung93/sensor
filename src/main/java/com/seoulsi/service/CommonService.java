package com.seoulsi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seoulsi.dto.CommonDto;
import com.seoulsi.dto.DailySenDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.MenuDto;
import com.seoulsi.dto.SensorDto;
import com.seoulsi.dto.extend.ParamDto;
import com.seoulsi.mapper.CommonMapper;

@Service
public class CommonService implements CommonMapper {

	@Autowired
	CommonMapper commonMapper;

	public List<CommonDto> guList() throws Exception {
		return commonMapper.guList();
	}

	@Override
	public List<CommonDto> partList() throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.partList();
	}

	@Override
	public List<MenuDto> getGrantMenu(String userId) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getGrantMenu(userId);
	}

	@Override
	public List<MemberDto> getGrantMenuRequest(MemberDto mdto) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getGrantMenuRequest(mdto);
	}

	@Override
	public List<MenuDto> getMenuId() throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getMenuId();
	}

	@Override
	public void insertGrantMenu(MenuDto mdto) throws Exception {
		// TODO Auto-generated method stub
		commonMapper.insertGrantMenu(mdto);
	}

	@Override
	public void insertGrantMenuN(MenuDto mdto) throws Exception {
		// TODO Auto-generated method stub
		commonMapper.insertGrantMenuN(mdto);
	}

	@Override
	public List<MenuDto> getMenu(String userId) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getMenu(userId);
	}

	@Override
	public List<CommonDto> codeList() throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.codeList();
	}

	@Override
	public List<CommonDto> codeListOne(String sortCd) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.codeListOne(sortCd);
	}

	@Override
	public void codeListUpdate(CommonDto cdto) throws Exception {
		// TODO Auto-generated method stub
		commonMapper.codeListUpdate(cdto);
	}

	@Override
	public void codeListRemove(CommonDto cdto) throws Exception {
		// TODO Auto-generated method stub
		commonMapper.codeListRemove(cdto);
	}

	@Override
	public void codeListSave(CommonDto cdto) throws Exception {
		// TODO Auto-generated method stub
		commonMapper.codeListSave(cdto);
	}

	@Override
	public List<CommonDto> getCCList(String sortCd) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getCCList(sortCd);
	}

	@Override
	public List<DailySenDto> getDailySenForDate(ParamDto paramDto) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getDailySenForDate(paramDto);
	}

	@Override
	public List<DailySenDto> getDailyCntForEqui(ParamDto paramDto) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getDailyCntForEqui(paramDto);
	}

	@Override
	public List<DailySenDto> getDailyCntForData(ParamDto paramDto) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getDailyCntForData(paramDto);
	}

	@Override
	public List<SensorDto> getDailyCntForEquiSensor(ParamDto paramDto) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getDailyCntForEquiSensor(paramDto);
	}

	@Override
	public List<SensorDto> getDailyCntForEquiSensorWind(ParamDto paramDto) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getDailyCntForEquiSensorWind(paramDto);
	}

}
