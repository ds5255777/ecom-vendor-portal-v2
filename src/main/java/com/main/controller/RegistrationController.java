package com.main.controller;

import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.main.db.bpaas.entity.EmailAuditLogs;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.MailContent;
import com.main.db.bpaas.entity.SendEmail;
import com.main.db.bpaas.entity.SupDetails;
import com.main.payloads.SupDetailsDTO;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/registrationController")
@RestController
public class RegistrationController {

	@Autowired
	private ServiceManager serviceManager;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(RegistrationController.class);

	public synchronized String generateVendorCode() {

		String vendorCodePrefix = "Temp-";
		return vendorCodePrefix.concat(new SimpleDateFormat("yyyyHHmmssSSS").format(new Date()));
	}

	@PostMapping({ "/getPendingRequest" })
	public String getPendingRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<Object[]> users = serviceManager.supDetailsRepo
						.findByPendingVenStatus(GlobalConstants.PENDING_REQUEST_STATUS);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				data.setData(users);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getApprovedRequest" })
	public String getApprovedRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<SupDetails> users = serviceManager.supDetailsRepo.findByVenStatus();
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				data.setData(users);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getRejectedRequest" })
	public String getRejectedRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<Object[]> users = serviceManager.supDetailsRepo
						.findByPendingVenStatus(GlobalConstants.REJECTED_REQUEST_STATUS);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				data.setData(users);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getQueryRequest" })
	public String getQueryRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<Object[]> users = serviceManager.supDetailsRepo
						.findByPendingVenStatus(GlobalConstants.QUERY_REQUEST_STATUS);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				data.setData(users);
			}
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/updateVendorRegistrationStatus" })
	public String updateVendorRegistrationStatus(Principal principal, @RequestBody SupDetailsDTO objDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				SupDetails obj = serviceManager.supDetailsRepo.findByPid(objDto.getPid());
				data.setData(this.serviceManager.modelMapper.map(obj, SupDetailsDTO.class));
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getAllApprovedVendor" })

	public String getAllApprovedVendor(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)
					|| rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {

				List<SupDetails> approvedVendor = serviceManager.supDetailsRepo.findByVenStatus();
				data.setData(approvedVendor);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/approveRequest" })
	public String approveRequest(Principal principal, @RequestBody SupDetailsDTO supDetailsDto,
			HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String vendorCode = "";
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		String userEmail = (String) request.getSession().getAttribute("userEmail");

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				Date date = new Date();
				DateFormat dateFormat = new SimpleDateFormat(GlobalConstants.DATE_FORMATTER);
				String strDate = dateFormat.format(date);
				vendorCode = generateVendorCode();

				serviceManager.supDetailsRepo.approveRequestByPid(vendorCode, supDetailsDto.getPid(), userEmail,
						strDate, GlobalConstants.APPROVED_REQUEST_STATUS);

				/* send Approval email */

				List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository
						.findByIsActive(GlobalConstants.ACTIVE_STATUS);
				EmailConfiguration emailConfiguration = emailList.get(0);

				SupDetails supDetails = serviceManager.supDetailsRepo.findByPid(supDetailsDto.getPid());

				String vendorEmail = supDetails.getContactDetails().get(0).getConEmail();
				String introducerEmailID = supDetails.getIntroducedByEmailID();

				List<String> findbyRoleId = serviceManager.userRepository.findbyRoleId(1);
				String allEmail = "";
				for (String string : findbyRoleId) {
					allEmail = allEmail + string + ",";
				}
				System.out.println(allEmail + introducerEmailID);

				List<MailContent> mailType = serviceManager.mailContentRepo.findByType("Vendor Approved");

				SendEmail sendEmail = new SendEmail();
				MailContent mailContent = mailType.get(0);
				String emailBody = mailContent.getEmailBody();

				emailBody = emailBody.replace("#VendorRefId#", supDetailsDto.getPid());
				emailBody = emailBody.replace("#approvedDate#", strDate);

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
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/rejectedRequest" })
	public String rejectedRequest(Principal principal, HttpServletRequest request, @RequestBody String obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		String userEmail = (String) request.getSession().getAttribute("userEmail");

		JSONObject jsonObject = new JSONObject(obj);
		String pid = jsonObject.optString("pid");
		String comment = jsonObject.optString("comment");
		String vendorCode = jsonObject.optString("bpCode");
		String vandorMailId = jsonObject.optString("vandorMailId");
		String introducedByEmailID = jsonObject.optString("introducedByEmailID");
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat(GlobalConstants.DATE_FORMATTER);
		String strDate = dateFormat.format(date);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				serviceManager.supDetailsRepo.approveRequestByPid(vendorCode, pid, userEmail, strDate,
						GlobalConstants.REJECTED_REQUEST_STATUS);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

				/* send onBoard email */

				List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository
						.findByIsActive(GlobalConstants.ACTIVE_STATUS);
				EmailConfiguration emailConfiguration = emailList.get(0);

				List<MailContent> mailType = serviceManager.mailContentRepo.findByType("Vendor Rejected");

				SendEmail sendEmail = new SendEmail();
				MailContent mailContent = mailType.get(0);
				String emailBody = mailContent.getEmailBody();

				emailBody = emailBody.replace("#VendorRefId#", pid);
				emailBody = emailBody.replace("#Reason#", comment);

				sendEmail.setMailfrom(emailConfiguration.getUserName());
				sendEmail.setSendTo(vandorMailId);
				sendEmail.setBcc(introducedByEmailID);
				sendEmail.setSubject(mailContent.getSubject());
				sendEmail.setEmailBody(emailBody);
				sendEmail.setStatus(GlobalConstants.EMAIL_STATUS_SENDING);

				serviceManager.sendEmailRepo.save(sendEmail);

				EmailAuditLogs auditLogs = new EmailAuditLogs();
				auditLogs.setMailFrom(emailConfiguration.getUserName());
				auditLogs.setMailTo(vandorMailId);
				sendEmail.setBcc(introducedByEmailID);
				auditLogs.setMailSubject(mailContent.getSubject());
				auditLogs.setMailMessage(emailBody);

				serviceManager.emailAuditLogsRepo.save(auditLogs);

			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllRequest" })
	public String getAllRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<SupDetails> findAll = serviceManager.supDetailsRepo.findAll();
				data.setData(findAll);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	// filterVendorDetails

	@GetMapping({ "filterVendorDetails" })
	public String filterInvoiceDetails(HttpServletRequest request, @RequestParam(name = "startDate") String fromDate,
			@RequestParam(name = "endDate") String toDate) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		logger.info(fromDate);
		logger.info(toDate);

		try {
//			Date date1=new SimpleDateFormat("yyyy-mm-dd").parse(fromDate); 
//			Date date2=new SimpleDateFormat("yyyy-MM-dd").parse(toDate); 
			List<SupDetails> listOfVendorDetails = serviceManager.supDetailsRepo.findByCreateDateBetween(fromDate,
					toDate);

			List<SupDetails> collect = listOfVendorDetails.stream()
					.filter(p -> p.getVenStatus().equalsIgnoreCase(GlobalConstants.APPROVED_REQUEST_STATUS)
							|| p.getVenStatus().equalsIgnoreCase(GlobalConstants.UPDATE_VENDOR))
					.collect(Collectors.toList());

			// List<SupDetails> collect = listOfVendorDetails.stream().map(listOfVendor->
			// this.serviceManager.modelMapper.map(listOfVendor,
			// SupDetails.class)).collect(Collectors.toList());

			data.setData(collect);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

}
