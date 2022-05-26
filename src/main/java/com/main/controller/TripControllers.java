package com.main.controller;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
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
import com.main.db.bpaas.entity.QueryEntity;
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
	
	@RequestMapping({ "filterTripDetails" })
	@CrossOrigin("*")
	public String filterTripDetails(Principal principal, HttpServletRequest request,
			@RequestParam(name = "actualDeparture") String fromDate,
			@RequestParam(name = "actualArrival") String toDate, @RequestParam(name = "vendorCode") String vendorCode) {
		
		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		logger.info("fromDate : "+fromDate);
		logger.info("toDate : "+toDate);
		logger.info("vendorCode : "+vendorCode);
		
		
		
		try {

			String rolename = (String) request.getSession().getAttribute("role");
			System.out.println("YYYYYYY"+rolename);
			if (rolename.equalsIgnoreCase("Network")) {
				List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
						.findByActualDepartureBetween(fromDate, toDate);
				data.setData(getListByDateFilter);
				data.setMsg("success");
			}

			if (rolename.equalsIgnoreCase("Vendor")) {
				List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
						.findByVendorCodeAndActualDepartureBetween(vendorCode, fromDate, toDate);
				data.setData(getListByDateFilter);
				data.setMsg("success");
			}

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}
		return gson.toJson(data).toString();
	}

	@RequestMapping({ "filterTripDetailsByNetwork" })
	@CrossOrigin("*")
	public String filterTripDetailsByNetwork(Principal principal, HttpServletRequest request,
			@RequestParam(name = "actualDeparture") String fromDate,
			@RequestParam(name = "actualArrival") String toDate) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println(fromDate);
		try {
			List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
					.findByActualDepartureBetween(fromDate, toDate);
			data.setData(getListByDateFilter);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}
		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getCloseTripsDetails" })
	@CrossOrigin("*")
	public String getCloseTripsDetails(Principal principal, HttpServletRequest request) {
		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo.getAllCloseTrip(vendorCode);
			data.setData(allTripDetailsList);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllTripsDetails" })
	@CrossOrigin("*")
	public String getAllTripsDetails(Principal principal, HttpServletRequest request) {
		String rolename = (String) request.getSession().getAttribute("role");
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		if (rolename.equalsIgnoreCase("Network")) {
			try {
				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo.findAll();
				data.setData(allTripDetailsList);
				data.setMsg("success");
			} catch (Exception e) {
				data.setMsg("error");
				logger.error("error : "+e);
			}
		} else if (rolename.equalsIgnoreCase("Vendor")) {
			String vendorCode = principal.getName();
			try {
				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo
						.getAllTripByVendorCode(vendorCode);
				data.setData(allTripDetailsList);
				data.setMsg("success");
			} catch (Exception e) {
				data.setMsg("error");
				logger.error("error : "+e);
			}
		} else if (rolename.equalsIgnoreCase("Admin")) {
			try {
				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo.findAll();
				data.setData(allTripDetailsList);
				data.setMsg("success");
			} catch (Exception e) {
				data.setMsg("error");
				logger.error("error : "+e);
			}
		}
		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getCloseAndApprovedTripsDetails" })
	@CrossOrigin("*")
	public String getCloseAndApprovedTripsDetails(Principal principal, HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String vendorCode = principal.getName();
		try {
			List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo.getAllCloseAndApproveTrip(vendorCode);
			data.setData(allTripDetailsList);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}
		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getInTransitTripsDetails" })
	@CrossOrigin("*")
	public String getInTransitTripsDetails(Principal principal, HttpServletRequest request) {
		String vendorCode = principal.getName();
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo.getAllInTransitTrip(vendorCode);
			data.setData(allTripDetailsList);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}
		return gson.toJson(data).toString();
	}

	@RequestMapping(value = "/statusNetwork", method = RequestMethod.POST)
	@CrossOrigin("*")
	public String statusNetwork(@RequestBody TripDetails obj) throws UnsupportedEncodingException, MessagingException {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			String runStatus = obj.getRunStatus().toString();
			String vendortripStatus = obj.getVendorTripStatus().toString();
			String paymentStatus = obj.getPaymentStatus().toString();

			List<TripDetails> obj1 = serviceManager.tripService.getTripsByFiltersNetwork(runStatus, vendortripStatus,
					paymentStatus);
			data.setData(obj1);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/updateVendorTripStatusByTripId" })
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
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/updateVendorTripStatusAndOpenCloseReadingByTripId" })
	@CrossOrigin("*")
	public String getApprovTripsDetails(Principal principal ,HttpServletRequest request, @RequestBody TripDetails tripObj) {

		DataContainer data = new DataContainer();

		String processedBy=principal.getName();
		System.out.println("**********Inside getApprovePendingApprovelTripsDetails********************");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String vendorTripStatus = tripObj.getVendorTripStatus();
		String tripID = tripObj.getTripID();
		String openingReading = tripObj.getOpeningReading();
		String closingReading = tripObj.getClosingReading();
		Date date = new Date();  
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");  
		String processedOn = dateFormat.format(date);  
		
		try {

			serviceManager.tripDetailsRepo.updateVendorTripStatusByTripId(tripID, vendorTripStatus, openingReading, closingReading,processedBy, processedOn);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getPendingApprovelTripsDetails" })
	@CrossOrigin("*")
	public String getPendingApprovelTripsDetails(Principal principal, HttpServletRequest request) {
		String vendorCode = principal.getName();
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo.getAllPendingTrip(vendorCode);

			data.setData(allTripDetailsList);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping(value = "/status", method = RequestMethod.POST)
	@CrossOrigin("*")
	public String status(@RequestBody TripDetails obj) throws UnsupportedEncodingException, MessagingException {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			String runStatus = obj.getRunStatus().toString();
			String vendortripStatus = obj.getVendorTripStatus().toString();
			String paymentStatus = obj.getPaymentStatus().toString();
			String vendorCode = obj.getVendorCode().toString();

			List<TripDetails> obj1 = serviceManager.tripService.getTripsByFilters(runStatus, vendortripStatus,
					paymentStatus, vendorCode);
			data.setData(obj1);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/tripDetailByTripId" })
	@CrossOrigin("*")
	public String getTripsDetailsByTripId(HttpServletRequest request, @RequestBody TripDetails tripObj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			tripObj = serviceManager.tripDetailsRepo.findByTripID(tripObj.getTripID());

			data.setData(tripObj);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/updateVendorTripStatusByTrips" })
	@CrossOrigin("*")
	public String updateVendortripStatusByTrips(HttpServletRequest request, @RequestBody TripDetails obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String tripId = obj.getTripID();
			System.out.println(tripId);

			tripId = tripId.replaceAll(",", " ");

			String[] split = tripId.split(" ");
			System.out.println(split);
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
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getRemarksByRefID" })
	@CrossOrigin("*")
	public String getRemarksByRefID(HttpServletRequest request, @RequestBody String obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			JSONObject jsonObject = new JSONObject(obj);
			System.out.println("jsonObject " + jsonObject.toString());
			String tripID = jsonObject.get("tripID").toString();
			System.out.println(" Trip id is ::" + tripID);
			List<QueryEntity> qe = serviceManager.queryRepo.findCommentsByRefID(tripID);
			

			data.setData(qe);
			data.setMsg("success");
			System.out.println("Trip id is ::" + tripID);

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping(value = "/getDraftLineTripDetails", method = RequestMethod.POST)
	@CrossOrigin("*")
	public String getDraftLineTripDetails(@RequestBody TripDetails obj, HttpSession session, HttpServletRequest request)
			throws UnsupportedEncodingException, MessagingException {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			String invoiceNumber = obj.getInvoiceNumber();
			System.out.println(invoiceNumber);
			List<TripDetails> list = serviceManager.tripDetailsRepo.getTripStatusIsDraftInvoicing(invoiceNumber);
			for (TripDetails tripDetails : list) {
				System.out.println(tripDetails.getTripID());
			}
			data.setData(list);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getTripDetailByTripId" })
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

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();

	}

	@RequestMapping({ "/findByTripDetailUsingTripID" })
	public String findByTripDetailUsingTripID(Principal principal, @RequestBody TripDetails obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String tripID = obj.getTripID();
			String invoiceNumber = obj.getInvoiceNumber();

			System.out.println("check user id >> " + obj.getTripID());
			serviceManager.tripDetailsRepo.findTripDetailAgainTripID(invoiceNumber, tripID);
			
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();

	}
}
