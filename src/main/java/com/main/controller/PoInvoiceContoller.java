package com.main.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.Document;
import com.main.db.bpaas.entity.EmailAuditLogs;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.MailContent;
import com.main.db.bpaas.entity.PoDetails;
import com.main.db.bpaas.entity.PoInvoiceDetails;
import com.main.db.bpaas.entity.PoInvoiceLine;
import com.main.db.bpaas.entity.SendEmail;
import com.main.db.bpaas.repo.PoDetailsRepo;
import com.main.db.bpaas.repo.PoInvoiceRepo;
import com.main.serviceManager.ServiceManager;

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
	
	@RequestMapping({ "/deleteDraftPoInvoice" })
	@CrossOrigin("*")
	public String deleteDraftPoInvoice(HttpServletRequest request, @RequestBody PoDetails obj) {
		
		logger.info("Log Some Information : "+dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String ecomInvoiceNumber = obj.getInvoiceNumber();
			Long id = poInvoiceRepo.getId(ecomInvoiceNumber);
			logger.info("ecomInvoiceNumber"+ecomInvoiceNumber);
			
			poInvoiceRepo.deleteById(id);
//			poInvoiceRepo.deleteByInvoiceNumber(ecomInvoiceNumber);
			poDetailsRepo.updatePoStatusagainsInvoiceNumber(ecomInvoiceNumber);

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getAllDraftInvoicePO" })
	@CrossOrigin("*")
	public String getAllDraftInvoicePO(HttpServletRequest request,Principal principal ) {

		DataContainer data = new DataContainer();
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = principal.getName();
			
			List<PoInvoiceDetails> details =poInvoiceRepo. getAllDraftPoInvoice(vendorCode);
			data.setData(details);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}
	
	@PostMapping({ "/savePoInvoice" })
	@CrossOrigin("*")
	public String savePoInvoice(HttpServletRequest request ,Principal principal,@RequestBody PoInvoiceDetails invoiceDetails ) {

		DataContainer data = new DataContainer();
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String filePath = filepath + File.separator + invoiceDetails.getInvoiceNumber();
			String fullFilePathWithName = "";

			if (null != invoiceDetails.getInvoiceFileName()) {

				File file1 = new File(filePath);

				if (!file1.exists()) {
					file1.mkdirs();
				}
				fullFilePathWithName = filePath + File.separator + "Invoice-" + invoiceDetails.getInvoiceFileName();

				Document doc = new Document();
				doc.setDocName(invoiceDetails.getInvoiceFileName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus("1");
				doc.setType("Invoice");
				doc.setForeignKey(invoiceDetails.getInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = invoiceDetails.getInvoiceFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			if (null != invoiceDetails.getDocumentFileOneName()) {

				fullFilePathWithName = filePath + File.separator + "Summary Sheet-" + invoiceDetails.getDocumentFileOneName();

				Document doc = new Document();
				doc.setDocName(invoiceDetails.getDocumentFileOneName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus("1");
				doc.setType("Invoice");
				doc.setForeignKey(invoiceDetails.getInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = invoiceDetails.getDocumentFileOneText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			String vendorCode = principal.getName();
		
			String ecomInvoiceNumber = invoiceDetails.getInvoiceNumber();

				logger.info(ecomInvoiceNumber);
				List<PoInvoiceLine> poInvoiceLine =invoiceDetails.getPoInvoiceLine();
				invoiceDetails.setStatus("In-Review");
				invoiceDetails.setVendorCode(vendorCode);
				invoiceDetails.setRaisedBy(vendorCode);
				invoiceDetails.setRaisedOn(new Date());
				
				Long id = serviceManager.poinvoiceRepo.getId(ecomInvoiceNumber);
				logger.info("ecomInvoiceNumber"+ecomInvoiceNumber);
				if(id!=null ) {
				poInvoiceRepo.deleteById(id);
				}
				serviceManager.poinvoiceRepo.save(invoiceDetails);
				
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


				  
				
				
		
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}
	
	
	@PostMapping({ "/getAllDraftPODetailsByInvoiceNo" })
	@CrossOrigin("*")
	public String getAllDraftPODetailsByInvoiceNo(HttpServletRequest request ,Principal principal,@RequestBody PoInvoiceDetails invoiceDetails ) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = principal.getName();
			String invoiceNo=invoiceDetails.getInvoiceNumber();
			logger.info("vendorCode : "+vendorCode + "invoiceNo : "+invoiceNo);
			List<PoInvoiceDetails> details = poInvoiceRepo.getAllDraftPODetailsByInvoiceNo(vendorCode,invoiceNo);
			
			data.setData(details);
			data.setMsg("success");
			

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();

	}
	
	@PostMapping({ "/saveDraftInvoice" })
	@CrossOrigin("*")
	public String saveDraftInvoice(HttpServletRequest request ,Principal principal,@RequestBody PoInvoiceDetails invoiceDetails ) {

		DataContainer data = new DataContainer();
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = principal.getName();
		
			String ecomInvoiceNumber = invoiceDetails.getInvoiceNumber();

			invoiceDetails.setStatus("Draft-Invoicing");
			invoiceDetails.setVendorCode(vendorCode);
			logger.info("save draft invoice , ecomInvoiceNumber : "+ecomInvoiceNumber);
			Long id = poInvoiceRepo.getId(ecomInvoiceNumber);
			logger.info("ecomInvoiceNumber"+ecomInvoiceNumber);
			if(id!=null ) {
			poInvoiceRepo.deleteById(id);
				
			}
			
			poInvoiceRepo.save(invoiceDetails);
		
			data.setMsg("success");
	

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}
	

	
	

}
