package com.main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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

	private String checkSchedular = "Completed";

//	@Scheduled(cron="*/5 * * * * *")
	@Scheduled(fixedDelay = 100 * 60 * 1000) // scheduled for 1 minutes
	public void sendAllEmail() {

		// will run in every 5 minutes
		try {
			if ("Completed".equalsIgnoreCase(checkSchedular)) {
				System.out.println("Running only once scheduler ");

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
				System.out.println("Running in Ten minutes ");
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
