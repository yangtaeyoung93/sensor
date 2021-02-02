package com.seoulsi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.seoulsi.dto.SensorDto;

@Mapper
public interface StatisticMapper {
	public List<SensorDto> getSensId() throws Exception;
	public void setSensId(SensorDto sdto) throws Exception;
	public List<SensorDto> getSensData() throws Exception;
	public List<SensorDto> getEquiPerson(SensorDto sdto) throws Exception;
	public List<SensorDto> getEquiPersonHour(SensorDto sdto) throws Exception;
	public List<SensorDto> getSensorList() throws Exception;
}
