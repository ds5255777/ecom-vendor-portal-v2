package com.main.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.RolesEntity;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.entity.User;
import com.main.serviceManager.ServiceManager;



@Controller
public class UIController {

	@Value("${maxFileSize}")
	public String maxFileSize;

	@Value("${fileSize}")
	public String fileSize;

	@Value("${dataLimit}")
	public String dataLimit;

	@Autowired
	ServiceManager serviceManager;


	@GetMapping({ "/login" })
	public String login(Model model, String error, String logout) {
		model.addAttribute("userForm", new User());

		if (error != null) {
			model.addAttribute("error", "Your username and password is invalid.");
		}

		if (logout != null) {
			model.addAttribute("message", "You have been logged out successfully.");
		}

		return "login";
	}

	@GetMapping("/registration")
	public String registration(Model model) {

		List<String> currency = serviceManager.currencyRepo.getCurrencyType();
		List<String> business = serviceManager.businessPartnerTypeRepo.getBusinessPartnerType();
		List<String> partner = serviceManager.businessPartnerRepo.getBusinessPartner();
		List<String> classification = serviceManager.businessClassificationRepo.getBusinessClassification();
		List<String> payment = serviceManager.paymentTermRepo.getPaymentTerms();
		List<String> nature = serviceManager.natureOfTransactionRepo.getNatureOfTransaction();
		List<String> country = serviceManager.countryRepo.getCountry();
		List<String> tdsCode = serviceManager.tDSSectionCodeRepo.getTDSSectionCode();
		List<String> financialYear = serviceManager.financialYearRepo.getFinancialYear();

		model.addAttribute("currency", currency);
		model.addAttribute("business", business);
		model.addAttribute("partner", partner);
		model.addAttribute("classification", classification);
		model.addAttribute("payment", payment);
		model.addAttribute("nature", nature);
		model.addAttribute("country", country);
		model.addAttribute("tdsCode", tdsCode);
		model.addAttribute("financialYear", financialYear);

		model.addAttribute("fileSize", fileSize);

		model.addAttribute("maxFileSize", maxFileSize);
		model.addAttribute("fileSize", fileSize);

		return "registration";
	}

	@GetMapping({ "/", "/dashboard" })
	public String dashboard(Model model, Principal principal, String error, String logout, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");
		User us = serviceManager.userService.findByUsername(principal.getName());
		
		String bpCode=serviceManager.userRepository.getBpCode(principal.getName());
		if("".equals(bpCode) || bpCode==null ) {
			bpCode="";
		}
		
		String vendorType = serviceManager.supDetailsRepo.findVendorType(bpCode);
		if("".equals(vendorType) || vendorType==null) {
			vendorType="vendor";
		}
		System.out.println("vendorType in dashboard : "+vendorType);
				

		model.addAttribute("dataLimit", dataLimit);

		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {

			List<TripDetails> totalTripCount = serviceManager.tripDetailsRepo.findAll();
			model.addAttribute("totalTripCount", totalTripCount.size());

			List<TripDetails> allApprovedTripscount = serviceManager.tripService.findAllTripsByStatus("Approved By Network Team");
			model.addAttribute("ApprovedTripscount", allApprovedTripscount.size());

			List<TripDetails> yetTobeApproved = serviceManager.tripService.findAllTripsByStatus("");
			model.addAttribute("yetTobeApproved", yetTobeApproved.size());

			List<TripDetails> getTripCountForQueryAdhoc = serviceManager.tripDetailsRepo.getQueryTripsForNetwork("Query");
			model.addAttribute("getTripCountForQueryAdhoc", getTripCountForQueryAdhoc.size());

			int getInClosedTripCountForAdhoc = serviceManager.tripDetailsRepo.getInTransitTripCountByRunTypeAndRunStatus("Adhoc",
					"Closed");
			model.addAttribute("getInClosedTripCountForAdhoc", getInClosedTripCountForAdhoc);

			int getAllInvoiceCount = serviceManager.invoiceGenerationEntityRepo.getCountForAllInvoices();
			model.addAttribute("getAllInvoiceCount", getAllInvoiceCount);

			// Changes made for limit and 50 trips only
			List<TripDetails> findAllTripsLimitFifty = serviceManager.tripService.findAllTripsLimitFifty();
			model.addAttribute("yetTobeApprovedAllDetails", findAllTripsLimitFifty);
			model.addAttribute("userStatus", us.getStatus());
			// changes end
			return "dashBoard_NetworkRole";

		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {

			// Manish added dashBoard_AdminRole
			int getAllUserCount = serviceManager.userRepository.getCountForAllUsers();
			int totalActiveUser = serviceManager.userRepository.getCountForAllActiveUsers();
			int totalInActiveUser = serviceManager.userRepository.getCountForAllInActiveUsers();
			model.addAttribute("getAllUserCount", getAllUserCount);
			model.addAttribute("totalActiveUser", totalActiveUser);
			model.addAttribute("totalInActiveUser", totalInActiveUser);

			// Vendor
			int getAllVendorCount = serviceManager.userRepository.getAllVendorCount();
			int allActiveVendorCount = serviceManager.userRepository.getAllActiveVendorCount();
			int allInActiveVendorCount = serviceManager.userRepository.getAllInActiveVendorCount();
			model.addAttribute("getAllVendorCount", getAllVendorCount);
			model.addAttribute("allActiveVendorCount", allActiveVendorCount);
			model.addAttribute("allInActiveVendorCount", allInActiveVendorCount);

			// Trips
			int totalTripCount = serviceManager.tripDetailsRepo.getTripCount();
			int TotalCloseTripCount = serviceManager.tripDetailsRepo.getCloseTripCount();
			int TotalInTransitTripCount = serviceManager.tripDetailsRepo.getInTransitTripCount();
			model.addAttribute("totalTripCount", totalTripCount);
			model.addAttribute("TotalCloseTripCount", TotalCloseTripCount);
			model.addAttribute("TotalInTransitTripCount", TotalInTransitTripCount);

			// Invoices
			int getAllInvoiceCount = serviceManager.invoiceGenerationEntityRepo.getCountForAllInvoices();
			int countForAllProcessedInvoice = serviceManager.invoiceGenerationEntityRepo.getCountForAllProcessedInvoice();
			int countForAllApproveInvoice = serviceManager.invoiceGenerationEntityRepo.getCountForAllApproveInvoice();
			model.addAttribute("getAllInvoiceCount", getAllInvoiceCount);
			model.addAttribute("countForAllProcessedInvoice", countForAllProcessedInvoice);
			model.addAttribute("countForAllApproveInvoice", countForAllApproveInvoice);

			String uname = principal.getName();
			model.addAttribute("uname", uname);

			return "dashBoard_AdminRole";

		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

			String vendorCode = principal.getName();
			int totalTripCount = serviceManager.tripDetailsRepo.getTripCount(vendorCode);
			int TotalCloseTripCount = serviceManager.invoiceGenerationEntityRepo.getQueryInvoiceCount(vendorCode);
			int TotalInTransitTripCount = serviceManager.tripDetailsRepo.getInTransitTripCount(vendorCode);

			long processInvoice = serviceManager.invoiceGenerationEntityRepo.getPendingInvoiceCount(vendorCode);
			int approveInvoice = serviceManager.invoiceGenerationEntityRepo.getApproveInvoiceCount(vendorCode);
			int draftInvoice = serviceManager.invoiceGenerationEntityRepo.getDraftInvoiceCount(vendorCode);

			model.addAttribute("role", rolename);
			model.addAttribute("totalTripCount", totalTripCount);
			model.addAttribute("TotalCloseTripCount", TotalCloseTripCount);
			model.addAttribute("TotalInTransitTripCount", TotalInTransitTripCount);
			model.addAttribute("pendingInvoice", processInvoice);
			model.addAttribute("approveInvoice", approveInvoice);
			model.addAttribute("draftInvoice", draftInvoice);
			model.addAttribute("userStatus", us.getStatus());
			
			request.setAttribute("vendorType", vendorType);
			model.addAttribute("vendorType", vendorType);

			//po Details
			/*
			 * int totalProcessPoCount = PoDetailsRepo.getAllProcessPoCount(vendorCode);
			 * model.addAttribute("totalProcessPoCount", totalProcessPoCount);
			 * System.out.println("totalProcessPoCount : "+totalProcessPoCount);
			 */
			
			return "dashboard";
		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)
				|| rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE_HEAD)) {
			long allInvoice = serviceManager.invoiceGenerationEntityRepo.getCountForAllInvoice();
			long inReviewInvoice = serviceManager.invoiceGenerationEntityRepo.getCountForInReviewInvoice();
			int countForPendingForApprovalInvoice = serviceManager.invoiceGenerationEntityRepo.getCountForPendingForApprovalInvoice();
			int countForApprovedInvoice = serviceManager.invoiceGenerationEntityRepo.getCountForApprovedInvoice();
			int countForPaymentrelaseInvoice = serviceManager.invoiceGenerationEntityRepo.getCountForPaymentrelaseInvoice();
			int queryCount = serviceManager.invoiceGenerationEntityRepo.getQueryzInvoice();

			model.addAttribute("role", rolename);
			model.addAttribute("allInvoice", allInvoice);
			model.addAttribute("inReviewInvoice", inReviewInvoice);
			model.addAttribute("countForPendingForApprovalInvoice", countForPendingForApprovalInvoice);
			model.addAttribute("countForApprovedInvoice", countForApprovedInvoice);
			model.addAttribute("countForPaymentrelaseInvoice", countForPaymentrelaseInvoice);
			model.addAttribute("queryCount", queryCount);
			return "dashBoard_Finance";
		} else if (rolename.equalsIgnoreCase("Audit")) {
			return "";
		}

		return "";

	}
	
	

	@GetMapping({ "/addUsers" })
	public String addUsers(Model model,Principal principal ,String error, String logout, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");

		if (rolename.equalsIgnoreCase("Admin")) {
		
		List<RolesEntity> roleList = serviceManager.rolesRepository.findByIsActive("1");
		List<RolesEntity> role = serviceManager.rolesRepository.findByIsActiveAndRoleNameNot("1","Vendor");
		model.addAttribute("rolesList", roleList);
		model.addAttribute("role", role);
		String uname = principal.getName();
		model.addAttribute("uname", uname);

			return "addUsers";

		}
		return "";

	}

	@GetMapping({ "/emailConfig" })
	public String emailConfig(Model model, String error, String logout, HttpServletRequest request) {

//		String actionType = "View";
//		String action = "Viewed Email Configuration";

//		      serviceManager.insertAddUpdateInMaster(request, action, actionType, null, null, null);
		return "emailConfig";

	}

	@GetMapping("/logout")
	public String logout(Model model, String error, String logout, HttpServletRequest request, HttpSession session) {

		session.removeAttribute("titleName");
		session.removeAttribute("logoPath");
		session.removeAttribute("sideLogoName");
		session.removeAttribute("userName");
		session.removeAttribute("userId");
		session.removeAttribute("firstName");
		session.removeAttribute("lastName");
		session.removeAttribute("role");
		session.removeAttribute("fullName");

		session.invalidate();

		return "login";

	}

	// vendor ui
	@GetMapping("/allTrips")
	public String allTrips(Model model, Principal principal, HttpServletRequest request) {
		String rolename = (String) request.getSession().getAttribute("role");

		String currentDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
		model.addAttribute("currentDate", currentDate);
		model.addAttribute("dataLimit", dataLimit);

		System.out.println("Role is ::" + rolename);
		if (rolename.equalsIgnoreCase("Network")) {
			System.out.println("All trips in network");
			return "allTripsNetwork";
		} else if (rolename.equalsIgnoreCase("Vendor")) {
			return "allTrips";
		} else if (rolename.equalsIgnoreCase("Admin")) {
			return "allTrips";
		}
		return "";
	}

	@GetMapping("/tripDetailsView")
	public String tripDetailsView(Model model, Principal principal, HttpServletRequest request) {

		String id = request.getParameter("id");

		List<TripDetails> getTripDetailsById = serviceManager.tripDetailsRepo.getTripDetailsById(id);

		model.addAttribute("id", id);
		model.addAttribute("getTripDetailsById", getTripDetailsById);

		return "tripDetailsView";

	}

	@GetMapping("/closedTrips")
	public String closedTrips(Model model, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "closedTrips";
	}

	@GetMapping("/closedAndApprovedTrips")
	public String closedAndApprovedTrips(Model model, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "closedAndApprovedTrips";
	}

	@GetMapping("/inTransitTrips")
	public String inTransitTrips(Model model, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "inTransitTrips";
	}

	@GetMapping("/pendingApproval")
	public String pendingApproval(Model model, Principal principal, HttpServletRequest request) {
		model.addAttribute("dataLimit", dataLimit);
		return "pendingApproval";
	}

	@GetMapping("/invoicesQueue")
	public String invoicesQueue(Model model, Principal principal, HttpServletRequest request) {
		
		String rolename = (String) request.getSession().getAttribute("role");
		model.addAttribute("dataLimit", dataLimit);
		model.addAttribute("rolename", rolename);
		return "invoicesQueue";
	}

	@GetMapping("/draftInvoice")
	public String draftInvoice(Model model, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "draftInvoice";
	}

	@GetMapping("/approvedInvoice")
	public String approvedInvoice(Model model, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "approvedInvoice";
	}

	@GetMapping("/pendingInvoice")
	public String pendingInvoice(Model model, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "pendingInvoice";
	}

	// Added by Manish
	@GetMapping("/tripMaster")
	public String tripMaster(Model model, Principal principal, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");

		if (rolename.equalsIgnoreCase("Admin")) {

			return "tripMaster";

		}
		return "";
	}

	@GetMapping("/vendorDetails")
	public String vendorDetails(Model model, Principal principal, HttpServletRequest request) {
		String rolename = (String) request.getSession().getAttribute("role");
		 List<String> currency = serviceManager.currencyRepo.getCurrencyType();
			List<String> business = serviceManager.businessPartnerTypeRepo.getBusinessPartnerType();
			List<String> partner = serviceManager.businessPartnerRepo.getBusinessPartner();
			List<String> classification = serviceManager.businessClassificationRepo.getBusinessClassification();
			List<String> payment = serviceManager.paymentTermRepo.getPaymentTerms();
			List<String> nature = serviceManager.natureOfTransactionRepo.getNatureOfTransaction();
			List<String> country = serviceManager.countryRepo.getCountry();
			List<String> tdsCode = serviceManager.tDSSectionCodeRepo.getTDSSectionCode();
			List<String> financialYear = serviceManager.financialYearRepo.getFinancialYear();

			model.addAttribute("currency", currency);
			model.addAttribute("business", business);
			model.addAttribute("partner", partner);
			model.addAttribute("classification", classification);
			model.addAttribute("payment", payment);
			model.addAttribute("nature", nature);
			model.addAttribute("country", country);
			model.addAttribute("tdsCode", tdsCode);
			model.addAttribute("financialYear", financialYear);

			model.addAttribute("fileSize", fileSize);

			model.addAttribute("maxFileSize", maxFileSize);
			model.addAttribute("fileSize", fileSize);



		if (rolename.equalsIgnoreCase("Admin")) {

			return "vendorDetails";
		}
		return "";
	}

	 @GetMapping("/notification")
	   	public String notification(Model model, Principal principal, HttpServletRequest request) {
	   		
	    	String rolename = (String) request.getSession().getAttribute("role");

			if (rolename.equalsIgnoreCase("Admin")) {
				
				return "notification";
			}
	   		return "";
	   	}
	     
		 @GetMapping("/vendorRegistrastion")
	   	public String vendorRegistrastion(Model model, Principal principal, HttpServletRequest request) {
	   		
			 String rolename = (String) request.getSession().getAttribute("role");
			 List<String> currency = serviceManager.currencyRepo.getCurrencyType();
				List<String> business = serviceManager.businessPartnerTypeRepo.getBusinessPartnerType();
				List<String> partner = serviceManager.businessPartnerRepo.getBusinessPartner();
				List<String> classification = serviceManager.businessClassificationRepo.getBusinessClassification();
				List<String> payment = serviceManager.paymentTermRepo.getPaymentTerms();
				List<String> nature = serviceManager.natureOfTransactionRepo.getNatureOfTransaction();
				List<String> country = serviceManager.countryRepo.getCountry();
				List<String> tdsCode = serviceManager.tDSSectionCodeRepo.getTDSSectionCode();
				List<String> financialYear = serviceManager.financialYearRepo.getFinancialYear();
				String uname = principal.getName();
				model.addAttribute("uname", uname);

				model.addAttribute("currency", currency);
				model.addAttribute("business", business);
				model.addAttribute("partner", partner);
				model.addAttribute("classification", classification);
				model.addAttribute("payment", payment);
				model.addAttribute("nature", nature);
				model.addAttribute("country", country);
				model.addAttribute("tdsCode", tdsCode);
				model.addAttribute("financialYear", financialYear);

				model.addAttribute("fileSize", fileSize);

				model.addAttribute("maxFileSize", maxFileSize);
				model.addAttribute("fileSize", fileSize);


				if (rolename.equalsIgnoreCase("Admin")) {
					
					return "vendorRegistrastion";
					
				}
	   		return "";
	   	}
		//End
			
		 


	@GetMapping("/dashbaordNetwork")
	public String dashbaordNetwork(Model model, Principal principal, HttpServletRequest request) {

		String tripId = request.getParameter("id");
		model.addAttribute("tripId", tripId);

		System.out.println("tripId ........." + tripId);

		int totalTripCount = serviceManager.tripDetailsRepo.getADHocTripCount("Adhoc");
		model.addAttribute("totalTripCount", totalTripCount);

		return "dashBoard_NetworkRole";
	}

	@GetMapping("/InsertTrip")
	public void InsertTrip(Model model, Principal principal, HttpServletRequest request) throws FileNotFoundException {
		System.out.println("***************************Inside Trip************************************************");
		TripDetails tripDetails = new TripDetails();

//        tripDetails.setId();
		tripDetails.setTripID("4027152");
		tripDetails.setRoute("AGH--DXH");
		tripDetails.setRunType("Schedule");
		tripDetails.setMode("Linehaul Run");
		tripDetails.setVehicleNumber("DL01LW3092");
		tripDetails.setVendorCode("");
		tripDetails.setVendorName("Nikhil Transport");

		tripDetails.setActualVechicleType("17 Feet");
		tripDetails.setStandardShipmentCapacity("3200");
		tripDetails.setStandardPayloadCapacity("4500");
		tripDetails.setRunStatus("Closed");
		tripDetails.setOriginHub("AGH");
		tripDetails.setOriginRegion("Central");
		tripDetails.setDestHub("DXH");
		tripDetails.setActualArrival("2022-02-13 12:20:56");
		tripDetails.setActualDeparture("2022-02-13 04:21:52");
		tripDetails.setActualKM(1.00);
		tripDetails.setStandardKM(236.00);
		tripDetails.setActualShipment("18");
		tripDetails.setActualChargeableWeight("109.5");

		serviceManager.tripService.save(tripDetails);

	}

	@GetMapping("/pendingApprovalNetwork")
	public String pendingApprovalNetwork(Model model, Principal principal) {
		List<TripDetails> yetTobeApproved = serviceManager.tripService.findAllTripsByStatus("");
		List<String> vendorNamefortrips =serviceManager.tripDetailsRepo.getVendorName();
		model.addAttribute("vendorNamefortrips", vendorNamefortrips);
		System.out.println("Size of pending approval trips is ::" + yetTobeApproved.size());
		model.addAttribute("yetTobeApprovedAllDetails", yetTobeApproved);
		return "pendingApprovalNetwork";
	}

//getApprovedAdhocTrips
	@GetMapping("/getApprovedAdhocTrips")
	public String getApprovedAdhocTrips(Model model, Principal principal) {
		System.out.println("In getApprovedAdhocTrips");
		List<TripDetails> allApprovedTripscount = serviceManager.tripService.findAllTripsByStatus("Yet To Be Approved");
		System.out.println("allApprovedTripscount  :::::::::::::::::::; " + allApprovedTripscount.size());
		model.addAttribute("ApprovedAllDetailsForNetwork", allApprovedTripscount);

		return "getApprovedAdhocTrips";
	}

	@GetMapping("/QueryTripsForNetwork")
	public String QueryTripsForNetwork(Model model, Principal principal) {
		System.out.println("********************In QueryTripsForNetwork**************");
		List<TripDetails> AllDetailsForNetwork = serviceManager.tripDetailsRepo.getQueryTripsForNetwork("Query");
		System.out.println(
				"AllDetailsForNetwork Query and Adhoc Trips  :::::::::::::::::::; " + AllDetailsForNetwork.size());
		List<String> vendorNamefortripsQuery =serviceManager.tripDetailsRepo.getVendorName(); 
		model.addAttribute("vendorNamefortripsQuery", vendorNamefortripsQuery);
		model.addAttribute("AllDetailsForNetwork", AllDetailsForNetwork);

		return "QueryTripsForNetwork";
	}

//ClosedAdhoc
	@GetMapping("/ClosedAdhoc")
	public String ClosedAdhoc(Model model, Principal principal) {
		System.out.println("********************In ClosedAndAdhoc**************");
		List<TripDetails> AllDetailsForNetwork = serviceManager.tripService.getInTransitTripByRunTypeAndRunStatus("Adhoc", "Closed");
		System.out.println(
				"AllDetailsForNetwork In closed and Adhoc Trips  :::::::::::::::::::; " + AllDetailsForNetwork.size());
		model.addAttribute("AllDetailsForNetwork", AllDetailsForNetwork);

		return "ClosedAdhoc";
	}
	
	public synchronized String generateInvoiceNumber() {
		
    	long count = serviceManager.invoiceGenerationEntityRepo.count();
    	String invoiceNumberPrefix = "ECOM";
    	
    	count=count+1;
    	 String invoiceNumber = invoiceNumberPrefix+String.format("%08d", count); // Filling with zeroes  
    	
    	return invoiceNumber;
	}

	@GetMapping("/tripsInvoiceGenerate")
	public String tripsInvoiceGenerate(Principal principal, HttpServletRequest request, Model model) {

		String userName = principal.getName();
		//String userNameIs = userName.substring(0, 4).toUpperCase();
		String invoiceNumber = "";

		invoiceNumber = generateInvoiceNumber();

		model.addAttribute("invoiceNumber", invoiceNumber);
		request.getSession().setAttribute("invoiceNumber", invoiceNumber);

		String tripId = request.getParameter("id");
		model.addAttribute("maxFileSize", maxFileSize);
		model.addAttribute("fileSize", fileSize);
		model.addAttribute("tripId", tripId);
		model.addAttribute("userName", userName);

		String tripUpdateId = tripId;
		tripUpdateId = tripUpdateId.replaceAll(",", " ");

		String[] split = tripUpdateId.split(" ");
		TripDetails findByTripID = null;

		try {

			for (String str : split) {
				findByTripID = serviceManager.tripDetailsRepo.findByTripID(str);

				if (null != findByTripID.getTripID()) {
					findByTripID.setVendorTripStatus("Draft-Invoicing");
					findByTripID.setInvoiceNumber(invoiceNumber);
					serviceManager.tripDetailsRepo.save(findByTripID);
				}
			}
			String vendorName = findByTripID.getVendorName();
			model.addAttribute("vendorName", vendorName);
			System.out.println(vendorName);
			// heasder
			InvoiceGenerationEntity invoiceSave = new InvoiceGenerationEntity();
			invoiceSave.setVendorName(vendorName);
			invoiceSave.setEcomInvoiceNumber(invoiceNumber);
			invoiceSave.setVendorCode(userName);
			invoiceSave.setInvoiceStatus("Draft-Invoicing");
			serviceManager.invoiceGenerationEntityRepo.save(invoiceSave);
			// listof.forEach(System.out::println);
		} catch (Exception e) {
			e.printStackTrace();
		}

		List<TripDetails> list = serviceManager.tripDetailsRepo.getTripStatusIsDraftInvoicing(invoiceNumber);
		List<Object> listofTrips = new ArrayList<>();
		for (TripDetails tripDetails : list) {
			System.out.println(tripDetails.getTripID());
			String tripID = tripDetails.getTripID();
			listofTrips.add(tripID);

		}
		model.addAttribute("listofTrips", listofTrips);

		return "draftInvoiceGenerate";
	}


	
	@GetMapping("/invoiceView")
	public String invoiceView(Model model, HttpServletRequest request, Principal principal) {

		String invoiceNumber = request.getParameter("id");
		String invoiceType = request.getParameter("type");
		model.addAttribute("type", invoiceType);
		model.addAttribute("invoiceNumber", invoiceNumber);
		return "invoiceView";
	}
	
		
	@GetMapping("/draftInvoiceGenerate")
	public String draftInvoiceGenerate(Model model, HttpServletRequest request, Principal principal) {

		String vendorName = null;
		String invoiceNumber = request.getParameter("id");

		model.addAttribute("maxFileSize", maxFileSize);
		model.addAttribute("fileSize", fileSize);
		model.addAttribute("invoiceNumber", invoiceNumber);

		System.out.println(invoiceNumber);
		List<TripDetails> list = serviceManager.tripDetailsRepo.getTripStatusIsDraftInvoicing(invoiceNumber);
		List<Object> listofTrips = new ArrayList<>();

		for (TripDetails tripDetails : list) {
			String tripID = tripDetails.getTripID();
			listofTrips.add(tripID);
			vendorName = tripDetails.getVendorName();
		}

		model.addAttribute("vendorName", vendorName);
		model.addAttribute("listofTrips", listofTrips);
		return "draftInvoiceGenerate";
	}

	@GetMapping("/changePassword")
	public String changePassword(Model model, HttpServletRequest request, Principal principal) {

		return "changePassword";
	}

//allInvoices_Finance
	@GetMapping("/allInvoices_Finance")
	public String allInvoicesFinance(Model model, HttpServletRequest request, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "allInvoices_Finance";
	}

	@GetMapping("/invoiceView_Finance")
	public String invoiceView_Finance(Model model, HttpServletRequest request, Principal principal) {
		String ecomInvoiceNumber = request.getParameter("id");
		String invoiceType = request.getParameter("type");
		model.addAttribute("ecomInvoiceNumber", ecomInvoiceNumber);
		model.addAttribute("type", invoiceType);
		return "invoiceView_Finance";
	}

	@GetMapping("/processInvoiceFinance")
	public String processInvoiceFinance(Model model, HttpServletRequest request, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "processInvoiceFinance";
	}

	@GetMapping("/InProcessInvoiceFinance")
	public String InProcessInvoiceFinance(Model model, HttpServletRequest request, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "InProcessInvoiceFinance";
	}

	@GetMapping("/pendingForApprovalInvoice")
	public String pendingForApprovalInvoice(Model model, HttpServletRequest request, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "pendingForApprovalInvoice";
	}

	@GetMapping("/paymentRelaseInvoice")
	public String paymentRelaseInvoice(Model model, HttpServletRequest request, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "paymentRelaseInvoice";
	}

	@GetMapping("/queryInvoiceFinance")
	public String queryInvoiceFinance(Model model, HttpServletRequest request, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "queryInvoiceFinance";
	}

	@GetMapping("/queryInvoice")
	public String queryInvoiceVendor(Model model, HttpServletRequest request, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		String rolename = (String) request.getSession().getAttribute("role");
		model.addAttribute("rolename", rolename);
		return "queryInvoiceVendor";
	}
	
	@GetMapping("/queryInvoiceEdit")
	public String queryInvoiceEdit(Model model, HttpServletRequest request, Principal principal) {
		model.addAttribute("maxFileSize", maxFileSize);
		String invoiceNumber = request.getParameter("id");
		String invoiceType = request.getParameter("type");
		model.addAttribute("fileSize", fileSize);
		model.addAttribute("invoiceNumber", invoiceNumber);
		model.addAttribute("type", invoiceType);
		return "queryInvoiceEdit";
	}

	@RequestMapping("/getDoc")
	@CrossOrigin("*")
	void getDoc(HttpServletResponse response, HttpServletRequest request, @RequestParam("name") String name,
			@RequestParam("path") String path) {

		File file = null;
		FileInputStream inputStream = null;
		try{
			String[] docNameExtensionArray = name.split("\\.");
			String docNameExtension = docNameExtensionArray[docNameExtensionArray.length - 1];
			System.out.println("docNameExtension.." + docNameExtension);
			String uri = request.getScheme() + "://" + // "http" + "://
					request.getServerName() + // "myhost"
					":" + // ":"
					request.getServerPort() + "/"; // "8080"

			System.out.println("uri..." + uri);

			System.out.println("uri..." + path);

			System.out.println("uri..." + name);

			file = new File(path);
			inputStream = new FileInputStream(file);
			response.setContentType("application/" + docNameExtension);

			response.setContentLength((int) file.length());
			response.setHeader("Content-Disposition", "inline;filename=\"" + name + "\"");
			response.setHeader("Content-Security-Policy", "frame-ancestors " + uri + " ");
			FileCopyUtils.copy(inputStream, response.getOutputStream());

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			try {
				inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
