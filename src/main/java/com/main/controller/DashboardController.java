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
import com.main.db.JdbcConnection;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.repo.InvoiceGenerationEntityRepo;
import com.main.db.bpaas.repo.QueryRepo;
import com.main.db.bpaas.repo.TripDetailsRepo;
import com.main.service.InvoiceServiceImpl;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/dashboardController")
@RestController
public class DashboardController {

	@Value("${dataLimit}")
	public String dataLimit;

	@Autowired
	ServiceManager serviceManager;

	@Autowired
	JdbcConnection dbconnection;

	@Autowired
	TripDetailsRepo tripDetailsRepo;

	@Autowired
	QueryRepo queryRepo;
	
	@Autowired
	private InvoiceGenerationEntityRepo invoiceGenerationEntityRepo;

	@Autowired
	InvoiceServiceImpl invoiceServiceImpl;

	@RequestMapping({ "getDashboardDetails" })
	@CrossOrigin("*")
	public String getDashBoardDetails(@RequestBody TripDetails reqObj, HttpSession session,
			HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String vendorCode = request.getSession().getAttribute("userName").toString();
		try {
			List<TripDetails> topTripRecods = tripDetailsRepo.getTopTripRecods(vendorCode, Integer.parseInt(dataLimit));

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

		String fs = jsonObject.getString("fs").toString();
		String totalFreight = jsonObject.getString("totalFreight").toString();
		String basicFreight = jsonObject.getString("basicFreight").toString();
		String commentsByUSer = jsonObject.getString("commentsby").toString();

		System.out.println("fs " + fs + "\ntotalFreight " + totalFreight + "\nbasicFreight " + basicFreight + ""
				+ "\ncommentsByUSer " + commentsByUSer);

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

		tripDetailsRepo.updateDetailsByNetwork(AssigenedTo, tripid, processedBy, processedon, LumpSomeCheckBox,
				LumpSomeAmount, "Yet To Be Approved");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		DataContainer data = new DataContainer();
		data.setMsg("success");

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
		TripDetails obj = tripDetailsRepo.findByTripID(tripid);
		int id = (int) obj.getId();

		comm.setReferenceid(tripid);
		comm.setComment(commentsByUSer);
		queryRepo.save(comm);
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
				List<InvoiceGenerationEntity> allInvoice = invoiceServiceImpl.getTopFiftyInvoice();
				data.setData(allInvoice);
			} else {
				List<InvoiceGenerationEntity> allInvoice = invoiceGenerationEntityRepo.topFiftyInProcessedInvoice();
				data.setData(allInvoice);
			}
			data.setMsg("success");

		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg("error");
		}

		return gson.toJson(data).toString();
	}

}
