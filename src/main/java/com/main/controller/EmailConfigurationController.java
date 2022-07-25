package com.main.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.payloads.EmailConfigurationDTO;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/emailConfigurationController")
@RestController
public class EmailConfigurationController {

	@Autowired
	ServiceManager serviceManager;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(EmailConfigurationController.class);

	@PostMapping({ "/saveUpdateEmailData" })
	@CrossOrigin("*")
	public String saveUpdateEmailData(HttpServletRequest request, @RequestBody EmailConfigurationDTO entityDto) {

		logger.info("Log Some Information : " + dateTimeFormatter.format(LocalDateTime.now()));
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			serviceManager.emailConfigurationRepository.save(this.serviceManager.modelMapper.map(entityDto, EmailConfiguration.class));
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getEmailCofigurationDataById" })
	@CrossOrigin("*")
	public String getEmailCofigurationDataById(HttpServletRequest request, @RequestBody EmailConfigurationDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			Optional<EmailConfiguration> email = serviceManager.emailConfigurationRepository.findById(entityDto.getId());
			
			data.setData(email.get());
			data.setData(this.serviceManager.modelMapper.map(email.get(), EmailConfigurationDTO.class));
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getEmailCofigurationDataByStatus" })
	@CrossOrigin("*")
	public String getEmailCofigurationDataByStatus(HttpServletRequest request, @RequestBody EmailConfigurationDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");
			List<EmailConfigurationDTO> emailListDto = emailList.stream()
					.map((listOfUser) -> this.serviceManager.modelMapper.map(listOfUser, EmailConfigurationDTO.class))
					.collect(Collectors.toList());
			data.setData(emailListDto);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/updateEmailConfigurationSatatusByid" })
	@CrossOrigin("*")
	public String updateEmailConfigurationSatatusByid(HttpServletRequest request,
			@RequestBody EmailConfigurationDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			serviceManager.emailConfigurationRepository.updateEmailConfigurationSatatusByid(entityDto.getIsActive(),
					entityDto.getId());
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

}
