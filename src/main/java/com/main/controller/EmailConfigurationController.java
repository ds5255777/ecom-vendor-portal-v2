package com.main.controller;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.payloads.EmailConfigurationDTO;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/emailConfigurationController")
@RestController
public class EmailConfigurationController {

	@Autowired
	private ServiceManager serviceManager;

	@Value("${registrationLink}")
	private String registrationLink;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(EmailConfigurationController.class);

	@PostMapping({ "/saveUpdateEmailData" })

	public String saveUpdateEmailData(HttpServletRequest request, @RequestBody EmailConfigurationDTO entityDto) {

		logger.info("Log Some Information : ");
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			serviceManager.emailConfigurationRepository
					.save(this.serviceManager.modelMapper.map(entityDto, EmailConfiguration.class));
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getEmailCofigurationDataById" })

	public String getEmailCofigurationDataById(HttpServletRequest request,
			@RequestBody EmailConfigurationDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			Optional<EmailConfiguration> email = serviceManager.emailConfigurationRepository
					.findById(entityDto.getId());
			if (email.isPresent()) {
				EmailConfigurationDTO emailObject = this.serviceManager.modelMapper.map(email,
						EmailConfigurationDTO.class);

				data.setData(emailObject);
			}

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getEmailCofigurationDataByStatus" })

	public String getEmailCofigurationDataByStatus(HttpServletRequest request,
			@RequestBody EmailConfigurationDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");
			List<EmailConfigurationDTO> emailListDto = emailList.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, EmailConfigurationDTO.class))
					.collect(Collectors.toList());
			data.setData(emailListDto);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/updateEmailConfigurationSatatusByid" })

	public String updateEmailConfigurationSatatusByid(HttpServletRequest request,
			@RequestBody EmailConfigurationDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			serviceManager.emailConfigurationRepository.updateEmailConfigurationSatatusByid(entityDto.getIsActive(),
					entityDto.getId());
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

}
