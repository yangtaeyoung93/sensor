package com.seoulsi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.seoulsi.dto.AdminDto;
import com.seoulsi.dto.AdminInsertDto;
import com.seoulsi.dto.CardDto;
import com.seoulsi.dto.EquLocDetail;
import com.seoulsi.dto.EquLocPic;
import com.seoulsi.dto.EquiDto;
import com.seoulsi.dto.MenuDto;
import com.seoulsi.dto.MngDeptDto;
import com.seoulsi.dto.WareDto;
import com.seoulsi.dto.extend.ParamDto;
import com.seoulsi.dto.MemberDto;

@Mapper
public interface AdminMapper {

	public List<AdminDto> adminList(AdminDto adminDto) throws Exception;

	public List<AdminInsertDto> modal(AdminInsertDto adminInsertDto) throws Exception;

	public CardDto cardInfo(String equiInfoKey) throws Exception;

	public List<CardDto> getGuCardList(String guTp) throws Exception;

	public CardDto getCardFile(String id) throws Exception;

	public void cardFileFront(CardDto cdto) throws Exception;

	public void cardFileSide(CardDto cdto) throws Exception;

	public void cardFileBack(CardDto cdto) throws Exception;

	public int cardInfoUpdate(CardDto cdto) throws Exception;

	public List<EquiDto> getCardLoc(String equiInfoKey) throws Exception;

	public List<EquiDto> getCardLocExcel(String guTp) throws Exception;

	public void updateLoc(EquiDto edto) throws Exception;

	public void updateLocDetail(EquLocDetail edto) throws Exception;

	public void equiCardImgUpdate(EquLocPic epdto) throws Exception;

	public EquLocPic equiCardImgSelect(String equiInfoKey) throws Exception;

	public void insertMngDept(MngDeptDto mdto) throws Exception;

	public List<MngDeptDto> mngDeptSearch(MngDeptDto mdto) throws Exception;

	public void mngDeptUpdate(MngDeptDto mdto) throws Exception;

	public void mngDeptDelete(MngDeptDto mdto) throws Exception;

	public void insertWare(WareDto mdto) throws Exception;

	public List<WareDto> wareSearch(WareDto mdto) throws Exception;

	public void wareUpdate(WareDto mdto) throws Exception;

	public void wareDelete(WareDto mdto) throws Exception;

	public MenuDto getWriteGrant(MenuDto mdto) throws Exception;

	public List<EquiDto> getGuEquiList(String guTp) throws Exception;

	public List<MemberDto> getUserHistory(ParamDto paramDto) throws Exception;
}
