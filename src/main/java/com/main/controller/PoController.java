package com.main.controller;

import java.security.Principal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.bean.PoAndLineItem;
import com.main.db.bpaas.entity.PoDetails;
import com.main.db.bpaas.entity.PoInvoiceDetails;
import com.main.db.bpaas.entity.PoLineDetails;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/poController")
@RestController
public class PoController {

	@Autowired
	private ServiceManager serviceManager;

	@RequestMapping({ "/getAllPODetails" })
	@CrossOrigin("*")
	public String getActiveMasterData(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<PoDetails> allPoDetails = serviceManager.podetailsRepo.findAll();

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
	public String poDetailsByPoNo(HttpServletRequest request, @RequestBody PoDetails details) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			details = serviceManager.podetailsRepo.findByPoNo(details.getPoNo());

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
	public String getAllProcessPo(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
			List<PoDetails> details = serviceManager.podetailsRepo.getAllProcessPo(vendorCode);

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
	public String getAllUnProcessPo(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
			System.out.println("vendorCode in getAllUnProcessPo : " + vendorCode);
			List<PoDetails> details = serviceManager.podetailsRepo.getAllUnProcessPo(vendorCode);

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
	public String getAllInvoiceDetails(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
			System.out.println("vendorCode in getAllUnProcessPo : " + vendorCode);
			List<PoInvoiceDetails> details = serviceManager.poinvoiceRepo.getAllInvoiceDetails(vendorCode);

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
	public String getSelectInvoiceDetailsPo(HttpServletRequest request, @RequestBody PoInvoiceDetails details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
			List<PoInvoiceDetails> poInvoiceDetails = serviceManager.poinvoiceRepo.findByInvoiceNumber(vendorCode,
					details.getInvoiceNumber());

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
	public String getAllPODetailsByPoNo(HttpServletRequest request, @RequestBody PoDetails details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");

			List<PoDetails> poInvoiceDetails = serviceManager.podetailsRepo.getPoDetailsByPoNo(details.getPoNo(),
					vendorCode);

			data.setData(poInvoiceDetails);
			data.setMsg("success");
			System.out.println("end of allPoDetails success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllPODetailsByLineNumber" })
	@CrossOrigin("*")
	public String getAllPODetailsByLineNumber(HttpServletRequest request, @RequestBody PoLineDetails details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<PoLineDetails> poInvoiceDetails = serviceManager.poLineItemRepo
					.getDataByLineNumber(details.getLineNumber());

			data.setData(poInvoiceDetails.get(0));
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
	public String savePoInvoiceQuery(HttpServletRequest request, @RequestBody QueryEntity details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String raisedBy = (String) request.getSession().getAttribute("userName");

			details.setRaisedBy(raisedBy);
			System.out.println("commt : " + details.getComment());
			details.setRaisedOn(new Date());

			serviceManager.queryRepo.save(details);

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
	public String getPoQueryData(HttpServletRequest request, @RequestBody QueryEntity details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String raisedBy = (String) request.getSession().getAttribute("userName");
			details.setRaisedBy(raisedBy);
			List<QueryEntity> getPoQueryData = serviceManager.queryRepo.findCommentsByRefIDPo(details.getReferenceid(),
					details.getRaisedBy());

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
			@RequestParam(name = "actualDeparture") Date fromDate,
			@RequestParam(name = "actualArrival") Date toDate) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println("fromDate : " + fromDate + " toDate : " + toDate);
		String vendorCode = principal.getName();
		try {
			
				List<PoDetails> getListByDateFilter = serviceManager.podetailsRepo
						.findByActualDepartureBetween(fromDate, toDate, vendorCode);
				data.setData(getListByDateFilter);
				data.setMsg("success");
			

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/updateRemaningQuantity" })
	@CrossOrigin("*")
	public String updateRemaningQuantity(HttpServletRequest request, @RequestBody PoAndLineItem details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			System.out.println("getRemaningQuatity" + details.getRemaningQuatity() + "id" + details.getId());

			serviceManager.podetailsRepo.updateRemaningQuatity(details.getRemaningQuatity(), details.getId());

			Integer flag = details.getFlag();
			if (flag == 1) {
				serviceManager.podetailsRepo.updateVendorPoStatusAgainsInvoiceNumber(details.getPoNumber());
			} else {
				serviceManager.podetailsRepo.updateVendorPoStatusUnprocess(details.getPoNumber());
			}

			System.out.println("end of getPoQueryData success");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/updateRemaningQuantitydraft" })
	@CrossOrigin("*")
	public String updateRemaningQuantitydraft(HttpServletRequest request, @RequestBody PoAndLineItem details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			System.out.println("getRemaningQuatity" + details.getRemaningQuatity() + "id" + details.getInvoiceno());

			serviceManager.podetailsRepo.updateRemaningQuantitydraft(details.getRemaningQuatity(),
					details.getLineNumberpo());

			Integer flag = details.getFlag();
			if (flag == 1) {
				serviceManager.podetailsRepo.updateVendorPoStatusAgainsInvoiceNumber(details.getPoNumber());
			} else {
				serviceManager.podetailsRepo.updateVendorPoStatusUnprocess(details.getPoNumber());
			}

			System.out.println("end of getPoQueryData success");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getCurrentRemaningQty" })
	@CrossOrigin("*")
	public String getCurrentRemaningQty(HttpServletRequest request, @RequestBody PoAndLineItem details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String getRemaningQuatity = serviceManager.podetailsRepo.getCurrentRemaningQty(details.getLineNumberpo());

			data.setData(getRemaningQuatity);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

}
