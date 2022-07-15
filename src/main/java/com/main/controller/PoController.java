package com.main.controller;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(PoController.class);

	@PostMapping({ "/getAllPODetails" })
	@CrossOrigin("*")
	public String getActiveMasterData(HttpServletRequest request, Principal principal) {

		logger.info("Log Some Information : " + dateTimeFormatter.format(LocalDateTime.now()));
		String vendorCode = principal.getName();
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<PoDetails> allPoDetails = serviceManager.podetailsRepo.findByVendorCode(vendorCode);

			data.setData(allPoDetails);
			data.setMsg("success");
			logger.info("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/poDetailsByPoNo" })
	@CrossOrigin("*")
	public String poDetailsByPoNo(HttpServletRequest request, @RequestBody PoDetails details) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			details = serviceManager.podetailsRepo.findByPoNo(details.getPoNo());

			data.setData(details);
			data.setMsg("success");
			logger.info("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getAllProcessPo" })
	@CrossOrigin("*")
	public String getAllProcessPo(HttpServletRequest request, Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = principal.getName();
			List<PoDetails> details = serviceManager.podetailsRepo.getAllProcessPo(vendorCode);

			data.setData(details);
			data.setMsg("success");
			logger.info("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error in getAllProcessPo method : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getAllUnProcessPo" })
	@CrossOrigin("*")
	public String getAllUnProcessPo(HttpServletRequest request,Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = principal.getName();
			logger.info("vendorCode in getAllUnProcessPo : " + vendorCode);
			List<PoDetails> details = serviceManager.podetailsRepo.getAllUnProcessPo(vendorCode);

			data.setData(details);
			data.setMsg("success");
			logger.info("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getAllInvoiceDetails" })
	@CrossOrigin("*")
	public String getAllInvoiceDetails(HttpServletRequest request,Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String vendorCode = principal.getName();

			if (vendorCode.equals("finance1")) {
				logger.info("vendorCode in getAllUnProcessPo : " + vendorCode);
				List<PoInvoiceDetails> details = serviceManager.poinvoiceRepo.getAllInvoiceDetailsForFinance();
				data.setData(details);

			} else {
				logger.info("vendorCode in getAllUnProcessPo : " + vendorCode);
				List<PoInvoiceDetails> details = serviceManager.poinvoiceRepo.getAllInvoiceDetails(vendorCode);
				data.setData(details);
			}

			data.setMsg("success");
			logger.info("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getSelectInvoiceDetailsPo" })
	@CrossOrigin("*")
	public String getSelectInvoiceDetailsPo(HttpServletRequest request,Principal principal, @RequestBody PoInvoiceDetails details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = principal.getName();

			if (vendorCode.equals("finance1")) {
				List<PoInvoiceDetails> poInvoiceDetails = serviceManager.poinvoiceRepo
						.findByInvoiceNumberByFinance(details.getInvoiceNumber());
				data.setData(poInvoiceDetails);
			} else {
				List<PoInvoiceDetails> poInvoiceDetails = serviceManager.poinvoiceRepo.findByInvoiceNumber(vendorCode,
						details.getInvoiceNumber());
				data.setData(poInvoiceDetails);
			}
			data.setMsg("success");
			logger.info("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getAllPODetailsByPoNo" })
	@CrossOrigin("*")
	public String getAllPODetailsByPoNo(HttpServletRequest request,Principal principal, @RequestBody PoDetails details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = principal.getName();

			List<PoDetails> poInvoiceDetails = serviceManager.podetailsRepo.getPoDetailsByPoNo(details.getPoNo(),
					vendorCode);

			data.setData(poInvoiceDetails);
			data.setMsg("success");
			logger.info("end of allPoDetails success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getAllPODetailsByLineNumber" })
	@CrossOrigin("*")
	public String getAllPODetailsByLineNumber(HttpServletRequest request, @RequestBody PoLineDetails details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<PoLineDetails> poInvoiceDetails = serviceManager.poLineItemRepo
					.getDataByLineNumber(details.getPoLineId());

			data.setData(poInvoiceDetails.get(0));
			data.setMsg("success");
			logger.info("end of allPoDetails success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/savePoInvoiceQuery" })
	@CrossOrigin("*")
	public String savePoInvoiceQuery(HttpServletRequest request,Principal principal, @RequestBody QueryEntity details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String raisedBy =principal.getName();

			details.setRaisedBy(raisedBy);
			logger.info("commt : " + details.getComment());
			details.setRaisedOn(new Date());

			serviceManager.queryRepo.save(details);

			data.setMsg("success");
			logger.info("end of allPoDetails success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getPoQueryData" })
	@CrossOrigin("*")
	public String getPoQueryData(HttpServletRequest request,Principal principal, @RequestBody QueryEntity details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String raisedBy = principal.getName();
			details.setRaisedBy(raisedBy);
			List<QueryEntity> getPoQueryData = serviceManager.queryRepo.findCommentsByRefIDPo(details.getReferenceid(),
					details.getRaisedBy());

			data.setData(getPoQueryData);

			data.setMsg("success");
			logger.info("end of getPoQueryData success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@GetMapping({ "filterPoDetails" })
	@CrossOrigin("*")
	public String filterPoDetails(Principal principal, HttpServletRequest request,
			@RequestParam(name = "actualDeparture") Date fromDate, @RequestParam(name = "actualArrival") Date toDate) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		logger.info("fromDate : " + fromDate + " toDate : " + toDate);
		String vendorCode = principal.getName();
		try {

			List<PoDetails> getListByDateFilter = serviceManager.podetailsRepo.findByActualDepartureBetween(fromDate,
					toDate, vendorCode);
			data.setData(getListByDateFilter);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/updateRemaningQuantity" })
	@CrossOrigin("*")
	public String updateRemaningQuantity(HttpServletRequest request,Principal principal, @RequestBody PoAndLineItem details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String processBy=principal.getName();
			Date proceessOn=new Date();
			
			logger.info("getRemaningQuatity in po line :::::::: " + details.getRemaningQuatity() + "poLineId"
					+ details.getId());

			serviceManager.podetailsRepo.updateRemaningQuatity(details.getRemaningQuatity(), details.getId());

			Integer flag = details.getFlag();
			if (flag == 1) {
				serviceManager.podetailsRepo.updateVendorPoStatusAgainsInvoiceNumber(details.getPoNumber(),proceessOn,processBy);
			} else {
				serviceManager.podetailsRepo.updateVendorPoStatusUnprocess(details.getPoNumber(),proceessOn,processBy);
			}

			logger.info("end of getPoQueryData success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/updateRemaningQuantitydraft" })
	@CrossOrigin("*")
	public String updateRemaningQuantitydraft(HttpServletRequest request,Principal principal, @RequestBody PoAndLineItem details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			logger.info("getRemaningQuatity" + details.getRemaningQuatity() + "id" + details.getId());

			serviceManager.podetailsRepo.updateRemaningQuatity(details.getRemaningQuatity(), details.getId());
			String processBy=principal.getName();
			Date proceessOn=new Date();
			System.out.println("processBy"+processBy+" :::proceessOn"+proceessOn);
			// serviceManager.podetailsRepo.updateRemaningQuantitydraft(details.getRemaningQuatity(),
			// details.getLineNumberpo());
			
			Integer flag = details.getFlag();
			if (flag == 1) {
				serviceManager.podetailsRepo.updateVendorPoStatusAgainsInvoiceNumber(details.getPoNumber(),proceessOn,processBy);
			} else {
				serviceManager.podetailsRepo.updateVendorPoStatusUnprocess(details.getPoNumber(),proceessOn,processBy);
			}

			logger.info("end of updateRemaningQuantitydraft ");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getCurrentRemaningQty" })
	@CrossOrigin("*")
	public String getCurrentRemaningQty(HttpServletRequest request, @RequestBody PoAndLineItem details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String getRemaningQuatity = serviceManager.podetailsRepo.getCurrentRemaningQty(details.getPoLineId());
			if (getRemaningQuatity == null) {

				getRemaningQuatity = serviceManager.podetailsRepo.getCurrentQty(details.getPoLineId());
			}
			data.setData(getRemaningQuatity);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

}
