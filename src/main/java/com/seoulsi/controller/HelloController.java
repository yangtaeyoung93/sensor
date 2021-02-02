package com.seoulsi.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.RedirectView;

import com.google.gson.Gson;
import com.seoulsi.dto.MemberDto;
import com.seoulsi.dto.TreeDto;
import com.seoulsi.dto.TreeNodeDto;
import com.seoulsi.service.CommonService;
import com.seoulsi.service.SettingService;
import com.seoulsi.service.testService;

@Controller
public class HelloController {

	private static Logger logger = LogManager.getLogger(HelloController.class);

	@Autowired
	private CommonService commonService;

	@Autowired
	private SettingService settingService;

	@Autowired
	private testService testService;

	@RequestMapping("/")
	public RedirectView Home(Model model, Authentication auth) throws Exception {

		return new RedirectView("/sensor/map");
		// try {
		// if (auth.getPrincipal() != null) {
		// }
		// } catch (Exception e) {
		// return "login/index";
		// }
		// return null;

	}

	@RequestMapping("/popup01")
	public String Popup01() throws Exception {

		return "common/popup01";
	}

	@RequestMapping("/popup02")
	public String Popup02() throws Exception {

		return "common/popup02";
	}

	@RequestMapping("/popup03")
	public String Popup03() throws Exception {

		return "common/popup03";
	}

	@RequestMapping("/test2")
	@ResponseBody
	public String Test() throws Exception {
		List<MemberDto> mdto = testService.getUserCode();
		TreeDto tree = new TreeDto();
		int count = 1;
		for (MemberDto m : mdto) {
			tree.setId(count);
			tree.setText(m.getCode());

			String[] userId = m.getUserId().split(",");
			String[] userName = m.getUserName().split(",");
			List<TreeNodeDto> cdr = new ArrayList<TreeNodeDto>();
			int nodeCount = 1;
			for (int i = 0; i < userId.length; i++) {
				TreeNodeDto treeNode = new TreeNodeDto();
				treeNode.setId(Integer.parseInt(String.valueOf(count) + String.valueOf(nodeCount)));
				treeNode.setUserId(userId[i]);
				treeNode.setUserName(userName[i]);

				cdr.add(treeNode);
				nodeCount++;
			}
			tree.setChildren(cdr);

			logger.info(m);
		}
		Gson gson = new Gson();
		String json = gson.toJson(tree);
		return json;
	}
}