package com.main.controller;




import java.security.Principal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.PoDetails;
import com.main.db.bpaas.entity.PoInvoiceDetails;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.repo.PoDetailsRepo;
import com.main.db.bpaas.repo.PoInvoiceRepo;
import com.main.db.bpaas.repo.QueryRepo;



@RequestMapping("/poController")
@RestController
public class PoController {

	
	@Autowired 
	PoDetailsRepo podetailsRepo;
	@Autowired
	PoInvoiceRepo poInvoiceRepo;
	
	@Autowired
	QueryRepo  queryRepo;
	
	@RequestMapping({ "/getAllPODetails" })
	@CrossOrigin("*")
	public String getActiveMasterData(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<PoDetails> allPoDetails =podetailsRepo.findAll();
			
			data.setData(allPoDetails);
			data.setMsg("success");
			System.out.println("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/poDetailsByPoNo" })
	@CrossOrigin("*")
	public String poDetailsByPoNo(HttpServletRequest request ,@RequestBody PoDetails details) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
			details = podetailsRepo.findByPoNo(details.getPoNo());
			
			data.setData(details);
			data.setMsg("success");
			System.out.println("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	
	@RequestMapping({ "/getAllProcessPo" })
	@CrossOrigin("*")
	public String getAllProcessPo(HttpServletRequest request ) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
			List<PoDetails> details = podetailsRepo.getAllProcessPo(vendorCode);
			
			data.setData(details);
			data.setMsg("success");
			System.out.println("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	
	@RequestMapping({ "/getAllUnProcessPo" })
	@CrossOrigin("*")
	public String getAllUnProcessPo(HttpServletRequest request ) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
			System.out.println("vendorCode in getAllUnProcessPo : "+vendorCode);
			List<PoDetails> details = podetailsRepo.getAllUnProcessPo(vendorCode);
			
			data.setData(details);
			data.setMsg("success");
			System.out.println("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	
	
	@RequestMapping({ "/getAllInvoiceDetails" })
	@CrossOrigin("*")
	public String getAllInvoiceDetails(HttpServletRequest request ) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
			System.out.println("vendorCode in getAllUnProcessPo : "+vendorCode);
			List<PoInvoiceDetails> details = poInvoiceRepo.findByVendorCode(vendorCode);
			
			data.setData(details);
			data.setMsg("success");
			System.out.println("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	@RequestMapping({ "/getSelectInvoiceDetailsPo" })
	@CrossOrigin("*")
	public String getSelectInvoiceDetailsPo(HttpServletRequest request ,@RequestBody PoInvoiceDetails details ) {

		DataContainer data = new DataContainer();
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			
			List<PoInvoiceDetails> poInvoiceDetails = poInvoiceRepo.findByInvoiceNumber(details.getInvoiceNumber());
			
			data.setData(poInvoiceDetails);
			data.setMsg("success");
			System.out.println("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllPODetailsByPoNo" })
	@CrossOrigin("*")
	public String getAllPODetailsByPoNo(HttpServletRequest request ,@RequestBody PoDetails details ) {

		DataContainer data = new DataContainer();
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
			
			List<PoDetails> poInvoiceDetails = podetailsRepo.getPoDetailsByPoNo(details.getPoNo(),vendorCode);
			
			data.setData(poInvoiceDetails);
			data.setMsg("success");
			System.out.println("end of allPoDetails success");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	
	@RequestMapping({ "/savePoInvoiceQuery" })
	@CrossOrigin("*")
	public String savePoInvoiceQuery(HttpServletRequest request ,@RequestBody  QueryEntity details) {

		DataContainer data = new DataContainer();
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String raisedBy = (String) request.getSession().getAttribute("userName");
			
			details.setRaisedBy(raisedBy);
			System.out.println("commt : "+details.getComment());
			details.setRaisedOn(new Date());
			
			
			
			queryRepo.save(details);
			
			data.setMsg("success");
			System.out.println("end of allPoDetails success");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	
	@RequestMapping({ "/getPoQueryData" })
	@CrossOrigin("*")
	public String getPoQueryData(HttpServletRequest request ,@RequestBody  QueryEntity details) {

		DataContainer data = new DataContainer();
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			
			String raisedBy = (String) request.getSession().getAttribute("userName");
			details.setRaisedBy(raisedBy);
			List<QueryEntity> getPoQueryData = queryRepo.findCommentsByRefIDPo(details.getReferenceid(),details.getRaisedBy());
			
			data.setData(getPoQueryData);
			
			data.setMsg("success");
			System.out.println("end of getPoQueryData success");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	@RequestMapping({ "filterPoDetails" })
	@CrossOrigin("*")
	public String filterPoDetails(Principal principal, HttpServletRequest request,
			@RequestParam(name = "actualDeparture") String fromDate,
			@RequestParam(name = "actualArrival") String toDate) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println("fromDate : "+fromDate+" toDate : "+toDate);
		String vendorCode=principal.getName();
		try {
			/*
			 * if(fromDate != "" && toDate != "") { List<TripDetails> getListByDateFilter =
			 * podetailsRepo.findByActualDepartureBetween(fromDate, toDate);
			 * data.setData(getListByDateFilter); data.setMsg("success"); }
			 */
			if(fromDate != "" && toDate != "" && vendorCode != ""  ) {
				List<PoDetails> getListByDateFilter = podetailsRepo.findByActualDepartureBetween(fromDate, toDate,
						vendorCode);
				data.setData(getListByDateFilter);
				data.setMsg("success");
			}
			
		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}
		
	
}
