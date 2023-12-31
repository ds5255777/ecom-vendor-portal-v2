package com.main.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.Document;
import com.main.db.bpaas.entity.EmailAuditLogs;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.MailContent;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.SendEmail;
import com.main.db.bpaas.entity.SendEmailToVendor;
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.entity.User;
import com.main.payloads.QueryEntityDTO;
import com.main.payloads.SendEmailToVendorDTO;
import com.main.payloads.SupDetailsDTO;
import com.main.service.UserServiceImpl;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/ajaxController")
@RestController
public class AjaxController {

	@Value("${logFilePath}")
	private String logFilePath;

	@Autowired
	private ServiceManager serviceManager;

	@Value("${filepaths}")
	public String filepaths;

	String processID = "";

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(AjaxController.class);

	public synchronized String generateVendorCode() {

		String vendorCodePrefix = "Temp-";
		return vendorCodePrefix.concat(new SimpleDateFormat("yyyyHHmmssSSS").format(new Date()));
	}

	@PostMapping("/SaveRegistration")
	@Transactional
	public String saveRegistration(@RequestBody SupDetailsDTO supDetailsDto, HttpServletRequest request) {

		String strDate = "";

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		processID = "";
		try {

			Date date = new Date();
			DateFormat dateFormat = new SimpleDateFormat(GlobalConstants.DATE_FORMATTER);
			strDate = dateFormat.format(date);
			for (int i = 0; i < supDetailsDto.getAddressDetails().size(); i++) {
				String state = supDetailsDto.getAddressDetails().get(i).getState();
				if (null != state) {
					String stCode = serviceManager.stateRepo.findByStateCode(state);

					String partnerType = supDetailsDto.getAddressDetails().get(i).getVendorType();
					String glCode = serviceManager.businessPartnerTypeRepo.getGlCodeByPartnerType(partnerType);
					if (!partnerType.isEmpty()) {
						String typeCode = serviceManager.businessPartnerTypeRepo.findByTypeCode(partnerType);
						supDetailsDto.getAddressDetails().get(i).setSupplierSiteCode(stCode.concat("_" + typeCode));
						supDetailsDto.getAddressDetails().get(i).setGlCode(glCode);
					}
				} else {
					supDetailsDto.getAddressDetails().get(i).setSupplierSiteCode("Head Office");
					supDetailsDto.getAddressDetails().get(i).setGlCode("203101");
				}
			}
			String venStatusForRaisedQuery = "";
			if (supDetailsDto.getId() != null) {
				Optional<SupDetails> suppDetailsObj = serviceManager.supDetailsRepo
						.findById(supDetailsDto.getId());
				if (suppDetailsObj.isPresent()) {
					venStatusForRaisedQuery = suppDetailsObj.get().getVenStatus();
					supDetailsDto.setVenStatus(venStatusForRaisedQuery);
					}
			
			}

			Optional<SendEmailToVendor> sendEmailToVendorOptional = serviceManager.sendEmailToVendorRepo
					.findByVendorPid(supDetailsDto.getPid());
			if (sendEmailToVendorOptional.isPresent()) {
				SendEmailToVendor SendEmailToVendorObj = sendEmailToVendorOptional.get();
				SendEmailToVendorObj.setStatus(GlobalConstants.PENDING_FOR_COMMERCIAL_TEAM_STATUS);
				serviceManager.sendEmailToVendorRepo.save(SendEmailToVendorObj);
			}

			/* New Vendor */
			if (supDetailsDto.getId() == null) {
				supDetailsDto.setVenStatus(GlobalConstants.PENDING_FOR_COMMERCIAL_TEAM_STATUS);

				supDetailsDto.setCreateDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

				supDetailsDto.setBpCode(generateVendorCode());
				SupDetails supSaved = serviceManager.supDetailsRepo
						.save(this.serviceManager.modelMapper.map(supDetailsDto, SupDetails.class));

				SendEmailToVendorDTO sendEmailToVendorDto = new SendEmailToVendorDTO();

				Integer flag = sendEmailToVendorDto.getFlag();

				Long id = supSaved.getId();
				SendEmailToVendor commTeamDetails = serviceManager.sendEmailToVendorRepo
						.findByFlag(supDetailsDto.getCommercialFlag());

				processID = supDetailsDto.getPid();

				serviceManager.supDetailsRepo.updatePidInSupDetails(id, processID);
				data.setData(processID);

				if (null != commTeamDetails) {
					serviceManager.sendEmailToVendorRepo.updateVendorDetails(sendEmailToVendorOptional.get().getFlag(),
							processID);
				}
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

				/* send onBoard email */

				List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository
						.findByIsActive(GlobalConstants.ACTIVE_STATUS);
				EmailConfiguration emailConfiguration = emailList.get(0);

				String vendorEmail = supDetailsDto.getContactDetails().get(0).getConEmail();
				String introducerEmailID = supDetailsDto.getIntroducedByEmailID();

				List<String> findbyRoleId = serviceManager.userRepository.findbyRoleId(7);
				String allEmail = "";
				for (String string : findbyRoleId) {
					allEmail = allEmail + string + ",";
				}
				System.out.println(allEmail + introducerEmailID);
				try {
					List<MailContent> mailType = serviceManager.mailContentRepo.findByType("Vendor On Board");

					SendEmail sendEmail = new SendEmail();
					MailContent mailContent = mailType.get(0);
					String emailBody = mailContent.getEmailBody();

					emailBody = emailBody.replace("#VendorRefId#", processID);
					emailBody = emailBody.replace("#OndordingDate#", strDate);

					sendEmail.setMailfrom(emailConfiguration.getUserName());
					sendEmail.setSendTo(vendorEmail);
					sendEmail.setSendCc(allEmail + introducerEmailID);
					sendEmail.setSubject(mailContent.getSubject());
					sendEmail.setEmailBody(emailBody);
					sendEmail.setStatus(GlobalConstants.EMAIL_STATUS_SENDING);

					serviceManager.sendEmailRepo.save(sendEmail);

					EmailAuditLogs auditLogs = new EmailAuditLogs();
					auditLogs.setMailFrom(emailConfiguration.getUserName());
					auditLogs.setMailTo(vendorEmail);
					auditLogs.setMailCC(introducerEmailID);
					auditLogs.setMailSubject(mailContent.getSubject());
					auditLogs.setMailMessage(emailBody);

					serviceManager.emailAuditLogsRepo.save(auditLogs);
					data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			else if (supDetailsDto.getId() != null && null!=supDetailsDto.getVenStatus()
					&& supDetailsDto.getVenStatus().equals(GlobalConstants.APPROVED_REQUEST_STATUS)) {

				String userEmail = (String) request.getSession().getAttribute("userEmail");

				User us = new User();
				String bpCode = supDetailsDto.getBpCode();

				String passwordUser = UserServiceImpl.generateRandomPassword();
				us.setBpCode(bpCode);
				us.setUsername(bpCode);
				us.setStatus(GlobalConstants.CHANGE_PASSWORD_STATUS);
				us.setRoleId(2);
				us.setVendorName(supDetailsDto.getSuppName());
				us.setContactNo(supDetailsDto.getContactDetails().get(0).getConPhone());
				us.setEmailId(supDetailsDto.getContactDetails().get(0).getConEmail());

				us.setFirstName(supDetailsDto.getContactDetails().get(0).getConFname());
				us.setLastName(supDetailsDto.getContactDetails().get(0).getConLname());
				us.setPassword(passwordUser);
				serviceManager.userService.save(us);

				supDetailsDto.setVenStatus(GlobalConstants.PENDING_FOR_COMMERCIAL_TEAM_STATUS);
				supDetailsDto.setFlag(GlobalConstants.SET_FLAG_TYPE_ACTIVE);
				supDetailsDto.setProcessedBy(userEmail);
				supDetailsDto.setProcessedOn(strDate);
				serviceManager.supDetailsRepo
						.save(this.serviceManager.modelMapper.map(supDetailsDto, SupDetails.class));

				List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository
						.findByIsActive(GlobalConstants.ACTIVE_STATUS);

				EmailConfiguration emailConfiguration = emailList.get(0);

				String vendorEmail = supDetailsDto.getContactDetails().get(0).getConEmail();

				try {
					List<MailContent> mailType = serviceManager.mailContentRepo
							.findByType("Send username And Password");

					SendEmail sendEmail = new SendEmail();
					MailContent mailContent = mailType.get(0);
					String emailBody = mailContent.getEmailBody();

					emailBody = emailBody.replace("#username#", bpCode);
					emailBody = emailBody.replace("#password#", passwordUser);

					sendEmail.setMailfrom(emailConfiguration.getUserName());
					sendEmail.setSendTo(vendorEmail);
					sendEmail.setSubject(mailContent.getSubject());
					sendEmail.setEmailBody(emailBody);
					sendEmail.setStatus(GlobalConstants.EMAIL_STATUS_SENDING);

					serviceManager.sendEmailRepo.save(sendEmail);

					EmailAuditLogs auditLogs = new EmailAuditLogs();
					auditLogs.setMailFrom(emailConfiguration.getUserName());
					auditLogs.setMailTo(vendorEmail);
					auditLogs.setMailSubject(mailContent.getSubject());
					auditLogs.setMailMessage(emailBody);

					serviceManager.emailAuditLogsRepo.save(auditLogs);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				try {
					List<MailContent> mailType = serviceManager.mailContentRepo.findByType("confirmation mail");

					SendEmail sendEmail = new SendEmail();
					MailContent mailContent = mailType.get(0);
					String emailBody = mailContent.getEmailBody();

					emailBody = emailBody.replace("#VendorRefId#", supDetailsDto.getPid());
					emailBody = emailBody.replace("#vendorCode#", supDetailsDto.getBpCode());
					emailBody = emailBody.replace("#vendorName#", supDetailsDto.getSuppName());
					emailBody = emailBody.replace("#approvedDate#", strDate);

					String processedBy = supDetailsDto.getProcessedBy();
					String emailId = supDetailsDto.getIntroducedByEmailID();

//					introducerDetails.get
					sendEmail.setMailfrom(emailConfiguration.getUserName());
					sendEmail.setSendTo(vendorEmail);
					sendEmail.setSendCc(processedBy + "," + emailId);
					sendEmail.setSubject(mailContent.getSubject());
					sendEmail.setEmailBody(emailBody);
					sendEmail.setStatus(GlobalConstants.EMAIL_STATUS_SENDING);

					serviceManager.sendEmailRepo.save(sendEmail);

					EmailAuditLogs auditLogs = new EmailAuditLogs();
					auditLogs.setMailFrom(emailConfiguration.getUserName());
					auditLogs.setMailTo(vendorEmail);
					sendEmail.setSendCc(processedBy + "," + emailId);
					auditLogs.setMailSubject(mailContent.getSubject());
					auditLogs.setMailMessage(emailBody);

					serviceManager.emailAuditLogsRepo.save(auditLogs);
				} catch (Exception e) {

					e.printStackTrace();
				}
				data.setData(processID);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

			} else if (supDetailsDto.getId() != null && supDetailsDto.getVenStatus() != null && supDetailsDto.getVenStatus().equals(venStatusForRaisedQuery)) {

				String userEmail = (String) request.getSession().getAttribute("userEmail");
				
				processID = supDetailsDto.getPid();
				
				supDetailsDto.setVenStatus(GlobalConstants.PENDING_FOR_COMMERCIAL_TEAM_STATUS);
				supDetailsDto.setFlag(GlobalConstants.SET_FLAG_TYPE_ACTIVE);
				supDetailsDto.setProcessedBy(userEmail);
				supDetailsDto.setProcessedOn(strDate);
				serviceManager.supDetailsRepo
						.save(this.serviceManager.modelMapper.map(supDetailsDto, SupDetails.class));

				/* For Sending Email */
				
				List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository
						.findByIsActive(GlobalConstants.ACTIVE_STATUS);
				EmailConfiguration emailConfiguration = emailList.get(0);

				String vendorEmail = supDetailsDto.getContactDetails().get(0).getConEmail();
				String introducerEmailID = supDetailsDto.getIntroducedByEmailID();

				List<String> findbyRoleId = serviceManager.userRepository.findbyRoleId(7);
				String allEmail = "";
				for (String string : findbyRoleId) {
					allEmail = allEmail + string + ",";
				}
				System.out.println(allEmail + introducerEmailID);
				try {
					List<MailContent> mailType = serviceManager.mailContentRepo.findByType("Vendor On Board");

					SendEmail sendEmail = new SendEmail();
					MailContent mailContent = mailType.get(0);
					String emailBody = mailContent.getEmailBody();

					emailBody = emailBody.replace("#VendorRefId#", processID);
					emailBody = emailBody.replace("#OndordingDate#", strDate);

					sendEmail.setMailfrom(emailConfiguration.getUserName());
					sendEmail.setSendTo(vendorEmail);
					sendEmail.setSendCc(allEmail + introducerEmailID);
					sendEmail.setSubject(mailContent.getSubject());
					sendEmail.setEmailBody(emailBody);
					sendEmail.setStatus(GlobalConstants.EMAIL_STATUS_SENDING);

					serviceManager.sendEmailRepo.save(sendEmail);

					EmailAuditLogs auditLogs = new EmailAuditLogs();
					auditLogs.setMailFrom(emailConfiguration.getUserName());
					auditLogs.setMailTo(vendorEmail);
					auditLogs.setMailCC(introducerEmailID);
					auditLogs.setMailSubject(mailContent.getSubject());
					auditLogs.setMailMessage(emailBody);

					serviceManager.emailAuditLogsRepo.save(auditLogs);
					data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				
				
				

				/*User us = new User();
				String bpCode = supDetailsDto.getBpCode();

				
				  String passwordUser = UserServiceImpl.generateRandomPassword();
				  us.setBpCode(bpCode); us.setUsername(bpCode);
				  us.setStatus(GlobalConstants.CHANGE_PASSWORD_STATUS); us.setRoleId(2);
				  us.setVendorName(supDetailsDto.getSuppName());
				  us.setContactNo(supDetailsDto.getContactDetails().get(0).getConPhone());
				  us.setEmailId(supDetailsDto.getContactDetails().get(0).getConEmail());
				  
				  us.setFirstName(supDetailsDto.getContactDetails().get(0).getConFname());
				  us.setLastName(supDetailsDto.getContactDetails().get(0).getConLname());
				  us.setPassword(passwordUser); serviceManager.userService.save(us);
				 
				supDetailsDto.setVenStatus(GlobalConstants.PENDING_FOR_COMMERCIAL_TEAM_STATUS);
				supDetailsDto.setFlag(GlobalConstants.SET_FLAG_TYPE_ACTIVE);
				supDetailsDto.setProcessedBy(userEmail);
				supDetailsDto.setProcessedOn(strDate);
				serviceManager.supDetailsRepo
						.save(this.serviceManager.modelMapper.map(supDetailsDto, SupDetails.class));

				List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository
						.findByIsActive(GlobalConstants.ACTIVE_STATUS);

				EmailConfiguration emailConfiguration = emailList.get(0);

				String vendorEmail = supDetailsDto.getContactDetails().get(0).getConEmail();

				try {
					List<MailContent> mailType = serviceManager.mailContentRepo
							.findByType("Send username And Password");

					SendEmail sendEmail = new SendEmail();
					MailContent mailContent = mailType.get(0);
					String emailBody = mailContent.getEmailBody();

					
					  emailBody = emailBody.replace("#username#", bpCode); emailBody =
					  emailBody.replace("#password#", passwordUser);
					 

					sendEmail.setMailfrom(emailConfiguration.getUserName());
					sendEmail.setSendTo(vendorEmail);
					sendEmail.setSubject(mailContent.getSubject());
					sendEmail.setEmailBody(emailBody);
					sendEmail.setStatus(GlobalConstants.EMAIL_STATUS_SENDING);

					serviceManager.sendEmailRepo.save(sendEmail);

					EmailAuditLogs auditLogs = new EmailAuditLogs();
					auditLogs.setMailFrom(emailConfiguration.getUserName());
					auditLogs.setMailTo(vendorEmail);
					auditLogs.setMailSubject(mailContent.getSubject());
					auditLogs.setMailMessage(emailBody);

					serviceManager.emailAuditLogsRepo.save(auditLogs);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				try {
					List<MailContent> mailType = serviceManager.mailContentRepo.findByType("confirmation mail");

					SendEmail sendEmail = new SendEmail();
					MailContent mailContent = mailType.get(0);
					String emailBody = mailContent.getEmailBody();

					emailBody = emailBody.replace("#VendorRefId#", supDetailsDto.getPid());
					emailBody = emailBody.replace("#vendorCode#", supDetailsDto.getBpCode());
					emailBody = emailBody.replace("#vendorName#", supDetailsDto.getSuppName());
					emailBody = emailBody.replace("#approvedDate#", strDate);

					String processedBy = supDetailsDto.getProcessedBy();
					String emailId = supDetailsDto.getIntroducedByEmailID();

//					introducerDetails.get
					sendEmail.setMailfrom(emailConfiguration.getUserName());
					sendEmail.setSendTo(vendorEmail);
					sendEmail.setSendCc(processedBy + "," + emailId);
					sendEmail.setSubject(mailContent.getSubject());
					sendEmail.setEmailBody(emailBody);
					sendEmail.setStatus(GlobalConstants.EMAIL_STATUS_SENDING);

					serviceManager.sendEmailRepo.save(sendEmail);

					EmailAuditLogs auditLogs = new EmailAuditLogs();
					auditLogs.setMailFrom(emailConfiguration.getUserName());
					auditLogs.setMailTo(vendorEmail);
					sendEmail.setSendCc(processedBy + "," + emailId);
					auditLogs.setMailSubject(mailContent.getSubject());
					auditLogs.setMailMessage(emailBody);

					serviceManager.emailAuditLogsRepo.save(auditLogs);*/
				} catch (Exception e) {

					e.printStackTrace();
				}
				data.setData(processID);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

			}
			else if (supDetailsDto.getVenStatus() != null && supDetailsDto.getVenStatus().equals(GlobalConstants.UPDATE_VENDOR)) {
				supDetailsDto.setVenStatus(GlobalConstants.UPDATE_VENDOR);

				String bpCode = supDetailsDto.getBpCode();

				String status = serviceManager.userRepository.getVendorStatus(bpCode);

				if (null == status || status.equals("") || status.equals(GlobalConstants.INACTIVE_STATUS)) {
					supDetailsDto.setFlag(GlobalConstants.SET_FLAG_IN_ACTIVE);
				}

				else if (status.equals(GlobalConstants.ACTIVE_STATUS)
						|| status.equals(GlobalConstants.CHANGE_PASSWORD_STATUS)) {
					supDetailsDto.setFlag(GlobalConstants.SET_FLAG_TYPE_ACTIVE);
				}

				serviceManager.supDetailsRepo
						.save(this.serviceManager.modelMapper.map(supDetailsDto, SupDetails.class));
				data.setData(processID);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		String filePath = filepaths + processID;
		String fullFilePathWithName = "";
		File file1 = new File(filePath);

		if (!file1.exists()) {
			file1.mkdirs();
		}
		File logFilePathFolder = new File(logFilePath);
		if (!logFilePathFolder.exists()) {
			logFilePathFolder.mkdir();
		}
		if (null != supDetailsDto.getGstFileName()) {

			fullFilePathWithName = filePath + File.separator + supDetailsDto.getGstFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getGstFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getGstFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getPdFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getPdFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getPdFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getPdFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getPanFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getPanFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getPanFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getPanFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getCcFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getCcFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getCcFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getCcFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getAcFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getAcFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getAcFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getAcFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getAplFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getAplFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getAplFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getAplFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getItrFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getItrFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getItrFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getItrFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);
				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getFuvfFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getFuvfFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getFuvfFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getFuvfFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getMsmecFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getMsmecFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getMsmecFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getMsmecFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getAmFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getAmFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getAmFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getAmFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getItraFileName1()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getItraFileName1();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getItraFileName1());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getItraFileText1();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getItraFileName2()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getItraFileName2();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getItraFileName2());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getItraFileText2();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getItraFileName3()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getItraFileName3();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getItraFileName3());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getItraFileText3();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getNmisFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getNmisFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getNmisFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus(GlobalConstants.ACTIVE_STATUS);
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getNmisFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/saveRegistrationQuery" })
	public String saveRegistrationQuery(Principal principal, HttpServletRequest request,
			@RequestBody QueryEntityDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			Integer getid = entityDto.getId();

			if (getid != null) {
				entityDto.setId(null);
				entityDto.setForeignKey(getid);
				entityDto.setRaisedOn(new Date());
				entityDto.setReferenceid(entityDto.getRaisedAgainQuery());
				serviceManager.queryRepo.save(this.serviceManager.modelMapper.map(entityDto, QueryEntity.class));
			}
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getVendorDetailByPid" })
	public String getVendorDetailByPid(HttpServletRequest request, @RequestBody SupDetailsDTO objDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String pid = objDto.getPid();
		try {
			SupDetails vendorPid = serviceManager.supDetailsRepo.findByPid(pid);
			if (vendorPid != null) {
				data.setData(this.serviceManager.modelMapper.map(vendorPid, SupDetailsDTO.class));
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getRegistrationQueryData" })
	public String getRegistrationQueryData(HttpServletRequest request, @RequestBody QueryEntityDTO objDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {

			List<QueryEntity> list = serviceManager.queryRepo
					.findByReferenceidAndTypeOrderByIdDesc(objDto.getReferenceid(), objDto.getType());

			List<QueryEntityDTO> usersListDto = list.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, QueryEntityDTO.class))
					.collect(Collectors.toList());
			data.setData(usersListDto);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@GetMapping({ "/checkExistingPan" })
	public String checkExistingPan(@RequestParam("panNumber") String panNumber, @RequestParam("flag") String flag) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			String checkEmail = serviceManager.supDetailsRepo.checkPanNumber(panNumber, flag);
			if (null == checkEmail) {
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setMsg("exist");
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@GetMapping({ "/checkVendorCode" })
	public String checkVendorCode(@RequestParam("bpCode") String bpCode, @RequestParam("suppName") String suppName) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			String checkEmail = serviceManager.supDetailsRepo.checkBpCode(bpCode);
			if (null == checkEmail) {
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setMsg("exist");
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

}
