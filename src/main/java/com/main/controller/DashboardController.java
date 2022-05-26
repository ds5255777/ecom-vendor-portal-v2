package com.main.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
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
import com.main.serviceManager.ServiceManager;

@RequestMapping("/dashboardController")
@RestController
public class DashboardController {

	@Autowired
	private ServiceManager serviceManager;

	@Value("${tripLimit}")
	public String tripLimit;

	@RequestMapping({ "getDashboardDetails" })
	@CrossOrigin("*")
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
			e.printStackTrace();
			data.setMsg("error");
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping("/updateDetailsforNetwork")
	@CrossOrigin("*")
	public String updateDetailsforNetwork(Model model, Principal principal, @RequestBody String agrn) {

		System.out.println("************************Data is ::" + agrn);

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
		System.out.println("fs " + fs + "\ntotalFreight " + totalFreight + "\nbasicFreight " + basicFreight + ""
				+ "\ncommentsByUSer " + commentsByUSer+"vendorName : "+vendorName);

		if ("".equalsIgnoreCase(LumpSomeAmount)) {
			LumpSomeCheckBox = "false";
		} else {
			LumpSomeCheckBox = "true";
		}

		if ("".equalsIgnoreCase(LumpSomeAmount)) {
			LumpSomeAmount = "0";
		}

		System.out.println("processedon" + processedon);
		System.out.println("tripid" + tripid);
		System.out.println("processedBy" + processedBy);
		System.out.println("AssigenedTo" + AssigenedTo);
		System.out.println("LumpSomeCheckBox" + LumpSomeCheckBox);
		System.out.println("LumpSomeAmount" + LumpSomeAmount);
		

		String Query = jsonObject.getString("Query").toString();
		System.out.println("Query is :::" + Query);
		if ("No".equalsIgnoreCase(Query)) {
			serviceManager.tripDetailsRepo.updateDetailsByNetwork(AssigenedTo, tripid, processedBy, processedon,
					LumpSomeCheckBox, LumpSomeAmount, "Yet To Be Approved", Double.parseDouble(basicFreight),
					Double.parseDouble(totalFreight), Double.parseDouble(fs),vendorName,vendorCode);
		} else {
			String standardKM = jsonObject.getString("standardKM").toString();
			String milage = jsonObject.getString("milage").toString();
			String ratePerKm = jsonObject.getString("ratePerKm").toString();
			String routeKms = jsonObject.getString("routeKms").toString();
			String fsBaseRate = jsonObject.getString("fsBaseRate").toString();
			String currentFuelRate = jsonObject.getString("currentFuelRate").toString();
			String fsDiff = jsonObject.getString("fsDiff").toString();
			
			

			System.out.println("standardKM " + standardKM);
			System.out.println("milage " + milage);
			System.out.println("ratePerKm " + ratePerKm);
			System.out.println("routeKms " + routeKms);
			System.out.println("fsBaseRate " + fsBaseRate);
			System.out.println("currentFuelRate " + currentFuelRate);
			System.out.println("fsDiff " + standardKM);

			try {
				serviceManager.tripDetailsRepo.updateDetailsByNetworkInQuery(tripid, processedBy, processedon,
						LumpSomeCheckBox, LumpSomeAmount, Double.parseDouble(standardKM), Double.parseDouble(milage),
						Double.parseDouble(ratePerKm), Double.parseDouble(routeKms), Double.parseDouble(fsBaseRate),
						Double.parseDouble(currentFuelRate), Double.parseDouble(fsDiff),
						Double.parseDouble(basicFreight), Double.parseDouble(totalFreight) ,vendorName,vendorCode);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			System.out.println("***************************Query runned*******************");
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		DataContainer data = new DataContainer();
		data.setMsg("success");
		// System.out.println("Value of S si :"+s);

		QueryEntity comm = new QueryEntity();
		comm.setRaisedBy(processedBy);
		
		
		try {
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			Date date = new Date();
			System.out.println(formatter.format(date));
			comm.setRaisedOn(date);
		} catch (Exception ex) {
			ex.printStackTrace();
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
		comm.setForeignKey(id);
		comm.setType(type);
		serviceManager.queryRepo.save(comm);

		return gson.toJson(data).toString();

	}

	@RequestMapping({ "getFinanceDashBoardDetails" })
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
			e.printStackTrace();
			data.setMsg("error");
		}

		return gson.toJson(data).toString();
	}

	// RefreshVaues for Scheduled trips in case of updation in Agreenment Master
	@RequestMapping({ "refreshValues" })
	public String refreshValues(Principal principal, @RequestBody String reqObj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println("**********Inside refresh values********************");
		try {
			JSONObject jsonObject = new JSONObject(reqObj);
			String vendorCode = (String) jsonObject.get("vendorCode");//
			String route = (String) jsonObject.get("route");

			System.out.println("Vendor code ::" + vendorCode);
			System.out.println("route ::" + route);

			AgreementMaster masterData = serviceManager.agreementMasterRepo.getAllTripsByVendorCode(vendorCode, route);
			System.out.println("masterData ::" + masterData.getVendorName());
			data.setData(masterData);
			data.setMsg("success");

		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg("error");
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "getBpCodeForNetwork" })
	public String getBpCodeForNetwork(Principal principal, @RequestBody String reqObj) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println("**********Inside refresh values********************");
		try {
			JSONObject jsonObject = new JSONObject(reqObj);
			String vendorName = (String) jsonObject.get("vendorName");//
			
			System.out.println("vendorName ::" + vendorName);
			String vendorCodeFromSuppDetails =serviceManager.supDetailsRepo.getVendorCode(vendorName);
			System.out.println("vendor Code ::" + vendorCodeFromSuppDetails);
			data.setData(vendorCodeFromSuppDetails);
			data.setMsg("success");

		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg("error");
		}

		return gson.toJson(data).toString();
	}

	
	
	
}
