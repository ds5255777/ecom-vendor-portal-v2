package com.main.controller;

import java.time.format.DateTimeFormatter;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.SendEmail;
import com.main.email.CommEmailFunction;
import com.main.serviceManager.ServiceManager;

@Component
public class SchedularController {

	@Autowired
	ServiceManager serviceManger;
	
	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(SchedularController.class);

	private String checkSchedular = "Completed";

//	@Scheduled(cron="*/5 * * * * *")
	@Scheduled(fixedDelay = 100 * 60 * 1000) // scheduled for 1 minutes
	public void sendAllEmail() {

		// will run in every 5 minutes
		try {
			
			if ("Completed".equalsIgnoreCase(checkSchedular)) {
				logger.info("Running only once scheduler ");

				try {

					List<SendEmail> statusList = serviceManger.sendEmailRepo.findByStatus("Y");
					List<EmailConfiguration> emailList = serviceManger.emailConfigurationRepository.findByIsActive("1");

					if (!statusList.isEmpty() || (!emailList.isEmpty())) {
						for (int i = 0; i < statusList.size(); i++) {

							EmailConfiguration emailConfiguration = emailList.get(0);

							CommEmailFunction.sendEmail(statusList.get(i).getSendTo(), statusList.get(i).getSubject(),
									statusList.get(i).getEmailBody(), emailConfiguration.getSmtpPort(),
									statusList.get(i).getMailfrom(), emailConfiguration.getPassword(),
									emailConfiguration.getServerName());

							 serviceManger.sendEmailRepo.updateStatus(GlobalConstants.EMAIL_STATUS_SEND,statusList.get(i).getId());

						}
					}

				} catch (Exception e) {
					e.printStackTrace();
				}

				checkSchedular = "Occupied";
			} else {
				logger.info("Running in five minutes ");
				try {

					List<SendEmail> statusList = serviceManger.sendEmailRepo.findByStatus("Y");
					List<EmailConfiguration> emailList = serviceManger.emailConfigurationRepository.findByIsActive("1");

					if (!statusList.isEmpty() || (!emailList.isEmpty())) {
						for (int i = 0; i < statusList.size(); i++) {

							EmailConfiguration emailConfiguration = emailList.get(0);

							CommEmailFunction.sendEmail(statusList.get(i).getMailfrom(), statusList.get(i).getSubject(),
									statusList.get(i).getEmailBody(), emailConfiguration.getSmtpPort(),
									emailConfiguration.getUserName(), emailConfiguration.getPassword(),
									emailConfiguration.getServerName());
							 serviceManger.sendEmailRepo.updateStatus(GlobalConstants.EMAIL_STATUS_SEND, statusList.get(i).getId());
						}
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

}
