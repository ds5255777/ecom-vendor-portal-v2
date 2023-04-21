package com.main.controller;

import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.AgreementMaster;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.TripDetails;
import com.main.payloads.InvoiceGenerationDto;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/dashboardController")
@RestController
public class DashboardController {

	@Autowired
	private ServiceManager serviceManager;

	@Value("${tripLimit}")
	private String invoiceLimit;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(DashboardController.class);

	@PostMapping({ "getDashboardDetails" })
	public String getDetails(Principal principal, HttpSession session, HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

				List<Object[]> topInvoiceRecords = serviceManager.invoiceGenerationEntityRepo
						.getTopInvoiceRecords(userName, Integer.parseInt(invoiceLimit));

				List<InvoiceGenerationEntity> invoice = new ArrayList<>();

				for (Object[] objects : topInvoiceRecords) {
					InvoiceGenerationEntity sdt = new InvoiceGenerationEntity();
					if (null != objects[0]) {
						sdt.setEcomInvoiceNumber(objects[0].toString());
					}
					if (null != objects[1]) {
						sdt.setInvoiceReceivingDate(objects[1].toString());
					}
					if (null != objects[2]) {
						sdt.setInvoiceNumber(objects[2].toString());
					}
					if (null != objects[3]) {
						sdt.setInvoiceAmount(objects[3].toString());
					}
					if (null != objects[4]) {
						sdt.setInvoiceStatus(objects[4].toString());
					}

					invoice.add(sdt);
				}

				data.setData(invoice);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping("/updateDetailsforNetwork")
	public String updateDetailsforNetwork(Model model, HttpServletRequest request, Principal principal,
			@RequestBody String agrn) {

		String rolename = (String) request.getSession().getAttribute("role");
		String userName = principal.getName();

		JSONObject jsonObject = new JSONObject(agrn);
		String processedon = jsonObject.optString("processedOn");
		String processedBy = jsonObject.optString("processedBy");
		String tripid = jsonObject.optString("tripID");
		String assigenedTo = jsonObject.optString("AssigenedTo");
		String lumpSomeCheckBox = "";
		String lumpSomeAmount = jsonObject.optString("LumpSomeAmount");

		String fs = jsonObject.optString("fs");
		String totalFreight = jsonObject.optString("totalFreight");
		String basicFreight = jsonObject.optString("basicFreight");
		String commentsByUSer = jsonObject.optString("commentsby");
		String vendorName = jsonObject.optString("vendorName");
		String vendorCode = jsonObject.optString("vendorCode");
		String type = jsonObject.optString("type");

		if ("".equalsIgnoreCase(lumpSomeAmount)) {
			lumpSomeCheckBox = "false";
		} else {
			lumpSomeCheckBox = "true";
		}

		if ("".equalsIgnoreCase(lumpSomeAmount)) {
			lumpSomeAmount = "0";
		}

		String query = jsonObject.optString("Query");
		if ("No".equalsIgnoreCase(query)) {
			serviceManager.tripDetailsRepo.updateDetailsByNetwork(assigenedTo, tripid, processedBy, processedon,
					lumpSomeCheckBox, lumpSomeAmount, "Yet To Be Approved", Double.parseDouble(basicFreight),
					Double.parseDouble(totalFreight), Double.parseDouble(fs), vendorName, vendorCode);
		} else {
			String standardKM = jsonObject.optString("standardKM");
			String milage = jsonObject.optString("milage");
			String ratePerKm = jsonObject.optString("ratePerKm");
			String routeKms = jsonObject.optString("routeKms");
			String fsBaseRate = jsonObject.optString("fsBaseRate");
			String currentFuelRate = jsonObject.optString("currentFuelRate");
			String fsDiff = jsonObject.optString("fsDiff");

			try {
				serviceManager.tripDetailsRepo.updateDetailsByNetworkInQuery(tripid, processedBy, processedon,
						lumpSomeCheckBox, lumpSomeAmount, Double.parseDouble(standardKM), Double.parseDouble(milage),
						Double.parseDouble(ratePerKm), Double.parseDouble(routeKms), Double.parseDouble(fsBaseRate),
						Double.parseDouble(currentFuelRate), Double.parseDouble(fsDiff),
						Double.parseDouble(basicFreight), Double.parseDouble(totalFreight), Double.parseDouble(fs),
						vendorName, vendorCode);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		DataContainer data = new DataContainer();
		data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		QueryEntity comm = new QueryEntity();
		comm.setRaisedBy(userName);

		try {
			Date date = new Date();
			comm.setRaisedOn(date);
		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		TripDetails obj = serviceManager.tripDetailsRepo.findByTripID(tripid);
		int id = obj.getId();

		comm.setRaisedAgainQuery(tripid);
		if ("Yes".equalsIgnoreCase(query)) {
			comm.setComment("Values Repopulated from MDM");
		} else {
			comm.setComment(commentsByUSer);
		}

		comm.setReferenceid(tripid);
		comm.setRole(rolename);
		comm.setForeignKey(id);
		comm.setType(type);
		serviceManager.queryRepo.save(comm);

		return gson.toJson(data);

	}

	@PostMapping({ "getFinanceDashBoardDetails" })
	public String getFinanceDashBoardDetails(HttpSession session, HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String rolename = (String) request.getSession().getAttribute("role");

		try {
			if (GlobalConstants.ROLE_FINANCE_HEAD.equalsIgnoreCase(rolename)) {
				List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getTopFiftyInvoice();
				List<InvoiceGenerationDto> listOfTopFiftyInvoice = allInvoice.stream()
						.map(listofTrip -> this.serviceManager.modelMapper.map(listofTrip, InvoiceGenerationDto.class))
						.collect(Collectors.toList());
				data.setData(listOfTopFiftyInvoice);
			} else if (GlobalConstants.ROLE_FINANCE.equalsIgnoreCase(rolename)) {
				List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceGenerationEntityRepo
						.topFiftyInProcessedInvoice();
				List<InvoiceGenerationDto> listOfTopFiftyInvoice = allInvoice.stream()
						.map(listofTrip -> this.serviceManager.modelMapper.map(listofTrip, InvoiceGenerationDto.class))
						.collect(Collectors.toList());
				data.setData(listOfTopFiftyInvoice);
			}
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "refreshValues" })
	public String refreshValues(Principal principal, @RequestBody String reqObj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			JSONObject jsonObject = new JSONObject(reqObj);
			String vendorCode = jsonObject.optString("vendorCode");
			String route = jsonObject.optString("route");

			AgreementMaster masterData = serviceManager.agreementMasterRepo.getAllTripsByVendorCode(vendorCode, route);

			if (null != masterData) {
				data.setData(masterData);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
			}
		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "getBpCodeForNetwork" })
	public String getBpCodeForNetwork(Principal principal, @RequestBody String reqObj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			JSONObject jsonObject = new JSONObject(reqObj);
			String vendorName = jsonObject.optString("vendorName");
			String vendorCode = serviceManager.supDetailsRepo.getVendorCode(vendorName);
			System.out.println(vendorCode);
			data.setData(serviceManager.supDetailsRepo.getVendorCode(vendorName));
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
		}

		return gson.toJson(data);
	}

}
