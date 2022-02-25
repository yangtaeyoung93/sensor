package com.seoulsi.service;

import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.seoulsi.dto.AdminDto;
import com.seoulsi.dto.AdminInsertDto;
import com.seoulsi.dto.CardDto;
import com.seoulsi.dto.EquLoc;
import com.seoulsi.dto.EquLocDetail;
import com.seoulsi.dto.EquLocPic;
import com.seoulsi.dto.EquiDto;
import com.seoulsi.dto.MenuDto;
import com.seoulsi.dto.MngDeptDto;
import com.seoulsi.dto.WareDto;
import com.seoulsi.dto.extend.ParamDto;
import com.seoulsi.mapper.AdminMapper;
import com.seoulsi.dto.MemberDto;

@Service
public class AdminService implements AdminMapper {

	@Autowired
	AdminMapper adminMapper;

	@Autowired
	DataSource dataSource;

	public List<AdminDto> adminList(AdminDto adminDto) throws Exception {
		return adminMapper.adminList(adminDto);
	}

	public List<AdminInsertDto> modal(AdminInsertDto adminInsertDto) throws Exception {
		return adminMapper.modal(adminInsertDto);
	}

	@Override
	public CardDto cardInfo(String equiInfoKey) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.cardInfo(equiInfoKey);
	}

	@Override
	public List<CardDto> getGuCardList(String guTp) throws Exception {
		return adminMapper.getGuCardList(guTp);
	}

	@Override
	public void cardFileFront(CardDto cdto) throws Exception {
		// TODO Auto-generated method stub
		adminMapper.cardFileFront(cdto);
	}

	@Override
	public void cardFileSide(CardDto cdto) throws Exception {
		// TODO Auto-generated method stub
		adminMapper.cardFileSide(cdto);
	}

	@Override
	public void cardFileBack(CardDto cdto) throws Exception {
		// TODO Auto-generated method stub
		adminMapper.cardFileBack(cdto);
	}

	@Override
	public CardDto getCardFile(String id) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.getCardFile(id);
	}

	@Override
	public int cardInfoUpdate(CardDto cdto) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.cardInfoUpdate(cdto);
	}

	public void cardInfoUpdateExcel(List<CardDto> list) throws Exception {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();

		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		// construct an appropriate transaction manager

		DataSourceTransactionManager txManager = new DataSourceTransactionManager(dataSource);

		TransactionStatus sts = txManager.getTransaction(def);

		try {
			for (CardDto cdto : list) {
				int result = adminMapper.cardInfoUpdate(cdto);
				if (result == 0) {
					txManager.rollback(sts);
				}
			}
		} catch (Exception e) {
			txManager.rollback(sts);
		}

		txManager.commit(sts);
	}

	@Override
	public List<EquiDto> getCardLoc(String equiInfoKey) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.getCardLoc(equiInfoKey);
	}

	@Override
	public List<EquiDto> getCardLocExcel(String guTp) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.getCardLocExcel(guTp);
	}

	@Override
	public void updateLoc(EquiDto edto) throws Exception {
		// TODO Auto-generated method stub
		adminMapper.updateLoc(edto);
	}

	@Override
	public void updateLocDetail(EquLocDetail edto) throws Exception {
		// TODO Auto-generated method stub
		adminMapper.updateLocDetail(edto);
	}

	public void cardLocUpdateExcel(Map<String, Object> resultMap) throws Exception {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();

		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		// construct an appropriate transaction manager

		DataSourceTransactionManager txManager = new DataSourceTransactionManager(dataSource);

		TransactionStatus sts = txManager.getTransaction(def);

		try {
			for (Map.Entry<String, Object> elem : resultMap.entrySet()) {
				String key = elem.getKey();
				Map<String, Object> value = (Map<String, Object>) resultMap.get(elem.getKey());
				for (Map.Entry<String, Object> elemValue : value.entrySet()) {
					String valueKey = elemValue.getKey();
					if (valueKey.equals("left")) {
						EquiDto valueEquLoc = (EquiDto) value.get(valueKey);
						adminMapper.updateLoc(valueEquLoc);
					}

					if (valueKey.equals("right")) {
						Map<String, EquLocDetail> valueMap = (Map<String, EquLocDetail>) value.get(valueKey);
						for (Map.Entry<String, EquLocDetail> elemValueMap : valueMap.entrySet()) {
							String valueMapKey = elemValueMap.getKey();
							EquLocDetail valueMapValue = valueMap.get(valueMapKey);
							valueMapValue.setLocDetailTp(valueMapKey);
							valueMapValue.setEquiInfoKey(key);
							adminMapper.updateLocDetail(valueMapValue);
						}
					}
				}

			}

		} catch (Exception e) {
			txManager.rollback(sts);
		}

		txManager.commit(sts);
	}

	@Override
	public void equiCardImgUpdate(EquLocPic epdto) throws Exception {
		// TODO Auto-generated method stub
		adminMapper.equiCardImgUpdate(epdto);
	}

	@Override
	public EquLocPic equiCardImgSelect(String equiInfoKey) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.equiCardImgSelect(equiInfoKey);
	}

	@Override
	public void insertMngDept(MngDeptDto mdto) throws Exception {
		// TODO Auto-generated method stub
		adminMapper.insertMngDept(mdto);
	}

	public void insertMngDeptExcel(List<MngDeptDto> list) throws Exception {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();

		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		// construct an appropriate transaction manager

		DataSourceTransactionManager txManager = new DataSourceTransactionManager(dataSource);

		TransactionStatus sts = txManager.getTransaction(def);

		try {
			for (MngDeptDto mdto : list) {
				adminMapper.insertMngDept(mdto);
			}
		} catch (Exception e) {
			txManager.rollback(sts);
		}

		txManager.commit(sts);
	}

	@Override
	public List<MngDeptDto> mngDeptSearch(MngDeptDto mdto) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.mngDeptSearch(mdto);
	}

	@Override
	public void mngDeptUpdate(MngDeptDto mdto) throws Exception {
		// TODO Auto-generated method stub
		adminMapper.mngDeptUpdate(mdto);
	}

	@Override
	public void mngDeptDelete(MngDeptDto mdto) throws Exception {
		// TODO Auto-generated method stub
		adminMapper.mngDeptDelete(mdto);
	}

	@Override
	public void insertWare(WareDto wdto) throws Exception {
		// TODO Auto-generated method stub
		adminMapper.insertWare(wdto);
	}

	public void insertWareExcel(List<WareDto> list) throws Exception {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();

		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		// construct an appropriate transaction manager

		DataSourceTransactionManager txManager = new DataSourceTransactionManager(dataSource);

		TransactionStatus sts = txManager.getTransaction(def);

		try {
			for (WareDto wdto : list) {
				adminMapper.insertWare(wdto);
			}
		} catch (Exception e) {
			txManager.rollback(sts);
		}

		txManager.commit(sts);
	}

	@Override
	public List<WareDto> wareSearch(WareDto mdto) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.wareSearch(mdto);
	}

	@Override
	public void wareUpdate(WareDto mdto) throws Exception {
		// TODO Auto-generated method stub
		adminMapper.wareUpdate(mdto);
	}

	@Override
	public void wareDelete(WareDto mdto) throws Exception {
		// TODO Auto-generated method stub
		adminMapper.wareDelete(mdto);

	}

	@Override
	public MenuDto getWriteGrant(MenuDto mdto) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.getWriteGrant(mdto);
	}

	@Override
	public List<EquiDto> getGuEquiList(String guTp) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.getGuEquiList(guTp);
	}

	@Override
	public List<MemberDto> getUserHistory(ParamDto paramDto) throws Exception {

		return adminMapper.getUserHistory(paramDto);
	}
}
