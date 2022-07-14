package com.main.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
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
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.entity.TripDetails;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/dashboardController")
@RestController
public class DashboardController {

	@Autowired
	private ServiceManager serviceManager;

	@Value("${tripLimit}")
	public String tripLimit;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(DashboardController.class);

	@PostMapping({ "getDashboardDetails" })

	public String getDashBoardDetails(@RequestBody TripDetails reqObj, HttpSession session,
			HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String vendorCode = request.getSession().getAttribute("userName").toString();
		try {
			List<TripDetails> topTripRecods = serviceManager.tripDetailsRepo.getTopTripRecods(vendorCode,
					Integer.parseInt(tripLimit));

			data.setData(topTripRecods);
			data.setMsg("success");

		} catch (Exception e) {
			logger.error("error : " + e);
			data.setMsg("error");
		}

		return gson.toJson(data).toString();
	}

	@PostMapping("/updateDetailsforNetwork")
	@CrossOrigin("*")
	public String updateDetailsforNetwork(Model model, HttpServletRequest request, Principal principal,
			@RequestBody String agrn) {

		logger.info("************************Data is ::" + agrn);
		String rolename = (String) request.getSession().getAttribute("role");
		String userName = principal.getName();

		JSONObject jsonObject = new JSONObject(agrn);
		String processedon = jsonObject.get("processedOn").toString();
		String processedBy = jsonObject.getString("processedBy").toString();
		String tripid = jsonObject.get("tripID").toString();
		String AssigenedTo = jsonObject.get("AssigenedTo").toString();
		String LumpSomeCheckBox = "";
		String LumpSomeAmount = jsonObject.getString("LumpSomeAmount").toString();

//fs
//totalFreight
//basicFreight
		String fs = jsonObject.getString("fs").toString();
		String totalFreight = jsonObject.getString("totalFreight").toString();
		String basicFreight = jsonObject.getString("basicFreight").toString();
		String commentsByUSer = jsonObject.getString("commentsby").toString();
		String vendorName = jsonObject.getString("vendorName").toString();
		String vendorCode = jsonObject.getString("vendorCode").toString();
		String type = jsonObject.getString("type").toString();

///
		logger.info("fs " + fs + "\ntotalFreight " + totalFreight + "\nbasicFreight " + basicFreight + ""
				+ "\ncommentsByUSer " + commentsByUSer + "vendorName : " + vendorName);

		if ("".equalsIgnoreCase(LumpSomeAmount)) {
			LumpSomeCheckBox = "false";
		} else {
			LumpSomeCheckBox = "true";
		}

		if ("".equalsIgnoreCase(LumpSomeAmount)) {
			LumpSomeAmount = "0";
		}

		logger.info("processedon" + processedon);
		logger.info("tripid" + tripid);
		logger.info("processedBy" + processedBy);
		logger.info("AssigenedTo" + AssigenedTo);
		logger.info("LumpSomeCheckBox" + LumpSomeCheckBox);
		logger.info("LumpSomeAmount" + LumpSomeAmount);

		String Query = jsonObject.getString("Query").toString();
		logger.info("Query is :::" + Query);
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

			logger.info("standardKM " + standardKM);
			logger.info("milage " + milage);
			logger.info("ratePerKm " + ratePerKm);
			logger.info("routeKms " + routeKms);
			logger.info("fsBaseRate " + fsBaseRate);
			logger.info("currentFuelRate " + currentFuelRate);
			logger.info("fsDiff " + standardKM);

			try {
				serviceManager.tripDetailsRepo.updateDetailsByNetworkInQuery(tripid, processedBy, processedon,
						LumpSomeCheckBox, LumpSomeAmount, Double.parseDouble(standardKM), Double.parseDouble(milage),
						Double.parseDouble(ratePerKm), Double.parseDouble(routeKms), Double.parseDouble(fsBaseRate),
						Double.parseDouble(currentFuelRate), Double.parseDouble(fsDiff),
						Double.parseDouble(basicFreight), Double.parseDouble(totalFreight), Double.parseDouble(fs),
						vendorName, vendorCode);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			logger.info("***************************Query runned*******************");
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		DataContainer data = new DataContainer();
		data.setMsg("success");
		// System.out.println("Value of S si :"+s);

		QueryEntity comm = new QueryEntity();
		comm.setRaisedBy(userName);

		try {
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			Date date = new Date();
			logger.info(formatter.format(date));
			comm.setRaisedOn(date);
		} catch (Exception ex) {
			logger.error("error : " + ex);
		}

//Find ID on the basic of tripid
		TripDetails obj = serviceManager.tripDetailsRepo.findByTripID(tripid);
		int id = (int) obj.getId();

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
	@CrossOrigin("*")
	public String getFinanceDashBoardDetails(HttpSession session, HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String rolename = (String) request.getSession().getAttribute("role");

		try {
			if (GlobalConstants.ROLE_FINANCE_HEAD.equalsIgnoreCase(rolename)) {
				List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceServiceImpl.getTopFiftyInvoice();
				data.setData(allInvoice);
			} else {
				List<InvoiceGenerationEntity> allInvoice = serviceManager.invoiceGenerationEntityRepo
						.topFiftyInProcessedInvoice();
				data.setData(allInvoice);
			}
			data.setMsg("success");

		} catch (Exception e) {
			logger.error("error : " + e);
			data.setMsg("error");
		}

		return gson.toJson(data).toString();
	}

	// RefreshVaues for Scheduled trips in case of updation in Agreenment Master
	@PostMapping({ "refreshValues" })
	public String refreshValues(Principal principal, @RequestBody String reqObj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		logger.info("**********Inside refresh values********************");
		try {
			JSONObject jsonObject = new JSONObject(reqObj);
			String vendorCode = (String) jsonObject.get("vendorCode");//
			String route = (String) jsonObject.get("route");

			logger.info("Vendor code ::" + vendorCode);
			logger.info("route ::" + route);

			AgreementMaster masterData = serviceManager.agreementMasterRepo.getAllTripsByVendorCode(vendorCode, route);
			//logger.info("masterData ::" + masterData.getVendorName());
			data.setData(masterData);
			data.setMsg("success");

		} catch (Exception e) {
			logger.error("error : " + e);
			e.printStackTrace();
			data.setMsg("error");
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "getBpCodeForNetwork" })
	public String getBpCodeForNetwork(Principal principal, @RequestBody String reqObj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		logger.info("**********Inside refresh values********************");
		try {
			JSONObject jsonObject = new JSONObject(reqObj);
			String vendorName = (String) jsonObject.get("vendorName");//

			logger.info("vendorName ::" + vendorName);
			String vendorCodeFromSuppDetails = serviceManager.supDetailsRepo.getVendorCode(vendorName);
			logger.info("vendor Code ::" + vendorCodeFromSuppDetails);
			data.setData(vendorCodeFromSuppDetails);
			data.setMsg("success");

		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg("error");
		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "getAllVendors" })
	public List<SupDetails> getAllVendors(Principal principal, HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			//String role = (String) request.getSession().getAttribute("Role");

			//if (role.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {
				//List<SupDetails> findAllVendors = serviceManager.supDetailsRepo.allVendorData();

				//data.setData(findAllVendors);
			//}
			data.setMsg("success");

		} catch (Exception e) {
			logger.error("error : " + e);
			data.setMsg("error");
		}

		return serviceManager.supDetailsRepo.allVendorData();
	}

	/*
	 * @RequestMapping({ "findVendorCodeAndName" }) public String
	 * findVendorCodeAndName(Principal principal, @RequestBody String reqObj) {
	 * DataContainer data = new DataContainer(); Gson gson = new
	 * GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create(); try { JSONObject
	 * jsonObject = new JSONObject(reqObj); String vendorName = (String)
	 * jsonObject.get("vendorName");// Object findByVendorCodeVendorName =
	 * serviceManager.userRepository.getVendorCodeVendorNameById(vendorName);
	 * data.setData(findByVendorCodeVendorName); data.setMsg("success"); } catch
	 * (Exception e) { e.printStackTrace(); data.setMsg("error"); }
	 * 
	 * return gson.toJson(data).toString(); }
	 */

}
