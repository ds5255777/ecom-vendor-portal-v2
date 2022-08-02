package com.main.controller;

import java.security.Principal;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Random;
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
import com.main.commonclasses.CommanFunction;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.SendEmailToVendor;
import com.main.db.bpaas.entity.User;
import com.main.payloads.EmailConfigurationDTO;
import com.main.payloads.SendEmailToVendorDTO;
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

		logger.info("Log Some Information : {} ", dateTimeFormatter.format(LocalDateTime.now()));
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

	@PostMapping({ "/sendEmailToVendor" })
	public String sendEmailToVendor(HttpServletRequest request, Principal principal,
			@RequestBody SendEmailToVendorDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			final Random rand = SecureRandom.getInstanceStrong();
			entityDto.setProcessOn(new Date());
			entityDto.setProcessBy(principal.getName());
			User us = serviceManager.userService.findByUsername(principal.getName());
			int randInt = rand.nextInt();
			entityDto.setFlag(randInt);
			String introducerEmail = us.getEmailId();
			serviceManager.sendEmailToVendorRepo
					.save(this.serviceManager.modelMapper.map(entityDto, SendEmailToVendor.class));

			List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");

			String maillink = registrationLink + "?vendorEmail="
					+ Base64.getEncoder().encodeToString(entityDto.getVendorEmail().getBytes()) + "&vendorType="
					+ Base64.getEncoder().encodeToString(entityDto.getVendorType().getBytes()) + "&region="
					+ Base64.getEncoder().encodeToString(entityDto.getRegion().getBytes()) + "&vendorAddress="
					+ Base64.getEncoder().encodeToString(entityDto.getVendorAddress().getBytes()) + "&processBy="
					+ Base64.getEncoder().encodeToString(entityDto.getProcessBy().getBytes()) + "&processByEmailId="
					+ Base64.getEncoder().encodeToString(introducerEmail.getBytes()) + "&flag=" + randInt;
			String newmailLink = maillink.replace(" ", "%20");

			String message = "<b>Dear Vendor,</b><br><br>";
			message += "<i> Request you to please click on below link and register yourself!</i><br>";
			message += "<font color=blue>Link :- </font>";
			String regards = "<p>Regards<br>ECOM Team</p>";

			String newUrlString = message + newmailLink + regards;
			new Thread(new Runnable() {
				@Override
				public void run() {
					try {
						if (!emailList.isEmpty()) {
							for (int i = 0; i < emailList.size(); i++) {
								CommanFunction.sendEmail(emailList.get(i), entityDto.getVendorEmail(), "", "",
										"Vendor Portal Request Acknowldgement", "" + newUrlString);
							}
						}
					} catch (Exception e) {
						logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
					}
					Thread.currentThread().interrupt();
				}
			}).start();

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllSentEmail" })
	public String getAllSentEmail(HttpServletRequest request, Principal principal,
			@RequestBody SendEmailToVendorDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			List<SendEmailToVendor> emailList = serviceManager.sendEmailToVendorRepo
					.findByProcessBy(principal.getName());
			List<SendEmailToVendorDTO> emailListDto = emailList.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, SendEmailToVendorDTO.class))
					.collect(Collectors.toList());
			data.setData(emailListDto);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

}
