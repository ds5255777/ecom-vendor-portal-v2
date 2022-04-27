package com.main.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
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

import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.RolesEntity;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.entity.User;
import com.main.db.bpaas.repo.InvoiceGenerationEntityRepo;
import com.main.db.bpaas.repo.TripDetailsRepo;
import com.main.service.InvoiceServiceImpl;
import com.main.service.TripService;
import com.main.service.UserService;
import com.main.serviceManager.ServiceManager;
import com.main.db.bpaas.repo.UserRepository;

@Controller
public class UIController {

	@Value("${maxFileSize}")
	public String maxFileSize;

	@Autowired
	ServiceManager serviceManager;

	@Autowired
	UserService userService;

	@Autowired
	TripDetailsRepo tripDetailsRepo;

	@Autowired
	InvoiceGenerationEntityRepo invoiceGenerationEntityRepo;

	@Autowired
	TripService tripService;

	@Autowired
	UserRepository userRepository;

	@Autowired
	InvoiceServiceImpl invoiceServiceImpl;

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

		model.addAttribute("maxFileSize", maxFileSize);

		return "registration";
	}

	@GetMapping({ "/", "/dashboard" })
	public String dashboard(Model model, Principal principal, String error, String logout, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");
		User us = userService.findByUsername(principal.getName());

		if (rolename.equalsIgnoreCase("Network")) {

			List<TripDetails> totalTripCount = tripDetailsRepo.findAll();
			model.addAttribute("totalTripCount", totalTripCount.size());

			List<TripDetails> allApprovedTripscount = tripService.findAllTripsByStatus("Approved By Network Team");
			model.addAttribute("ApprovedTripscount", allApprovedTripscount.size());

			List<TripDetails> yetTobeApproved = tripService.findAllTripsByStatus("");
			model.addAttribute("yetTobeApproved", yetTobeApproved.size());

			List<TripDetails> getTripCountForQueryAdhoc = tripDetailsRepo.getQueryTripsForNetwork("Query");
			model.addAttribute("getTripCountForQueryAdhoc", getTripCountForQueryAdhoc.size());

			int getInClosedTripCountForAdhoc = tripDetailsRepo.getInTransitTripCountByRunTypeAndRunStatus("Adhoc",
					"Closed");
			model.addAttribute("getInClosedTripCountForAdhoc", getInClosedTripCountForAdhoc);

			int getAllInvoiceCount = invoiceGenerationEntityRepo.getCountForAllInvoices();
			model.addAttribute("getAllInvoiceCount", getAllInvoiceCount);

			// Changes made for limit and 50 trips only
			List<TripDetails> findAllTripsLimitFifty = tripService.findAllTripsLimitFifty();
			model.addAttribute("yetTobeApprovedAllDetails", findAllTripsLimitFifty);
			// changes end
			return "dashBoard_NetworkRole";

		} else if (rolename.equalsIgnoreCase("Admin")) {

			// Manish added dashBoard_AdminRole
			int getAllUserCount = userRepository.getCountForAllUsers();
			int totalActiveUser = userRepository.getCountForAllActiveUsers();
			int totalInActiveUser = userRepository.getCountForAllInActiveUsers();
			model.addAttribute("getAllUserCount", getAllUserCount);
			model.addAttribute("totalActiveUser", totalActiveUser);
			model.addAttribute("totalInActiveUser", totalInActiveUser);

			// Vendor
			int getAllVendorCount = userRepository.getAllVendorCount();
			int allActiveVendorCount = userRepository.getAllActiveVendorCount();
			int allInActiveVendorCount = userRepository.getAllInActiveVendorCount();
			model.addAttribute("getAllVendorCount", getAllVendorCount);
			model.addAttribute("allActiveVendorCount", allActiveVendorCount);
			model.addAttribute("allInActiveVendorCount", allInActiveVendorCount);

			// Trips
			int totalTripCount = tripDetailsRepo.getTripCount();
			int TotalCloseTripCount = tripDetailsRepo.getCloseTripCount();
			int TotalInTransitTripCount = tripDetailsRepo.getInTransitTripCount();
			model.addAttribute("totalTripCount", totalTripCount);
			model.addAttribute("TotalCloseTripCount", TotalCloseTripCount);
			model.addAttribute("TotalInTransitTripCount", TotalInTransitTripCount);

			// Invoices
			int getAllInvoiceCount = invoiceGenerationEntityRepo.getCountForAllInvoices();
			int countForAllProcessedInvoice = invoiceGenerationEntityRepo.getCountForAllProcessedInvoice();
			int countForAllApproveInvoice = invoiceGenerationEntityRepo.getCountForAllApproveInvoice();
			model.addAttribute("getAllInvoiceCount", getAllInvoiceCount);
			model.addAttribute("countForAllProcessedInvoice", countForAllProcessedInvoice);
			model.addAttribute("countForAllApproveInvoice", countForAllApproveInvoice);
			
			String uname = principal.getName();
			model.addAttribute("uname", uname);

			return "dashBoard_AdminRole";

		} else if (rolename.equalsIgnoreCase("Vendor")) {

			String vendorCode = principal.getName();
			int totalTripCount = tripDetailsRepo.getTripCount(vendorCode);
			int TotalCloseTripCount = invoiceGenerationEntityRepo.getQueryInvoiceCount(vendorCode);
			int TotalInTransitTripCount = tripDetailsRepo.getInTransitTripCount(vendorCode);

			long processInvoice = invoiceGenerationEntityRepo.getPendingInvoiceCount(vendorCode);
			int approveInvoice = invoiceGenerationEntityRepo.getApproveInvoiceCount(vendorCode);
			int draftInvoice = invoiceGenerationEntityRepo.getDraftInvoiceCount(vendorCode);

			model.addAttribute("role", rolename);
			model.addAttribute("totalTripCount", totalTripCount);
			model.addAttribute("TotalCloseTripCount", TotalCloseTripCount);
			model.addAttribute("TotalInTransitTripCount", TotalInTransitTripCount);
			model.addAttribute("pendingInvoice", processInvoice);
			model.addAttribute("approveInvoice", approveInvoice);
			model.addAttribute("draftInvoice", draftInvoice);
			model.addAttribute("userStatus", us.getStatus());

			return "dashboard";
		} else if (rolename.equalsIgnoreCase("Finance") || rolename.equalsIgnoreCase("Finance Head")) {
			long allInvoice = invoiceGenerationEntityRepo.getCountForAllInvoice();
			long inReviewInvoice = invoiceGenerationEntityRepo.getCountForInReviewInvoice();
			int countForPendingForApprovalInvoice = invoiceGenerationEntityRepo.getCountForPendingForApprovalInvoice();
			int countForApprovedInvoice = invoiceGenerationEntityRepo.getCountForApprovedInvoice();
			int countForPaymentrelaseInvoice = invoiceGenerationEntityRepo.getCountForPaymentrelaseInvoice();
			int queryCount = invoiceGenerationEntityRepo.getQueryzInvoice();
			
			model.addAttribute("allInvoice", allInvoice);
			model.addAttribute("inReviewInvoice", inReviewInvoice);
			model.addAttribute("countForPendingForApprovalInvoice",countForPendingForApprovalInvoice);
			model.addAttribute("countForApprovedInvoice",countForApprovedInvoice);
			model.addAttribute("countForPaymentrelaseInvoice",countForPaymentrelaseInvoice);
			model.addAttribute("queryCount",queryCount);
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
		model.addAttribute("rolesList", roleList);
		String uname = principal.getName();
		model.addAttribute("uname", uname);

//		      serviceManager.insertAddUpdateInMaster(request, action, actionType, null, null, null);
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
		
		String currentDate=new SimpleDateFormat("dd-MM-yyyy").format(new Date());
		model.addAttribute("currentDate", currentDate);
		
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

		List<TripDetails> getTripDetailsById = tripDetailsRepo.getTripDetailsById(id);

		model.addAttribute("id", id);
		model.addAttribute("getTripDetailsById", getTripDetailsById);

		return "tripDetailsView";

	}

	@GetMapping("/closedTrips")
	public String closedTrips(Model model, Principal principal) {

		return "closedTrips";
	}

	@GetMapping("/closedAndApprovedTrips")
	public String closedAndApprovedTrips(Model model, Principal principal) {

		return "closedAndApprovedTrips";
	}

	@GetMapping("/inTransitTrips")
	public String inTransitTrips(Model model, Principal principal) {

		return "inTransitTrips";
	}

	@GetMapping("/pendingApproval")
	public String pendingApproval(Model model, Principal principal, HttpServletRequest request) {

		return "pendingApproval";
	}

	@GetMapping("/invoicesQueue")
	public String invoicesQueue(Model model, Principal principal) {

		return "invoicesQueue";
	}

	@GetMapping("/draftInvoice")
	public String draftInvoice(Model model, Principal principal) {

		return "draftInvoice";
	}

	@GetMapping("/approvedInvoice")
	public String approvedInvoice(Model model, Principal principal) {

		return "approvedInvoice";
	}

	@GetMapping("/pendingInvoice")
	public String pendingInvoice(Model model, Principal principal) {

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

			if (rolename.equalsIgnoreCase("Admin")) {
				
				String uname = principal.getName();
				model.addAttribute("uname", uname);
				
				return "vendorRegistrastion";
				
			}
   		return "";
   	}
	//End

//    @GetMapping("/tripsInvoiceGenerate")
//    public String tripsInvoiceGenerate(Principal principal, HttpServletRequest request, Model model) {
//
//        String tripId = request.getParameter("id");
//        model.addAttribute("tripId", tripId);
//
//        return "tripsInvoiceGenerate";
//    }
//Added by Saurabh for Network Module Part
	@GetMapping("/dashbaordNetwork")
	public String dashbaordNetwork(Model model, Principal principal, HttpServletRequest request) {

		String tripId = request.getParameter("id");
		model.addAttribute("tripId", tripId);

		System.out.println("tripId ........." + tripId);

		int totalTripCount = tripDetailsRepo.getADHocTripCount("Adhoc");
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

		tripService.save(tripDetails);

	}

	@GetMapping("/pendingApprovalNetwork")
	public String pendingApprovalNetwork(Model model, Principal principal) {
		List<TripDetails> yetTobeApproved = tripService.findAllTripsByStatus("");
		System.out.println("Size of pending approval trips is ::" + yetTobeApproved.size());
		model.addAttribute("yetTobeApprovedAllDetails", yetTobeApproved);
		return "pendingApprovalNetwork";
	}

//getApprovedAdhocTrips
	@GetMapping("/getApprovedAdhocTrips")
	public String getApprovedAdhocTrips(Model model, Principal principal) {
		System.out.println("In getApprovedAdhocTrips");
		List<TripDetails> allApprovedTripscount = tripService.findAllTripsByStatus("Approved By Network Team");
		System.out.println("allApprovedTripscount  :::::::::::::::::::; " + allApprovedTripscount.size());
		model.addAttribute("ApprovedAllDetailsForNetwork", allApprovedTripscount);

		return "getApprovedAdhocTrips";
	}

	@GetMapping("/QueryTripsForNetwork")
	public String QueryTripsForNetwork(Model model, Principal principal) {
		System.out.println("********************In QueryTripsForNetwork**************");
		List<TripDetails> AllDetailsForNetwork = tripDetailsRepo.getQueryTripsForNetwork("Query");
		System.out.println(
				"AllDetailsForNetwork Query and Adhoc Trips  :::::::::::::::::::; " + AllDetailsForNetwork.size());
		model.addAttribute("AllDetailsForNetwork", AllDetailsForNetwork);

		return "QueryTripsForNetwork";
	}

//ClosedAdhoc
	@GetMapping("/ClosedAdhoc")
	public String ClosedAdhoc(Model model, Principal principal) {
		System.out.println("********************In ClosedAndAdhoc**************");
		List<TripDetails> AllDetailsForNetwork = tripService.getInTransitTripByRunTypeAndRunStatus("Adhoc", "Closed");
		System.out.println(
				"AllDetailsForNetwork In closed and Adhoc Trips  :::::::::::::::::::; " + AllDetailsForNetwork.size());
		model.addAttribute("AllDetailsForNetwork", AllDetailsForNetwork);

		return "ClosedAdhoc";
	}

	@GetMapping("/tripsInvoiceGenerate")
	public String tripsInvoiceGenerate(Principal principal, HttpServletRequest request, Model model) {

		String userName = principal.getName();
		String userNameIs = userName.substring(0, 4).toUpperCase();
		String invoiceNumber = "";

		invoiceNumber = "ECOM-" + userNameIs.concat(new SimpleDateFormat("yyyyHHmmssSSS").format(new Date()));

		model.addAttribute("invoiceNumber", invoiceNumber);
		request.getSession().setAttribute("invoiceNumber", invoiceNumber);

		String tripId = request.getParameter("id");
		model.addAttribute("maxFileSize", maxFileSize);
		model.addAttribute("tripId", tripId);
		model.addAttribute("userName", userName);

		String tripUpdateId = tripId;
		tripUpdateId = tripUpdateId.replaceAll(",", " ");

		String[] split = tripUpdateId.split(" ");
		TripDetails findByTripID = null;

		try {

			for (String str : split) {
				findByTripID = tripDetailsRepo.findByTripID(str);

				if (null != findByTripID.getTripID()) {
					findByTripID.setVendorTripStatus("Draft-Invoicing");
					findByTripID.setInvoiceNumber(invoiceNumber);
					tripDetailsRepo.save(findByTripID);
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
			invoiceGenerationEntityRepo.save(invoiceSave);
			// listof.forEach(System.out::println);
		} catch (Exception e) {
			e.printStackTrace();
		}

		List<TripDetails> list = tripDetailsRepo.getTripStatusIsDraftInvoicing(invoiceNumber);
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
		model.addAttribute("invoiceNumber", invoiceNumber);

		System.out.println(invoiceNumber);
		List<TripDetails> list = tripDetailsRepo.getTripStatusIsDraftInvoicing(invoiceNumber);
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

		return "allInvoices_Finance";
	}

	@GetMapping("/invoiceView_Finance")
	public String invoiceView_Finance(Model model, HttpServletRequest request, Principal principal) {
		String invoiceNumber = request.getParameter("id");
		String invoiceType = request.getParameter("type");
		model.addAttribute("invoiceNumber", invoiceNumber);
		model.addAttribute("type", invoiceType);
		return "invoiceView_Finance";
	}

	@GetMapping("/processInvoiceFinance")
	public String processInvoiceFinance(Model model, HttpServletRequest request, Principal principal) {

		return "processInvoiceFinance";
	}

	@GetMapping("/InProcessInvoiceFinance")
	public String InProcessInvoiceFinance(Model model, HttpServletRequest request, Principal principal) {

		return "InProcessInvoiceFinance";
	}
	
	@GetMapping("/pendingForApprovalInvoice")
	public String pendingForApprovalInvoice(Model model, HttpServletRequest request, Principal principal) {

		return "pendingForApprovalInvoice";
	}
	
	@GetMapping("/paymentRelaseInvoice")
	public String paymentRelaseInvoice(Model model, HttpServletRequest request, Principal principal) {

		return "paymentRelaseInvoice";
	}
	
	@GetMapping("/queryInvoiceFinance")
	public String queryInvoiceFinance(Model model, HttpServletRequest request, Principal principal) {

		return "queryInvoiceFinance";
	}
	
	@GetMapping("/queryInvoiceVendor")
	public String queryInvoiceVendor(Model model, HttpServletRequest request, Principal principal) {

		return "queryInvoiceVendor";
	}
	
	@RequestMapping("/getDoc")
	@CrossOrigin("*")
	void getDoc(HttpServletResponse response, HttpServletRequest request, @RequestParam("name") String name,@RequestParam("path") String path) {

		try {
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

			File file = new File(path);
			FileInputStream inputStream = new FileInputStream(file);
			response.setContentType("application/" + docNameExtension);
			

			response.setContentLength((int) file.length());
			response.setHeader("Content-Disposition", "inline;filename=\"" + name + "\"");
			response.setHeader("Content-Security-Policy", "frame-ancestors " + uri + " ");
			FileCopyUtils.copy(inputStream, response.getOutputStream());

		} catch (Exception e) {
			e.printStackTrace();

		}
	}

}
