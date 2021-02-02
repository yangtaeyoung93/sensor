package com.seoulsi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seoulsi.dto.SensorDto;
import com.seoulsi.mapper.StatisticMapper;

@Service
public class StatisticService implements StatisticMapper {

	@Autowired
	private StatisticMapper statisticMapper;
	@Override
	public List<SensorDto> getSensId() throws Exception {
		// TODO Auto-generated method stub
		return statisticMapper.getSensId();
	}
	@Override
	public void setSensId(SensorDto sdto) throws Exception {
		// TODO Auto-generated method stub
		statisticMapper.setSensId(sdto);
	}
	@Override
	public List<SensorDto> getSensData() throws Exception {
		// TODO Auto-generated method stub
		return statisticMapper.getSensData();
	}
	@Override
	public List<SensorDto> getEquiPerson(SensorDto sdto) throws Exception {
		// TODO Auto-generated method stub
		return statisticMapper.getEquiPerson(sdto);
	}
	
	@Override
	public List<SensorDto> getEquiPersonHour(SensorDto sdto) throws Exception {
		// TODO Auto-generated method stub
		return statisticMapper.getEquiPersonHour(sdto);
	}
	
	@Override
	public List<SensorDto> getSensorList() throws Exception {
		// TODO Auto-generated method stub
		return statisticMapper.getSensorList();
	}

}
