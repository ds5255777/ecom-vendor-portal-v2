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
import javax.servlet.http.HttpSession;

import org.dozer.DozerBeanMapper;
import org.dozer.Mapper;
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
import com.main.bean.InvoiceQueryDto;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.Document;
import com.main.db.bpaas.entity.EmailAuditLogs;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.InvoiceLineItem;
import com.main.db.bpaas.entity.MailContent;
import com.main.db.bpaas.entity.PoInvoiceDetails;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.SendEmail;
import com.main.db.bpaas.entity.TripDetails;
import com.main.payloads.InvoiceGenerationDto;
import com.main.payloads.TripDetailsDto;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/invoiceController")
@RestController
public class InvoiceController {

	@Value("${filepath}")
	private String filepath;

	@Autowired
	private ServiceManager serviceManager;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(InvoiceController.class);

	@PostMapping({ "/getAllInvoice" })

	public String getAllInvoice(Principal principal) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String vendorCode = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(vendorCode);
		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
				List<InvoiceGenerationEntity> pandingInvoice = serviceManager.invoiceGenerationEntityRepo
						.getAllInvoice(vendorCode);
				List<InvoiceGenerationDto> listOfInvoice = pandingInvoice.stream()
						.map(allInvoice -> this.serviceManager.modelMapper.map(allInvoice, InvoiceGenerationDto.class))
						.collect(Collectors.toList());
				data.setData(listOfInvoice);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {
				List<InvoiceGenerationEntity> pandingInvoice = serviceManager.invoiceGenerationEntityRepo
						.getAllNetworkInvoice();
				data.setData(pandingInvoice);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getAllPendingInvoice" })
	public String getAllPendingInvoice(Principal principal) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(vendorCode);
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
				List<InvoiceGenerationEntity> pandingInvoice = serviceManager.invoiceGenerationEntityRepo
						.getAllProcessedInvoice(vendorCode);

				List<InvoiceGenerationDto> listOfInvoice = pandingInvoice.stream()
						.map(allInvoice -> this.serviceManager.modelMapper.map(allInvoice, InvoiceGenerationDto.class))
						.collect(Collectors.toList());
				data.setData(listOfInvoice);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllApproveInvoice" })
	public String getAllApproveInvoice(Principal principal) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(vendorCode);
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
				List<InvoiceGenerationEntity> pandingInvoice = serviceManager.invoiceGenerationEntityRepo
						.getAllApproveInvoice(vendorCode);

				List<InvoiceGenerationDto> listOfInvoice = pandingInvoice.stream()
						.map(allInvoice -> this.serviceManager.modelMapper.map(allInvoice, InvoiceGenerationDto.class))
						.collect(Collectors.toList());
				data.setData(listOfInvoice);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllQueryInvoiceVendor" })
	public String getAllQueryInvoiceVendor(Principal principal, HttpServletRequest request) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(vendorCode);
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
				List<InvoiceGenerationEntity> queryInvoice = serviceManager.invoiceGenerationEntityRepo
						.getAllQueryInvoiceVendor(vendorCode);

				List<InvoiceGenerationDto> listOfInvoice = queryInvoice.stream()
						.map(allInvoice -> this.serviceManager.modelMapper.map(allInvoice, InvoiceGenerationDto.class))
						.collect(Collectors.toList());
				data.setData(listOfInvoice);
			} else {
				List<InvoiceGenerationEntity> queryInvoice = serviceManager.invoiceGenerationEntityRepo
						.getAllQueryInvoiceVendor();
				List<InvoiceGenerationDto> listOfInvoice = queryInvoice.stream()
						.map(allInvoice -> this.serviceManager.modelMapper.map(allInvoice, InvoiceGenerationDto.class))
						.collect(Collectors.toList());
				data.setData(listOfInvoice);
			}
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllRejectInvoice" })
	public String getAllRejectInvoice(Principal principal, @RequestBody List<InvoiceGenerationEntity> invoiceDetails) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String vendorCode = principal.getName();
		try {
			List<InvoiceGenerationEntity> pandingInvoice = serviceManager.invoiceGenerationEntityRepo
					.getAllRejectInvoice(vendorCode);

			List<InvoiceGenerationDto> listOfInvoice = pandingInvoice.stream()
					.map(allInvoice -> this.serviceManager.modelMapper.map(allInvoice, InvoiceGenerationDto.class))
					.collect(Collectors.toList());
			data.setData(listOfInvoice);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllInvoiceToBilling" })
	public String getMonthallyInvoice(Principal principal, HttpServletRequest request) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String vendorCode = principal.getName();
		try {
			List<InvoiceGenerationEntity> pandingInvoice = serviceManager.invoiceGenerationEntityRepo
					.getAllRejectInvoice(vendorCode);

			List<InvoiceGenerationDto> listOfInvoice = pandingInvoice.stream()
					.map(allInvoice -> this.serviceManager.modelMapper.map(allInvoice, InvoiceGenerationDto.class))
					.collect(Collectors.toList());
			data.setData(listOfInvoice);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping("/saveInvoice")
	public String saveInvoice(HttpServletRequest request, @RequestBody InvoiceGenerationDto invoiceDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			String filePath = filepath + File.separator + invoiceDto.getEcomInvoiceNumber();
			String fullFilePathWithName = "";

			if (null != invoiceDto.getInvoiceFileName()) {

				File file1 = new File(filePath);

				if (!file1.exists()) {
					file1.mkdirs();
				}
				fullFilePathWithName = filePath + File.separator + invoiceDto.getInvoiceFileName();

				Document doc = new Document();
				doc.setDocName(invoiceDto.getInvoiceFileName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus(GlobalConstants.ACTIVE_STATUS);
				doc.setType(GlobalConstants.SET_TYPE_INVOICE);
				doc.setForeignKey(invoiceDto.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				FileOutputStream fos = new FileOutputStream(fullFilePathWithName);
				String b64 = invoiceDto.getInvoiceFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
				fos.close();

			}

			if (null != invoiceDto.getDocumentFileOneName()) {

				fullFilePathWithName = filePath + File.separator + invoiceDto.getDocumentFileOneName();

				Document doc = new Document();
				doc.setDocName(invoiceDto.getDocumentFileOneName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus(GlobalConstants.ACTIVE_STATUS);
				doc.setType(GlobalConstants.SET_TYPE_INVOICE);
				doc.setForeignKey(invoiceDto.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				FileOutputStream fos = new FileOutputStream(fullFilePathWithName);
				String b64 = invoiceDto.getDocumentFileOneText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
				fos.close();

			}

			if (null != invoiceDto.getDocumentFileTwoName()) {

				fullFilePathWithName = filePath + File.separator + invoiceDto.getDocumentFileTwoName();

				Document doc = new Document();
				doc.setDocName(invoiceDto.getDocumentFileTwoName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus(GlobalConstants.ACTIVE_STATUS);
				doc.setType(GlobalConstants.SET_TYPE_INVOICE);
				doc.setForeignKey(invoiceDto.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				FileOutputStream fos = new FileOutputStream(fullFilePathWithName);
				String b64 = invoiceDto.getDocumentFileTwoText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
				fos.close();

			}
			String ecomInvoiceNumber = invoiceDto.getEcomInvoiceNumber();

			Long idByinvocienumber = serviceManager.invoiceGenerationEntityRepo.getIdByinvocienumber(ecomInvoiceNumber);

			Date date = new Date();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
			String processedOn = dateFormat.format(date);

			if (null != idByinvocienumber) {
				invoiceDto.setInvoiceStatus(GlobalConstants.INVOICE_STATUS_IN_REVIEW);
				invoiceDto.setId(idByinvocienumber);
				invoiceDto.setProcessedBy(invoiceDto.getVendorCode());
				invoiceDto.setProcessedOn(processedOn);
				invoiceDto.setAssignTo(GlobalConstants.ROLE_FINANCE);
				serviceManager.tripDetailsRepo.updateVendorTripStatusAgainsInvoiceNumber(ecomInvoiceNumber);
				InvoiceGenerationEntity invoiceSave = this.serviceManager.modelMapper.map(invoiceDto,
						InvoiceGenerationEntity.class);
				serviceManager.invoiceGenerationEntityRepo.save(invoiceSave);
			}

			List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository
					.findByIsActive(GlobalConstants.ACTIVE_STATUS);
			EmailConfiguration emailConfiguration = emailList.get(0);

			String vendorEmail = (String) request.getSession().getAttribute("userEmail");

			List<MailContent> queryType = serviceManager.mailContentRepo.findByType("Vendor Invoice Process");

			if (!queryType.isEmpty()) {
				SendEmail sendEmail = new SendEmail();
				MailContent mailContent = queryType.get(0);
				sendEmail.setMailfrom(emailConfiguration.getUserName());
				sendEmail.setSendTo(vendorEmail);
				sendEmail.setSubject(mailContent.getSubject());
				sendEmail.setEmailBody(mailContent.getEmailBody());
				sendEmail.setStatus(GlobalConstants.EMAIL_STATUS_SENDING);

				serviceManager.sendEmailRepo.save(sendEmail);

				EmailAuditLogs auditLogs = new EmailAuditLogs();
				auditLogs.setMailFrom(emailConfiguration.getUserName());
				auditLogs.setMailTo(vendorEmail);
				auditLogs.setMailSubject(mailContent.getSubject());
				auditLogs.setMailMessage(mailContent.getEmailBody());

				serviceManager.emailAuditLogsRepo.save(auditLogs);
			}
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);

	}

	@PostMapping("/updateInvoice")
	public String updateInvoice(HttpServletRequest request, @RequestBody InvoiceQueryDto obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String rolename = (String) request.getSession().getAttribute("role");
		try {
			String filePath = filepath + File.separator + obj.getEcomInvoiceNumber();
			String fullFilePathWithName = "";
			Date date = new Date();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
			String processedOn = dateFormat.format(date);

			if (null != obj.getDocumentFileOneName()) {

				File file1 = new File(filePath);

				if (!file1.exists()) {
					file1.mkdirs();
				}

				fullFilePathWithName = filePath + File.separator + obj.getDocumentFileOneName();

				Document doc = new Document();
				doc.setDocName(obj.getDocumentFileOneName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus(GlobalConstants.ACTIVE_STATUS);
				doc.setType(GlobalConstants.SET_TYPE_INVOICE);
				doc.setForeignKey(obj.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);
				logger.info(fullFilePathWithName);

				FileOutputStream fos = new FileOutputStream(fullFilePathWithName);
				String b64 = obj.getDocumentFileOneText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
				fos.close();
			}

			if (null != obj.getDocumentFileTwoName()) {

				fullFilePathWithName = filePath + File.separator + obj.getDocumentFileTwoName();

				Document doc = new Document();
				doc.setDocName(obj.getDocumentFileTwoName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus(GlobalConstants.ACTIVE_STATUS);
				doc.setType(GlobalConstants.SET_TYPE_INVOICE);
				doc.setForeignKey(obj.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				FileOutputStream fos = new FileOutputStream(fullFilePathWithName);
				String b64 = obj.getDocumentFileTwoText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
				fos.close();
			}
			String ecomInvoiceNumber = obj.getEcomInvoiceNumber();

			List<InvoiceLineItem> invoiceLineItemsList = obj.getInvoiceLineItems();

			InvoiceGenerationEntity invObj = serviceManager.invoiceGenerationEntityRepo
					.findByEcomInvoiceNumber(ecomInvoiceNumber);

			if (null != obj) {

				List<InvoiceLineItem> artifactsList = invoiceLineItemsList.stream()
						.filter(x -> "1".equalsIgnoreCase(x.getNewAdded())).collect(Collectors.toList());

				if (!artifactsList.isEmpty()) {
					for (InvoiceLineItem invoiceLineItem : artifactsList) {
						serviceManager.tripDetailsRepo.updateVendorTripStatusAgainsQueryInvoice(
								invoiceLineItem.getTripID(), ecomInvoiceNumber);
					}
				}

				invObj.setInvoiceLineItem(invoiceLineItemsList);
				invObj.setAssignTo(obj.getAssignTo());
				invObj.setInvoiceStatus(obj.getInvoiceStatus());
				invObj.setInvoiceAmount(obj.getInvoiceAmount());
				invObj.setTaxableAmount(obj.getTaxableAmount());
				invObj.setProcessedBy(obj.getVendorCode());
				invObj.setProcessedOn(processedOn);

				serviceManager.invoiceGenerationEntityRepo.save(invObj);
				serviceManager.tripDetailsRepo.updateVendorTripStatusAgainsQueryInvoice("123", ecomInvoiceNumber);

				QueryEntity queryEntity = new QueryEntity();
				queryEntity.setComment(obj.getRemarks());
				queryEntity.setForeignKey(Integer.valueOf(invObj.getId().toString()));
				queryEntity.setRaisedAgainQuery(obj.getInvoiceNumber());
				queryEntity.setRole(rolename);
				queryEntity.setRaisedBy(obj.getVendorCode());
				queryEntity.setRaisedOn(new Date());
				queryEntity.setReferenceid(obj.getInvoiceNumber());
				queryEntity.setType("Invoice");
				serviceManager.queryRepo.save(queryEntity);

				String invoiceNumber = obj.getEcomInvoiceNumber();
				logger.info(invoiceNumber);

			}
			data.setData(obj);
			List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");
			EmailConfiguration emailConfiguration = emailList.get(0);

			String vendorEmail = (String) request.getSession().getAttribute("userEmail");

			List<MailContent> queryType = serviceManager.mailContentRepo.findByType("Invoice Update");

			if (!queryType.isEmpty()) {
				SendEmail sendEmail = new SendEmail();
				MailContent mailContent = queryType.get(0);
				sendEmail.setMailfrom(emailConfiguration.getUserName());
				sendEmail.setSendTo(vendorEmail);
				sendEmail.setSubject(mailContent.getSubject());
				sendEmail.setEmailBody(mailContent.getEmailBody());
				sendEmail.setStatus(GlobalConstants.EMAIL_STATUS_SENDING);

				serviceManager.sendEmailRepo.save(sendEmail);

				EmailAuditLogs auditLogs = new EmailAuditLogs();
				auditLogs.setMailFrom(emailConfiguration.getUserName());
				auditLogs.setMailTo(vendorEmail);
				auditLogs.setMailSubject(mailContent.getSubject());
				auditLogs.setMailMessage(mailContent.getEmailBody());

				serviceManager.emailAuditLogsRepo.save(auditLogs);
			}

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);

	}

	@PostMapping({ "/getSelectInvoiceDetails" })
	public String getSelectInvoiceDetails(Principal principal, @RequestBody InvoiceGenerationDto invoiceObj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String invoiceNumber = invoiceObj.getEcomInvoiceNumber();
		String vendorCode = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(vendorCode);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)
					|| rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE_HEAD)
					|| rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {
				InvoiceGenerationEntity invoiceObject = serviceManager.invoiceGenerationEntityRepo
						.findByEcomInvoiceNumber(invoiceNumber);

				data.setData(serviceManager.modelMapper.map(invoiceObject, InvoiceGenerationDto.class));
			} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

				InvoiceGenerationEntity invoiceObject = serviceManager.invoiceGenerationEntityRepo
						.findByEcomInvoiceNumberAndVendorCode(invoiceNumber, vendorCode);
				data.setData(serviceManager.modelMapper.map(invoiceObject, InvoiceGenerationDto.class));

			}
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllDraftInvoice" })
	public String getAllDraftInvoice(Principal principal) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			List<InvoiceGenerationEntity> draftInvoice = serviceManager.invoiceGenerationEntityRepo
					.getDraftInvoice(vendorCode);
			List<InvoiceGenerationDto> listOfInvoice = draftInvoice.stream()
					.map(allInvoice -> this.serviceManager.modelMapper.map(allInvoice, InvoiceGenerationDto.class))
					.collect(Collectors.toList());
			data.setData(listOfInvoice);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/deleteDraftInvoice" })
	public String deleteDraftInvoice(@RequestBody InvoiceGenerationDto obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			Long id = obj.getId();
			String ecomInvoiceNumber = obj.getEcomInvoiceNumber();
			serviceManager.invoiceGenerationEntityRepo.deleteById(id);
			serviceManager.invoiceNumberRepo.removeInvoice(ecomInvoiceNumber);
			serviceManager.tripDetailsRepo.updatetripStatusagainsInvoiceNumber(ecomInvoiceNumber);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/deleteLineItem" })
	public String deleteLineItem(HttpServletRequest request, @RequestBody TripDetailsDto obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			String tripID = obj.getTripID();

			serviceManager.tripDetailsRepo.updateVendorTripStatus(tripID);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/discardDraftInvoice" })
	public String discardDraftInvoice(HttpServletRequest request, @RequestBody InvoiceGenerationDto obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			String invoiceNumber = obj.getEcomInvoiceNumber();

			serviceManager.tripDetailsRepo.discardDraftInvoice(invoiceNumber);
			serviceManager.invoiceNumberRepo.removeInvoice(invoiceNumber);
			serviceManager.tripDetailsRepo.updateVendorTripStatusAgainsInvoice(invoiceNumber);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllQueryInvoiceVendorPo" })
	public String getAllQueryInvoiceVendorPo(Principal principal, HttpServletRequest request) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			List<PoInvoiceDetails> queryInvoice = serviceManager.poinvoiceRepo.getAllQueryInvoiceVendorPo(vendorCode);

			List<InvoiceGenerationDto> listOfInvoice = queryInvoice.stream()
					.map(allInvoice -> this.serviceManager.modelMapper.map(allInvoice, InvoiceGenerationDto.class))
					.collect(Collectors.toList());
			data.setData(listOfInvoice);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/checkForExistingInvoiceNumber" })
	public String checkForExistingInvoiceNumber(HttpServletRequest request, @RequestBody InvoiceGenerationDto obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			String invoiceNumber = serviceManager.invoiceGenerationEntityRepo
					.checkForExistingInvoiceNumber(obj.getVendorCode(), obj.getInvoiceNumber());

			if (null == invoiceNumber) {
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setMsg("exist");
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping(value = "/getQueryInvoice")
	public String getQueryInvoice(@RequestBody InvoiceGenerationDto obj, Principal principal, HttpSession session,
			HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String vendorCode = principal.getName();

		try {
			String invoiceNumber = obj.getEcomInvoiceNumber();
			InvoiceGenerationEntity queryInvoice = serviceManager.invoiceGenerationEntityRepo
					.getQueryInvoice(vendorCode, invoiceNumber);
			InvoiceGenerationDto invoiceObj = this.serviceManager.modelMapper.map(queryInvoice,
					InvoiceGenerationDto.class);

			data.setData(invoiceObj);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/deleteTripQueryInvoice" })
	public String deleteTripQueryInvoice(HttpServletRequest request, @RequestBody TripDetailsDto obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			String tripID = obj.getTripID();
			serviceManager.tripDetailsRepo.updateVendorTripStatus(tripID);
			serviceManager.invoiceLineItemRepo.updateTrip(tripID);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/addNewTripInQueryInvoice" })
	public String addNewTripInQueryInvoice(HttpServletRequest request, @RequestBody TripDetailsDto obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			String tripID = obj.getTripID();
			TripDetails tripDetails = serviceManager.tripDetailsRepo.findByTripID(tripID);
			if (null != tripDetails) {
				Mapper mapper = new DozerBeanMapper();
				InvoiceLineItem lineItem = mapper.map(tripDetails, InvoiceLineItem.class);
				lineItem.setId(null);
				data.setData(lineItem);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setData("data Not found");
				data.setMsg("Failed");
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return gson.toJson(data);
	}

}
