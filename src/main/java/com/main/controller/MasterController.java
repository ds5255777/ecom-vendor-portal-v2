package com.main.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.AgreementMaster;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/masterController")
@RestController
public class MasterController {

	@Autowired
	private ServiceManager serviceManager;
	
	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(MasterController.class);

	@RequestMapping({ "/saveTripMaster" })
	@CrossOrigin("*")
	public String saveTripMaster(HttpServletRequest request, @RequestBody AgreementMaster master) {
		
		logger.info("Log Some Information : "+dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			AgreementMaster save = serviceManager.agreementMasterRepo.save(master);

			data.setData(save);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getActiveMasterData" })
	@CrossOrigin("*")
	public String getActiveMasterData(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<AgreementMaster> allAgreementMasters = serviceManager.agreementMasterRepo.findAll();

			data.setData(allAgreementMasters);
			data.setMsg("success");
			System.out.println("end of getActiveMasterData" + allAgreementMasters);

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

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
			AgreementMaster agreementMaster = serviceManager.agreementMasterRepo.findById(master.getId()).get();

			data.setData(agreementMaster);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

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
			AgreementMaster agreementMaster = serviceManager.agreementMasterRepo.save(master);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/deleteMaster" })
	@CrossOrigin("*")
	public String deleteMaster(HttpServletRequest request, @RequestBody AgreementMaster master) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			serviceManager.agreementMasterRepo.deleteById(master.getId());

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}

}
