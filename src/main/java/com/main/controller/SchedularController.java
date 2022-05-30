package com.main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.SendEmail;
import com.main.email.CommEmailFunction;
import com.main.serviceManager.ServiceManager;

@Component
public class SchedularController {

	@Autowired
	ServiceManager serviceManger;

	private String checkSchedular = "Completed";
	@Value("${spring.datasource.jdbcUrl}")
	private String dburl;

//	@Scheduled(cron="*/5 * * * * *")
	@Scheduled(fixedDelay = 1 * 60 * 1000) // scheduled for 1 minutes
	public void sendAllEmail() {

		// will run in every 5 minutes
		try {
			System.out.println("db...." + dburl + "  checkSchedular1..." + checkSchedular);
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
							SendEmail sendEmail = statusList.get(i);
							
							//serviceManger.sendEmailRepo.updateStatus(sendEmail.setStatus("N"));

						}
					}

				} catch (Exception e) {
					e.printStackTrace();
				}

				checkSchedular = "Occupied";
			} else {
				System.out.println("Running in five minutes ");
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
						}
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			System.out.println("db...." + dburl + "  checkSchedular2..." + checkSchedular);
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

}
