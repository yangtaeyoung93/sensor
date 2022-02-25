package com.seoulsi.service;

import java.util.List;

import com.seoulsi.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seoulsi.mapper.SensorMapper;

@Service
public class SensorService implements SensorMapper {

	@Autowired
	SensorMapper sensorMapper;

	public List<SensorDto> sensorList() throws Exception {
		return sensorMapper.sensorList();
	}

	public List<SensorDto> sensorEquiList(String guNum) throws Exception {
		return sensorMapper.sensorEquiList(guNum);
	}

	public List<SensorDto> sensorEquiListBaram() throws Exception {
		return sensorMapper.sensorEquiListBaram();
	}

	public List<SensorDto> sensorEquiListAir() throws Exception {
		return sensorMapper.sensorEquiListAir();
	}

	public List<SensorDto> equiSearchAllList(SensorDto sensorDto) throws Exception {
		return sensorMapper.equiSearchAllList(sensorDto);
	}

	public List<SensorDto> equiSearchList(SensorDto sensorDto) throws Exception {
		return sensorMapper.equiSearchList(sensorDto);
	}

	public List<SensorDto> equiSearchAllListCorrection(SensorDto sensorDto) throws Exception {
		return sensorMapper.equiSearchAllListCorrection(sensorDto);
	}

	public List<SensorDto> equiSearchListCorrection(SensorDto sensorDto) throws Exception {
		return sensorMapper.equiSearchListCorrection(sensorDto);
	}

	public List<SensorDto> equiSearchListCount(SensorDto sensorDto) throws Exception {
		return sensorMapper.equiSearchListCount(sensorDto);
	}

	public List<GuDto> guData(SensorDto sensorDto) throws Exception {
		return sensorMapper.guData(sensorDto);
	}

	public List<GuDto> guDataAvg(SensorDto sensorDto) throws Exception {
		return sensorMapper.guDataAvg(sensorDto);
	}

	public List<GuDto> baramGuData(SensorDto sensorDto) throws Exception {
		return sensorMapper.baramGuData(sensorDto);
	}

	@Override
	public List<SensorDto> getEquiGpsInfo() throws Exception {
		// TODO Auto-generated method stub
		return sensorMapper.getEquiGpsInfo();
	}

	@Override
	public List<StatDto> getStatList(StatDto statDto) throws Exception {
		// TODO Auto-generated method stub
		return sensorMapper.getStatList(statDto);
	}

	@Override
	public List<StatDto> getStatAllList(StatDto statDto) throws Exception {
		// TODO Auto-generated method stub
		return sensorMapper.getStatAllList(statDto);
	}

	@Override
	public List<StatDto> getStatLastUpdate(String wareName) throws Exception {
		// TODO Auto-generated method stub
		return sensorMapper.getStatLastUpdate(wareName);
	}

	@Override
	public List<TotalDto> getTotalList() throws Exception {
		// TODO Auto-generated method stub
		return sensorMapper.getTotalList();
	}

	@Override
	public List<TotalDto> getTotalWareDataList() throws Exception {
		// TODO Auto-generated method stub
		return sensorMapper.getTotalWareDataList();
	}

	@Override
	public List<TotalDto> getUnreceiveWareList() throws Exception {
		// TODO Auto-generated method stub
		return sensorMapper.getUnreceiveWareList();
	}

	@Override
	public List<TotalDto> getReceiveWareList() throws Exception {
		// TODO Auto-generated method stub
		return sensorMapper.getReceiveWareList();
	}

	@Override
	public List<TotalDto> getBadWareList(TotalDto dataCat) throws Exception {
		// TODO Auto-generated method stub
		return sensorMapper.getBadWareList(dataCat);
	}

	@Override
	public List<SensorDto> getStatisticData(SensorDto sensorDto) throws Exception {
		// TODO Auto-generated method stub
		return sensorMapper.getStatisticData(sensorDto);
	}

	@Override
	public List<SensorDto> getStatisticAllData(SensorDto sensorDto) throws Exception {
		// TODO Auto-generated method stub
		return sensorMapper.getStatisticAllData(sensorDto);
	}

	@Override
	public List<DailySenDto> getEquiCnt() throws Exception {
		// TODO Auto-generated method stub
		return sensorMapper.getEquiCnt();
	}

	@Override
	public Integer getEquiCount(SdotDTO sdotDTO) throws Exception {
		return sensorMapper.getEquiCount(sdotDTO);
	}

	@Override
	public List<SensorDto> getSearEqui(SdotDTO sdotDTO) throws Exception {
		return sensorMapper.getSearEqui(sdotDTO);
	}


}
