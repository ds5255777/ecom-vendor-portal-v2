package com.main.controller;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
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
import com.main.db.JdbcConnection;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.repo.QueryRepo;
import com.main.db.bpaas.repo.TripDetailsRepo;
import com.main.service.TripService;
import com.sun.xml.messaging.saaj.packaging.mime.MessagingException;

@RequestMapping("/tripControllers")
@RestController
public class TripControllers {

	@Autowired
	private TripDetailsRepo tripDetailsRepo;

	@Autowired
	private QueryRepo queryRepo;

	@Autowired
	JdbcConnection dbconnection;

	@Autowired
	private TripService tripService;

	@RequestMapping({ "filterTripDetails" })
	@CrossOrigin("*")
	public String filterTripDetails(Principal principal, HttpServletRequest request,
			@RequestParam(name = "actualDeparture") String fromDate,
			@RequestParam(name = "actualArrival") String toDate) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		// String vendorCode = request.getSession().getAttribute("userName").toString();
		String vendorCode = principal.getName();
		try {
			System.out.println(fromDate);
			System.out.println(toDate);

			List<TripDetails> getListByDateFilter = tripDetailsRepo.findByActualDepartureBetween(fromDate, toDate);

			getListByDateFilter.forEach(w -> {
				System.out.println("all data" + w);
			});

			System.out.println(getListByDateFilter);
			data.setData(getListByDateFilter);
			data.setMsg("success");
		} catch (Exception e) {
			// TODO: handle exception
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getCloseTripsDetails" })
	@CrossOrigin("*")
	public String getCloseTripsDetails(Principal principal, HttpServletRequest request,
			@RequestBody List<TripDetails> tripList) {

		DataContainer data = new DataContainer();
//Saurabh
		String vendorCode = principal.getName();
//Saurabh
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<TripDetails> allTripDetailsList = tripDetailsRepo.getAllCloseTrip(vendorCode);

			data.setData(allTripDetailsList);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllTripsDetails" })
	@CrossOrigin("*")
	public String getAllTripsDetails(Principal principal, HttpServletRequest request,
			@RequestBody List<TripDetails> tripList) {
		String rolename = (String) request.getSession().getAttribute("role");
		System.out.println("Role name ::" + rolename);
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		if (rolename.equalsIgnoreCase("Network")) {
			System.out.println("All trips in network");

			try {
				List<TripDetails> allTripDetailsList = tripDetailsRepo.findAll();

				data.setData(allTripDetailsList);
				data.setMsg("success");

			} catch (Exception e) {
				data.setMsg("error");
				e.printStackTrace();
			}
		} else if (rolename.equalsIgnoreCase("Vendor")) {

//Saurabh
			String vendorCode = principal.getName();
//Saurabh

			try {
				List<TripDetails> allTripDetailsList = tripDetailsRepo.getAllTripByVendorCode(vendorCode);

				data.setData(allTripDetailsList);
				data.setMsg("success");

			} catch (Exception e) {
				data.setMsg("error");
				e.printStackTrace();
			}
		}else if (rolename.equalsIgnoreCase("Admin")) {

			//Manish
			
			
		        try {
		            List<TripDetails> allTripDetailsList = tripDetailsRepo.findAll();

		            data.setData(allTripDetailsList);
		            data.setMsg("success");

		        } catch (Exception e) {
		            data.setMsg("error");
		            e.printStackTrace();
		        }
			
			
						
					}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getCloseAndApprovedTripsDetails" })
	@CrossOrigin("*")
	public String getCloseAndApprovedTripsDetails(HttpServletRequest request, @RequestBody List<TripDetails> tripList) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<TripDetails> allTripDetailsList = tripDetailsRepo.getAllCloseAndApproveTrip();

			data.setData(allTripDetailsList);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getInTransitTripsDetails" })
	@CrossOrigin("*")
	public String getInTransitTripsDetails(Principal principal, HttpServletRequest request,
			@RequestBody List<TripDetails> tripList) {
		String vendorCode = principal.getName();
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<TripDetails> allTripDetailsList = tripDetailsRepo.getAllInTransitTrip(vendorCode);

			data.setData(allTripDetailsList);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping(value = "/statusNetwork", method = RequestMethod.POST)
	@CrossOrigin("*")
	public String statusNetwork(@RequestBody TripDetails obj) throws UnsupportedEncodingException, MessagingException {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		String runStatus = obj.getRunStatus().toString();
		String vendortripStatus = obj.getVendorTripStatus().toString();
		String paymentStatus = obj.getPaymentStatus().toString();

		System.out.println("runStatus  " + runStatus);
		System.out.println("vendortripStatus " + vendortripStatus);
		System.out.println("paymentStatus  " + paymentStatus);

		List<TripDetails> obj1 = tripService.getTripsByFilters(runStatus, vendortripStatus, paymentStatus);
		data.setData(obj1);
		data.setMsg("success");

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/updateVendorTripStatusByTripId" })
	@CrossOrigin("*")
	public String getApprovePendingApprovelTripsDetails(HttpServletRequest request, @RequestBody TripDetails tripObj) {

		DataContainer data = new DataContainer();

		System.out.println("**********Inside getApprovePendingApprovelTripsDetails********************");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			tripDetailsRepo.updateVendorTripStatusByTripId(tripObj.getVendorTripStatus(), tripObj.getTripID());
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/updateVendorTripStatusAndOpenCloseReadingByTripId" })
	@CrossOrigin("*")
	public String getApprovTripsDetails(HttpServletRequest request, @RequestBody TripDetails tripObj) {

		DataContainer data = new DataContainer();

		System.out.println("**********Inside getApprovePendingApprovelTripsDetails********************");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String vendorTripStatus = tripObj.getVendorTripStatus();
		String tripID = tripObj.getTripID();
		String openingReading = tripObj.getOpeningReading();
		String closingReading = tripObj.getClosingReading();
		try {

			tripDetailsRepo.updateVendorTripStatusByTripId(tripID, vendorTripStatus, openingReading, closingReading);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getPendingApprovelTripsDetails" })
	@CrossOrigin("*")
	public String getPendingApprovelTripsDetails(Principal principal, HttpServletRequest request,
			@RequestBody List<TripDetails> tripList) {
		// String vendorCode = request.getSession().getAttribute("userName").toString();
		String vendorCode = principal.getName();
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<TripDetails> allTripDetailsList = tripDetailsRepo.getAllPendingTrip(vendorCode);

			data.setData(allTripDetailsList);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping(value = "/status", method = RequestMethod.POST)
	@CrossOrigin("*")
	public String status(@RequestBody TripDetails obj) throws UnsupportedEncodingException, MessagingException {
		// System.out.println("*******************************Inside status");
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		String runStatus = obj.getRunStatus().toString();
		String vendortripStatus = obj.getVendorTripStatus().toString();
		String paymentStatus = obj.getPaymentStatus().toString();

		System.out.println("runStatus  " + runStatus);
		System.out.println("vendortripStatus " + vendortripStatus);
		System.out.println("paymentStatus  " + paymentStatus);

		List<TripDetails> obj1 = tripService.getTripsByFilters(runStatus, vendortripStatus, paymentStatus);
		data.setData(obj1);
		data.setMsg("success");

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/tripDetailByTripId" })
	@CrossOrigin("*")
	public String getTripsDetailsByTripId(HttpServletRequest request, @RequestBody TripDetails tripObj) {

		DataContainer data = new DataContainer();

		// System.out.println("trip id : " + tripObj.getTripID());
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			tripObj = tripDetailsRepo.findByTripID(tripObj.getTripID());

			data.setData(tripObj);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/saveTripQuery" })
	@CrossOrigin("*")
	public String saveTripQuery(HttpServletRequest request, @RequestBody QueryEntity entity) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			Integer getid = entity.getId();

			Integer id = getid;
			System.out.println(id);
			Optional<TripDetails> findById = tripDetailsRepo.findById(id);
			queryRepo.updateStatusByUserid("Query", "Network", id);
			TripDetails tripDetails = findById.get();
			String tripID = tripDetails.getTripID();
			System.out.println(tripID);

			if (getid != null) {
				entity.setId(null);
				entity.setTripqueryfk(getid);
				entity.setRaisedOn(new Date());
				entity.setReferenceid(tripID);
				queryRepo.save(entity);
			}

			data.setData(entity);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
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
			// List<Object> listof = new ArrayList<>();
			TripDetails findByTripID = null;

			for (String str : split) {
				findByTripID = tripDetailsRepo.findByTripID(str);

				if (null != findByTripID.getTripID()) {
					findByTripID.setVendorTripStatus("Draft-Invoicing");
					tripDetailsRepo.updateVendorInvoiceStatusByTripId(findByTripID.getVendorTripStatus(),
							findByTripID.getTripID());
				}
			}

			data.setData(obj);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

///getRemarksByRefID
	@RequestMapping({ "/getRemarksByRefID" })
	@CrossOrigin("*")
	public String getRemarksByRefID(HttpServletRequest request, @RequestBody String obj) {

		DataContainer data = new DataContainer();

		// System.out.println("trip Query "+queryObj.getTripDetails());
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			JSONObject jsonObject = new JSONObject(obj);
			System.out.println("jsonObject " + jsonObject.toString());
			String tripID = jsonObject.get("tripID").toString();
			System.out.println(" Trip id is ::" + tripID);
			List<QueryEntity> qe = queryRepo.findCommentsByRefID(tripID);
			System.out.println("Query cahl gyi size hai" + qe.size() + "" + "" + qe.get(0).getComment());

			data.setData(qe);
			data.setMsg("success");
			System.out.println("Trip id is ::" + tripID);

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

//
	@RequestMapping(value = "/getDraftLineTripDetails", method = RequestMethod.POST)
	@CrossOrigin("*")
	public String getDraftLineTripDetails(@RequestBody TripDetails obj, HttpSession session, HttpServletRequest request)
			throws UnsupportedEncodingException, MessagingException {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			String invoiceNumber = obj.getInvoiceNumber();
			System.out.println(invoiceNumber);
			List<TripDetails> list = tripDetailsRepo.getTripStatusIsDraftInvoicing(invoiceNumber);
			for (TripDetails tripDetails : list) {
				System.out.println(tripDetails.getTripID());
			}
			data.setData(list);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getTripDetailByTripId" })
	public String getTripDetailByTripId(@RequestBody TripDetails obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		// List<TripDetails> newlist = new ArrayList<TripDetails>();
		try {

			System.out.println("check user id >> " + obj.getTripID());
			List<TripDetails> list = tripDetailsRepo.findAllTripIdStatsIsClosedAndApprove();
			data.setData(list);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();

	}

	@RequestMapping({ "/findByTripDetailUsingTripID" })
	public String findByTripDetailUsingTripID(@RequestBody TripDetails obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		// List<TripDetails> newlist = new ArrayList<TripDetails>();
		try {
			String tripID = obj.getTripID();
			String invoiceNumber = obj.getInvoiceNumber();

			System.out.println("check user id >> " + obj.getTripID());
			tripDetailsRepo.findTripDetailAgainTripID(invoiceNumber, tripID);
			// data.setData(list);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();

	}
}
