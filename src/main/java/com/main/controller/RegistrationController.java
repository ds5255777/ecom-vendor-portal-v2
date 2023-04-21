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
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
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
import com.main.db.bpaas.entity.SendEmail;
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.entity.SupDetailsTransaction;
import com.main.db.bpaas.repo.SupDetailsTransactionRepo;
import com.main.payloads.SupDetailsDTO;
import com.main.payloads.SupDetailsTransactionDTO;
import com.main.servicemanager.ServiceManager;
import com.main.servicemanager.SupDetailsServiceImpl;

@RequestMapping("/registrationController")
@RestController
public class RegistrationController {

	@Value("${filepaths}")
	public String filepaths;

	@Value("${logFilePath}")
	private String logFilePath;

	@Autowired
	private ServiceManager serviceManager;

	@Autowired
	private SupDetailsTransactionRepo supDetailsTranRepo;

	@Autowired
	private SupDetailsServiceImpl supServiceImpl;

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

	/*
	 * @PostMapping({ "/getQueryRequest" }) public String getQueryRequest(Principal
	 * principal) {
	 * 
	 * DataContainer data = new DataContainer(); Gson gson = new
	 * GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create(); String
	 * userName = principal.getName(); String rolename =
	 * serviceManager.rolesRepository.getuserRoleByUserName(userName);
	 * 
	 * try { if
	 * (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {
	 * 
	 * List<Object[]> users = serviceManager.supDetailsRepo
	 * .findByPendingVenStatus(GlobalConstants.QUERY_REQUEST_STATUS);
	 * data.setMsg(GlobalConstants.SUCCESS_MESSAGE); data.setData(users); } } catch
	 * (Exception e) { data.setMsg(GlobalConstants.ERROR_MESSAGE);
	 * logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e); } return
	 * gson.toJson(data); }
	 */

	@PostMapping({ "/getQueryRequest" })
	public String getQueryRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<Object[]> users = supDetailsTranRepo.findByVenStatus(GlobalConstants.UPDATING_REQUEST_STATUS);
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

	@PostMapping({ "/updateVendorProfileStatus" })
	public String updateVendorProfileStatus(Principal principal, @RequestBody SupDetailsTransactionDTO objDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				SupDetailsTransaction obj = supDetailsTranRepo.findByPidAndVenStatus(objDto.getPid(),
						GlobalConstants.UPDATING_REQUEST_STATUS);
				data.setData(this.serviceManager.modelMapper.map(obj, SupDetailsTransactionDTO.class));
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

	@PostMapping("updateVendor")
	public String updateVendor(HttpServletRequest request, @RequestBody SupDetailsTransactionDTO supDetailsDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String strDate = "";
		String processID = "";
		try {
			String bpCode = supDetailsDto.getBpCode();

			SupDetailsTransaction listVendetails = supDetailsTranRepo.findByBpCodeAndVenStatus(bpCode,
					GlobalConstants.UPDATING_REQUEST_STATUS);

			if (null == listVendetails) {

				SupDetails supDetails = serviceManager.supDetailsRepo.findBybpCode(bpCode);

				processID = supDetails.getPid();
				Date date = new Date();
				DateFormat dateFormat = new SimpleDateFormat(GlobalConstants.DATE_FORMATTER);
				strDate = dateFormat.format(date);

				for (int i = 0; i < supDetailsDto.getAddressDetails().size(); i++) {
					String state = supDetailsDto.getAddressDetails().get(i).getState();
					String stCode = serviceManager.stateRepo.findByStateCode(state);

					String partnerType = supDetailsDto.getAddressDetails().get(i).getVendorType();
					String glCode = serviceManager.businessPartnerTypeRepo.getGlCodeByPartnerType(partnerType);
					if (!partnerType.isEmpty()) {
						String typeCode = serviceManager.businessPartnerTypeRepo.findByTypeCode(partnerType);
						supDetailsDto.getAddressDetails().get(i).setSupplierSiteCode(stCode.concat("_" + typeCode));
						supDetailsDto.getAddressDetails().get(i).setGlCode(glCode);
					}
				}
				supDetailsDto.setVenStatus(GlobalConstants.UPDATING_REQUEST_STATUS);
				supDetailsDto.setPid(processID);
				supDetailsDto.setCreateDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
				supDetailsTranRepo
						.save(this.serviceManager.modelMapper.map(supDetailsDto, SupDetailsTransaction.class));

				String filePath = filepaths + "/" + processID;
				String fullFilePathWithName = "";
				File file1 = new File(filePath);

				String docId = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());

				if (!file1.exists()) {
					file1.mkdirs();
				}
				File logFilePathFolder = new File(logFilePath);
				if (!logFilePathFolder.exists()) {
					logFilePathFolder.mkdir();
				}
				if (null != supDetailsDto.getGstFileName()) {

					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getGstFileName();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getGstFileName());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getPdFileName();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getPdFileName());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getPanFileName();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getPanFileName());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getCcFileName();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getCcFileName());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getAcFileName();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getAcFileName());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getAplFileName();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getAplFileName());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getItrFileName();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getItrFileName());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getFuvfFileName();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getFuvfFileName());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getMsmecFileName();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getMsmecFileName());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getAmFileName();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getAmFileName());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getItraFileName1();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getItraFileName1());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getItraFileName2();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getItraFileName2());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getItraFileName3();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getItraFileName3());
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
					fullFilePathWithName = filePath + File.separator + docId + "_" + supDetailsDto.getNmisFileName();

					Document doc = new Document();
					doc.setDocName(docId + "_" + supDetailsDto.getNmisFileName());
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
				System.out.println(supDetailsDto.toString());
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				return gson.toJson(data);
			}

			data.setMsg("Duplicate Record");
			return gson.toJson(data);

		} catch (

		Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/updateProfile" })
	public String updateProfile(Principal principal, @RequestBody SupDetailsTransactionDTO supDetailsDto,
			HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				SupDetailsTransaction vendorDetails = supDetailsTranRepo.findByPidAndVenStatus(supDetailsDto.getPid(),
						GlobalConstants.UPDATING_REQUEST_STATUS);

				supDetailsDto = this.serviceManager.modelMapper.map(vendorDetails, SupDetailsTransactionDTO.class);

				SupDetailsTransaction updateSuppDetails = supServiceImpl.updateSuppDetails(supDetailsDto, userName);
				if (null != updateSuppDetails) {
					data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				} else {
					data.setMsg(GlobalConstants.ERROR_MESSAGE);
				}
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/rejectedProfile" })
	public String rejectedProfile(Principal principal, @RequestBody String obj, HttpServletRequest request) {

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

		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat(GlobalConstants.DATE_FORMATTER);
		String strDate = dateFormat.format(date);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				supDetailsTranRepo.approveRequestByPid(vendorCode, pid, userName, strDate,
						GlobalConstants.REJECTED_REQUEST_STATUS);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

				/* send onBoard email */

				List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository
						.findByIsActive(GlobalConstants.ACTIVE_STATUS);
				EmailConfiguration emailConfiguration = emailList.get(0);

				List<MailContent> mailType = serviceManager.mailContentRepo.findByType("Profile Rejected");

				SendEmail sendEmail = new SendEmail();
				MailContent mailContent = mailType.get(0);
				String emailBody = mailContent.getEmailBody();

				emailBody = emailBody.replace("#VendorRefId#", pid);
				emailBody = emailBody.replace("#Reason#", comment);

				sendEmail.setMailfrom(emailConfiguration.getUserName());
				sendEmail.setSendTo(vandorMailId);
				sendEmail.setSubject(mailContent.getSubject());
				sendEmail.setEmailBody(emailBody);
				sendEmail.setStatus(GlobalConstants.EMAIL_STATUS_SENDING);

				serviceManager.sendEmailRepo.save(sendEmail);

				EmailAuditLogs auditLogs = new EmailAuditLogs();
				auditLogs.setMailFrom(emailConfiguration.getUserName());
				auditLogs.setMailTo(vandorMailId);
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

}
