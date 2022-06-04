package com.main.controller;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.Document;
import com.main.db.bpaas.entity.EmailAuditLogs;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.MailContent;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.SendEmail;
import com.main.serviceManager.ServiceManager;
import com.sun.xml.messaging.saaj.packaging.mime.MessagingException;

@RestController
@RequestMapping("/financeController")
public class FinanceController {

	@Autowired
	private ServiceManager serviceManager;
	

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(DashboardController.class);

	// all invoice
	@RequestMapping({ "/viewAllInvoiceForFinanceTeam" })
	@CrossOrigin("*")
	public String getAllInvoice(HttpServletRequest request) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getAllInvoice();

			data.setData(allInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	// Approved Invoice
	@RequestMapping({ "/viewAllProcessInvoiceForFinanceTeam" })
	@CrossOrigin("*")
	public String getAllProcessInvoice(HttpServletRequest request) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getAllProcessInvoice();

			data.setData(allInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	// Pending For Approval
	@RequestMapping({ "/viewAllUnProcessInvoiceForFinanceTeam" })
	@CrossOrigin("*")
	public String getAllUnProcessInvoice(HttpServletRequest request) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getAllUnProcessInvoice();

			data.setData(allInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	// Pending For Approval
	@RequestMapping({ "/getAllInReviewInvoice" })
	@CrossOrigin("*")
	public String getAllInReviewInvoice(HttpServletRequest request) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getAllInReviewInvoice();

			data.setData(allInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	// Payment Release
	@RequestMapping({ "/getPaymentReleaseInvoice" })
	@CrossOrigin("*")
	public String getPaymentReleaseInvoice(HttpServletRequest request) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getPaymentReleaseInvoice();

			data.setData(allInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/viewAllQueryInvoiceForFinanceTeam" })
	@CrossOrigin("*")
	public String getAllQueryInvoice(HttpServletRequest request) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getAllQueryInvoice();

			data.setData(allInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getQueryByTypeAndForeignKey" })
	@CrossOrigin("*")
	public String getQueryByTypeAndForeignKey(HttpServletRequest request, @RequestBody QueryEntity obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {

			List<QueryEntity> list = serviceManager.queryRepo
					.findByReferenceidAndTypeOrderByIdDesc(obj.getReferenceid(), obj.getType());

			data.setData(list);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}
		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/saveQuery" })
	@CrossOrigin("*")
	public String saveInvoiceQuery(Principal principal, HttpServletRequest request, @RequestBody QueryEntity entity) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String userName = principal.getName();
		String rolename = (String) request.getSession().getAttribute("role");
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String processedOn = dateFormat.format(date);
		List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");
		EmailConfiguration emailConfiguration = emailList.get(0);
		String vendorEmail = (String) request.getSession().getAttribute("userEmail");
		
		String emailType=null;
		String type="";

		try {
			Integer getid = entity.getId();

			if ("Invoice".equalsIgnoreCase(entity.getType())) {
				entity.setType(GlobalConstants.SET_TYPE_INVOICE);
				if (GlobalConstants.ROLE_VENDOR.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateInvoiceStatus(processedOn, userName,
							GlobalConstants.INVOICE_STATUS_IN_REVIEW, GlobalConstants.ROLE_FINANCE, getid);
					emailType=GlobalConstants.EMAIL_TYPE_VEN_INVOICE_UPDATE;
					type=entity.getType();
				} else if (GlobalConstants.ROLE_FINANCE.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateInvoiceStatus(processedOn, userName,
							GlobalConstants.INVOICE_STATUS_QUERY, GlobalConstants.ROLE_VENDOR, getid);
					emailType=GlobalConstants.EMAIL_TYPE_FIN_TEM_INVOICE_QUERY;
					type=entity.getType();
				} else if (GlobalConstants.ROLE_FINANCE_HEAD.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateInvoiceStatus(processedOn, userName,
							GlobalConstants.INVOICE_STATUS_QUERY, GlobalConstants.ROLE_FINANCE, getid);
					emailType=GlobalConstants.EMAIL_TYPE_FIN_HED_INVOICE_QUERY;
					type=entity.getType();
				} else if (GlobalConstants.ROLE_NETWORK.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateInvoiceStatus(processedOn, userName,
							GlobalConstants.INVOICE_STATUS_QUERY, GlobalConstants.ROLE_VENDOR, getid);
					emailType=GlobalConstants.EMAIL_TYPE_NET_TEM_INVOICE_QUERY;
					type=entity.getType();
				}

			} else {
				entity.setType(GlobalConstants.SET_TYPE_TRIP);
				if (GlobalConstants.ROLE_VENDOR.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateStatusByUserid(processedOn, userName,
							GlobalConstants.INVOICE_STATUS_QUERY, GlobalConstants.ROLE_NETWORK, getid);
					emailType=GlobalConstants.EMAIL_TYPE_VEN_TRIP_QUERY;
					type=entity.getType();
				}
			}

			if (getid != null) {
				entity.setId(null);
				entity.setForeignKey(getid);
				entity.setRaisedBy(userName);
				entity.setRaisedOn(new Date());
				entity.setReferenceid(entity.getRaisedAgainQuery());
				serviceManager.queryRepo.save(entity);
			}
			
			List<MailContent> queryType = serviceManager.mailContentRepo.findByType(type);

			if (!queryType.isEmpty()) {
				SendEmail sendEmail = new SendEmail();
				MailContent mailContent = queryType.get(0);
				sendEmail.setMailfrom(emailConfiguration.getUserName());
				
				if(rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
					if(GlobalConstants.SET_TYPE_TRIP.equals(type)) {
						sendEmail.setSendTo("Network Team");
					}else {
						sendEmail.setSendTo("Finance Team");
						sendEmail.setSendCc("Network Team");
					}
					
				}else if(rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {
					
					if(GlobalConstants.SET_TYPE_TRIP.equals(type)) {
						sendEmail.setSendTo("vender");
					}else {
						sendEmail.setSendTo("Finance Team");
						sendEmail.setSendCc("vendor ");
					}
					
				}else if(rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)) {
					sendEmail.setSendTo("Insert vender email");
					sendEmail.setSendCc("Network team");
				}else if(rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE_HEAD)) {
					sendEmail.setSendCc("Finance team");
				}
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

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	// getDocumentById
	@RequestMapping({ "/getDocumentByTypeAndForeignKey" })
	@CrossOrigin("*")
	public String getDocumentByTypeAndForeignKey(HttpServletRequest request, @RequestBody Document entity) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			List<Document> list = serviceManager.documentRepo.findByTypeAndForeignKeyOrderByIdDesc(entity.getType(),
					entity.getForeignKey());
			data.setData(list);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}
		return gson.toJson(data).toString();
	}

	// getDocumentById
	@RequestMapping({ "/approveInvoiceFinanceSide" })
	@CrossOrigin("*")
	public String approveInvoiceFinanceSide(Principal principal, HttpServletRequest request,
			@RequestBody InvoiceGenerationEntity entity) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		String userName = principal.getName();

		String role = (String) request.getSession().getAttribute("role");
		logger.info(role);
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String processedOn = dateFormat.format(date);
		try {

			if (GlobalConstants.ROLE_FINANCE_HEAD.equalsIgnoreCase(role)) {
				serviceManager.invoiceGenerationEntityRepo.updateInvoiceStatus(processedOn, userName,
						entity.getEcomInvoiceNumber(), "Approved");
			} else {
				serviceManager.invoiceGenerationEntityRepo.updateInvoiceStatus(processedOn, userName,
						entity.getEcomInvoiceNumber(), "Pending For Approval");
			}

			List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");
			EmailConfiguration emailConfiguration = emailList.get(0);

			String vendorEmail = (String) request.getSession().getAttribute("userEmail");

			List<MailContent> queryType = serviceManager.mailContentRepo.findByType("Finance Team Invoice Approve");

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

			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}
		return gson.toJson(data).toString();
	}

	// filterInvoiceDetails

	@RequestMapping({ "filterInvoiceDetails" })
	@CrossOrigin("*")
	public String filterInvoiceDetails(HttpServletRequest request,
			@RequestParam(name = "actualDeparture") String fromDate,
			@RequestParam(name = "actualArrival") String toDate) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		logger.info(fromDate);
		logger.info(toDate);
		try {
			List<InvoiceGenerationEntity> findByInvoiceDateBetween = serviceManager.invoiceGenerationEntityRepo
					.findByInvoiceDateBetween(fromDate, toDate);
			data.setData(findByInvoiceDateBetween);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}
		return gson.toJson(data).toString();
	}

	@RequestMapping({ "getFilterInvoiceByVendorCode" })
	@CrossOrigin("*")
	public String getFilterInvoiceByVendorCode(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<String> vendorList = serviceManager.invoiceGenerationEntityRepo.getDistnictVendorList();
			data.setData(vendorList);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}
		return gson.toJson(data).toString();
	}

	@RequestMapping(value = "/viewInvoiceForFinanceTeam", method = RequestMethod.POST)
	@CrossOrigin("*")
	public String viewInvoiceForFinanceTeam(@RequestBody InvoiceGenerationEntity obj)
			throws UnsupportedEncodingException, MessagingException {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			List<InvoiceGenerationEntity> obj1 = serviceManager.invoiceServiceImpl
					.getTripsByFilters(obj.getVendorCode(), obj.getInvoiceStatus());
			data.setData(obj1);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}
}
