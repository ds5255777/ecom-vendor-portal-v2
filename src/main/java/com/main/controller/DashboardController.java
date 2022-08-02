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
	public String invoiceLimit;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(DashboardController.class);

	@PostMapping({ "getDashboardDetails" })
	public String getDashBoardDetails(Principal principal, HttpSession session, HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
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
			logger.error(GlobalConstants.ERROR_MESSAGE , e);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping("/updateDetailsforNetwork")
	public String updateDetailsforNetwork(Model model, HttpServletRequest request, Principal principal,
			@RequestBody String agrn) {

		String rolename = (String) request.getSession().getAttribute("role");
		String userName = principal.getName();

		JSONObject jsonObject = new JSONObject(agrn);
		String processedon = jsonObject.get("processedOn").toString();
		String processedBy = jsonObject.getString("processedBy").toString();
		String tripid = jsonObject.get("tripID").toString();
		String AssigenedTo = jsonObject.get("AssigenedTo").toString();
		String LumpSomeCheckBox = "";
		String LumpSomeAmount = jsonObject.getString("LumpSomeAmount").toString();

		String fs = jsonObject.getString("fs").toString();
		String totalFreight = jsonObject.getString("totalFreight").toString();
		String basicFreight = jsonObject.getString("basicFreight").toString();
		String commentsByUSer = jsonObject.getString("commentsby").toString();
		String vendorName = jsonObject.getString("vendorName").toString();
		String vendorCode = jsonObject.getString("vendorCode").toString();
		String type = jsonObject.getString("type").toString();

		if ("".equalsIgnoreCase(LumpSomeAmount)) {
			LumpSomeCheckBox = "false";
		} else {
			LumpSomeCheckBox = "true";
		}

		if ("".equalsIgnoreCase(LumpSomeAmount)) {
			LumpSomeAmount = "0";
		}

		String Query = jsonObject.getString("Query").toString();
		if ("No".equalsIgnoreCase(Query)) {
			serviceManager.tripDetailsRepo.updateDetailsByNetwork(AssigenedTo, tripid, processedBy, processedon,
					LumpSomeCheckBox, LumpSomeAmount, "Yet To Be Approved", Double.parseDouble(basicFreight),
					Double.parseDouble(totalFreight), Double.parseDouble(fs), vendorName, vendorCode);
		} else {
			String standardKM = jsonObject.getString("standardKM").toString();
			String milage = jsonObject.getString("milage").toString();
			String ratePerKm = jsonObject.getString("ratePerKm").toString();
			String routeKms = jsonObject.getString("routeKms").toString();
			String fsBaseRate = jsonObject.getString("fsBaseRate").toString();
			String currentFuelRate = jsonObject.getString("currentFuelRate").toString();
			String fsDiff = jsonObject.getString("fsDiff").toString();

			try {
				serviceManager.tripDetailsRepo.updateDetailsByNetworkInQuery(tripid, processedBy, processedon,
						LumpSomeCheckBox, LumpSomeAmount, Double.parseDouble(standardKM), Double.parseDouble(milage),
						Double.parseDouble(ratePerKm), Double.parseDouble(routeKms), Double.parseDouble(fsBaseRate),
						Double.parseDouble(currentFuelRate), Double.parseDouble(fsDiff),
						Double.parseDouble(basicFreight), Double.parseDouble(totalFreight), Double.parseDouble(fs),
						vendorName, vendorCode);
			} catch (Exception ex) {
				logger.error("error : " + ex);
			}
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		DataContainer data = new DataContainer();
		data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		QueryEntity comm = new QueryEntity();
		comm.setRaisedBy(userName);

		try {
			Date date = new Date();
			comm.setRaisedOn(date);
		} catch (Exception ex) {
			logger.error("error : " + ex);
		}

		TripDetails obj = serviceManager.tripDetailsRepo.findByTripID(tripid);
		int id = obj.getId();

		comm.setRaisedAgainQuery(tripid);
		if ("Yes".equalsIgnoreCase(Query)) {
			comm.setComment("Values Repopulated from MDM");
		} else {
			comm.setComment(commentsByUSer);
		}

		comm.setReferenceid(tripid);
		comm.setRole(rolename);
		comm.setForeignKey(id);
		comm.setType(type);
		serviceManager.queryRepo.save(comm);

		return gson.toJson(data).toString();

	}

	@PostMapping({ "getFinanceDashBoardDetails" })
	public String getFinanceDashBoardDetails(HttpSession session, HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String rolename = (String) request.getSession().getAttribute("role");

		try {
			if (GlobalConstants.ROLE_FINANCE_HEAD.equalsIgnoreCase(rolename)) {
				List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getTopFiftyInvoice();
				List<InvoiceGenerationDto> listOfTopFiftyInvoice = allInvoice.stream().map(
						(listofTrip) -> this.serviceManager.modelMapper.map(listofTrip, InvoiceGenerationDto.class))
						.collect(Collectors.toList());
				data.setData(listOfTopFiftyInvoice);
			} else if (GlobalConstants.ROLE_FINANCE.equalsIgnoreCase(rolename)) {
				List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceGenerationEntityRepo
						.topFiftyInProcessedInvoice();
				List<InvoiceGenerationDto> listOfTopFiftyInvoice = allInvoice.stream().map(
						(listofTrip) -> this.serviceManager.modelMapper.map(listofTrip, InvoiceGenerationDto.class))
						.collect(Collectors.toList());
				data.setData(listOfTopFiftyInvoice);
			}
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE , e);
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "refreshValues" })
	public String refreshValues(Principal principal, @RequestBody String reqObj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			JSONObject jsonObject = new JSONObject(reqObj);
			String vendorCode = (String) jsonObject.get("vendorCode");//
			String route = (String) jsonObject.get("route");

			AgreementMaster masterData = serviceManager.agreementMasterRepo.getAllTripsByVendorCode(vendorCode, route);
			data.setData(masterData);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE , e);
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "getBpCodeForNetwork" })
	public String getBpCodeForNetwork(Principal principal, @RequestBody String reqObj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			JSONObject jsonObject = new JSONObject(reqObj);
			String vendorName = (String) jsonObject.get("vendorName");//
			data.setData(serviceManager.supDetailsRepo.getVendorCode(vendorName));
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			logger.error(GlobalConstants.ERROR_MESSAGE , e);
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
		}

		return gson.toJson(data).toString();
	}

}
