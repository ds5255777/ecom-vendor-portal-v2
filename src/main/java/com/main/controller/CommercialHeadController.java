package com.main.controller;

import java.security.Principal;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpServletRequest;

import org.modelmapper.ModelMapper;
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
import com.main.db.bpaas.entity.SendEmailToVendor;
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.entity.Verifier;
import com.main.payloads.SendEmailToVendorDTO;
import com.main.payloads.SupDetailsDTO;
import com.main.payloads.VerifierDTO;
import com.main.service.CommercialHeadService;
import com.main.servicemanager.ServiceManager;
@RequestMapping("/CommercialHeadController")
@RestController
public class CommercialHeadController {
	
	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(CommercialHeadController.class);

	@Autowired
	private ServiceManager serviceManager;
	
	@Autowired
	private CommercialHeadService commercialHeadService;
	
	
	@GetMapping("/getDetailFromCommercialTeam")
	public String getDetailFromCommercialTeam(Principal principal) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data = commercialHeadService.getDetailFromCommercialTeam(principal);
	       
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }

	    return gson.toJson(data);
	}
	
	
	// this is approve api
	@PutMapping("/findCommercialTeamDetails")
	public String findCommercialTeamDetailsById(HttpServletRequest request,@RequestBody SendEmailToVendorDTO sendEmailToVendorDto,Principal principal) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data=commercialHeadService.findCommercialTeamDetailsById(sendEmailToVendorDto,principal,request);
	        
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }
	    

	    return gson.toJson(data);
	}
	
	@PutMapping("/rasieQueryCommercialTeam")
	public String rasieQueryCommercialTeam(HttpServletRequest request,@RequestBody SendEmailToVendorDTO sendEmailToVendorDto,Principal principal) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data=commercialHeadService.rasieQueryCommercialTeam(sendEmailToVendorDto,principal,request);
	        
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }
	    

	    return gson.toJson(data);
	}
	

	@PutMapping("/approveByCommercialTeam")
	public String approveByCommercialTeam(HttpServletRequest request,@RequestBody SendEmailToVendorDTO sendEmailToVendorDto,Principal principal) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data=commercialHeadService.approveByCommercialTeam(sendEmailToVendorDto,principal,request);
	        
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }
	    

	    return gson.toJson(data);
	}
	
	
	@GetMapping("/findListOfAllVendorByThirdPartyVerifier")
	public String findListOfAllVendorByThirdPartyVerifier() {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			data = commercialHeadService.findListOfAllVendorByThirdPartyVerifier();

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}
	
	
//	@GetMapping("/getSupplierDetailsByThirdPartyVerifier")
//	public String getSupplierDetailsByThirdPartyVerifier() {
//	    DataContainer data = new DataContainer();
//	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
//
//	    try {
//	        data=commercialHeadService.getSupplierDetailsByThirdPartyVerifier();
//	        
//	    } catch (Exception e) {
//	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
//	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
//	    }
//	    
//
//	    return gson.toJson(data);
//	}
	
	@GetMapping("/getCommentDetailsOnThirdPartyVerifierPage")
	public String getCommentDetailsOnThirdPartyVerifierPage(@RequestParam(value = "vendorPid") String vendorPid) {
		
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			data  = commercialHeadService.getCommentDetailsOnThirdPartyVerifierPage(vendorPid);

		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}
	
	
	@PutMapping("/rejectCommercialTeamDetails")
	public String rejectCommercialTeamDetails(@RequestBody SendEmailToVendorDTO sendEmailToVendorDto,HttpServletRequest request, Principal principal) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data=commercialHeadService.rejectCommercialTeamDetails(sendEmailToVendorDto,request,principal);
	        
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }

	    return gson.toJson(data);
	}
	
	@PutMapping("/rejectByVerifier")
	public String rejectByVerifier(@RequestBody SendEmailToVendorDTO sendEmailToVendorDto,HttpServletRequest request, Principal principal) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data=commercialHeadService.rejectByVerifier(sendEmailToVendorDto,request,principal);
	        
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }

	    return gson.toJson(data);
	}
	
	
	@PutMapping("/approveByThirdPartyVerifier")
	public String approveByThirdPartyVerifier(HttpServletRequest request,@RequestBody SendEmailToVendorDTO sendEmailToVendorDto,Principal principal) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data=commercialHeadService.approveByThirdPartyVerifier(sendEmailToVendorDto,principal,request);
	        
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }
	    

	    return gson.toJson(data);
	}
	
	@GetMapping("/findListOfAllVendorByEhsVerifier")
	public String findListOfAllVendorByEhsVerifier(HttpServletRequest request,Principal principal) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data=commercialHeadService.findListOfAllVendorByEhsVerifier(request,principal);
	        
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }
	    

	    return gson.toJson(data);
	}
	
	
	@PutMapping("/rejectByEhsVerifier")
	public String rejectByEhsVerifier(@RequestBody SendEmailToVendorDTO sendEmailToVendorDto,HttpServletRequest request, Principal principal) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data=commercialHeadService.rejectByEhsVerifier(sendEmailToVendorDto,request,principal);
	        
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }

	    return gson.toJson(data);
	}
	
	
	@PutMapping("/approveByEhsVerifier")
	public String approveByEhsVerifier(HttpServletRequest request,@RequestBody SendEmailToVendorDTO sendEmailToVendorDto,Principal principal) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data=commercialHeadService.approveByEhsVerifier(sendEmailToVendorDto,principal,request);
	        
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }
	    

	    return gson.toJson(data);
	}
	
	@PutMapping("/approveBySeniorManagerForEhsVerification")
	public String approveBySeniorManagerForEhsVerification(HttpServletRequest request,@RequestBody SendEmailToVendorDTO sendEmailToVendorDto,Principal principal) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data=commercialHeadService.approveBySeniorManagerForEhsVerification(sendEmailToVendorDto,principal,request);
	        
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }
	    

	    return gson.toJson(data);
	}
	
	
	@PutMapping("/rejectByEhsManager")
	public String rejectByEhsManager(@RequestBody SendEmailToVendorDTO sendEmailToVendorDto,HttpServletRequest request, Principal principal) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data=commercialHeadService.rejectByEhsManager(sendEmailToVendorDto,request,principal);
	        
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }

	    return gson.toJson(data);
	}
	
	
	@GetMapping("/findListOfAllVendorByDocumentChecker")
	public String findListOfAllVendorByDocumentChecker(HttpServletRequest request,Principal principal) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			data = commercialHeadService.findListOfAllVendorByDocumentChecker(request,principal);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}
	
	
}
