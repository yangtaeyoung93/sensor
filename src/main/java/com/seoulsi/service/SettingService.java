package com.seoulsi.service;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.seoulsi.dto.CommonDto;
import com.seoulsi.dto.EquiDto;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.MenuDto;
import com.seoulsi.dto.ResultDto;
import com.seoulsi.dto.SettingDto;
import com.seoulsi.mapper.SettingMapper;

@Service
public class SettingService implements SettingMapper {
	@Autowired
	SettingMapper settingMapper;

	@Autowired
	DataSource dataSource;

	@Override
	public List<SettingDto> getGuEquiList() throws Exception {
		// TODO Auto-generated method stub
		return settingMapper.getGuEquiList();
	}

	@Override
	public List<CommonDto> getCommList() throws Exception {
		// TODO Auto-generated method stub
		return settingMapper.getCommList();
	}

	@Override
	public List<EquiDto> getEquiInfo(String equiInfoKey) throws Exception {
		// TODO Auto-generated method stub
		return settingMapper.getEquiInfo(equiInfoKey);
	}

	@Override
	@Transactional
	public void saveEquiInfo(EquiDto edto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.saveEquiInfo(edto);

	}

	@Override
	public void insertEquiInfo(EquiDto edto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.insertEquiInfo(edto);
	}

	public void insertEquiInfoExcel(List<EquiDto> list) throws Exception {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();

		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		// construct an appropriate transaction manager

		DataSourceTransactionManager txManager = new DataSourceTransactionManager(dataSource);

		TransactionStatus sts = txManager.getTransaction(def);

		try {
			for (EquiDto edto : list) {
				settingMapper.insertEquiInfo(edto);
			}
		} catch (Exception e) {
			txManager.rollback(sts);
		}

		txManager.commit(sts);
	}

	@Override
	public void deleteEquiByEquiInfoKey(EquiDto edto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.deleteEquiByEquiInfoKey(edto);
	}

	@Override
	public List<MemberDto> getUserCode() throws Exception {
		// TODO Auto-generated method stub
		return settingMapper.getUserCode();
	}

	@Override
	public List<MemberDto> getUserByCode(String code) throws Exception {
		// TODO Auto-generated method stub
		return settingMapper.getUserByCode(code);
	}

	@Override
	public List<MemberDto> getUserInfo(String user) throws Exception {
		// TODO Auto-generated method stub
		return settingMapper.getUserInfo(user);
	}

	@Override
	public void clearUser(MemberDto memberDto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.clearUser(memberDto);
	}

	@Override
	public void updateUser(MemberDto memberDto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.updateUser(memberDto);
	}

	@Override
	public void insertUser(MemberDto memberDto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.insertUser(memberDto);
	}

	@Override
	public void deleteUser(MemberDto memberDto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.deleteUser(memberDto);
	}

	@Override
	public void deleteUserGrant(MemberDto memberDto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.deleteUserGrant(memberDto);
	}

	@Override
	public void updateUserGrant(MenuDto menuDto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.updateUserGrant(menuDto);
	}

	@Override
	public void deleteCardByEquiInfoKey(EquiDto edto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.deleteCardByEquiInfoKey(edto);
	}

	@Override
	public void deleteLocByEquiInfoKey(EquiDto edto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.deleteLocByEquiInfoKey(edto);
	}

	@Override
	public void deleteLocDetailByEquiInfoKey(EquiDto edto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.deleteLocDetailByEquiInfoKey(edto);
	}

	@Override
	public void deleteLocPicByEquiInfoKey(EquiDto edto) throws Exception {
		// TODO Auto-generated method stub
		settingMapper.deleteLocPicByEquiInfoKey(edto);
	}
}
