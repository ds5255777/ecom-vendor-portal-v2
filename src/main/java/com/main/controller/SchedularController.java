package com.main.controller;

import java.time.format.DateTimeFormatter;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.main.commonclasses.CommanFunction;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.SendEmail;
import com.main.serviceManager.ServiceManager;

@Component
public class SchedularController {

	@Autowired
	ServiceManager serviceManger;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(SchedularController.class);

	private String checkSchedular = "Completed";

//	@Scheduled(cron="*/5 * * * * *")
	@Scheduled(fixedDelay = 10000 * 60 * 1000) // scheduled for 1 minutes
	public void sendAllEmail() {

		try {

			if ("Completed".equalsIgnoreCase(checkSchedular)) {
				logger.info("Running only once scheduler ");

				try {

					List<SendEmail> statusList = serviceManger.sendEmailRepo
							.findByStatus(GlobalConstants.EMAIL_STATUS_SENDING);
					List<EmailConfiguration> emailList = serviceManger.emailConfigurationRepository
							.findByIsActive(GlobalConstants.ACTIVE_STATUS);

					if (!statusList.isEmpty() || (!emailList.isEmpty())) {
						for (int i = 0; i < statusList.size(); i++) {

							CommanFunction.sendEmail(emailList.get(0), statusList.get(i).getSendTo(),
									statusList.get(i).getSendCc(), statusList.get(i).getBcc(),
									statusList.get(i).getSubject(), statusList.get(i).getEmailBody());

							serviceManger.sendEmailRepo.updateStatus(GlobalConstants.EMAIL_STATUS_SEND,
									statusList.get(i).getId());

						}
					}

				} catch (Exception e) {
					e.printStackTrace();
				}

				checkSchedular = "Occupied";
			} else {
				try {

					List<SendEmail> statusList = serviceManger.sendEmailRepo
							.findByStatus(GlobalConstants.EMAIL_STATUS_SENDING);
					List<EmailConfiguration> emailList = serviceManger.emailConfigurationRepository
							.findByIsActive(GlobalConstants.ACTIVE_STATUS);

					if (!statusList.isEmpty() || (!emailList.isEmpty())) {
						for (int i = 0; i < statusList.size(); i++) {

							CommanFunction.sendEmail(emailList.get(0), statusList.get(i).getSendTo(),
									statusList.get(i).getSendCc(), statusList.get(i).getBcc(),
									statusList.get(i).getSubject(), statusList.get(i).getEmailBody());
							serviceManger.sendEmailRepo.updateStatus(GlobalConstants.EMAIL_STATUS_SEND,
									statusList.get(i).getId());
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
