package com.main.controller;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
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
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.MailContent;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.SendEmail;
import com.main.payloads.DocumentDto;
import com.main.payloads.InvoiceGenerationDto;
import com.main.payloads.QueryDto;
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
	@PostMapping({ "/viewAllInvoiceForFinanceTeam" })
	@CrossOrigin("*")
	public String getAllInvoice(Principal principal) {

		DataContainer data = new DataContainer();
		String userName = principal.getName();
		String userRole = this.serviceManager.rolesRepository.getuserRoleByUserName(userName);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			if (userRole.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)
					|| userRole.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE_HEAD)) {

				List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getAllInvoice();
				List<InvoiceGenerationDto> listofAllInvoice = allInvoice.stream()
						.map((listOfInvoice) -> this.serviceManager.modelMapper.map(listOfInvoice,
								InvoiceGenerationDto.class))
						.collect(Collectors.toList());

				data.setData(listofAllInvoice);
				data.setMsg("success");
			} else {
				data.setMsg("error");
			}

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	// Approved Invoice
	@PostMapping({ "/viewAllProcessInvoiceForFinanceTeam" })
	@CrossOrigin("*")
	public String getAllProcessInvoice(Principal principal) {

		DataContainer data = new DataContainer();
		String userName = principal.getName();
		String userRole = this.serviceManager.rolesRepository.getuserRoleByUserName(userName);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			if (userRole.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)
					|| userRole.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE_HEAD)) {
				List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getAllProcessInvoice();

				List<InvoiceGenerationDto> listofAllInvoice = allInvoice.stream()
						.map((listOfInvoice) -> this.serviceManager.modelMapper.map(listOfInvoice,
								InvoiceGenerationDto.class))
						.collect(Collectors.toList());

				data.setData(listofAllInvoice);
				data.setMsg("success");
			}

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	// Pending For Approval
	@PostMapping({ "/viewAllUnProcessInvoiceForFinanceTeam" })
	@CrossOrigin("*")
	public String getAllUnProcessInvoice(Principal principal) {

		DataContainer data = new DataContainer();
		String userName = principal.getName();
		String userRole = this.serviceManager.rolesRepository.getuserRoleByUserName(userName);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			if (userRole.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)
					|| userRole.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE_HEAD)) {
				List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getAllUnProcessInvoice();
				List<InvoiceGenerationDto> listofAllInvoice = allInvoice.stream()
						.map((listOfInvoice) -> this.serviceManager.modelMapper.map(listOfInvoice,
								InvoiceGenerationDto.class))
						.collect(Collectors.toList());

				data.setData(listofAllInvoice);
				data.setMsg("success");
			}

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	// Pending For Approval
	@PostMapping({ "/getAllInReviewInvoice" })
	@CrossOrigin("*")
	public String getAllInReviewInvoice(Principal principal) {

		DataContainer data = new DataContainer();
		String userName = principal.getName();
		String userRole = this.serviceManager.rolesRepository.getuserRoleByUserName(userName);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			if (userRole.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)
					|| userRole.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE_HEAD)) {
				List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getAllInReviewInvoice();
				List<InvoiceGenerationDto> listofAllInvoice = allInvoice.stream()
						.map((listOfInvoice) -> this.serviceManager.modelMapper.map(listOfInvoice,
								InvoiceGenerationDto.class))
						.collect(Collectors.toList());

				data.setData(listofAllInvoice);
				data.setMsg("success");
			}

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	// Payment Release
	@PostMapping({ "/getPaymentReleaseInvoice" })
	@CrossOrigin("*")
	public String getPaymentReleaseInvoice(Principal principal) {

		DataContainer data = new DataContainer();
		String userName = principal.getName();
		String userRole = this.serviceManager.rolesRepository.getuserRoleByUserName(userName);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			if (userRole.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)
					|| userRole.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE_HEAD)) {
				List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getPaymentReleaseInvoice();

				data.setData(allInvoice);
				data.setMsg("success");
			}

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/viewAllQueryInvoiceForFinanceTeam" })
	@CrossOrigin("*")
	public String getAllQueryInvoice(Principal principal) {

		DataContainer data = new DataContainer();
		String userName = principal.getName();
		String userRole = this.serviceManager.rolesRepository.getuserRoleByUserName(userName);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			if (userRole.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)
					|| userRole.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE_HEAD)) {
				List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getAllQueryInvoice();

				data.setData(allInvoice);
				data.setMsg("success");
			}

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getQueryByTypeAndForeignKey" })
	@CrossOrigin("*")
	public String getQueryByTypeAndForeignKey(HttpServletRequest request, @RequestBody QueryDto obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {

			List<QueryEntity> queryList = serviceManager.queryRepo
					.findByReferenceidAndTypeOrderByIdDesc(obj.getReferenceid(), obj.getType());
			List<QueryDto> listOfQuery = queryList.stream()
					.map((listQuery) -> this.serviceManager.modelMapper.map(listQuery, QueryDto.class))
					.collect(Collectors.toList());

			data.setData(listOfQuery);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/saveQuery" })
	@CrossOrigin("*")
	public String saveInvoiceQuery(Principal principal, HttpServletRequest request, @RequestBody QueryDto entity) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String userName = principal.getName();
		String rolename = (String) request.getSession().getAttribute("role");
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String processedOn = dateFormat.format(date);
		List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository
				.findByIsActive(GlobalConstants.ACTIVE_STATUS);
		EmailConfiguration emailConfiguration = emailList.get(0);
		String vendorEmail = (String) request.getSession().getAttribute("userEmail");

		String emailType = null;
		String type = "";

		try {
			Integer getid = entity.getId();

			if (GlobalConstants.SET_TYPE_INVOICE.equalsIgnoreCase(entity.getType())) {
				entity.setType(GlobalConstants.SET_TYPE_INVOICE);
				if (GlobalConstants.ROLE_VENDOR.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateInvoiceStatus(processedOn, userName,
							GlobalConstants.INVOICE_STATUS_IN_REVIEW, GlobalConstants.ROLE_FINANCE, getid);
					emailType = GlobalConstants.EMAIL_TYPE_VEN_INVOICE_UPDATE;
					type = entity.getType();
				} else if (GlobalConstants.ROLE_FINANCE.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateInvoiceStatus(processedOn, userName,
							GlobalConstants.INVOICE_STATUS_QUERY, GlobalConstants.ROLE_VENDOR, getid);
					emailType = GlobalConstants.EMAIL_TYPE_FIN_TEM_INVOICE_QUERY;
					type = entity.getType();
				} else if (GlobalConstants.ROLE_FINANCE_HEAD.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateInvoiceStatus(processedOn, userName,
							GlobalConstants.INVOICE_STATUS_QUERY, GlobalConstants.ROLE_FINANCE, getid);
					emailType = GlobalConstants.EMAIL_TYPE_FIN_HED_INVOICE_QUERY;
					type = entity.getType();
				} else if (GlobalConstants.ROLE_NETWORK.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateInvoiceStatus(processedOn, userName,
							GlobalConstants.INVOICE_STATUS_QUERY, GlobalConstants.ROLE_VENDOR, getid);
					emailType = GlobalConstants.EMAIL_TYPE_NET_TEM_INVOICE_QUERY;
					type = entity.getType();
				}

			} else if (GlobalConstants.SET_TYPE_TRIP.equalsIgnoreCase(entity.getType())) {
				entity.setType(GlobalConstants.SET_TYPE_TRIP);
				if (GlobalConstants.ROLE_VENDOR.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateStatusByUserid(processedOn, userName,
							GlobalConstants.INVOICE_STATUS_QUERY, GlobalConstants.ROLE_NETWORK, getid);
					emailType = GlobalConstants.EMAIL_TYPE_VEN_TRIP_QUERY;
					type = entity.getType();
				}
			} else if (GlobalConstants.SET_TYPE_REGISTRATION.equalsIgnoreCase(entity.getType())) {
				entity.setType(GlobalConstants.SET_TYPE_REGISTRATION);
				if (GlobalConstants.ROLE_REGISTRATION_APPROVAL.equalsIgnoreCase(rolename)) {
					serviceManager.supDetailsRepo.updateVendorStatus(GlobalConstants.QUERY_REQUEST_STATUS, getid);
					emailType = GlobalConstants.EMAIL_TYPE_VEN_TRIP_QUERY;
					type = entity.getType();
				}
			}

			if (getid != null) {
				entity.setId(null);
				entity.setForeignKey(getid);
				entity.setRaisedBy(userName);
				entity.setRaisedOn(new Date());
				entity.setRole(rolename);
				entity.setReferenceid(entity.getRaisedAgainQuery());
				QueryEntity saveQuery = this.serviceManager.modelMapper.map(entity, QueryEntity.class);
				serviceManager.queryRepo.save(saveQuery);
			}

			List<MailContent> queryType = serviceManager.mailContentRepo.findByType(type);

			if (!queryType.isEmpty()) {
				SendEmail sendEmail = new SendEmail();
				MailContent mailContent = queryType.get(0);
				sendEmail.setMailfrom(emailConfiguration.getUserName());

				if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
					if (GlobalConstants.SET_TYPE_TRIP.equals(type)) {
						sendEmail.setSendTo("Network Team");
					} else {
						sendEmail.setSendTo("Finance Team");
						sendEmail.setSendCc("Network Team");
					}

				} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {

					if (GlobalConstants.SET_TYPE_TRIP.equals(type)) {
						sendEmail.setSendTo("vender");
					} else {
						sendEmail.setSendTo("Finance Team");
						sendEmail.setSendCc("vendor ");
					}

				} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)) {
					sendEmail.setSendTo("Insert vender email");
					sendEmail.setSendCc("Network team");
				} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE_HEAD)) {
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
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	// getDocumentById
	@PostMapping({ "/getDocumentByTypeAndForeignKey" })
	@CrossOrigin("*")
	public String getDocumentByTypeAndForeignKey(HttpServletRequest request, @RequestBody DocumentDto entity) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			List<Document> listDoc = serviceManager.documentRepo.findByTypeAndForeignKeyOrderByIdDesc(entity.getType(),
					entity.getForeignKey());
			List<DocumentDto> listOfDocument = listDoc.stream()
					.map((documentList) -> this.serviceManager.modelMapper.map(documentList, DocumentDto.class))
					.collect(Collectors.toList());

			data.setData(listOfDocument);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	// getDocumentById
	@PostMapping({ "/approveInvoiceFinanceSide" })
	@CrossOrigin("*")
	public String approveInvoiceFinanceSide(Principal principal, HttpServletRequest request,
			@RequestBody InvoiceGenerationDto entity) {

		DataContainer data = new DataContainer();
		String userName = principal.getName();
		String userRole = this.serviceManager.rolesRepository.getuserRoleByUserName(userName);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String processedOn = dateFormat.format(date);
		try {

			if (GlobalConstants.ROLE_FINANCE_HEAD.equalsIgnoreCase(userRole)) {
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
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	// filterInvoiceDetails

	@GetMapping({ "filterInvoiceDetails" })
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
			List<InvoiceGenerationDto> filterInvoiceData = findByInvoiceDateBetween.stream()
					.map((filterData) -> this.serviceManager.modelMapper.map(filterData, InvoiceGenerationDto.class))
					.collect(Collectors.toList());
			data.setData(filterInvoiceData);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "getFilterInvoiceByVendorCode" })
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
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "viewInvoiceForFinanceTeam" })
	@CrossOrigin("*")
	public String viewInvoiceForFinanceTeam(@RequestBody InvoiceGenerationDto obj)
			throws UnsupportedEncodingException, MessagingException {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			List<InvoiceGenerationEntity> invoiceViewList = serviceManager.invoiceServiceImpl
					.getTripsByFilters(obj.getVendorCode(), obj.getInvoiceStatus());
			List<InvoiceGenerationDto> invoiceForFinanceTeam = invoiceViewList.stream()
					.map((invoiceList) -> this.serviceManager.modelMapper.map(invoiceList, InvoiceGenerationDto.class))
					.collect(Collectors.toList());
			data.setData(invoiceForFinanceTeam);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}
}
