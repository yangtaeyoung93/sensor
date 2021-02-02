package com.seoulsi.service;

import java.util.List;
import java.util.Date;
import java.text.SimpleDateFormat;

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

		List<DailySenDto> returnDto;

		System.out.println("검색날짜 : " + paramDto.getToDate() + "부터 " + paramDto.getFromDate() + "까지");

		// 오늘 날짜 tm8형식으로 구하기
		Date now = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String today = dateFormat.format(now);
		System.out.println("today : " + today);

		// 분 구하기 : 30분마다 통계 -> 30분 이하면 15를 곱함
		System.out.println(now.getMinutes());
		if (now.getMinutes() <= 30) {
			paramDto.setMm("15");
		} else {
			paramDto.setMm("30");
		}
		System.out.println("mm값 : " + paramDto.getMm());

		// 검색 끝 날짜가 오늘인경우
		if (paramDto.getFromDate().equals(today)) {

			// 검색 시작 날짜가 오늘인경우(오늘~오늘)
			if (paramDto.getToDate().equals(today)) {
				System.out.println("오늘~오늘");
				returnDto = commonMapper.getDailyCntForDataForToday(paramDto);
				System.out.println("DTO : " + returnDto);

			} else {// 검색 시작날짜가 과거인경우(과거~오늘)
				System.out.println("과거~오늘");
				returnDto = commonMapper.getDailyCntForDataForPastToday(paramDto);
				System.out.println("DTO : " + returnDto);
			}

		} else {// 검색날짜가 과거~과거
			System.out.println("과거~과거");
			returnDto = commonMapper.getDailyCntForData(paramDto);
			System.out.println("DTO : " + returnDto);

		}
		System.out.println("returnDto값: " + returnDto);
		return returnDto;
	}

	@Override
	public List<DailySenDto> getDailyCntForDataForPastToday(ParamDto paramDto) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getDailyCntForDataForPastToday(paramDto);
	}

	@Override
	public List<DailySenDto> getDailyCntForDataForToday(ParamDto paramDto) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getDailyCntForDataForToday(paramDto);
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

	@Override
	public List<DailySenDto> getDailyCntForMoveEqui(ParamDto paramDto) throws Exception {
		// TODO Auto-generated method stub
		return commonMapper.getDailyCntForMoveEqui(paramDto);
	}

}
