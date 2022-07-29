package com.main.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.AgreementMaster;
import com.main.payloads.AgreementMasterDTO;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/masterController")
@RestController
public class MasterController {

	@Autowired
	private ServiceManager serviceManager;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(MasterController.class);

	@PostMapping({ "/saveTripMaster" })
	public String saveTripMaster(HttpServletRequest request, @RequestBody AgreementMasterDTO masterDto) {

		logger.info("Log Some Information : " + dateTimeFormatter.format(LocalDateTime.now()));
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			AgreementMaster save = serviceManager.agreementMasterRepo
					.save(this.serviceManager.modelMapper.map(masterDto, AgreementMaster.class));
			data.setData(this.serviceManager.modelMapper.map(save, AgreementMasterDTO.class));
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getActiveMasterData" })
	public String getActiveMasterData(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<AgreementMaster> allAgreementMasters = serviceManager.agreementMasterRepo.findAll();
			List<AgreementMasterDTO> allAgreementMastersDto = allAgreementMasters.stream()
					.map((listOfUser) -> this.serviceManager.modelMapper.map(listOfUser, AgreementMasterDTO.class))
					.collect(Collectors.toList());
			data.setData(allAgreementMastersDto);
			data.setMsg("success");
			logger.info("end of getActiveMasterData" + allAgreementMastersDto);
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getMasterById" })
	public String getUserById(HttpServletRequest request, @RequestBody AgreementMasterDTO masterDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			logger.info("hii master");
			AgreementMaster agreementMaster = serviceManager.agreementMasterRepo.findById(masterDto.getId()).get();
			data.setData(this.serviceManager.modelMapper.map(agreementMaster, AgreementMasterDTO.class));
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/saveUpdateMasterDetails" })
	public String saveUpdateMasterDetails(HttpServletRequest request, @RequestBody AgreementMasterDTO masterDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			logger.info("in mster update");
			serviceManager.agreementMasterRepo
					.save(this.serviceManager.modelMapper.map(masterDto, AgreementMaster.class));
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/deleteMaster" })
	public String deleteMaster(HttpServletRequest request, @RequestBody AgreementMasterDTO masterDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			serviceManager.agreementMasterRepo.deleteById(masterDto.getId());
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

}
