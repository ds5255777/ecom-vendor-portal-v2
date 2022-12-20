package com.main.controller;

import java.security.Principal;
import java.security.SecureRandom;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
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
import com.main.db.bpaas.entity.MailContent;
import com.main.db.bpaas.entity.SendEmailToVendor;
import com.main.db.bpaas.entity.User;
import com.main.payloads.SendEmailToVendorDTO;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/commercialMailController")
@RestController
public class CommercialMailingController {

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(CommercialMailingController.class);

	@Autowired
	private ServiceManager serviceManager;

	@Value("${registrationLink}")
	private String registrationLink;

	String emailBody = "";

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
					+ Base64.getEncoder().encodeToString(entityDto.getVendorType().getBytes()) + "&resgion="
					+ Base64.getEncoder().encodeToString(entityDto.getRegion().getBytes()) + "&creditTerms="
					+ Base64.getEncoder().encodeToString(entityDto.getCreditTerms().getBytes()) + "&processBy="
					+ Base64.getEncoder().encodeToString(entityDto.getProcessBy().getBytes()) + "&processByEmailId="
					+ Base64.getEncoder().encodeToString(introducerEmail.getBytes()) + "&flag=" + randInt;
			String newmailLink = maillink.replace(" ", "%20");

			List<MailContent> mailType = serviceManager.mailContentRepo.findByType("Vendor Onboarding LIink");

			MailContent mailContent = mailType.get(0);
			emailBody = mailContent.getEmailBody();
			/*
			 * Date date = new Date(); DateFormat dateFormat = new
			 * SimpleDateFormat(GlobalConstants.DATE_FORMATTER); String strDate =
			 * dateFormat.format(date);
			 */
			emailBody = emailBody.replace("#URL_VENDOR_ONBOARD#", newmailLink);
			//emailBody = emailBody.replace("#OndordingDate#", strDate);

			new Thread(new Runnable() {
				@Override
				public void run() {
					try {
						if (!emailList.isEmpty()) {
							for (int i = 0; i < emailList.size(); i++) {
								CommanFunction.sendEmail(emailList.get(i), entityDto.getVendorEmail(), introducerEmail, "",
										"Ecom | Vendor Onboarding Link", "" + emailBody);
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
	public String getAllSentEmail(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			List<SendEmailToVendor> emailList = serviceManager.sendEmailToVendorRepo
					.findByProcessBy(principal.getName());

			List<SendEmailToVendor> collect = emailList.stream().sorted(Comparator.comparingInt(SendEmailToVendor::getId).reversed()).collect(Collectors.toList());
			data.setData(collect);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

}
