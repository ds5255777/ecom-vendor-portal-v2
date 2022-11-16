package com.main.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
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
import org.json.JSONArray;
import org.json.JSONObject;
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
import com.main.payloads.PoInvoiceDetailsDTO;
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping("/saveInvoice")
	public String saveInvoice(HttpServletRequest request, @RequestBody InvoiceGenerationDto invoiceDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		JSONArray docJson = new JSONArray();
		JSONObject documentObj = new JSONObject();
		String[] documentExtensionArray = null;
		String filename = null;
		String documentExtension = null;

		String filePath = filepath + File.separator + invoiceDto.getEcomInvoiceNumber();
		String fullFilePathWithName = "";
		File file1 = new File(filePath);

		if (!file1.exists()) {
			file1.mkdirs();
		}

		if (null != invoiceDto.getInvoiceFileName()) {

			documentExtensionArray = invoiceDto.getInvoiceFileName().split("\\.(?=[^\\.]+$)");
			filename = documentExtensionArray[0];
			documentExtension = documentExtensionArray[1];

			documentObj = new JSONObject();
			documentObj.put("DocName", filename);
			documentObj.put("Extension", documentExtension);
			documentObj.put("Encoded", invoiceDto.getInvoiceFileText());
			docJson.put(documentObj);

			fullFilePathWithName = filePath + File.separator + invoiceDto.getInvoiceFileName();

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {

				Document doc = new Document();
				doc.setDocName(invoiceDto.getInvoiceFileName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus(GlobalConstants.ACTIVE_STATUS);
				doc.setType(GlobalConstants.SET_TYPE_INVOICE);
				doc.setForeignKey(invoiceDto.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				String b64 = invoiceDto.getInvoiceFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);

			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}

		}

		if (null != invoiceDto.getDocumentFileOneName()) {
			documentExtensionArray = invoiceDto.getDocumentFileOneName().split("\\.(?=[^\\.]+$)");
			filename = documentExtensionArray[0];
			documentExtension = documentExtensionArray[1];

			documentObj = new JSONObject();
			documentObj.put("DocName", filename);
			documentObj.put("Extension", documentExtension);
			documentObj.put("Encoded", invoiceDto.getDocumentFileOneText());
			docJson.put(documentObj);

			fullFilePathWithName = filePath + File.separator + invoiceDto.getDocumentFileOneName();

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				Document doc = new Document();
				doc.setDocName(invoiceDto.getDocumentFileOneName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus(GlobalConstants.ACTIVE_STATUS);
				doc.setType(GlobalConstants.SET_TYPE_INVOICE);
				doc.setForeignKey(invoiceDto.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				String b64 = invoiceDto.getDocumentFileOneText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);

			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}

		if (null != invoiceDto.getDocumentFileTwoName()) {
			documentExtensionArray = invoiceDto.getDocumentFileTwoName().split("\\.(?=[^\\.]+$)");
			filename = documentExtensionArray[0];
			documentExtension = documentExtensionArray[1];

			documentObj = new JSONObject();
			documentObj.put("DocName", filename);
			documentObj.put("Extension", documentExtension);
			documentObj.put("Encoded", invoiceDto.getDocumentFileTwoText());
			docJson.put(documentObj);

			fullFilePathWithName = filePath + File.separator + invoiceDto.getDocumentFileTwoName();

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				Document doc = new Document();
				doc.setDocName(invoiceDto.getDocumentFileTwoName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus(GlobalConstants.ACTIVE_STATUS);
				doc.setType(GlobalConstants.SET_TYPE_INVOICE);
				doc.setForeignKey(invoiceDto.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				String b64 = invoiceDto.getDocumentFileTwoText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);

			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}

		}

		// Vendor API calling
		// String vendor = "";
		String processID = "";
		try {
			String urldata = "http://65.1.184.148:8080/VendorPortal/portal/nonpo";
			URL url = new URL(urldata);
			System.out.println("In here*************");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// Header Details
			JSONObject json = new JSONObject();

			json.put("processid", "");
			json.put("process_flow", "");
			json.put("operating_Unit", "");
			json.put("type1", "");
			json.put("supp_name", invoiceDto.getVendorName());
			json.put("supp_number", invoiceDto.getVendorCode());
			json.put("supp_site_name", "");
			json.put("inv_date", invoiceDto.getInvoiceDate());
			json.put("inv_number", invoiceDto.getInvoiceNumber());
			json.put("inv_currency", invoiceDto.getInvoiceCurrency());
			json.put("gl_date1", "");
			json.put("payment_currency", "");
			json.put("header_des", "");
			json.put("term_date", "");
			json.put("terms", "");
			json.put("payment_met", "");
			json.put("pay_groups", "");
			json.put("payment_rate_date", "");
			json.put("payment_rate_type", "");
			json.put("payment_rate", "");
			json.put("match_action", "");
			json.put("expenses", "");
			json.put("payment_due_date", "");
			json.put("company_code", "");
			json.put("orignal_tax_inv_no", "");
			json.put("orignal_tax_inv_date", "");
			json.put("inv_amount_float", "");
			json.put("batch_name", "");
			json.put("month_1", "");
			json.put("year_1", "");
			json.put("state_1", "");

			JSONArray arrayForLineItem = new JSONArray();
			JSONObject nonPOLinesItem = null;

			if (!invoiceDto.getInvoiceLineItem().isEmpty()) {

				List<InvoiceLineItem> invoiceLineItem = invoiceDto.getInvoiceLineItem();

				for (int i = 0; i < invoiceLineItem.size(); i++) {
					nonPOLinesItem = new JSONObject();
					nonPOLinesItem.put("number_no", i);
					nonPOLinesItem.put("gross_amt", invoiceLineItem.get(i).getTotalFreight());
					nonPOLinesItem.put("route_name", invoiceLineItem.get(i).getRoute());
					nonPOLinesItem.put("vehicle_no", invoiceLineItem.get(i).getStandardVechicleType());
					nonPOLinesItem.put("description", invoiceLineItem.get(i).getLineLevelDescription());
					nonPOLinesItem.put("natural_account", "");
					nonPOLinesItem.put("cost_center", "");
					nonPOLinesItem.put("function_Function", "");
					nonPOLinesItem.put("tds_section_code", "");
					nonPOLinesItem.put("tds_tax_category", "");
					nonPOLinesItem.put("gst_tax_category", "");
					nonPOLinesItem.put("gst_tax_amount", "");
					nonPOLinesItem.put("business_line", "");

					arrayForLineItem.put(nonPOLinesItem);
				}

			}

			json.put("NonPOLines", arrayForLineItem);
			json.put("Documents", docJson);

			System.out.println("JSON is ::" + json.toString());

			conn.setRequestProperty("Accept", "application/json");
			//conn.setRequestProperty("username","newgen");
			//conn.setRequestProperty("password","VEnD0rP@4T89!");

			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Authorization", "Basic bmV3Z2VuOlZFbkQwclBANFQ4OSE=");
			conn.setDoOutput(true);

			OutputStream os = conn.getOutputStream();
			os.write(json.toString().getBytes());
			os.flush();

			if (conn.getResponseCode() != 200) {
				throw new RuntimeException("Failed : HTTP Error code : " + conn.getResponseCode());
			} else {
				System.out.println("conn.responsecode" + conn.getResponseCode());
			}
			InputStreamReader in = new InputStreamReader(conn.getInputStream());
			BufferedReader br = new BufferedReader(in);
			String finalOut = "";
			String outputloop = "";
			while ((outputloop = br.readLine()) != null) {
				finalOut = finalOut + outputloop;
				System.out.println("finalOut :\n" + finalOut);
			}

			System.out.println("Final output ::: " + finalOut);

			if ("".equalsIgnoreCase(finalOut)) {
				System.out.println("Error!!!!!!!!!Output from authentication web service is null");
			} else {
				System.out.println(" FinalOutput JSON in api ::: " + finalOut);
			}
			JSONObject jsonObject = new JSONObject(finalOut);
			if (null != jsonObject) {
				String statuscode = jsonObject.optString("Status");
				if ("201".equalsIgnoreCase(statuscode)) {
					processID = jsonObject.optString("ProcessID");

					invoiceDto.setPid(processID);
					System.out.println("   ------------" + processID);

				}

			}

			conn.disconnect();
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			data.setData(processID);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
			// serviceManager.invoiceGenerationEntityRepo.save(invoiceSave);
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

		return gson.toJson(data);

	}

	@PostMapping("/updateInvoice")
	public String updateInvoice(HttpServletRequest request, @RequestBody InvoiceQueryDto obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String rolename = (String) request.getSession().getAttribute("role");
		String filePath = filepath + File.separator + obj.getEcomInvoiceNumber();
		String fullFilePathWithName = "";
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String processedOn = dateFormat.format(date);

		File file1 = new File(filePath);

		if (!file1.exists()) {
			file1.mkdirs();
		}

		if (null != obj.getDocumentFileOneName()) {

			fullFilePathWithName = filePath + File.separator + obj.getDocumentFileOneName();

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				Document doc = new Document();
				doc.setDocName(obj.getDocumentFileOneName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus(GlobalConstants.ACTIVE_STATUS);
				doc.setType(GlobalConstants.SET_TYPE_INVOICE);
				doc.setForeignKey(obj.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);
				logger.info(fullFilePathWithName);

				String b64 = obj.getDocumentFileOneText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);

			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}

		if (null != obj.getDocumentFileTwoName()) {

			fullFilePathWithName = filePath + File.separator + obj.getDocumentFileTwoName();

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				Document doc = new Document();
				doc.setDocName(obj.getDocumentFileTwoName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus(GlobalConstants.ACTIVE_STATUS);
				doc.setType(GlobalConstants.SET_TYPE_INVOICE);
				doc.setForeignKey(obj.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				String b64 = obj.getDocumentFileTwoText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);

			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
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
					serviceManager.tripDetailsRepo.updateVendorTripStatusAgainsQueryInvoice(invoiceLineItem.getTripID(),
							ecomInvoiceNumber);
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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

			List<PoInvoiceDetailsDTO> poQueryInvoice = queryInvoice.stream()
					.map(allInvoice -> this.serviceManager.modelMapper.map(allInvoice, PoInvoiceDetailsDTO.class))
					.collect(Collectors.toList());
			data.setData(poQueryInvoice);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

}
