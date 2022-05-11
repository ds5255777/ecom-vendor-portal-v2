package com.main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.PoDetails;
import com.main.db.bpaas.entity.PoInvoiceDetails;
import com.main.db.bpaas.entity.PoInvoiceLine;
import com.main.db.bpaas.repo.PoDetailsRepo;
import com.main.db.bpaas.repo.PoInvoiceRepo;

@RequestMapping("/PoInvoiceContoller")
@RestController
public class PoInvoiceContoller {

	@Autowired
	PoInvoiceRepo poInvoiceRepo;
	
	@Autowired
	PoDetailsRepo poDetailsRepo;
	
	@RequestMapping({ "/deleteDraftPoInvoice" })
	@CrossOrigin("*")
	public String deleteDraftPoInvoice(HttpServletRequest request, @RequestBody PoDetails obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			//Long id = obj.getId();
			
			//Long id = 2L;
			String ecomInvoiceNumber = obj.getInvoiceNumber();
			Long id = poInvoiceRepo.getId(ecomInvoiceNumber);
			System.out.println("ecomInvoiceNumber"+ecomInvoiceNumber);
			
			poInvoiceRepo.deleteById(id);
//			poInvoiceRepo.deleteByInvoiceNumber(ecomInvoiceNumber);
			poDetailsRepo.updatePoStatusagainsInvoiceNumber(ecomInvoiceNumber);

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllDraftInvoicePO" })
	@CrossOrigin("*")
	public String getAllDraftInvoicePO(HttpServletRequest request ) {

		DataContainer data = new DataContainer();
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
			
			List<PoDetails> poInvoiceDetails = poDetailsRepo.getAllDraftPoInvoice(vendorCode);
			
			data.setData(poInvoiceDetails);
			data.setMsg("success");
			System.out.println("end of draft success");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	
	@RequestMapping({ "/savePoInvoice" })
	@CrossOrigin("*")
	public String savePoInvoice(HttpServletRequest request ,@RequestBody PoInvoiceDetails invoiceDetails ) {

		DataContainer data = new DataContainer();
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
			
			
			
			
			String ecomInvoiceNumber = invoiceDetails.getInvoiceNumber();

			//Long idByinvocienumber = invoiceGenerationEntityRepo.getIdByinvocienumber(ecomInvoiceNumber);
			//System.out.println(idByinvocienumber);

			//if (null != idByinvocienumber) {
				//invoiceDetails.setStatus("Processed");
				//invoiceDetails.setId(ecomInvoiceNumber);
				System.out.println(ecomInvoiceNumber);
				
				List<PoInvoiceLine> poInvoiceLine =invoiceDetails.getPoInvoiceLine();
				//poInvoiceLine.remaningQuatity;
				
				 {				
				poDetailsRepo.updateVendorPoStatusAgainsInvoiceNumber(ecomInvoiceNumber);
				
				}
				
				invoiceDetails.setStatus("In-Review");
				invoiceDetails.setVendorCode(vendorCode);
				
				Long id = poInvoiceRepo.getId(ecomInvoiceNumber);
				System.out.println("ecomInvoiceNumber"+ecomInvoiceNumber);
				if(id!=null ) {
				poInvoiceRepo.deleteById(id);
					
				}
				//poInvoiceRepo.deleteByInvoiceNumber(ecomInvoiceNumber);
				
				poInvoiceRepo.save(invoiceDetails);
		
			data.setMsg("success");
			System.out.println("end of draft success");
	

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	
	
	@RequestMapping({ "/getAllDraftPODetailsByInvoiceNo" })
	@CrossOrigin("*")
	public String getAllDraftPODetailsByInvoiceNo(HttpServletRequest request ,@RequestBody PoInvoiceDetails invoiceDetails ) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
			String invoiceNo=invoiceDetails.getInvoiceNumber();
			System.out.println("vendorCode in getAllUnProcessPo : "+vendorCode + "invoiceNo : "+invoiceNo);
			List<PoInvoiceDetails> details = poInvoiceRepo.getAllDraftPODetailsByInvoiceNo(vendorCode,invoiceNo);
			
			data.setData(details);
			data.setMsg("success");
			System.out.println("end of allPoDetails");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();

	}
	
	@RequestMapping({ "/saveDraftInvoice" })
	@CrossOrigin("*")
	public String saveDraftInvoice(HttpServletRequest request ,@RequestBody PoInvoiceDetails invoiceDetails ) {

		DataContainer data = new DataContainer();
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String vendorCode = (String) request.getSession().getAttribute("userName");
		
			String ecomInvoiceNumber = invoiceDetails.getInvoiceNumber();

			invoiceDetails.setStatus("Draft-Invoicing");
			invoiceDetails.setVendorCode(vendorCode);
			System.out.println("save draft invoice , ecomInvoiceNumber : "+ecomInvoiceNumber);
			
			
			Long id = poInvoiceRepo.getId(ecomInvoiceNumber);
			System.out.println("ecomInvoiceNumber"+ecomInvoiceNumber);
			if(id!=null ) {
			poInvoiceRepo.deleteById(id);
				
			}
			
			poInvoiceRepo.save(invoiceDetails);
		
			data.setMsg("success");
			System.out.println("end of draft success");
	

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	

	
	

}
