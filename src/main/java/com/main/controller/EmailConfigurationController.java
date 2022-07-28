package com.main.controller;

import java.net.URL;
import java.security.Principal;
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
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.CommanFunction;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.SendEmailToVendor;
import com.main.db.bpaas.entity.User;
import com.main.payloads.EmailConfigurationDTO;
import com.main.payloads.SendEmailToVendorDTO;
import com.main.serviceManager.ServiceManager;


@RequestMapping("/emailConfigurationController")
@RestController
public class EmailConfigurationController {

	@Autowired
	ServiceManager serviceManager;
	
	@Value("${registrationLink}")
	public String registrationLink;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(EmailConfigurationController.class);

	@PostMapping({ "/saveUpdateEmailData" })

	public String saveUpdateEmailData(HttpServletRequest request, @RequestBody EmailConfigurationDTO entityDto) {

		logger.info("Log Some Information : " + dateTimeFormatter.format(LocalDateTime.now()));
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			serviceManager.emailConfigurationRepository
					.save(this.serviceManager.modelMapper.map(entityDto, EmailConfiguration.class));
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getEmailCofigurationDataById" })

	public String getEmailCofigurationDataById(HttpServletRequest request,
			@RequestBody EmailConfigurationDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			Optional<EmailConfiguration> email = serviceManager.emailConfigurationRepository
					.findById(entityDto.getId());
			if (email.isPresent()) {
				EmailConfigurationDTO emailObject = this.serviceManager.modelMapper.map(email,
						EmailConfigurationDTO.class);

				data.setData(emailObject);
			}

			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getEmailCofigurationDataByStatus" })

	public String getEmailCofigurationDataByStatus(HttpServletRequest request,
			@RequestBody EmailConfigurationDTO entityDto) {

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
	@PostMapping({ "/sendEmailToVendor" })
	@CrossOrigin("*")
	public String sendEmailToVendor(HttpServletRequest request,Principal principal, @RequestBody SendEmailToVendorDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			entityDto.setProcessOn(new Date());
			entityDto.setProcessBy(principal.getName());
			User us = serviceManager.userService.findByUsername(principal.getName());
			Random rand = new Random();
	        int rand_int = rand.nextInt(10000);
	        entityDto.setFlag(rand_int);
	        System.out.println("Random Integers: "+rand_int);
			String introducerEmail=us.getEmailId();
			serviceManager.sendEmailToVendorRepo.save(this.serviceManager.modelMapper.map(entityDto, SendEmailToVendor.class));
		
			// List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByEmailId(introducerEmail);
			List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");

			 String maillink = registrationLink+"?vendorEmail=" + Base64.getEncoder().encodeToString(entityDto.getVendorEmail().getBytes())+"&vendorType="+Base64.getEncoder().encodeToString(entityDto.getVendorType().getBytes())+"&region="+Base64.getEncoder().encodeToString(entityDto.getRegion().getBytes())+"&vendorAddress="+Base64.getEncoder().encodeToString(entityDto.getVendorAddress().getBytes())+"&processBy="+Base64.getEncoder().encodeToString(entityDto.getProcessBy().getBytes())+"&processByEmailId="+Base64.getEncoder().encodeToString(introducerEmail.getBytes())+"&flag="+rand_int;
			 String newmailLink=maillink.replaceAll(" ", "%20");
			 
			
			 String message = "<b>Dear Vendor,</b><br><br>";
		        message += "<i> Request you to please click on below link and register yourself!</i><br>";
		        message += "<font color=blue>Link :- </font>";
		        String regards="<p>Regards<br>ECOM Team</p>";
		        
		        String newUrlString =message+ newmailLink+regards;
				new Thread(new Runnable() {
					@Override
					public void run() {
						try {
						if (!emailList.isEmpty()) {
							for (int i = 0; i < emailList.size(); i++) {
								CommanFunction.sendEmail(emailList.get(i),entityDto.getVendorEmail(),"", "", "Vendor Portal Request Acknowldgement", ""+newUrlString);
							System.out.println("Email sent succesfully");
							}
						}
					}catch (Exception e) {
						e.printStackTrace();
					}
					Thread.currentThread().interrupt();
					}
				}).start();
				
			
			data.setMsg("success");
			
		 
		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	@PostMapping({ "/getAllSentEmail" })
	@CrossOrigin("*")
	public String getAllSentEmail(HttpServletRequest request,Principal principal, @RequestBody SendEmailToVendorDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<SendEmailToVendor> emailList = serviceManager.sendEmailToVendorRepo.findByProcessBy(principal.getName());
			List<SendEmailToVendorDTO> emailListDto = emailList.stream()
					.map((listOfUser) -> this.serviceManager.modelMapper.map(listOfUser, SendEmailToVendorDTO.class))
					.collect(Collectors.toList());
			data.setData(emailListDto);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

}
