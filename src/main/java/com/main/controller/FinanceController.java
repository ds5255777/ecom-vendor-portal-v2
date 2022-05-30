package com.main.controller;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.email.CommEmailFunction;
import com.main.email.WelcomeEmail;
import com.main.serviceManager.ServiceManager;
import com.sun.xml.messaging.saaj.packaging.mime.MessagingException;

@RestController
@RequestMapping("/financeController")
public class FinanceController {

	@Autowired
	private ServiceManager serviceManager;

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
			e.printStackTrace();
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
			e.printStackTrace();
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
			e.printStackTrace();
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
			e.printStackTrace();
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
			e.printStackTrace();
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
			e.printStackTrace();
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
			e.printStackTrace();
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
		try {
			Integer getid = entity.getId();

			if ("Invoice".equalsIgnoreCase(entity.getType())) {
				entity.setType("Invoice");
				if (GlobalConstants.ROLE_VENDOR.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateInvoiceStatus(processedOn, userName,"In-Review", "Finance", getid);
				} else if (GlobalConstants.ROLE_FINANCE.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateInvoiceStatus(processedOn, userName,"Query", "Vendor", getid);
				} else if (GlobalConstants.ROLE_FINANCE_HEAD.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateInvoiceStatus(processedOn, userName,"Query", "Finance", getid);
				}else if (GlobalConstants.ROLE_NETWORK.equalsIgnoreCase(rolename)) {
					serviceManager.queryRepo.updateInvoiceStatus(processedOn, userName,"Query", "Vendor", getid);
				}

			}
			else {
				entity.setType("Trip");
				
				
				
				serviceManager.queryRepo.updateStatusByUserid(processedOn, userName, "Query", "Network", getid);
			}

			if (getid != null) {
				entity.setId(null);
				entity.setForeignKey(getid);
				entity.setRaisedBy(userName);
				entity.setRaisedOn(new Date());
				entity.setReferenceid(entity.getRaisedAgainQuery());
				serviceManager.queryRepo.save(entity);
			}
			new Thread(new Runnable() {
				@Override
				public void run() {
					try {
						List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");
						
						if(!emailList.isEmpty()) {
							EmailConfiguration emailConfiguration=emailList.get(0);
							
							CommEmailFunction.sendEmail("girdhar.supyal@bpaassolutions.com", "Trip Query",
									"Trip is not ok", emailConfiguration.getSmtpPort(), emailConfiguration.getUserName(), emailConfiguration.getPassword(), emailConfiguration.getServerName());
						}
						 
						
						

					} catch (Exception e) {
						e.printStackTrace();
					}
					Thread.currentThread().interrupt();
				}
			}).start();
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
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
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	// getDocumentById
	@RequestMapping({ "/approveInvoiceFinanceSide" })
	@CrossOrigin("*")
	public String approveInvoiceFinanceSide(Principal principal,HttpServletRequest request, @RequestBody InvoiceGenerationEntity entity) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		
		String userName = principal.getName();

		String role = (String) request.getSession().getAttribute("role");
		System.out.println(role);
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");  
		String processedOn = dateFormat.format(date);
		try {

			if (GlobalConstants.ROLE_FINANCE_HEAD.equalsIgnoreCase(role)) {
				serviceManager.invoiceGenerationEntityRepo.updateInvoiceStatus(processedOn,userName,entity.getEcomInvoiceNumber(),
						"Approved");
			} else {
				serviceManager.invoiceGenerationEntityRepo.updateInvoiceStatus(processedOn,userName,entity.getEcomInvoiceNumber(),
						"Pending For Approval");
			}

			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
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
		System.out.println(fromDate);
		System.out.println(toDate);
		try {
			List<InvoiceGenerationEntity> findByInvoiceDateBetween = serviceManager.invoiceGenerationEntityRepo
					.findByInvoiceDateBetween(fromDate, toDate);
			data.setData(findByInvoiceDateBetween);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
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
			e.printStackTrace();
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
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}
}
