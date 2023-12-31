package com.main.controller;

import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.main.payloads.QueryEntityDTO;
import com.main.payloads.TripDetailsDto;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/tripControllers")
@RestController
public class TripControllers {

	@Autowired
	private ServiceManager serviceManager;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(TripControllers.class);

	@GetMapping({ "filterTripDetails" })

	public String filterTripDetails(Principal principal, @RequestParam(name = "actualDeparture") String fromDate,
			@RequestParam(name = "actualArrival") String toDate, @RequestParam(name = "vendorCode") String vendorCode) {

		logger.info("Log Some Information filterTripDetails ");

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		try {
			fromDate = fromDate.replace(",", "");

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {
				List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
						.findByActualDepartureBetweenOrderByTripIDDesc(fromDate, toDate);
				List<TripDetailsDto> collect = getListByDateFilter.stream()
						.map(filterList -> this.serviceManager.modelMapper.map(filterList, TripDetailsDto.class))
						.collect(Collectors.toList());
				long count = serviceManager.tripDetailsRepo.countByActualDepartureBetween(fromDate, toDate);
				data.setTotalRecord(count);
				data.setData(collect);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
				List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
						.findByVendorCodeAndActualDepartureBetweenOrderByTripIDDesc(userName, fromDate, toDate);
				List<TripDetailsDto> collect = getListByDateFilter.stream()
						.map(filterList -> this.serviceManager.modelMapper.map(filterList, TripDetailsDto.class))
						.collect(Collectors.toList());
				data.setData(collect);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getCloseTripsDetails" })

	public String getCloseTripsDetails(Principal principal) {
		DataContainer data = new DataContainer();
		String userName = principal.getName();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo
						.findByRunStatusIgnoreCaseAndVendorCodeOrderByIdDesc(GlobalConstants.RUN_CLOSED, userName);
				List<TripDetailsDto> closeTripList = allTripDetailsList.stream()
						.map(closeTrip -> this.serviceManager.modelMapper.map(closeTrip, TripDetailsDto.class))
						.collect(Collectors.toList());
				data.setData(closeTripList);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllTripsDetails" })

	public String getAllTripsDetails(Principal principal) {
		DataContainer data = new DataContainer();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {
			try {
				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo.findTopTrip();

				long count = serviceManager.tripDetailsRepo.count();
				data.setData(allTripDetailsList);
				data.setTotalRecord(count);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
			String vendorCode = principal.getName();
			try {
				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo
						.findByVendorCodeOrderByIdDesc(vendorCode);

				List<TripDetailsDto> listTrip = allTripDetailsList.stream()
						.map(trip -> this.serviceManager.modelMapper.map(trip, TripDetailsDto.class))
						.collect(Collectors.toList());
				data.setData(listTrip);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getCloseAndApprovedTripsDetails" })
	public String getCloseAndApprovedTripsDetails(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo
						.findByRunStatusIgnoreCaseAndVendorTripStatusAndVendorCodeOrderByIdDesc(
								GlobalConstants.RUN_CLOSED, GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, userName);
				List<TripDetailsDto> closeAndTripList = allTripDetailsList.stream()
						.map(closeAndApproveTrip -> this.serviceManager.modelMapper.map(closeAndApproveTrip,
								TripDetailsDto.class))
						.collect(Collectors.toList());
				data.setData(closeAndTripList);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getInTransitTripsDetails" })

	public String getInTransitTripsDetails(Principal principal) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

				List<String> runStatusList = new ArrayList<>();
				runStatusList.add("CLOSED");
				runStatusList.add("Closed");
				runStatusList.add("closed");
				runStatusList.add("CANCELLED");
				runStatusList.add("cancelled");
				runStatusList.add("Cancelled");

				// findByAgeNotIn(Collection<Age> ages)

				// .findByVendorTripStatusAndAssignToAndVendorCodeAndRunStatusInOrderByIdDesc(
				// findByVendorCodeAndRunStatusNotInOrderByIdDesc(userName, runStatusList)

				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo
						.findByVendorCodeAndRunStatusNotInOrderByIdDesc(userName, runStatusList);
				List<TripDetailsDto> inTransitTripList = allTripDetailsList.stream()
						.map(inTransitTrip -> this.serviceManager.modelMapper.map(inTransitTrip, TripDetailsDto.class))
						.collect(Collectors.toList());
				data.setData(inTransitTripList);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping(value = "/status")

	public String statusNetwork(Principal principal, @RequestBody TripDetailsDto obj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		try {

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {
				String runStatus = obj.getRunStatus();
				String vendortripStatus = obj.getVendorTripStatus();
				String paymentStatus = obj.getPaymentStatus();

				List<TripDetails> tripFindByStatus = serviceManager.tripService.getTripsByFiltersNetwork(runStatus,
						vendortripStatus, paymentStatus);
				List<TripDetailsDto> tripFilterList = tripFindByStatus.stream()
						.map(filterTrip -> this.serviceManager.modelMapper.map(filterTrip, TripDetailsDto.class))
						.collect(Collectors.toList());
				data.setData(tripFilterList);
			} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

				String runStatus = obj.getRunStatus();
				String vendortripStatus = obj.getVendorTripStatus();
				String paymentStatus = obj.getPaymentStatus();
				String vendorCode = obj.getVendorCode();
				if (vendorCode.equalsIgnoreCase(userName)) {
					List<TripDetails> tripFindByStatus = serviceManager.tripService.getTripsByFilters(runStatus,
							vendortripStatus, paymentStatus, vendorCode);
					List<TripDetailsDto> tripFilterList = tripFindByStatus.stream()
							.map(filterTrip -> this.serviceManager.modelMapper.map(filterTrip, TripDetailsDto.class))
							.collect(Collectors.toList());
					data.setData(tripFilterList);
				}
			}
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/updateVendorTripStatusAndOpenCloseReadingByTripId" })
	public String getApprovTripsDetails(Principal principal, HttpServletRequest request,
			@Valid @RequestBody TripDetailsDto tripDtoObj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String processedOn = dateFormat.format(date);

		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		String openingReading = tripDtoObj.getOpeningReading();
		String closingReading = tripDtoObj.getClosingReading();

		openingReading = openingReading.replaceAll("[^a-zA-Z0-9]", " ");
		closingReading = closingReading.replaceAll("[^a-zA-Z0-9]", " ");
		try {
			if ((rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR))
					&& (tripDtoObj.getVendorCode().equals(userName))) {

				this.serviceManager.modelMapper.map(tripDtoObj, TripDetails.class);

				serviceManager.tripDetailsRepo.updateVendorTripStatusByTripId(tripDtoObj.getTripID(),
						GlobalConstants.APPROVED_REQUEST_STATUS, openingReading, closingReading, userName, processedOn);

				List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository
						.findByIsActive(GlobalConstants.ACTIVE_STATUS);
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
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getPendingApprovelTripsDetails" })

	public String getPendingApprovelTripsDetails(Principal principal) {

		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

				List<TripDetails> pendingApprovalTrip = serviceManager.tripDetailsRepo
						.findByVendorTripStatusAndRunStatusIgnoreCaseAndAssignToAndVendorCodeOrderByIdDesc(
								GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED, GlobalConstants.RUN_CLOSED,
								GlobalConstants.ROLE_VENDOR, userName);
				List<TripDetailsDto> pendingApprovalTripList = pendingApprovalTrip.stream()
						.map(pendingApprovalList -> this.serviceManager.modelMapper.map(pendingApprovalList,
								TripDetailsDto.class))
						.collect(Collectors.toList());

				data.setData(pendingApprovalTripList);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

			}
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/tripDetailByTripId" })
	public String getTripsDetailsByTripId(Principal principal, @RequestBody TripDetailsDto tripDtoObj) {

		DataContainer data = new DataContainer();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)
					|| rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
				TripDetails tripDtoToEntity = this.serviceManager.modelMapper.map(tripDtoObj, TripDetails.class);

				data.setData(serviceManager.tripDetailsRepo.findByTripID(tripDtoToEntity.getTripID()));
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getRemarksByRefID" })
	public String getRemarksByRefID(Principal principal, @RequestBody String obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			JSONObject jsonObject = new JSONObject(obj);
			String tripID = jsonObject.optString("tripID");
			List<QueryEntity> qe = serviceManager.queryRepo.findCommentsByRefID(tripID);
			List<QueryEntityDTO> queryList = qe.stream()
					.map(listQuery -> this.serviceManager.modelMapper.map(listQuery, QueryEntityDTO.class))
					.collect(Collectors.toList());

			data.setData(queryList);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getDraftLineTripDetails" })

	public String getDraftLineTripDetails(Principal principal, @RequestBody TripDetailsDto tripDtoObj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

				String invoiceNumber = tripDtoObj.getInvoiceNumber();
				List<TripDetails> tripList = serviceManager.tripDetailsRepo.getTripStatusIsDraftInvoicing(invoiceNumber,
						userName);

				List<TripDetailsDto> invoiceTripDetails = tripList.stream()
						.map(draftLineTripList -> this.serviceManager.modelMapper.map(draftLineTripList,
								TripDetailsDto.class))
						.collect(Collectors.toList());

				data.setData(invoiceTripDetails);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getTripDetailByTripId" })
	public String getTripDetailByTripId(Principal principal, HttpSession session) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String vendorCode = principal.getName();
		try {

			List<String> list = serviceManager.tripDetailsRepo.getTripId(vendorCode);

			data.setData(list);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);

	}

	@PostMapping({ "/findByTripDetailUsingTripID" })
	public String findByTripDetailUsingTripID(Principal principal, @RequestBody TripDetailsDto tripDtoObj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			String tripID = tripDtoObj.getTripID();
			String invoiceNumber = tripDtoObj.getInvoiceNumber();

			serviceManager.tripDetailsRepo.findTripDetailAgainTripID(invoiceNumber, tripID);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);

	}

	@GetMapping({ "/filterByColumn" })

	public String filterByColumn(Principal principal, @RequestParam(name = "columnName") String columnName,
			@RequestParam(name = "columnValue") String columnValue,
			@RequestParam(name = "tripStatus") String tripStatus,
			@RequestParam(name = "vendorCode") String vendorCode) {

		logger.info("Log Some Information filterByColumn ");

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			if (tripStatus.equals(GlobalConstants.VENDOR_TRIP_STATUS_APPROVED)) {

				if (columnName.equals("route")) {
					List<String> routeList = Arrays.asList(columnValue.split(","));
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByRouteInAndVendorTripStatusAndVendorCodeAndRunStatusIgnoreCase(routeList,
									GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode,
									GlobalConstants.RUN_CLOSED);
					List<TripDetailsDto> filterByRoute = getListByDateFilter.stream().map(
							filterInRoot -> this.serviceManager.modelMapper.map(filterInRoot, TripDetailsDto.class))
							.collect(Collectors.toList());
					data.setData(filterByRoute);
				} else if (columnName.equals("origin_hub")) {
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByOriginHubAndVendorTripStatusAndVendorCode(columnValue,
									GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode);
					List<TripDetailsDto> filterByRoute = getListByDateFilter.stream().map(
							filterInRoot -> this.serviceManager.modelMapper.map(filterInRoot, TripDetailsDto.class))
							.collect(Collectors.toList());
					data.setData(filterByRoute);
				} else if (columnName.equals("dest_hub")) {
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByDestHubAndVendorTripStatusAndVendorCode(columnValue,
									GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode);
					List<TripDetailsDto> filterByRoute = getListByDateFilter.stream().map(
							filterInRoot -> this.serviceManager.modelMapper.map(filterInRoot, TripDetailsDto.class))
							.collect(Collectors.toList());
					data.setData(filterByRoute);
				} else if (columnName.equals("run_type")) {
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByRunTypeAndVendorTripStatusAndVendorCode(columnValue,
									GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode);
					List<TripDetailsDto> filterByRoute = getListByDateFilter.stream().map(
							filterInRoot -> this.serviceManager.modelMapper.map(filterInRoot, TripDetailsDto.class))
							.collect(Collectors.toList());
					data.setData(filterByRoute);
				} else if (columnName.equals("vehicle_number")) {
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByVehicleNumberAndVendorTripStatusAndVendorCodeAndRunStatusIgnoreCase(columnValue,
									GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode,
									GlobalConstants.RUN_CLOSED);
					List<TripDetailsDto> filterByRoute = getListByDateFilter.stream().map(
							filterInRoot -> this.serviceManager.modelMapper.map(filterInRoot, TripDetailsDto.class))
							.collect(Collectors.toList());
					data.setData(filterByRoute);
				}
			} else if (tripStatus.equals(GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED)) {

				if (columnName.equals("route")) {
					List<String> routeList = Arrays.asList(columnValue.split(","));
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByRouteInAndVendorTripStatusAndVendorCodeAndRunStatusIgnoreCase(routeList,
									GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED, vendorCode,
									GlobalConstants.RUN_CLOSED);
					List<TripDetailsDto> filterByRoute = getListByDateFilter.stream().map(
							filterInRoot -> this.serviceManager.modelMapper.map(filterInRoot, TripDetailsDto.class))
							.collect(Collectors.toList());
					data.setData(filterByRoute);
				} else if (columnName.equals("vehicle_number")) {
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByVehicleNumberAndVendorTripStatusAndVendorCodeAndRunStatusIgnoreCase(columnValue,
									GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED, vendorCode,
									GlobalConstants.RUN_CLOSED);
					List<TripDetailsDto> filterByRoute = getListByDateFilter.stream().map(
							filterInRoot -> this.serviceManager.modelMapper.map(filterInRoot, TripDetailsDto.class))
							.collect(Collectors.toList());
					data.setData(filterByRoute);
				}

			}
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@GetMapping({ "multipleTripApproved" })
	public String multipleTripApproved(Principal principal, @RequestParam("tripID") String obj,
			@RequestParam("vendorTripStatus") String vendorTripStatus) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String processedBy = principal.getName();
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String processedOn = dateFormat.format(date);
		try {
			List<String> myList = new ArrayList<>(Arrays.asList(obj.split(",")));

			serviceManager.tripDetailsRepo.getUpdateStatusSelectTrips(processedBy, processedOn,
					GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, myList);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setData(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "getApprovedAdhocTrips" })
	public String approvedAdhocTrips(Principal principal) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			List<TripDetails> approvedTrips = serviceManager.tripService
					.findAllTripsByStatus(GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED);
			List<TripDetailsDto> collect = approvedTrips.stream()
					.map(filterList -> this.serviceManager.modelMapper.map(filterList, TripDetailsDto.class))
					.collect(Collectors.toList());
			data.setData(collect);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "getQueryTrips" })
	public String queryTrips(Principal principal) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {

			/*
			 * List<TripDetails> approvedTrips = serviceManager.tripDetailsRepo
			 * .getQueryTripsForNetwork(GlobalConstants.VENDOR_TRIP_STATUS_QUERY);
			 * 
			 * List<TripDetailsDto> collect = approvedTrips.stream() .map(filterList ->
			 * this.serviceManager.modelMapper.map(filterList, TripDetailsDto.class))
			 * .collect(Collectors.toList());
			 * 
			 * List<TripDetails> collect = approvedTrips.stream()
			 * .sorted(Comparator.comparingInt(TripDetails::getId).reversed()).collect(
			 * Collectors.toList()); data.setData(collect);
			 * data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			 */
			try {
				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo
						.findTop100ByVendorTripStatusOrderByIdDesc(GlobalConstants.VENDOR_TRIP_STATUS_QUERY);

				long count = serviceManager.tripDetailsRepo
						.countByVendorTripStatus(GlobalConstants.VENDOR_TRIP_STATUS_QUERY);
				data.setData(allTripDetailsList);
				data.setTotalRecord(count);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}

		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "getClosedAdhocTrips" })
	public String closedAdhocTrips(Principal principal) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			List<TripDetails> approvedTrips = serviceManager.tripService.getInTransitTripByRunTypeAndRunStatus(
					GlobalConstants.ADHOC_TYPE_TRIPS, GlobalConstants.RUN_CLOSED);
			List<TripDetailsDto> collect = approvedTrips.stream()
					.map(filterList -> this.serviceManager.modelMapper.map(filterList, TripDetailsDto.class))
					.collect(Collectors.toList());
			data.setData(collect);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "getPendingAdhocTrips" })
	public String pendingAdhocTrips(Principal principal) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			/*
			 * List<TripDetails> approvedTrips =
			 * serviceManager.tripService.findAllTripsByStatus(""); List<TripDetails>
			 * collect = approvedTrips.stream()
			 * .sorted(Comparator.comparingInt(TripDetails::getId).reversed()).collect(
			 * Collectors.toList());
			 * 
			 * List<TripDetailsDto> collect = approvedTrips.stream() .map(filterList ->
			 * this.serviceManager.modelMapper.map(filterList, TripDetailsDto.class))
			 * .collect(Collectors.toList());
			 * 
			 * data.setData(collect); data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			 */

			try {
				List<TripDetails> allTripDetailsList = serviceManager.tripService.findAllTripsByStatus("");

				long count = serviceManager.tripDetailsRepo
						.countByVendorTripStatusAndAssignToAndRunTypeAndRunStatusIgnoreCase(
								GlobalConstants.NETWORK_TRIP_STATUS_YET_TO_APPROVED_NETWORK,
								GlobalConstants.ROLE_NETWORK, GlobalConstants.ADHOC_TYPE_TRIPS,
								GlobalConstants.RUN_CLOSED);
				data.setData(allTripDetailsList);
				data.setTotalRecord(count);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}

		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping("/getPaginationDataOfVendor")
	public String getPaginationDataOfVendor(@RequestBody TripDetailsDto obj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {

			Integer dataSize = 100;

			Integer fetchCount = obj.getId();
			fetchCount = fetchCount - 1;
			fetchCount = fetchCount * dataSize;

			List<TripDetails> vendorList = serviceManager.tripDetailsRepo.getTripDataByPagination(fetchCount, dataSize);
			long count = serviceManager.tripDetailsRepo.count();
			data.setData(vendorList);
			data.setTotalRecord(count);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@PostMapping("/getPaginationDataOfQueryTrip")
	public String getPaginationDataOfQueryTrip(@RequestBody TripDetailsDto obj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {

			Integer dataSize = 100;

			Integer fetchCount = obj.getId();
			fetchCount = fetchCount - 1;
			fetchCount = fetchCount * dataSize;

			List<TripDetails> vendorList = serviceManager.tripDetailsRepo.getQueryTripDataByPagination(fetchCount,
					dataSize);
			long count = serviceManager.tripDetailsRepo
					.countByVendorTripStatus(GlobalConstants.VENDOR_TRIP_STATUS_QUERY);
			data.setData(vendorList);
			data.setTotalRecord(count);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@PostMapping("/getPaginationPendingApproval")
	public String getPaginationPendingApproval(@RequestBody TripDetailsDto obj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {

			Integer dataSize = 100;

			Integer fetchCount = obj.getId();
			fetchCount = fetchCount - 1;
			fetchCount = fetchCount * dataSize;

			List<TripDetails> vendorList = serviceManager.tripDetailsRepo.getPendingApprovalDataByPagination(fetchCount,
					dataSize);
			long count = serviceManager.tripDetailsRepo
					.countByVendorTripStatusAndAssignToAndRunTypeAndRunStatusIgnoreCase(
							GlobalConstants.NETWORK_TRIP_STATUS_YET_TO_APPROVED_NETWORK, GlobalConstants.ROLE_NETWORK,
							GlobalConstants.ADHOC_TYPE_TRIPS, GlobalConstants.RUN_CLOSED);

			data.setData(vendorList);
			data.setTotalRecord(count);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data);
	}

	@GetMapping({ "/getAllSearchRecord" })
	public String getAllApproveInvoice(@RequestParam(name = "tripId") String tripId,
			@RequestParam(name = "pageName") String pageName) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			if (pageName.equalsIgnoreCase("pendingApproval")) {
				logger.info("pendingApproval for trip search");
				List<TripDetails> tripDetails = serviceManager.tripDetailsRepo
						.findTop100ByVendorTripStatusAndAssignToAndRunTypeAndRunStatusIgnoreCaseAndTripIDContaining(
								GlobalConstants.NETWORK_TRIP_STATUS_YET_TO_APPROVED_NETWORK,
								GlobalConstants.VENDOR_NETWORK, GlobalConstants.ADHOC_TYPE_TRIPS,
								GlobalConstants.RUN_CLOSED, tripId);
				// List<String> tripIdList =
				// tripDetails.stream().map(TripDetails::getTripID).collect(Collectors.toList());
				data.setData(tripDetails);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else if (pageName.equalsIgnoreCase("queryTrips")) {
				logger.info("queryTrips for trip search");
				List<TripDetails> filterDetails = serviceManager.tripDetailsRepo
						.findTop100ByVendorTripStatusAndTripIDContaining(GlobalConstants.VENDOR_TRIP_STATUS_QUERY,
								tripId);
				data.setData(filterDetails);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

			}
		} catch (Exception e) {
			logger.error("Trip not getting :::: {}", e);
		}

		return gson.toJson(data).toString();
	}

	@GetMapping({ "filterDetails" })
	public String filterDetails(Principal principal, @RequestParam(name = "actualDeparture") String fromDate,
			@RequestParam(name = "actualArrival") String toDate, @RequestParam(name = "pageName") String pageName) {
		logger.info("Log Some Information filterTripDetails ");
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {

				if (pageName.equalsIgnoreCase("pendingApproval")) {
					logger.info("pendingApproval for date wise search");
					List<TripDetails> filterDetails = serviceManager.tripDetailsRepo
							.findByActualDepartureBetweenAndVendorTripStatusAndAssignToAndRunTypeAndRunStatusIgnoreCaseOrderByIdDesc(
									fromDate, toDate, GlobalConstants.NETWORK_TRIP_STATUS_YET_TO_APPROVED_NETWORK,
									GlobalConstants.VENDOR_NETWORK, GlobalConstants.ADHOC_TYPE_TRIPS,
									GlobalConstants.RUN_CLOSED);
					data.setData(filterDetails);
					data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				} else if (pageName.equalsIgnoreCase("queryTrips")) {
					logger.info("queryTrips  for date wise search");
					List<TripDetails> filterDetails = serviceManager.tripDetailsRepo
							.findByActualDepartureBetweenAndVendorTripStatusOrderByIdDesc(fromDate, toDate,
									GlobalConstants.VENDOR_TRIP_STATUS_QUERY);
					data.setData(filterDetails);
					data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

				} else {
					logger.info("queryTrips  wrong perameter");
					data.setMsg(GlobalConstants.ERROR_MESSAGE);
				}

			}
		} catch (Exception e) {
			logger.error("Trip not getting :::: {}", e);
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
		}

		return gson.toJson(data);
	}

}