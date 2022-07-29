package com.main.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.InvoiceNumber;
import com.main.db.bpaas.entity.PoDetails;
import com.main.db.bpaas.entity.PoLineDetails;
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

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(UIController.class);

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
	public String registration(Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ParseException {
		Base64.Decoder decoder = Base64.getDecoder();
		String vendorEmail = new String(decoder.decode(request.getParameter("vendorEmail")));
		if (!"".equalsIgnoreCase(vendorEmail)) {
			String flag = request.getParameter("flag");
			Integer flag1 = Integer.valueOf(flag);
			String processOn = serviceManager.sendEmailToVendorRepo.processOn(flag1);

			Date date1 = new SimpleDateFormat("yyyy-MM-dd").parse(processOn);
			String dbDate = new SimpleDateFormat("yyyy-MM-dd").format(date1);
			String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
			if (!currentDate.equalsIgnoreCase(dbDate)) {

				response.setContentType("text/html");
				PrintWriter pwriter = response.getWriter();

				pwriter.println(
						"<font color=red>Link Expired! Please Contact With Administrator And Try Again...</font>");
				pwriter.close();
			}
		}
		String vendorType1 = new String(decoder.decode(request.getParameter("vendorType")));
		String[] strSplit = vendorType1.split(",");

		ArrayList<String> vendorType2 = new ArrayList<String>(Arrays.asList(strSplit));
		String region1 = new String(decoder.decode(request.getParameter("region")));
		String vendorAddress = new String(decoder.decode(request.getParameter("vendorAddress")));
		String processBy = new String(decoder.decode(request.getParameter("processBy")));
		String processByEmailId = new String(decoder.decode(request.getParameter("processByEmailId")));
		model.addAttribute("vendorEmail", vendorEmail);
		model.addAttribute("vendorType2", vendorType2);
		model.addAttribute("region1", region1);
		model.addAttribute("vendorAddress", vendorAddress);
		model.addAttribute("processBy", processBy);
		model.addAttribute("processByEmailId", processByEmailId);

		String pid = "";
		try {
			pid = request.getParameter("pid");
		} catch (Exception ex) {
			logger.error("error : " + ex);
		}

		if ("".equalsIgnoreCase(pid)) {

			List<String> currency = serviceManager.currencyRepo.getCurrencyType();
			List<String> business = serviceManager.businessPartnerTypeRepo.getBusinessPartnerType();
			List<String> partner = serviceManager.businessPartnerRepo.getBusinessPartner();
			List<String> classification = serviceManager.businessClassificationRepo.getBusinessClassification();
			List<String> stateName = serviceManager.stateRepo.getStateName();
			List<String> payment = serviceManager.paymentTermRepo.getPaymentTerms();
			List<String> country = serviceManager.countryRepo.getCountry();
			List<String> tdsCode = serviceManager.tDSSectionCodeRepo.getTDSSectionCode();
			List<String> financialYear = serviceManager.financialYearRepo.getFinancialYear();
			List<String> adharLinkStatus = serviceManager.adharLinkStatusRepo.getAdharLinkStatus();
			List<String> region = serviceManager.regionRepo.getRegion();
			List<String> sectionType = serviceManager.sectionTypeRepo.getSectionType();
			List<String> paymentMethod = serviceManager.paymentMethodRepo.paymentMethod();

			String userEmail = (String) request.getSession().getAttribute("userEmail");

			model.addAttribute("userEmail", userEmail);

			model.addAttribute("currency", currency);
			model.addAttribute("business", business);
			model.addAttribute("partner", partner);
			model.addAttribute("classification", classification);
			model.addAttribute("stateName", stateName);
			model.addAttribute("payment", payment);
			model.addAttribute("country", country);
			model.addAttribute("tdsCode", tdsCode);
			model.addAttribute("financialYear", financialYear);
			model.addAttribute("pid", pid);
			model.addAttribute("fileSize", fileSize);

			model.addAttribute("maxFileSize", maxFileSize);
			model.addAttribute("fileSize", fileSize);
			model.addAttribute("adharLink", adharLinkStatus);
			model.addAttribute("region", region);
			model.addAttribute("sectionType", sectionType);
			model.addAttribute("paymentMethod", paymentMethod);

			return "registration";

		} else {

			model.addAttribute("pid", pid);
			List<String> currency = serviceManager.currencyRepo.getCurrencyType();
			List<String> business = serviceManager.businessPartnerTypeRepo.getBusinessPartnerType();
			List<String> partner = serviceManager.businessPartnerRepo.getBusinessPartner();
			List<String> stateName = serviceManager.stateRepo.getStateName();
			List<String> classification = serviceManager.businessClassificationRepo.getBusinessClassification();
			List<String> payment = serviceManager.paymentTermRepo.getPaymentTerms();
			List<String> country = serviceManager.countryRepo.getCountry();
			List<String> tdsCode = serviceManager.tDSSectionCodeRepo.getTDSSectionCode();
			List<String> financialYear = serviceManager.financialYearRepo.getFinancialYear();
			List<String> adharLinkStatus = serviceManager.adharLinkStatusRepo.getAdharLinkStatus();
			List<String> region = serviceManager.regionRepo.getRegion();
			List<String> sectionType = serviceManager.sectionTypeRepo.getSectionType();
			List<String> paymentMethod = serviceManager.paymentMethodRepo.paymentMethod();

			model.addAttribute("currency", currency);
			model.addAttribute("business", business);
			model.addAttribute("partner", partner);
			model.addAttribute("stateName", stateName);
			model.addAttribute("classification", classification);
			model.addAttribute("payment", payment);
			model.addAttribute("country", country);
			model.addAttribute("tdsCode", tdsCode);
			model.addAttribute("financialYear", financialYear);

			model.addAttribute("fileSize", fileSize);

			model.addAttribute("maxFileSize", maxFileSize);
			model.addAttribute("fileSize", fileSize);
			model.addAttribute("adharLink", adharLinkStatus);
			model.addAttribute("region", region);
			model.addAttribute("sectionType", sectionType);
			model.addAttribute("paymentMethod", paymentMethod);

		}
		return "registration";

	}

	@GetMapping({ "/", "/dashboard" })
	public String dashboard(Model model, Principal principal, String error, String logout, HttpServletRequest request) {

		User us = serviceManager.userService.findByUsername(principal.getName());
		String rolename = us.getRolesObj().getRoleName();
		String bpCode = serviceManager.userRepository.getBpCode(principal.getName());
		model.addAttribute("role", rolename);
		model.addAttribute("username", principal.getName());
		if (null == bpCode) {
			bpCode = "";
		}

		String vendorType = serviceManager.supDetailsRepo.findVendorType(bpCode);
		if (null == vendorType || "".equals(vendorType)) {
			vendorType = "vendor";
		}

		model.addAttribute("dataLimit", dataLimit);

		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {

			List<TripDetails> totalTripCount = serviceManager.tripDetailsRepo.findAll();
			model.addAttribute("totalTripCount", totalTripCount.size());

			List<TripDetails> allApprovedTripscount = serviceManager.tripService
					.findAllTripsByStatus("Yet To Be Approved");
			model.addAttribute("ApprovedTripscount", allApprovedTripscount.size());

			List<TripDetails> yetTobeApproved = serviceManager.tripService.findAllTripsByStatus("");
			model.addAttribute("yetTobeApproved", yetTobeApproved.size());

			List<TripDetails> getTripCountForQueryAdhoc = serviceManager.tripDetailsRepo
					.getQueryTripsForNetwork("Query");
			model.addAttribute("getTripCountForQueryAdhoc", getTripCountForQueryAdhoc.size());

			int getInClosedTripCountForAdhoc = serviceManager.tripDetailsRepo
					.getInTransitTripCountByRunTypeAndRunStatus("Adhoc", "Closed");
			model.addAttribute("getInClosedTripCountForAdhoc", getInClosedTripCountForAdhoc);

			int getAllInvoiceCount = serviceManager.invoiceGenerationEntityRepo.getCountForAllInvoices();
			model.addAttribute("getAllInvoiceCount", getAllInvoiceCount);

			List<TripDetails> findAllTripsLimitFifty = serviceManager.tripService.findAllTripsLimitFifty();
			model.addAttribute("yetTobeApprovedAllDetails", findAllTripsLimitFifty);
			model.addAttribute("role", rolename);
			model.addAttribute("userStatus", us.getStatus());
			return "dashBoard_NetworkRole";

		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {

			int getAllUserCount = serviceManager.userRepository.getCountForAllUsers();
			int totalActiveUser = serviceManager.userRepository.getCountForAllActiveUsers();
			int totalInActiveUser = serviceManager.userRepository.getCountForAllInActiveUsers();
			model.addAttribute("getAllUserCount", getAllUserCount);
			model.addAttribute("totalActiveUser", totalActiveUser);
			model.addAttribute("totalInActiveUser", totalInActiveUser);

			int getAllVendorCount = serviceManager.userRepository.getAllVendorCount();
			int allActiveVendorCount = serviceManager.userRepository.getAllActiveVendorCount();
			int allInActiveVendorCount = serviceManager.userRepository.getAllInActiveVendorCount();
			model.addAttribute("getAllVendorCount", getAllVendorCount);
			model.addAttribute("allActiveVendorCount", allActiveVendorCount);
			model.addAttribute("allInActiveVendorCount", allInActiveVendorCount);

			int totalTripCount = serviceManager.tripDetailsRepo.getTripCount();
			int TotalCloseTripCount = serviceManager.tripDetailsRepo.getCloseTripCount();
			int TotalInTransitTripCount = serviceManager.tripDetailsRepo.getInTransitTripCount();
			model.addAttribute("totalTripCount", totalTripCount);
			model.addAttribute("TotalCloseTripCount", TotalCloseTripCount);
			model.addAttribute("TotalInTransitTripCount", TotalInTransitTripCount);

			int getAllInvoiceCount = serviceManager.invoiceGenerationEntityRepo.getCountForAllInvoices();
			int countForAllProcessedInvoice = serviceManager.invoiceGenerationEntityRepo
					.getCountForAllProcessedInvoice();
			int countForAllApproveInvoice = serviceManager.invoiceGenerationEntityRepo.getCountForAllApproveInvoice();
			model.addAttribute("getAllInvoiceCount", getAllInvoiceCount);
			model.addAttribute("countForAllProcessedInvoice", countForAllProcessedInvoice);
			model.addAttribute("countForAllApproveInvoice", countForAllApproveInvoice);

			String uname = principal.getName();
			model.addAttribute("uname", uname);
			model.addAttribute("role", rolename);
			model.addAttribute("userStatus", us.getStatus());

			return "dashBoard_AdminRole";

		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

			String vendorCode = principal.getName();
			int totalTripCount = serviceManager.tripDetailsRepo.getTripCount(vendorCode);
			int TotalCloseTripCount = serviceManager.invoiceGenerationEntityRepo.getQueryInvoiceCount(vendorCode);
			int TotalInTransitTripCount = serviceManager.tripDetailsRepo.getInTransitTripCount(vendorCode);
			int closedTripCount = serviceManager.tripDetailsRepo.getCloseTripCount(vendorCode);
			int queryTripCount = serviceManager.tripDetailsRepo.getQueryTripCount(vendorCode);

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
			model.addAttribute("closedTripCount", closedTripCount);
			model.addAttribute("queryTripCount", queryTripCount);

			request.setAttribute("vendorType", vendorType);
			model.addAttribute("vendorType", vendorType);
			model.addAttribute("role", rolename);

			if (vendorType.equalsIgnoreCase("Fixed Asset") || vendorType.equalsIgnoreCase("FIXED ASSETS")) {

				rolename = (String) request.getSession().getAttribute("role");
				vendorCode = (String) request.getSession().getAttribute("userName");
				String processBy = principal.getName();
				Date proceessOn = new Date();
				List<PoDetails> details1 = new ArrayList<PoDetails>();
				List<PoDetails> details = serviceManager.podetailsRepo.getAllUnProcessPo(vendorCode);

				for (int i = 0; i < details.size(); i++) {
					List<PoLineDetails> podet = details.get(i).getPoline();
					String pono = details.get(i).getPoNo();
					float remaningquantity = 0;
					for (int j = 0; j < podet.size(); j++) {
						remaningquantity = remaningquantity + Float.parseFloat(podet.get(j).getRemaningQuatity());
					}
					if (remaningquantity != 0.0 || remaningquantity != 0.00 || remaningquantity != 0) {
						details1.add(details.get(i));
					} else {
						serviceManager.podetailsRepo.updateVendorPoStatusAgainsInvoiceNumber(pono, proceessOn,
								processBy);
					}
				}

				int totalAllPoCount = serviceManager.podetailsRepo.getAllPoCount(vendorCode);
				model.addAttribute("totalAllPoCount", totalAllPoCount);

				int totalProcessPoCount = serviceManager.podetailsRepo.getAllProcessPoCount(vendorCode);
				model.addAttribute("totalProcessPoCount", totalProcessPoCount);
				int totalUnprocessPOCount = serviceManager.podetailsRepo.getAllUnProcessPoCount(vendorCode);
				model.addAttribute("totalUnprocessPOCount", totalUnprocessPOCount);
				int totalQueryCount = serviceManager.podetailsRepo.getAllQueryCount(vendorCode);
				model.addAttribute("totalQueryCount", totalQueryCount);

				int totalInvoiceCount = serviceManager.poinvoiceRepo.getAllInvoiceCount(vendorCode);
				model.addAttribute("totalInvoiceCount", totalInvoiceCount);

				int allPOcount = serviceManager.poinvoiceRepo.getAllPOcount(vendorCode);
				model.addAttribute("allPOcount", allPOcount);

				int totalDraftInvoiceCount = serviceManager.poinvoiceRepo.getTotalDraftInvoiceCount(vendorCode);
				model.addAttribute("totalDraftInvoiceCount", totalDraftInvoiceCount);

				model.addAttribute("userStatus", us.getStatus());
				model.addAttribute("dataLimit", dataLimit);

				if (rolename.equalsIgnoreCase("Vendor")) {

					return "dashboard_Po";

				} else {
					return "";
				}
			}

			return "dashboard";

		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)
				|| rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE_HEAD)) {
			long allInvoice = serviceManager.invoiceGenerationEntityRepo.getCountForAllInvoice();
			long inReviewInvoice = serviceManager.invoiceGenerationEntityRepo.getCountForInReviewInvoice();
			int countForPendingForApprovalInvoice = serviceManager.invoiceGenerationEntityRepo
					.getCountForPendingForApprovalInvoice();
			int countForApprovedInvoice = serviceManager.invoiceGenerationEntityRepo.getCountForApprovedInvoice();
			int countForPaymentrelaseInvoice = serviceManager.invoiceGenerationEntityRepo
					.getCountForPaymentrelaseInvoice();
			int queryCount = serviceManager.invoiceGenerationEntityRepo.getQueryzInvoice();

			model.addAttribute("role", rolename);
			model.addAttribute("allInvoice", allInvoice);
			model.addAttribute("inReviewInvoice", inReviewInvoice);
			model.addAttribute("countForPendingForApprovalInvoice", countForPendingForApprovalInvoice);
			model.addAttribute("countForApprovedInvoice", countForApprovedInvoice);
			model.addAttribute("countForPaymentrelaseInvoice", countForPaymentrelaseInvoice);
			model.addAttribute("queryCount", queryCount);
			model.addAttribute("role", rolename);
			return "dashBoard_Finance";
		} else if (rolename.equalsIgnoreCase("Audit")) {
			return "";
		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {
			Integer pendingRequest = serviceManager.supDetailsRepo
					.countByVenStatus(GlobalConstants.PENDING_REQUEST_STATUS);
			Integer approvedRequest = serviceManager.supDetailsRepo
					.countByVenStatus(GlobalConstants.APPROVED_REQUEST_STATUS);
			Integer rejectedRequest = serviceManager.supDetailsRepo
					.countByVenStatus(GlobalConstants.REJECTED_REQUEST_STATUS);
			Integer queryRequest = serviceManager.supDetailsRepo.countByVenStatus(GlobalConstants.QUERY_REQUEST_STATUS);
			model.addAttribute("pendingRequest", pendingRequest);
			model.addAttribute("approvedRequest", approvedRequest);
			model.addAttribute("rejectedRequest", rejectedRequest);
			model.addAttribute("queryRequest", queryRequest);
			model.addAttribute("role", rolename);
			return "dashboardRegistration";
		} else if (rolename.equalsIgnoreCase("Commercial Team")) {
			List<String> vendorType1 = serviceManager.businessPartnerTypeRepo.getBusinessPartnerType();
			List<String> region = serviceManager.regionRepo.getRegion();

			model.addAttribute("region", region);
			model.addAttribute("vendorType", vendorType1);
			return "triggerEmail";
		}

		return "";

	}

	@GetMapping({ "/addUsers" })
	public String addUsers(Model model, Principal principal, String error, String logout, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");

		if (rolename.equalsIgnoreCase("Admin")) {

			List<RolesEntity> roleList = serviceManager.rolesRepository.findByIsActive("1");
			List<RolesEntity> role = serviceManager.rolesRepository.findByIsActiveAndRoleNameNot("1", "Vendor");
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

		return "emailConfig";
	}

	@GetMapping({ "/triggerEmail" })
	public String triggerEmail(Model model, String error, String logout, HttpServletRequest request) {

		List<String> vendorType = serviceManager.businessPartnerTypeRepo.getBusinessPartnerType();
		List<String> region = serviceManager.regionRepo.getRegion();

		model.addAttribute("region", region);
		model.addAttribute("vendorType", vendorType);
		return "triggerEmail";
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

	@GetMapping("/allTrips")
	public String allTrips(Model model, Principal principal, HttpServletRequest request) {
		String rolename = (String) request.getSession().getAttribute("role");

		String currentDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
		model.addAttribute("currentDate", currentDate);
		model.addAttribute("dataLimit", dataLimit);

		if (rolename.equalsIgnoreCase("Network")) {
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

	@GetMapping("/tripMaster")
	public String tripMaster(Model model, Principal principal, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");

		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {

			return "tripMaster";

		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)) {

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
		List<String> country = serviceManager.countryRepo.getCountry();
		List<String> tdsCode = serviceManager.tDSSectionCodeRepo.getTDSSectionCode();
		List<String> financialYear = serviceManager.financialYearRepo.getFinancialYear();
		List<String> adharLinkStatus = serviceManager.adharLinkStatusRepo.getAdharLinkStatus();
		List<String> region = serviceManager.regionRepo.getRegion();
		List<String> sectionType = serviceManager.sectionTypeRepo.getSectionType();
		List<String> paymentMethod = serviceManager.paymentMethodRepo.paymentMethod();
		List<String> flag = serviceManager.flagRepo.getFlag();
		List<String> stateName = serviceManager.stateRepo.getStateName();

		model.addAttribute("currency", currency);
		model.addAttribute("business", business);
		model.addAttribute("partner", partner);
		model.addAttribute("classification", classification);
		model.addAttribute("payment", payment);
		model.addAttribute("country", country);
		model.addAttribute("tdsCode", tdsCode);
		model.addAttribute("financialYear", financialYear);

		model.addAttribute("fileSize", fileSize);

		model.addAttribute("maxFileSize", maxFileSize);
		model.addAttribute("fileSize", fileSize);
		model.addAttribute("maxFileSize", maxFileSize);
		model.addAttribute("fileSize", fileSize);
		model.addAttribute("adharLink", adharLinkStatus);
		model.addAttribute("region", region);
		model.addAttribute("sectionType", sectionType);
		model.addAttribute("paymentMethod", paymentMethod);
		model.addAttribute("flag", flag);
		model.addAttribute("stateName", stateName);

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
		List<String> country = serviceManager.countryRepo.getCountry();
		List<String> tdsCode = serviceManager.tDSSectionCodeRepo.getTDSSectionCode();
		List<String> financialYear = serviceManager.financialYearRepo.getFinancialYear();
		List<String> adharLinkStatus = serviceManager.adharLinkStatusRepo.getAdharLinkStatus();
		List<String> region = serviceManager.regionRepo.getRegion();
		List<String> sectionType = serviceManager.sectionTypeRepo.getSectionType();
		List<String> paymentMethod = serviceManager.paymentMethodRepo.paymentMethod();
		List<String> flag = serviceManager.flagRepo.getFlag();
		List<String> stateName = serviceManager.stateRepo.getStateName();

		String uname = principal.getName();
		model.addAttribute("uname", uname);

		model.addAttribute("currency", currency);
		model.addAttribute("business", business);
		model.addAttribute("partner", partner);
		model.addAttribute("classification", classification);
		model.addAttribute("payment", payment);
		model.addAttribute("country", country);
		model.addAttribute("tdsCode", tdsCode);
		model.addAttribute("financialYear", financialYear);

		model.addAttribute("fileSize", fileSize);

		model.addAttribute("maxFileSize", maxFileSize);
		model.addAttribute("fileSize", fileSize);
		model.addAttribute("adharLink", adharLinkStatus);
		model.addAttribute("region", region);
		model.addAttribute("sectionType", sectionType);
		model.addAttribute("paymentMethod", paymentMethod);
		model.addAttribute("flag", flag);
		model.addAttribute("stateName", stateName);

		if (rolename.equalsIgnoreCase("Admin")) {

			return "vendorRegistrastion";

		}
		return "";
	}

	@GetMapping("/dashbaordNetwork")
	public String dashbaordNetwork(Model model, Principal principal, HttpServletRequest request) {

		String tripId = request.getParameter("id");
		model.addAttribute("tripId", tripId);

		int totalTripCount = serviceManager.tripDetailsRepo.getADHocTripCount("Adhoc");
		model.addAttribute("totalTripCount", totalTripCount);

		return "dashBoard_NetworkRole";
	}

	@GetMapping("/pendingApprovalNetwork")
	public String pendingApprovalNetwork(Model model, Principal principal) {
		List<TripDetails> yetTobeApproved = serviceManager.tripService.findAllTripsByStatus("");
		List<String> vendorNamefortrips = serviceManager.tripDetailsRepo.getVendorName();
		model.addAttribute("vendorNamefortrips", vendorNamefortrips);
		model.addAttribute("yetTobeApprovedAllDetails", yetTobeApproved);
		model.addAttribute("dataLimit", dataLimit);
		return "pendingApprovalNetwork";
	}

	@GetMapping("/getApprovedAdhocTrips")
	public String getApprovedAdhocTrips(Model model, Principal principal) {
		List<TripDetails> allApprovedTripscount = serviceManager.tripService.findAllTripsByStatus("Yet To Be Approved");
		model.addAttribute("ApprovedAllDetailsForNetwork", allApprovedTripscount);
		model.addAttribute("dataLimit", dataLimit);
		return "getApprovedAdhocTrips";
	}

	@GetMapping("/QueryTripsForNetwork")
	public String queryTripsForNetwork(Model model, Principal principal) {
		List<TripDetails> allDetailsForNetwork = serviceManager.tripDetailsRepo.getQueryTripsForNetwork("Query");
		List<String> vendorNamefortripsQuery = serviceManager.tripDetailsRepo.getVendorName();
		model.addAttribute("vendorNamefortripsQuery", vendorNamefortripsQuery);
		model.addAttribute("AllDetailsForNetwork", allDetailsForNetwork);
		model.addAttribute("dataLimit", dataLimit);
		return "QueryTripsForNetwork";
	}

	@GetMapping("/ClosedAdhoc")
	public String closedAdhoc(Model model, Principal principal) {
		List<TripDetails> AllDetailsForNetwork = serviceManager.tripService
				.getInTransitTripByRunTypeAndRunStatus("Adhoc", "Closed");
		model.addAttribute("AllDetailsForNetwork", AllDetailsForNetwork);
		model.addAttribute("dataLimit", dataLimit);
		return "ClosedAdhoc";
	}

	public synchronized String generateInvoiceNumber() {

		long count = serviceManager.invoiceNumberRepo.count();
		String invoiceNumberPrefix = "ECOM-";

		count = count + 1;
		String invoiceNumber = invoiceNumberPrefix + String.format("%08d", count); 
		return invoiceNumber;
	}

	@GetMapping("/tripsInvoiceGenerate")
	public String tripsInvoiceGenerate(Principal principal, HttpServletRequest request, Model model) {

		String userName = principal.getName();
		String invoiceNumber = "";

		invoiceNumber = generateInvoiceNumber();

		InvoiceNumber inNumber = new InvoiceNumber();
		inNumber.setEcomInvoiceNumber(invoiceNumber);
		inNumber.setStatus("Used_Trip_Invoice");
		serviceManager.invoiceNumberRepo.save(inNumber);

		model.addAttribute("invoiceNumber", invoiceNumber);
		request.getSession().setAttribute("invoiceNumber", invoiceNumber);

		Base64.Decoder decoder = Base64.getDecoder();

		String tripId = new String(decoder.decode(request.getParameter("id")));
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

				Date date = new Date();
				DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
				String processedOn = dateFormat.format(date);

				if (null != findByTripID.getTripID()) {
					findByTripID.setVendorTripStatus("Draft-Invoicing");
					findByTripID.setInvoiceNumber(invoiceNumber);
					findByTripID.setProcessedOn(processedOn);
					findByTripID.setProcessedBy(userName);
					serviceManager.tripDetailsRepo.save(findByTripID);
				}
			}
			String vendorName = findByTripID.getVendorName();
			model.addAttribute("vendorName", vendorName);
			InvoiceGenerationEntity invoiceSave = new InvoiceGenerationEntity();
			invoiceSave.setVendorName(vendorName);
			invoiceSave.setEcomInvoiceNumber(invoiceNumber);
			invoiceSave.setVendorCode(userName);
			invoiceSave.setInvoiceStatus("Draft-Invoicing");
			serviceManager.invoiceGenerationEntityRepo.save(invoiceSave);
		} catch (Exception e) {
			logger.error("error : " + e);
		}

		List<TripDetails> list = serviceManager.tripDetailsRepo.getTripStatusIsDraftInvoicing(invoiceNumber, userName);
		List<Object> listofTrips = new ArrayList<>();
		for (TripDetails tripDetails : list) {
			String tripID = tripDetails.getTripID();
			listofTrips.add(tripID);

		}
		String currentDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
		model.addAttribute("currentDate", currentDate);
		model.addAttribute("listofTrips", listofTrips);

		return "draftInvoiceGenerate";
	}

	@GetMapping("/invoiceView")
	public String invoiceView(Model model, HttpServletRequest request, Principal principal) {

		Base64.Decoder decoder = Base64.getDecoder();
		String invoiceNumber = new String(decoder.decode(request.getParameter("id")));
		String invoiceType = new String(decoder.decode(request.getParameter("type")));
		model.addAttribute("type", invoiceType);
		model.addAttribute("invoiceNumber", invoiceNumber);
		return "invoiceView";
	}

	@GetMapping("/draftInvoiceGenerate")
	public String draftInvoiceGenerate(Model model, HttpServletRequest request, Principal principal) {

		String vendorName = principal.getName();
		Base64.Decoder decoder = Base64.getDecoder();
		String invoiceNumber = new String(decoder.decode(request.getParameter("id")));

		model.addAttribute("maxFileSize", maxFileSize);
		model.addAttribute("fileSize", fileSize);
		model.addAttribute("invoiceNumber", invoiceNumber);

		List<TripDetails> list = serviceManager.tripDetailsRepo.getTripStatusIsDraftInvoicing(invoiceNumber,
				vendorName);

		List<Object> listofTrips = new ArrayList<>();

		for (TripDetails tripDetails : list) {
			String tripID = tripDetails.getTripID();
			listofTrips.add(tripID);
			vendorName = tripDetails.getVendorName();
		}
		String currentDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
		model.addAttribute("currentDate", currentDate);
		model.addAttribute("vendorName", vendorName);
		model.addAttribute("listofTrips", listofTrips);
		return "draftInvoiceGenerate";
	}

	@GetMapping("/changePassword")
	public String changePassword(Model model, HttpServletRequest request, Principal principal) {

		return "changePassword";
	}

	@GetMapping("/allInvoices_Finance")
	public String allInvoicesFinance(Model model, HttpServletRequest request, Principal principal) {
		String currentDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
		model.addAttribute("currentDate", currentDate);
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

		Base64.Decoder decoder = Base64.getDecoder();
		model.addAttribute("maxFileSize", maxFileSize);
		String invoiceNumber = new String(decoder.decode(request.getParameter("id")));
		String invoiceType = new String(decoder.decode(request.getParameter("type")));
		model.addAttribute("fileSize", fileSize);
		model.addAttribute("invoiceNumber", invoiceNumber);
		model.addAttribute("type", invoiceType);
		return "queryInvoiceEdit";
	}

	@GetMapping("/getDoc")

	void getDoc(HttpServletResponse response, HttpServletRequest request, @RequestParam("name") String name,
			@RequestParam("path") String path) {

		File file = null;
		FileInputStream inputStream = null;
		try {
			String[] docNameExtensionArray = name.split("\\.");
			String docNameExtension = docNameExtensionArray[docNameExtensionArray.length - 1];
			String uri = request.getScheme() + "://" + request.getServerName() + ":" + 
					request.getServerPort() + "/";

			file = new File(path);
			inputStream = new FileInputStream(file);
			response.setContentType("application/" + docNameExtension);

			response.setContentLength((int) file.length());
			response.setHeader("Content-Disposition", "inline;filename=\"" + name + "\"");
			response.setHeader("Content-Security-Policy", "frame-ancestors " + uri + " ");
			FileCopyUtils.copy(inputStream, response.getOutputStream());

		} catch (Exception e) {
			logger.error("error : " + e);

		} finally {
			try {
				if (null != inputStream)
					inputStream.close();
			} catch (IOException e) {
				logger.error("error : " + e);
			}
		}
	}

	@GetMapping("/dashboardRegistration")
	public String dashboardRegistration(Model model, HttpServletRequest request, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "dashboardRegistration";
	}

	@GetMapping("/vendorView")
	public String vendorView(Model model, HttpServletRequest request, Principal principal) {

		Base64.Decoder decoder = Base64.getDecoder();
		String pid = new String(decoder.decode(request.getParameter("pid")));
		String vendorType = new String(decoder.decode(request.getParameter("status")));
		model.addAttribute("vendorType", vendorType);
		model.addAttribute("pid", pid);
		return "vendorView";
	}

	@GetMapping("/vendorReports")
	public String vendorReports(Model model, HttpServletRequest request, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "vendorReports";
	}

	@GetMapping("/allOnBoardRequest")
	public String allOnBoardRequest(Model model, HttpServletRequest request, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "allOnBoardRequest";
	}

}
