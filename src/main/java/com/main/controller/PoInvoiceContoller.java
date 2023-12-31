package com.main.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Date;
import java.util.List;
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
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.Document;
import com.main.db.bpaas.entity.EmailAuditLogs;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.MailContent;
import com.main.db.bpaas.entity.PoInvoiceDetails;
import com.main.db.bpaas.entity.SendEmail;
import com.main.db.bpaas.repo.PoDetailsRepo;
import com.main.db.bpaas.repo.PoInvoiceRepo;
import com.main.payloads.PoDetailsDTO;
import com.main.payloads.PoInvoiceDetailsDTO;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/PoInvoiceContoller")
@RestController
public class PoInvoiceContoller {

	@Autowired
	PoInvoiceRepo poInvoiceRepo;

	@Autowired
	PoDetailsRepo poDetailsRepo;

	@Autowired
	ServiceManager serviceManager;

	@Value("${filepath}")
	private String filepath;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(PoInvoiceContoller.class);

	@PostMapping({ "/deleteDraftPoInvoice" })
	public String deleteDraftPoInvoice(HttpServletRequest request, @RequestBody PoDetailsDTO objDto) {

		logger.info("Log Some Information deleteDraftPoInvoice ");

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			String ecomInvoiceNumber = objDto.getInvoiceNumber();
			Long id = poInvoiceRepo.getId(ecomInvoiceNumber);
			logger.info("ecomInvoiceNumber {} ", ecomInvoiceNumber);

			poInvoiceRepo.deleteById(id);
			poDetailsRepo.updatePoStatusagainsInvoiceNumber(ecomInvoiceNumber);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllDraftInvoicePO" })
	public String getAllDraftInvoicePO(HttpServletRequest request, Principal principal) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			String vendorCode = principal.getName();

			List<PoInvoiceDetails> details = poInvoiceRepo.getAllDraftPoInvoice(vendorCode);
			List<PoInvoiceDetailsDTO> detailsDto = details.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, PoInvoiceDetailsDTO.class))
					.collect(Collectors.toList());
			data.setData(detailsDto);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/savePoInvoice" })
	public String savePoInvoice(HttpServletRequest request, Principal principal,
			@RequestBody PoInvoiceDetailsDTO invoiceDetailsDto) throws IOException {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String filePath = filepath + File.separator + invoiceDetailsDto.getInvoiceNumber();
		File file1 = new File(filePath);

		if (!file1.exists()) {
			file1.mkdirs();
		}
		if (null != invoiceDetailsDto.getInvoiceFileName()) {
			String fullFilePathWithName = filePath + File.separator + invoiceDetailsDto.getInvoiceFileName();
			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName)) {
				Document doc = new Document();
				doc.setDocName(invoiceDetailsDto.getInvoiceFileName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus("1");
				doc.setType("Invoice");
				doc.setForeignKey(invoiceDetailsDto.getInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				String b64 = invoiceDetailsDto.getInvoiceFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);
				fos.write(decoder);
				
			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}

		if (null != invoiceDetailsDto.getDocumentFileOneName()) {
			String fullFilePathWithName = filePath + File.separator + invoiceDetailsDto.getDocumentFileOneName();
			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName)) {

				Document doc = new Document();
				doc.setDocName(invoiceDetailsDto.getDocumentFileOneName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus("1");
				doc.setType("Invoice");
				doc.setForeignKey(invoiceDetailsDto.getInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				String b64 = invoiceDetailsDto.getDocumentFileOneText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
				
			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}

		}

		String vendorCode = principal.getName();

		String ecomInvoiceNumber = invoiceDetailsDto.getInvoiceNumber();

		invoiceDetailsDto.setStatus(GlobalConstants.INVOICE_STATUS_IN_REVIEW);
		invoiceDetailsDto.setVendorCode(vendorCode);
		invoiceDetailsDto.setRaisedBy(vendorCode);
		invoiceDetailsDto.setRaisedOn(new Date());

		Long id = serviceManager.poinvoiceRepo.getId(ecomInvoiceNumber);
		if (id != null) {
			poInvoiceRepo.deleteById(id);
		}
		serviceManager.poinvoiceRepo
				.save(this.serviceManager.modelMapper.map(invoiceDetailsDto, PoInvoiceDetails.class));

		List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");
		EmailConfiguration emailConfiguration = emailList.get(0);

		String vendorEmail = (String) request.getSession().getAttribute("userEmail");

		List<MailContent> queryType = serviceManager.mailContentRepo.findByType("Vendor Trip Query");

		if (!queryType.isEmpty()) {
			SendEmail sendEmail = new SendEmail();
			MailContent mailContent = queryType.get(0);
			sendEmail.setMailfrom(emailConfiguration.getUserName());
			sendEmail.setSendTo(vendorEmail);
			sendEmail.setSubject(mailContent.getSubject());
			sendEmail.setEmailBody(mailContent.getEmailBody());
			sendEmail.setStatus("Y");

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

	@PostMapping({ "/getAllDraftPODetailsByInvoiceNo" })
	public String getAllDraftPODetailsByInvoiceNo(HttpServletRequest request, Principal principal,
			@RequestBody PoInvoiceDetailsDTO invoiceDetailsDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			String vendorCode = principal.getName();
			String invoiceNo = invoiceDetailsDto.getInvoiceNumber();
			List<PoInvoiceDetails> details = poInvoiceRepo.getAllDraftPODetailsByInvoiceNo(vendorCode, invoiceNo);
			List<PoInvoiceDetailsDTO> detailsDto = details.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, PoInvoiceDetailsDTO.class))
					.collect(Collectors.toList());
			data.setData(detailsDto);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);

	}

	@PostMapping({ "/saveDraftInvoice" })
	public String saveDraftInvoice(HttpServletRequest request, Principal principal,
			@RequestBody PoInvoiceDetailsDTO invoiceDetailsDto) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			String vendorCode = principal.getName();

			String ecomInvoiceNumber = invoiceDetailsDto.getInvoiceNumber();

			invoiceDetailsDto.setStatus("Draft-Invoicing");
			invoiceDetailsDto.setVendorCode(vendorCode);
			Long id = poInvoiceRepo.getId(ecomInvoiceNumber);
			if (id != null) {
				poInvoiceRepo.deleteById(id);
			}

			poInvoiceRepo.save(this.serviceManager.modelMapper.map(invoiceDetailsDto, PoInvoiceDetails.class));

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}
}
