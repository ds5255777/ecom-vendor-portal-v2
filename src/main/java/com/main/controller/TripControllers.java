package com.main.controller;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
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
import com.main.db.bpaas.entity.EmailAuditLogs;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.MailContent;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.SendEmail;
import com.main.db.bpaas.entity.TripDetails;
import com.main.serviceManager.ServiceManager;
import com.sun.xml.messaging.saaj.packaging.mime.MessagingException;

@RequestMapping("/tripControllers")
@RestController
public class TripControllers {

	@Autowired
	private ServiceManager serviceManager;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(TripControllers.class);

	@GetMapping({ "filterTripDetails" })
	@CrossOrigin("*")
	public String filterTripDetails(Principal principal, HttpServletRequest request,
			@RequestParam(name = "actualDeparture") String fromDate,
			@RequestParam(name = "actualArrival") String toDate, @RequestParam(name = "vendorCode") String vendorCode) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {

			String rolename = (String) request.getSession().getAttribute("role");
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {
				List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
						.findByActualDepartureBetween(fromDate, toDate);
				data.setData(getListByDateFilter);
				data.setMsg("success");
			}

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
				List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
						.findByVendorCodeAndActualDepartureBetween(vendorCode, fromDate, toDate);
				data.setData(getListByDateFilter);
				data.setMsg("success");
			}

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getCloseTripsDetails" })
	@CrossOrigin("*")
	public String getCloseTripsDetails(Principal principal, HttpServletRequest request) {
		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo
					.findByRunStatusAndVendorCode(GlobalConstants.RUN_CLOSED, vendorCode);
			data.setData(allTripDetailsList);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getAllTripsDetails" })
	@CrossOrigin("*")
	public String getAllTripsDetails(Principal principal, HttpServletRequest request) {
		String rolename = (String) request.getSession().getAttribute("role");
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {
			try {
				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo.findAll();
				data.setData(allTripDetailsList);
				data.setMsg("success");
			} catch (Exception e) {
				data.setMsg("error");
				logger.error("error : " + e);
			}
		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
			String vendorCode = principal.getName();
			try {
				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo.findByVendorCode(vendorCode);
				data.setData(allTripDetailsList);
				data.setMsg("success");
			} catch (Exception e) {
				data.setMsg("error");
				logger.error("error : " + e);
			}
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getCloseAndApprovedTripsDetails" })
	@CrossOrigin("*")
	public String getCloseAndApprovedTripsDetails(Principal principal, HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String vendorCode = principal.getName();
		try {
			List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo
					.findByRunStatusAndVendorTripStatusAndVendorCode(GlobalConstants.RUN_CLOSED,
							GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode);
			data.setData(allTripDetailsList);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getInTransitTripsDetails" })
	@CrossOrigin("*")
	public String getInTransitTripsDetails(Principal principal, HttpServletRequest request) {
		String vendorCode = principal.getName();
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo
					.findByRunStatusAndVendorCode(GlobalConstants.RUN_IN_TRANSIT, vendorCode);
			data.setData(allTripDetailsList);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	@PostMapping(value = "/status")
	@CrossOrigin("*")
	public String statusNetwork(HttpServletRequest request, Principal principal, @RequestBody TripDetails obj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String rolename = (String) request.getSession().getAttribute("role");
		String userName = principal.getName();
		try {

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {
				String runStatus = obj.getRunStatus().toString();
				String vendortripStatus = obj.getVendorTripStatus().toString();
				String paymentStatus = obj.getPaymentStatus().toString();

				List<TripDetails> obj1 = serviceManager.tripService.getTripsByFiltersNetwork(runStatus,
						vendortripStatus, paymentStatus);
				data.setData(obj1);
			} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

				String runStatus = obj.getRunStatus().toString();
				String vendortripStatus = obj.getVendorTripStatus().toString();
				String paymentStatus = obj.getPaymentStatus().toString();
				String vendorCode = obj.getVendorCode().toString();
				if (vendorCode.equalsIgnoreCase(userName)) {
					List<TripDetails> obj1 = serviceManager.tripService.getTripsByFilters(runStatus, vendortripStatus,
							paymentStatus, vendorCode);
					data.setData(obj1);
				}
			}
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/updateVendorTripStatusByTripId" })
	@CrossOrigin("*")
	public String getApprovePendingApprovelTripsDetails(HttpServletRequest request, @RequestBody TripDetails tripObj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			serviceManager.tripDetailsRepo.updateVendorTripStatusByTripId(tripObj.getVendorTripStatus(),
					tripObj.getTripID());
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/updateVendorTripStatusAndOpenCloseReadingByTripId" })
	@CrossOrigin("*")
	public String getApprovTripsDetails(Principal principal, HttpServletRequest request,
			@RequestBody TripDetails tripObj) {

		DataContainer data = new DataContainer();

		String processedBy = principal.getName();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String processedOn = dateFormat.format(date);

		try {
			if (tripObj.getVendorCode().equals(processedBy)) {

				serviceManager.tripDetailsRepo.updateVendorTripStatusByTripId(tripObj.getTripID(),
						tripObj.getVendorTripStatus(), tripObj.getOpeningReading(), tripObj.getClosingReading(),
						processedBy, processedOn);
				// call mailing api

				List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive(GlobalConstants.ACTIVE_STATUS);
				EmailConfiguration emailConfiguration = emailList.get(0);

				String vendorEmail = (String) request.getSession().getAttribute("userEmail");

				List<MailContent> queryType = serviceManager.mailContentRepo.findByType("Vendor Trip Approve");

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
			}

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getPendingApprovelTripsDetails" })
	@CrossOrigin("*")
	public String getPendingApprovelTripsDetails(Principal principal, HttpServletRequest request) {

		String vendorCode = principal.getName();
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo
					.findByVendorTripStatusAndRunStatusAndAssignToAndVendorCode(
							GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED, GlobalConstants.RUN_CLOSED,
							GlobalConstants.ROLE_VENDOR, vendorCode);

			data.setData(allTripDetailsList);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/tripDetailByTripId" })
	@CrossOrigin("*")
	public String getTripsDetailsByTripId(Principal principal, @RequestBody TripDetails tripObj) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			tripObj = serviceManager.tripDetailsRepo.findByTripIDAndVendorCode(tripObj.getTripID(), vendorCode);

			data.setData(tripObj);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/updateVendorTripStatusByTrips" })
	@CrossOrigin("*")
	public String updateVendortripStatusByTrips(HttpServletRequest request, @RequestBody TripDetails obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String tripId = obj.getTripID();
			logger.info(tripId);

			tripId = tripId.replaceAll(",", " ");

			String[] split = tripId.split(" ");
			logger.info("" + split);
			TripDetails findByTripID = null;

			for (String str : split) {
				findByTripID = serviceManager.tripDetailsRepo.findByTripID(str);

				if (null != findByTripID.getTripID()) {
					findByTripID.setVendorTripStatus("Draft-Invoicing");
					serviceManager.tripDetailsRepo.updateVendorInvoiceStatusByTripId(findByTripID.getVendorTripStatus(),
							findByTripID.getTripID());
				}
			}

			data.setData(obj);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getRemarksByRefID" })
	@CrossOrigin("*")
	public String getRemarksByRefID(HttpServletRequest request, @RequestBody String obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			JSONObject jsonObject = new JSONObject(obj);
			logger.info("jsonObject " + jsonObject.toString());
			String tripID = jsonObject.get("tripID").toString();
			logger.info(" Trip id is ::" + tripID);
			List<QueryEntity> qe = serviceManager.queryRepo.findCommentsByRefID(tripID);

			data.setData(qe);
			data.setMsg("success");
			logger.info("Trip id is ::" + tripID);

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getDraftLineTripDetails" })
	@CrossOrigin("*")
	public String getDraftLineTripDetails(@RequestBody TripDetails obj, HttpSession session, HttpServletRequest request)
			throws UnsupportedEncodingException, MessagingException {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			String invoiceNumber = obj.getInvoiceNumber();
			logger.info(invoiceNumber);
			List<TripDetails> list = serviceManager.tripDetailsRepo.getTripStatusIsDraftInvoicing(invoiceNumber);
			for (TripDetails tripDetails : list) {
				logger.info(tripDetails.getTripID());
			}
			data.setData(list);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getTripDetailByTripId" })
	public String getTripDetailByTripId(Principal principal, HttpSession session, HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String vendorCode = principal.getName();
		try {

			List<String> list = serviceManager.tripDetailsRepo.getTripId(vendorCode);
			data.setData(list);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();

	}

	@PostMapping({ "/findByTripDetailUsingTripID" })
	public String findByTripDetailUsingTripID(Principal principal, @RequestBody TripDetails obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String tripID = obj.getTripID();
			String invoiceNumber = obj.getInvoiceNumber();

			logger.info("check user id >> " + obj.getTripID());
			serviceManager.tripDetailsRepo.findTripDetailAgainTripID(invoiceNumber, tripID);

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();

	}

	@GetMapping({ "/filterByColumn" })
	@CrossOrigin("*")
	public String filterByColumn(Principal principal, HttpServletRequest request,
			@RequestParam(name = "columnName") String columnName,
			@RequestParam(name = "columnValue") String columnValue,
			@RequestParam(name = "tripStatus") String tripStatus,
			@RequestParam(name = "vendorCode") String vendorCode) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			if (tripStatus.equals(GlobalConstants.VENDOR_TRIP_STATUS_APPROVED)) {

				if (columnName.equals("route")) {
					List<String> routeList = Arrays.asList(columnValue.split(","));
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByRouteInAndVendorTripStatusAndVendorCode(routeList,
									GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode);
					data.setData(getListByDateFilter);
				} else if (columnName.equals("origin_hub")) {
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByOriginHubAndVendorTripStatusAndVendorCode(columnValue,
									GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode);
					data.setData(getListByDateFilter);
				} else if (columnName.equals("dest_hub")) {
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByDestHubAndVendorTripStatusAndVendorCode(columnValue,
									GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode);
					data.setData(getListByDateFilter);
				} else if (columnName.equals("run_type")) {
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByRunTypeAndVendorTripStatusAndVendorCode(columnValue,
									GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode);
					data.setData(getListByDateFilter);
				} else if (columnName.equals("vehicle_number")) {
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByVehicleNumberAndVendorTripStatusAndVendorCode(columnValue,
									GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode);
					data.setData(getListByDateFilter);
				}
			} else if (tripStatus.equals(GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED)) {

				if (columnName.equals("route")) {
					List<String> routeList = Arrays.asList(columnValue.split(","));
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByRouteInAndVendorTripStatusAndVendorCode(routeList,
									GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED, vendorCode);
					data.setData(getListByDateFilter);
				} else if (columnName.equals("vehicle_number")) {
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByVehicleNumberAndVendorTripStatusAndVendorCode(columnValue,
									GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED, vendorCode);
					data.setData(getListByDateFilter);
				}

			}
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	@GetMapping({ "multipleTripApproved" })
	@CrossOrigin("*")
	public String multipleTripApproved(Principal principal, @RequestParam("tripID") String obj,
			@RequestParam("vendorTripStatus") String vendorTripStatus) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String processedBy = principal.getName();
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String processedOn = dateFormat.format(date);
		try {
			List<String> myList = new ArrayList<String>(Arrays.asList(obj.split(",")));

			serviceManager.tripDetailsRepo.getUpdateStatusSelectTrips(processedBy, processedOn, vendorTripStatus,
					myList);
			data.setMsg("success");

		} catch (Exception e) {
			data.setData("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}
}
