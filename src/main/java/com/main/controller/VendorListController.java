package com.main.controller;

import java.time.format.DateTimeFormatter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.SupDetails;
import com.main.service.SupDetailsService;
import com.main.service.VendorListService;
import com.main.servicemanager.ServiceManager;

@RestController
public class VendorListController {
	
	@Autowired
	private ServiceManager serviceManager;
	
	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(VerifierController.class);
	
	
	@Autowired
	private SupDetailsService supDetailsService;

	@GetMapping("/getSupplierDetailsByVendorPid/{vendorPid}")
	public ResponseEntity<DataContainer> getSupplierDetailsByVendorPid(@PathVariable String vendorPid) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	    	SupDetails supplierDetails = supDetailsService.getSupplierDetailsByVendorPid(vendorPid);
	        if (supplierDetails != null) {
	            data.setData(supplierDetails);
	            data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
	            return ResponseEntity.ok(data);
	        } else {
	            data.setMsg(GlobalConstants.ERROR_MESSAGE);
	            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(data);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(data);
	    }
	}

	
}
