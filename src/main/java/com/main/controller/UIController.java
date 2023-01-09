package com.main.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
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
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.main.db.bpaas.entity.AddressDetails;
import com.main.db.bpaas.entity.Document;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.InvoiceNumber;
import com.main.db.bpaas.entity.RolesEntity;
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.entity.User;
import com.main.servicemanager.ServiceManager;

@Controller
public class UIController {

	@Value("${maxFileSize}")
	public String maxFileSize;

	@Value("${fileSize}")
	public String fileSize;

	@Value("${dataLimit}")
	public String dataLimit;

	@Value("${zipFileLocation}")
	public String zipFileLocation;

	@Value("${linkExpireTimeInHours}")
	public Integer linkExpireTimeInHours;

	@Value("${spring.profiles.active}")
	public String profile;

	@Autowired
	private ServiceManager serviceManager;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(UIController.class);

	@GetMapping({ "/login" })
	public String login(Model model, Principal principal, String error, String logout, HttpServletRequest request) {
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
		logger.info(" vendor Email registartion >>>>>>>>>> {}", vendorEmail);
		Integer flag1 = 0;
		try {
			if (!"".equalsIgnoreCase(vendorEmail)) {
				String flag = request.getParameter("flag");
				logger.info(" Flag >>>>>>>>>> {}", flag);
				flag1 = Integer.valueOf(flag);
				logger.info(" Flag1 >>>>>>>>>> {}", flag1);
				String processOn = serviceManager.sendEmailToVendorRepo.processOn(flag1);
				Date date1 = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(processOn);
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date1);
				calendar.add(Calendar.HOUR_OF_DAY, linkExpireTimeInHours);
				Date expiryDate = calendar.getTime();
				logger.info(" expiryDate >>>>>>>>>> {}", expiryDate);
				if (expiryDate.before(new Date())) {
					response.setContentType("text/html");
					PrintWriter pwriter = response.getWriter();
					pwriter.println(
							"<font color=red>Link Expired! Please Contact With Administrator And Try Again...</font>");
					pwriter.close();
				}
			}
		} catch (NumberFormatException e1) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e1);
		} catch (ParseException e1) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e1);
		} catch (IOException e1) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e1);
		}
		String vendorType1 = new String(decoder.decode(request.getParameter("vendorType")));
		String[] strSplit = vendorType1.split(",");
		ArrayList<String> vendorType2 = new ArrayList<>(Arrays.asList(strSplit));
		String region1 = new String(decoder.decode(request.getParameter("resgion")));
		String creditTerms = new String(decoder.decode(request.getParameter("creditTerms")));
		String processBy = new String(decoder.decode(request.getParameter("processBy")));
		String processByEmailId = new String(decoder.decode(request.getParameter("processByEmailId")));

		logger.info(" Vendor email  {}", vendorEmail);
		logger.info(" Vendor Type 2 {}", vendorType2);
		logger.info(" Vendor region1 {}", region1);
		logger.info(" Vendor creditTerms {}", creditTerms);
		logger.info(" Vendor processBy {}", processBy);
		logger.info(" Vendor processByEmailId {}", processByEmailId);
		try {
			List<SupDetails> findAll = serviceManager.supDetailsRepo.findAll();
			for (int i = 0; i < findAll.size(); i++) {
				String vendorExitingEmail = null;
				for (int j = 0; j < findAll.get(i).getContactDetails().size(); j++) {
					if (null != findAll.get(i).getContactDetails().get(j).getConEmail())
						vendorExitingEmail = findAll.get(i).getContactDetails().get(j).getConEmail();
				}
				if (null != vendorExitingEmail) {
					System.out.println("Mail Id is :" + findAll.get(i).getContactDetails().get(0).getConEmail());

					if (vendorExitingEmail.equalsIgnoreCase(vendorEmail)) {
						String venStatus = findAll.get(i).getVenStatus();
						System.out.println("Vendor Status ::: " + venStatus);
						if (!venStatus.equalsIgnoreCase(GlobalConstants.REJECTED_REQUEST_STATUS)) {

							response.setContentType("text/html");
							PrintWriter pwriter = response.getWriter();
							pwriter.println(
									"<font color=red>Vendor Already Exists ! Please Contact With Administrator And Try Again...</font>");
							pwriter.close();
						}

					}
				}
			}
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		model.addAttribute("vendorEmail", vendorEmail);
		model.addAttribute("vendorType2", vendorType2);
		model.addAttribute("region1", region1);
		model.addAttribute("creditTerms", creditTerms);
		model.addAttribute("processBy", processBy);
		model.addAttribute("processByEmailId", processByEmailId);
		model.addAttribute("commercialFlag", flag1);

		String pid = "";
		try {
			pid = request.getParameter("pid");
		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
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
		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {
			long allTripCount = serviceManager.tripDetailsRepo.count();
			model.addAttribute("totalTripCount", allTripCount);
			Integer allApprovedTripscount = serviceManager.tripDetailsRepo.countByVendorTripStatusAndAssignToAndRunType(
					GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED, GlobalConstants.ROLE_VENDOR,
					GlobalConstants.ADHOC_TYPE_TRIPS);
			model.addAttribute("ApprovedTripscount", allApprovedTripscount);
			Integer yetTobeApproved = serviceManager.tripDetailsRepo
					.countByVendorTripStatusAndAssignToAndRunTypeAndRunStatusIgnoreCase(
							GlobalConstants.NETWORK_TRIP_STATUS_YET_TO_APPROVED_NETWORK, GlobalConstants.ROLE_NETWORK,
							GlobalConstants.ADHOC_TYPE_TRIPS, GlobalConstants.RUN_CLOSED);
			model.addAttribute("yetTobeApproved", yetTobeApproved);
			Integer getTripCountForQueryAdhoc = serviceManager.tripDetailsRepo
					.countByVendorTripStatus(GlobalConstants.QUERY_REQUEST_STATUS);
			model.addAttribute("getTripCountForQueryAdhoc", getTripCountForQueryAdhoc);

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
			int totalCloseTripCount = serviceManager.tripDetailsRepo.getCloseTripCount();
			int totalInTransitTripCount = serviceManager.tripDetailsRepo.getInTransitTripCount();
			model.addAttribute("totalTripCount", totalTripCount);
			model.addAttribute("TotalCloseTripCount", totalCloseTripCount);
			model.addAttribute("TotalInTransitTripCount", totalInTransitTripCount);

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
			model.addAttribute("userStatus", us.getStatus());
			model.addAttribute("inReviewInvoice", inReviewInvoice);
			model.addAttribute("countForPendingForApprovalInvoice", countForPendingForApprovalInvoice);
			model.addAttribute("countForApprovedInvoice", countForApprovedInvoice);
			model.addAttribute("countForPaymentrelaseInvoice", countForPaymentrelaseInvoice);
			model.addAttribute("queryCount", queryCount);
			model.addAttribute("role", rolename);
			return "dashBoard_Finance";
		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
			String bpCode = us.getBpCode();
			String username = us.getUsername();
			String name = principal.getName();

			if (bpCode.equalsIgnoreCase(name) && username.equalsIgnoreCase(name)) {
				SupDetails vendorDetails = serviceManager.supDetailsRepo.findBybpCode(bpCode);

				String vendorType = null;
				if (null != vendorDetails) {
					List<AddressDetails> addressDetails = vendorDetails.getAddressDetails();
					for (int i = 0; i < addressDetails.size(); i++) {
						vendorType = addressDetails.get(i).getVendorType();
					}
				}
				if (null != vendorType) {
					if (vendorType.equalsIgnoreCase(GlobalConstants.VENDOR_NETWORK)) {

						int totalTripCount = serviceManager.tripDetailsRepo.getTripCount(bpCode);
						int totalCloseTripCount = serviceManager.invoiceGenerationEntityRepo
								.getQueryInvoiceCount(bpCode);
						int totalInTransitTripCount = serviceManager.tripDetailsRepo.getInTransitTripCount(bpCode);
						int closedTripCount = serviceManager.tripDetailsRepo.getCloseTripCount(bpCode);
						int queryTripCount = serviceManager.tripDetailsRepo.getQueryTripCount(bpCode);

						long processInvoice = serviceManager.invoiceGenerationEntityRepo.getPendingInvoiceCount(bpCode);
						int approveInvoice = serviceManager.invoiceGenerationEntityRepo.getApproveInvoiceCount(bpCode);
						int draftInvoice = serviceManager.invoiceGenerationEntityRepo.getDraftInvoiceCount(bpCode);

						model.addAttribute("role", rolename);
						model.addAttribute("totalTripCount", totalTripCount);
						model.addAttribute("TotalCloseTripCount", totalCloseTripCount);
						model.addAttribute("TotalInTransitTripCount", totalInTransitTripCount);
						model.addAttribute("pendingInvoice", processInvoice);
						model.addAttribute("approveInvoice", approveInvoice);
						model.addAttribute("draftInvoice", draftInvoice);
						model.addAttribute("userStatus", us.getStatus());
						model.addAttribute("closedTripCount", closedTripCount);
						model.addAttribute("queryTripCount", queryTripCount);

						request.setAttribute("vendorType", vendorType);
						model.addAttribute("vendorType", vendorType);
						model.addAttribute("role", rolename);

						return "dashboard";

					} else if (vendorType.equalsIgnoreCase(GlobalConstants.VENDOR_FIXED_ASSETS)) {

						int totalAllPoCount = serviceManager.podetailsRepo.getAllPoCount(bpCode);
						model.addAttribute("totalAllPoCount", totalAllPoCount);

						int totalProcessPoCount = serviceManager.podetailsRepo.getAllProcessPoCount(bpCode);
						model.addAttribute("totalProcessPoCount", totalProcessPoCount);
						int totalUnprocessPOCount = serviceManager.podetailsRepo.getAllUnProcessPoCount(bpCode);
						model.addAttribute("totalUnprocessPOCount", totalUnprocessPOCount);
						int totalQueryCount = serviceManager.podetailsRepo.getAllQueryCount(bpCode);
						model.addAttribute("totalQueryCount", totalQueryCount);

						int totalInvoiceCount = serviceManager.poinvoiceRepo.getAllInvoiceCount(bpCode);
						model.addAttribute("totalInvoiceCount", totalInvoiceCount);

						int allPOcount = serviceManager.poinvoiceRepo.getAllPOcount(bpCode);
						model.addAttribute("allPOcount", allPOcount);

						int totalDraftInvoiceCount = serviceManager.poinvoiceRepo.getTotalDraftInvoiceCount(bpCode);
						model.addAttribute("totalDraftInvoiceCount", totalDraftInvoiceCount);

						model.addAttribute("userStatus", us.getStatus());
						model.addAttribute("dataLimit", dataLimit);
						request.setAttribute("vendorType", vendorType);
						model.addAttribute("vendorType", vendorType);

						return "dashboard_Po";

					} else {

						return "poInvoiceDetails";
					}

				}
			}

		} else if (rolename.equalsIgnoreCase("Audit")) {
			return "";
		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {
			Integer pendingRequest = serviceManager.supDetailsRepo
					.countByVenStatus(GlobalConstants.PENDING_REQUEST_STATUS);
			Integer approvedRequest = serviceManager.supDetailsRepo.countByVenStatusIn();
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
			List<String> payment = serviceManager.paymentTermRepo.getPaymentTerms();
			model.addAttribute("region", region);
			model.addAttribute("payment", payment);
			model.addAttribute("vendorType", vendorType1);
			return "triggerEmail";
		}

		return "";

	}

	@GetMapping({ "/addUsers" })
	public String addUsers(Model model, Principal principal, String error, String logout, HttpServletRequest request) {
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {

			List<RolesEntity> roleList = serviceManager.rolesRepository.findByIsActive(GlobalConstants.ACTIVE_STATUS);
			List<RolesEntity> role = serviceManager.rolesRepository
					.findByIsActiveAndRoleNameNot(GlobalConstants.ACTIVE_STATUS, GlobalConstants.ROLE_VENDOR);
			model.addAttribute("rolesList", roleList);
			model.addAttribute("role", role);

			model.addAttribute("uname", userName);
			model.addAttribute("dataLimit", dataLimit);

			return "addUsers";

		}
		return "error";

	}

	@GetMapping({ "/emailConfig" })
	public String emailConfig(Model model, Principal principal, String error, String logout,
			HttpServletRequest request) {
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {
			return "emailConfig";
		}
		return "error";
	}

	@GetMapping({ "/triggerEmail" })
	public String triggerEmail(Model model, Principal principal, String error, String logout,
			HttpServletRequest request) {

		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {
			List<String> vendorType = serviceManager.businessPartnerTypeRepo.getBusinessPartnerType();
			List<String> region = serviceManager.regionRepo.getRegion();

			model.addAttribute("region", region);
			model.addAttribute("vendorType", vendorType);
			return "triggerEmail";
		}
		return "error";

	}

	@GetMapping("/allTrips")
	public String allTrips(Model model, Principal principal, HttpServletRequest request) {
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		String currentDate = new SimpleDateFormat(GlobalConstants.DATE_FORMATTER_DD_MM_YYYY).format(new Date());
		model.addAttribute("currentDate", currentDate);
		model.addAttribute("dataLimit", dataLimit);

		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {
			return "allTripsNetwork";
		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
			return "allTrips";
		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {
			return "allTrips";
		}
		return "error";
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

		if ((rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN))
				|| (rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE))) {
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
		model.addAttribute("dataLimit", dataLimit);

		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)
				|| rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

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
		String uname = principal.getName();

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
		String userMailId = serviceManager.userRepository.getUserMailId(uname);

		model.addAttribute("uname", uname);
		model.addAttribute("userMailId", userMailId);

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

		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)
				|| rolename.equalsIgnoreCase(GlobalConstants.ROLE_CCOMMERCIAL_TEAM)) {

			return "vendorRegistrastion";

		}
		return "error";
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
		/*
		 * List<TripDetails> yetTobeApproved =
		 * serviceManager.tripService.findAllTripsByStatus(""); List<String>
		 * vendorNamefortrips = serviceManager.tripDetailsRepo.getVendorName();
		 * model.addAttribute("vendorNamefortrips", vendorNamefortrips);
		 * model.addAttribute("yetTobeApprovedAllDetails", yetTobeApproved);
		 */
		model.addAttribute("dataLimit", dataLimit);
		return "pendingApprovalNetwork";
	}

	@GetMapping("/getApprovedAdhocTrips")
	public String getApprovedAdhocTrips(Model model, Principal principal) {
		/*
		 * List<TripDetails> allApprovedTripscount =
		 * serviceManager.tripService.findAllTripsByStatus("Yet To Be Approved");
		 * model.addAttribute("ApprovedAllDetailsForNetwork", allApprovedTripscount);
		 * model.addAttribute("dataLimit", dataLimit);
		 */
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

		return "ClosedAdhoc";
	}

	public synchronized String generateInvoiceNumber() {

		long count = serviceManager.invoiceNumberRepo.count();
		String invoiceNumberPrefix = "ECOM-";
		count = count + 1;
		return invoiceNumberPrefix + String.format("%08d", count);
	}

	@GetMapping("/tripsInvoiceGenerate")
	public String tripsInvoiceGenerate(Principal principal, HttpServletRequest request, Model model) {

		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
			String invoiceNumber = "";

			invoiceNumber = generateInvoiceNumber();

			InvoiceNumber inNumber = new InvoiceNumber();
			inNumber.setEcomInvoiceNumber(invoiceNumber);
			inNumber.setStatus("Used_Trip_Invoice");
			serviceManager.invoiceNumberRepo.save(inNumber);

			model.addAttribute("invoiceNumber", invoiceNumber);
			request.getSession().setAttribute("invoiceNumber", invoiceNumber);

			String eInvoiceStatus = serviceManager.supDetailsRepo.getEInvoiceStatusByVendorCode(userName);
			model.addAttribute("eInvoiceStatus", eInvoiceStatus);

			Base64.Decoder decoder = Base64.getDecoder();

			String tripId = new String(decoder.decode(request.getParameter("id")));
			model.addAttribute("maxFileSize", maxFileSize);
			model.addAttribute("fileSize", fileSize);
			model.addAttribute("tripId", tripId);
			model.addAttribute("userName", userName);

			String tripUpdateId = tripId;
			tripUpdateId = tripUpdateId.replace(",", " ");

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
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}

			List<TripDetails> list = serviceManager.tripDetailsRepo.getTripStatusIsDraftInvoicing(invoiceNumber,
					userName);
			List<Object> listofTrips = new ArrayList<>();
			for (TripDetails tripDetails : list) {
				String tripID = tripDetails.getTripID();
				listofTrips.add(tripID);

			}
			String currentDate = new SimpleDateFormat(GlobalConstants.DATE_FORMATTER_DD_MM_YYYY).format(new Date());
			model.addAttribute("currentDate", currentDate);
			model.addAttribute("listofTrips", listofTrips);

			return "draftInvoiceGenerate";
		}
		return "error";
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
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(vendorName);
		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

			Base64.Decoder decoder = Base64.getDecoder();
			String invoiceNumber = new String(decoder.decode(request.getParameter("id")));
			String eInvoiceStatus = serviceManager.supDetailsRepo.getEInvoiceStatusByVendorCode(vendorName);

			model.addAttribute("maxFileSize", maxFileSize);
			model.addAttribute("fileSize", fileSize);
			model.addAttribute("invoiceNumber", invoiceNumber);
			model.addAttribute("eInvoiceStatus", eInvoiceStatus);

			List<TripDetails> list = serviceManager.tripDetailsRepo.getTripStatusIsDraftInvoicing(invoiceNumber,
					vendorName);

			List<Object> listofTrips = new ArrayList<>();

			for (TripDetails tripDetails : list) {
				String tripID = tripDetails.getTripID();
				listofTrips.add(tripID);
				vendorName = tripDetails.getVendorName();
			}
			String currentDate = new SimpleDateFormat(GlobalConstants.DATE_FORMATTER_DD_MM_YYYY).format(new Date());
			model.addAttribute("currentDate", currentDate);
			model.addAttribute("vendorName", vendorName);
			model.addAttribute("listofTrips", listofTrips);
			return "draftInvoiceGenerate";
		}
		return "error";
	}

	@GetMapping("/changePassword")
	public String changePassword(Model model, HttpServletRequest request, Principal principal) {

		return "changePassword";
	}

	@GetMapping("/allInvoices_Finance")
	public String allInvoicesFinance(Model model, HttpServletRequest request, Principal principal) {
		String currentDate = new SimpleDateFormat(GlobalConstants.DATE_FORMATTER_DD_MM_YYYY).format(new Date());
		model.addAttribute("currentDate", currentDate);
		model.addAttribute("dataLimit", dataLimit);
		return "allInvoices_Finance";
	}

	@GetMapping("/invoiceViewFinance")
	public String invoiceViewFinance(Model model, HttpServletRequest request, Principal principal) {
		String ecomInvoiceNumber = request.getParameter("id");
		String invoiceType = request.getParameter("type");
		model.addAttribute("ecomInvoiceNumber", ecomInvoiceNumber);
		model.addAttribute("type", invoiceType);
		return "invoiceViewFinance";
	}

	@GetMapping("/processInvoiceFinance")
	public String processInvoiceFinance(Model model, HttpServletRequest request, Principal principal) {
		model.addAttribute("dataLimit", dataLimit);
		return "processInvoiceFinance";
	}

	@GetMapping("/InProcessInvoiceFinance")
	public String inProcessInvoiceFinance(Model model, HttpServletRequest request, Principal principal) {
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

		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

			Base64.Decoder decoder = Base64.getDecoder();
			model.addAttribute("maxFileSize", maxFileSize);
			String invoiceNumber = new String(decoder.decode(request.getParameter("id")));
			String invoiceType = new String(decoder.decode(request.getParameter("type")));
			model.addAttribute("fileSize", fileSize);
			model.addAttribute("invoiceNumber", invoiceNumber);
			model.addAttribute("type", invoiceType);
			return "queryInvoiceEdit";
		}
		return "error";
	}

	@GetMapping("/getDoc")

	void getDoc(HttpServletResponse response, HttpServletRequest request, @RequestParam("name") String name,
			@RequestParam("path") String path) throws IOException {

		File file = new File(path);
		try (FileInputStream inputStream = new FileInputStream(file)) {
			String[] docNameExtensionArray = name.split("\\.");
			String docNameExtension = docNameExtensionArray[docNameExtensionArray.length - 1];
			String uri = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";

			response.setContentType("application/" + docNameExtension);

			response.setContentLength((int) file.length());
			response.setHeader("Content-Disposition", "inline;filename=\"" + name + "\"");
			response.setHeader("Content-Security-Policy", "frame-ancestors " + uri + " ");
			FileCopyUtils.copy(inputStream, response.getOutputStream());

		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
	}

	@GetMapping("/dashboardRegistration")
	public String dashboardRegistration(Model model, HttpServletRequest request, Principal principal) {
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

			model.addAttribute("dataLimit", dataLimit);
			return "dashboardRegistration";
		}
		return "error";
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

	@GetMapping("/invoiceVendor")
	public String invoiceVendor(Model model, HttpServletRequest request, Principal principal) {

		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

			SupDetails vendorDetails = serviceManager.supDetailsRepo.findBybpCode(userName);

			if (null != vendorDetails) {

				if (vendorDetails.getAddressDetails().get(0).getVendorType()
						.equalsIgnoreCase(GlobalConstants.VENDOR_NETWORK)
						&& vendorDetails.getAddressDetails().get(0).getVendorType()
								.equalsIgnoreCase(GlobalConstants.VENDOR_FIXED_ASSETS)) {

					return "error";
				}

				String invoiceNumber = "";
				invoiceNumber = generateInvoiceNumber();
				InvoiceNumber inNumber = new InvoiceNumber();
				inNumber.setEcomInvoiceNumber(invoiceNumber);
				inNumber.setStatus("Used_Other_Ven_Invoice");
				serviceManager.invoiceNumberRepo.save(inNumber);
				model.addAttribute("invoiceNumber", invoiceNumber);

				List<String> listSiteCode = new ArrayList<>();
				for (int i = 0; i < vendorDetails.getAddressDetails().size(); i++) {
					String supplierSiteCode = vendorDetails.getAddressDetails().get(i).getSupplierSiteCode();
					listSiteCode.add(supplierSiteCode);
				}
				model.addAttribute("supplierSiteCode", listSiteCode);

				List<String> venAccNumber = new ArrayList<>();
				for (int i = 0; i < vendorDetails.getAccountDetails().size(); i++) {
					String accNumber = vendorDetails.getAccountDetails().get(i).getAccoutNumber();
					venAccNumber.add(accNumber);
				}
				model.addAttribute("accountNumber", venAccNumber);

				model.addAttribute("vendorCode", vendorDetails.getBpCode());

				model.addAttribute("creidtTerms", vendorDetails.getCreditTerms());

				model.addAttribute("paymentMethod", vendorDetails.getPaymentMethod());

				model.addAttribute("fileSize", fileSize);

				return "invoiceVendor";
			}
		}
		return "error";
	}

	@GetMapping("/users")
	public String users(Model model, HttpServletRequest request, Principal principal) {

		return "error";
	}

	@GetMapping("/users/**")
	public String usersError(Model model, HttpServletRequest request, Principal principal) {

		return "error";
	}

	@GetMapping("/downloadZip")
	void downloadDoc(HttpServletResponse response, HttpServletRequest request,
			@RequestParam("vendorCode") String vendorCode) {
		try {
			String uri = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
			File zipfolder = new File(zipFileLocation);
			if (!zipfolder.exists()) {
				zipfolder.mkdirs();
			}
			String zipFile = zipFileLocation + "/" + new SimpleDateFormat("yyyy-MM-ddHHmmssSSS").format(new Date())
					+ ".zip";

			SupDetails vendorDetails = serviceManager.supDetailsRepo.findBybpCode(vendorCode);

			String pid = vendorDetails.getPid();

			List<Document> docListObj = serviceManager.documentRepo.findByForeignKeyAndType(vendorDetails.getPid(),
					GlobalConstants.SET_TYPE_REGISTRATION);

			tryForZip(zipFile, docListObj, pid);
			File file = new File(zipFile);
			if (file.exists()) {
				tryForZipDwnld(file, response, uri);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void tryForZip(String zipFile, List<Document> docListObj, String parentDirName) {
		try (FileOutputStream fos = new FileOutputStream(zipFile); ZipOutputStream zos = new ZipOutputStream(fos);) {
			if (!docListObj.isEmpty()) {
				System.out.println(docListObj.size());
				for (int i = 0; i < docListObj.size(); i++) {
					/*
					 * List<String> filePath =
					 * serviceManager.documentRepo.getPathByForeignKeyAndTypeAndStatus(
					 * parentDirName, GlobalConstants.ACTIVE_STATUS,
					 * GlobalConstants.SET_TYPE_REGISTRATION);
					 */
					// SfilePath=docListObj.get(i).getDocPath();

					zipWholeDirectory(zos, new File(docListObj.get(i).getDocPath()), parentDirName);

				}
			}
			zos.flush();
			fos.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void tryForZipDwnld(File file, HttpServletResponse response, String uri) {
		try (FileInputStream inputStream = new FileInputStream(file);) {
			response.setContentType("application/.zip");
			response.setContentLength((int) file.length());
			response.setHeader("Content-Disposition", "inline;filename=\"" + file.getName() + "\"");
			response.setHeader("Content-Security-Policy", "frame-ancestors " + uri + " ");
			FileCopyUtils.copy(inputStream, response.getOutputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void zipWholeDirectory(ZipOutputStream zos, File fileToZip, String parentDirectoryName) throws Exception {
		if (fileToZip == null || !fileToZip.exists()) {
			return;
		}
		String zipEntryName = parentDirectoryName;
		// If we are dealing with a directory:
		if (fileToZip.isDirectory()) {
			if (parentDirectoryName == null) // if parentDirectory is null, that means it's the first iteration of the
												// recursion, so we do not include the first container folder
			{
				zipEntryName = "";
			}
			for (File file : fileToZip.listFiles()) // we iterate over all the folders/files and archive them by keeping
													// the structure too.
			{
				zipWholeDirectory(zos, file, zipEntryName);
			}
		} else {
			single(zos, fileToZip, zipEntryName);
		}
	}

	public void single(ZipOutputStream zos, File fileToZip, String parentDirectoryName) throws IOException {
		File fileToBeZipped = new File(fileToZip.getAbsolutePath());
		try (FileInputStream fis = new FileInputStream(fileToBeZipped);) {
			byte[] buffer = new byte[1024];
			zos.putNextEntry(new ZipEntry(
					GlobalConstants.SET_TYPE_REGISTRATION + "/" + parentDirectoryName + "/" + fileToZip.getName()));
			int length;
			while ((length = fis.read(buffer)) > 0) {
				zos.write(buffer, 0, length);
			}
			zos.closeEntry();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
