package com.main.controller;

import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.Verifier;
import com.main.payloads.VerifierDTO;
import com.main.service.VerifierService;
import com.main.servicemanager.ServiceManager;

@RestController
@RequestMapping("/verifier")
public class VerifierController {
	
	
	@Autowired
	private VerifierService verifierService;
	
	@Autowired
	private ServiceManager serviceManager;
	
	
	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(VerifierController.class);

	@PostMapping("/createVerifier")
	public String saveVarifier(HttpServletRequest request,
			@Valid @RequestBody VerifierDTO verifierDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			
			data = verifierService.addVerifier(verifierDto);
		} catch (Exception e) {
			e.printStackTrace();
			  data.setMsg(GlobalConstants.ERROR_MESSAGE);
		        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		    }
			
		return gson.toJson(data);
	}
	
	
	@GetMapping("/listOfAllVerifiers")
	public String listOfAllVerifiers() {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data = verifierService.listOfAllVerifiers();
	       
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }

	    return gson.toJson(data);
	}


	@GetMapping("/getVerifier/{id}")
	public String getVerifier(@PathVariable Long id) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        Verifier verifier = verifierService.findVerifierById(id);
	        if (verifier != null) {
	            VerifierDTO verifierDto = serviceManager.modelMapper.map(verifier, VerifierDTO.class);
	            data.setData(verifierDto);
	            data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
	        } else {
	            data.setMsg("Verifier not found");
	        }
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }

	    return gson.toJson(data);
	}


	@PutMapping("/updateVerifier")
	public String updateVerifier( @RequestBody VerifierDTO verifierDto) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
			
			data = verifierService.updateVerifier(verifierDto);
		} catch (Exception e) {
			e.printStackTrace();
			  data.setMsg(GlobalConstants.ERROR_MESSAGE);
		        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		    }

	    return gson.toJson(data);
	}
	
	
	@GetMapping("/verifiers/status/{status}")
	public String getVerifierByStatus(@PathVariable String status) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
	    
	    try {
	        List<Verifier> verifiers = verifierService.findByStatus(status);
	        List<VerifierDTO> verifierDto = verifiers.stream()
	                .map(verifier -> serviceManager.modelMapper.map(verifier, VerifierDTO.class))
	                .collect(Collectors.toList());
	        
	        data.setData(verifierDto);
	        data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }
	    
	    return gson.toJson(data);
	}
	
	
	@PutMapping("/deleteVerifier/{id}")
	public String deleteVerifier(@PathVariable Long id) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	       data = verifierService.deleteVerifier(id);
	        
	       
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }

	    return gson.toJson(data);
	}
	
	@GetMapping("/listOfAllVerifiersByRegion")
	public String getVerifierNameByRegionId(@RequestParam ("regionList") String regionList) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        List<VerifierDTO> verifierNames = verifierService.getVerifierNamesByRegionList(Arrays.asList(regionList.split(",")));
	        data.setData(verifierNames);
	        data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }

	    return gson.toJson(data);
	}
	
	
	


}
