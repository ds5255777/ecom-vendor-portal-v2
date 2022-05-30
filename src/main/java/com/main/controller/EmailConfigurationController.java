package com.main.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/emailConfigurationController")
@RestController
public class EmailConfigurationController {

	@Autowired 		
	ServiceManager serviceManager;
	
	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(InvoiceController.class);
	  
	  @RequestMapping({"/saveUpdateEmailData"})	
	    @CrossOrigin("*")
	    public String saveUpdateEmailData(HttpServletRequest request, @RequestBody EmailConfiguration entity) {
		  
		  logger.info("Log Some Information : "+dateTimeFormatter.format(LocalDateTime.now()));
				DataContainer data= new DataContainer();
				Gson gson=new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
					try {
						
						serviceManager.emailConfigurationRepository.save(entity);
						data.setMsg("success");
						
					 }
						catch (Exception e) {
						data.setMsg("error");
					
						logger.error("error : "+e);
						
					}
			
				return gson.toJson(data).toString();
		}
		
	  
	    @RequestMapping({"/getEmailCofigurationDataById"})	
	    @CrossOrigin("*")
	    public String getEmailCofigurationDataById(HttpServletRequest request, @RequestBody EmailConfiguration entity) {
		
				DataContainer data= new DataContainer();
				Gson gson=new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
					try {
						
						Optional<EmailConfiguration> email=serviceManager.emailConfigurationRepository.findById(entity.getId());
						data.setData(email.get());
						data.setMsg("success");
						
					 }
						catch (Exception e) {
						data.setMsg("error");
					
						logger.error("error : "+e);
						
					}
			
				return gson.toJson(data).toString();
		}
	    
	    @RequestMapping({"/getEmailCofigurationDataByStatus"})	
	    @CrossOrigin("*")
	    public String getEmailCofigurationDataByStatus(HttpServletRequest request, @RequestBody EmailConfiguration entity) {
		
				DataContainer data= new DataContainer();
				Gson gson=new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
					try {
						
						List<EmailConfiguration>emailList=serviceManager.emailConfigurationRepository.findByIsActive("1");
						data.setData(emailList);
						data.setMsg("success");
						
					 }
						catch (Exception e) {
						data.setMsg("error");
					
						logger.error("error : "+e);
						
					}
			
				return gson.toJson(data).toString();
		}
		
	    @RequestMapping({"/updateEmailConfigurationSatatusByid"})	
	    @CrossOrigin("*")
	    public String updateEmailConfigurationSatatusByid(HttpServletRequest request, @RequestBody EmailConfiguration entity) {
		
				DataContainer data= new DataContainer();
				Gson gson=new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
					try {
						
						
						serviceManager.emailConfigurationRepository.updateEmailConfigurationSatatusByid(entity.getIsActive(),entity.getId());
						data.setMsg("success");
						
					 }
						catch (Exception e) {
						data.setMsg("error");
					
						logger.error("error : "+e);
						
					}
			
				return gson.toJson(data).toString();
		}
	    
	    
	    
		
	    
}
