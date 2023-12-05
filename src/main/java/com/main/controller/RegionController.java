package com.main.controller;

import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.Region;
import com.main.db.bpaas.entity.Verifier;
import com.main.payloads.RegionDTO;
import com.main.payloads.VerifierDTO;
import com.main.service.RegionService;
import com.main.servicemanager.ServiceManager;

@RestController
@RequestMapping("/region")
public class RegionController {
	
	@Autowired
	private ServiceManager serviceManager;
	
	@Autowired
	private RegionService regionService;
	
	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(VerifierController.class);
	
	@PostMapping("/saveRegion")
	public String saveRegion(HttpServletRequest request,
			@Valid @RequestBody RegionDTO regionDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			
			data = regionService.addRegion(regionDto);
		} catch (Exception e) {
			e.printStackTrace();
			  data.setMsg(GlobalConstants.ERROR_MESSAGE);
		        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		    }
			
		return gson.toJson(data);
	}
	
	
	@GetMapping("/listOfAllRegions")
	public String listOfAllRegions() {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        data = regionService.listOfAllRegions();
	       
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }

	    return gson.toJson(data);
	}
	
	@GetMapping("/getRegion")
	public String getRegion(@PathVariable Integer id) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	        Region region = regionService.findRegionById(id);
	        if (region != null) {
	            RegionDTO regionDto = serviceManager.modelMapper.map(region, RegionDTO.class);
	            data.setData(regionDto);
	            data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
	        } else {
	            data.setMsg("Region not found");
	        }
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }

	    return gson.toJson(data);
	}
	
	
	@PutMapping("/updateRegion")
	public String updateRegion( @RequestBody RegionDTO regionDto) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
			
			data = regionService.updateRegion(regionDto);
		} catch (Exception e) {
			e.printStackTrace();
			  data.setMsg(GlobalConstants.ERROR_MESSAGE);
		        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		    }

	    return gson.toJson(data);
	}
	
	
	@GetMapping("/regions/status/{status}")
	public String getRegionsByStatus(@PathVariable String status) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
	    
	    try {
	        List<Region> regions = regionService.findByStatus(status);
	        List<RegionDTO> regionDTOs = regions.stream()
	                .map(region -> serviceManager.modelMapper.map(region, RegionDTO.class))
	                .collect(Collectors.toList());
	        
	        data.setData(regionDTOs);
	        data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }
	    
	    return gson.toJson(data);
	}
	
	
	@DeleteMapping("/deleteRegion/{id}")
	public String deleteRegion(@PathVariable Integer id) {
	    DataContainer data = new DataContainer();
	    Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

	    try {
	       data = regionService.deleteRegion(id);
	        
	       
	    } catch (Exception e) {
	        data.setMsg(GlobalConstants.ERROR_MESSAGE);
	        logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
	    }

	    return gson.toJson(data);
	}


}
