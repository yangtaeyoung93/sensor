package com.seoulsi.mapper;

import java.util.List;

import com.seoulsi.dto.*;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SensorMapper {

	public List<SensorDto> sensorList() throws Exception;

	public List<SensorDto> sensorEquiList(String guNum) throws Exception;

	public List<SensorDto> sensorEquiListBaram() throws Exception;

	public List<SensorDto> sensorEquiListAir() throws Exception;

	public List<SensorDto> equiSearchAllList(SensorDto sensorDto) throws Exception;

	public List<SensorDto> equiSearchAllListCorrection(SensorDto sensorDto) throws Exception;

	public List<SensorDto> equiSearchList(SensorDto sensorDto) throws Exception;

	public List<SensorDto> equiSearchListCorrection(SensorDto sensorDto) throws Exception;

	public List<SensorDto> equiSearchListCount(SensorDto sensorDto) throws Exception;

	public List<GuDto> guData(SensorDto sensorDto) throws Exception;

	public List<GuDto> guDataAvg(SensorDto sensorDto) throws Exception;

	public List<GuDto> baramGuData(SensorDto sensorDto) throws Exception;

	public List<SensorDto> getEquiGpsInfo() throws Exception;

	public List<SensorDto> getSearEqui(SdotDTO sdotDTO) throws Exception;

	public List<StatDto> getStatList(StatDto statDto) throws Exception;

	public List<StatDto> getStatLastUpdate(String wareName) throws Exception;

	public List<StatDto> getStatAllList(StatDto statDto) throws Exception;

	public List<TotalDto> getTotalList() throws Exception;

	public List<TotalDto> getTotalWareDataList() throws Exception;

	public List<TotalDto> getUnreceiveWareList() throws Exception;

	public List<TotalDto> getReceiveWareList() throws Exception;

	public List<TotalDto> getBadWareList(TotalDto dataCat) throws Exception;

	public List<SensorDto> getStatisticData(SensorDto sensorDto) throws Exception;

	public List<SensorDto> getStatisticAllData(SensorDto sensorDto) throws Exception;

	public List<DailySenDto> getEquiCnt() throws Exception;

	public Integer getEquiCount(SdotDTO sdotDTO) throws Exception;
}
