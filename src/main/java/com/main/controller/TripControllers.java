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
import com.main.payloads.InvoiceGenerationDto;
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

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_NETWORK)) {
				List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
						.findByActualDepartureBetween(fromDate, toDate);
				List<TripDetailsDto> collect = getListByDateFilter.stream()
						.map(filterList -> this.serviceManager.modelMapper.map(filterList, TripDetailsDto.class))
						.collect(Collectors.toList());
				data.setData(collect);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
				List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
						.findByVendorCodeAndActualDepartureBetween(userName, fromDate, toDate);
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
						.findByRunStatusAndVendorCode(GlobalConstants.RUN_CLOSED, userName);
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
				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo.findAll();
				List<TripDetailsDto> listTrip = allTripDetailsList.stream()
						.map(allTrip -> this.serviceManager.modelMapper.map(allTrip, TripDetailsDto.class))
						.collect(Collectors.toList());
				data.setData(listTrip);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
			String vendorCode = principal.getName();
			try {
				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo.findByVendorCode(vendorCode);
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
						.findByRunStatusAndVendorTripStatusAndVendorCode(GlobalConstants.RUN_CLOSED,
								GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, userName);
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

				List<TripDetails> allTripDetailsList = serviceManager.tripDetailsRepo
						.findByRunStatusAndVendorCode(GlobalConstants.RUN_IN_TRANSIT, userName);
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
				String runStatus = obj.getRunStatus().toString();
				String vendortripStatus = obj.getVendorTripStatus().toString();
				String paymentStatus = obj.getPaymentStatus().toString();

				List<TripDetails> tripFindByStatus = serviceManager.tripService.getTripsByFiltersNetwork(runStatus,
						vendortripStatus, paymentStatus);
				List<TripDetailsDto> tripFilterList = tripFindByStatus.stream()
						.map(filterTrip -> this.serviceManager.modelMapper.map(filterTrip, TripDetailsDto.class))
						.collect(Collectors.toList());
				data.setData(tripFilterList);
			} else if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

				String runStatus = obj.getRunStatus().toString();
				String vendortripStatus = obj.getVendorTripStatus().toString();
				String paymentStatus = obj.getPaymentStatus().toString();
				String vendorCode = obj.getVendorCode().toString();
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
			@RequestBody TripDetailsDto tripDtoObj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String processedOn = dateFormat.format(date);

		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if ((rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR))
					&& (tripDtoObj.getVendorCode().equals(userName))) {

				this.serviceManager.modelMapper.map(tripDtoObj, TripDetails.class);

				serviceManager.tripDetailsRepo.updateVendorTripStatusByTripId(tripDtoObj.getTripID(),
						tripDtoObj.getVendorTripStatus(), tripDtoObj.getOpeningReading(),
						tripDtoObj.getClosingReading(), userName, processedOn);

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
						.findByVendorTripStatusAndRunStatusAndAssignToAndVendorCode(
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
			String tripID = jsonObject.get("tripID").toString();
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

			List<InvoiceGenerationDto> draftInvoice = list.stream()
					.map(draftinvoiceList -> this.serviceManager.modelMapper.map(draftinvoiceList,
							InvoiceGenerationDto.class))
					.collect(Collectors.toList());
			data.setData(draftInvoice);
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
							.findByRouteInAndVendorTripStatusAndVendorCode(routeList,
									GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode);
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
							.findByVehicleNumberAndVendorTripStatusAndVendorCode(columnValue,
									GlobalConstants.VENDOR_TRIP_STATUS_APPROVED, vendorCode);
					List<TripDetailsDto> filterByRoute = getListByDateFilter.stream().map(
							filterInRoot -> this.serviceManager.modelMapper.map(filterInRoot, TripDetailsDto.class))
							.collect(Collectors.toList());
					data.setData(filterByRoute);
				}
			} else if (tripStatus.equals(GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED)) {

				if (columnName.equals("route")) {
					List<String> routeList = Arrays.asList(columnValue.split(","));
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByRouteInAndVendorTripStatusAndVendorCode(routeList,
									GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED, vendorCode);
					List<TripDetailsDto> filterByRoute = getListByDateFilter.stream().map(
							filterInRoot -> this.serviceManager.modelMapper.map(filterInRoot, TripDetailsDto.class))
							.collect(Collectors.toList());
					data.setData(filterByRoute);
				} else if (columnName.equals("vehicle_number")) {
					List<TripDetails> getListByDateFilter = serviceManager.tripDetailsRepo
							.findByVehicleNumberAndVendorTripStatusAndVendorCode(columnValue,
									GlobalConstants.VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED, vendorCode);
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

			serviceManager.tripDetailsRepo.getUpdateStatusSelectTrips(processedBy, processedOn, vendorTripStatus,
					myList);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setData(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}
}
