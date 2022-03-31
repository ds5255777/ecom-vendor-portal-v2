package com.main.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.AgreementMaster;
import com.main.db.bpaas.entity.User;
import com.main.db.bpaas.repo.AgreementMasterRepo;
import com.main.service.UserService;
import com.main.serviceManager.ServiceManager;


@RequestMapping("/masterController")
@RestController
public class MasterController {

	
	
	@Autowired
	ServiceManager serviceManager;
	
	@Autowired AgreementMasterRepo agreementMasterRepo;

	@Autowired
	UserService userService;
	
	@RequestMapping({ "/saveTripMaster" })
	@CrossOrigin("*")
	public String saveTripMaster(HttpServletRequest request, @RequestBody AgreementMaster master) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			AgreementMaster save = agreementMasterRepo.save(master);
			
			data.setData(save);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	

	@RequestMapping({ "/getActiveMasterData" })
	@CrossOrigin("*")
	public String getActiveMasterData(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<AgreementMaster> allAgreementMasters =agreementMasterRepo.findAll();
			/*
			 * List<String> userStatusList = new ArrayList<>();
			 * userStatusList.add(GlobalConstants.ACTIVE_STATUS);
			 * userStatusList.add(GlobalConstants.CHANGE_PASSWORD_STATUS);
			 */

		//	List<AgreementMaster> masterList = agreementMasterRepo.findMasterDetails();

			data.setData(allAgreementMasters);
			data.setMsg("success");
			System.out.println("end of getActiveMasterData"+allAgreementMasters);

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	
	
	
	
	@RequestMapping({ "/getMasterById" })
	@CrossOrigin("*")
	public String getUserById(HttpServletRequest request, @RequestBody AgreementMaster master) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
					System.out.println("hii master");
//					String  userName = (String) request.getSession().getAttribute("userName");
//					Integer  userId = (Integer) request.getSession().getAttribute("userId");

			//User userop = serviceManager.userRepository.findById(user.getId()).get();
			AgreementMaster agreementMaster= agreementMasterRepo.findById(master.getId()).get();

			data.setData(agreementMaster);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	
	
	@RequestMapping({ "/saveUpdateMasterDetails" })
	@CrossOrigin("*")
	public String saveUpdateMasterDetails(HttpServletRequest request, @RequestBody AgreementMaster master) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
				System.out.println("in mster update");
				AgreementMaster agreementMaster= agreementMasterRepo.save(master);
				data.setMsg("success");


		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/deleteMaster" })
	@CrossOrigin("*")
	public String deleteMaster(HttpServletRequest request, @RequestBody AgreementMaster master) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			
			agreementMasterRepo.deleteById(master.getId());

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	
	
}
