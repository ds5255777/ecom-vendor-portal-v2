package com.main.controller;




import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.PoDetails;
import com.main.db.bpaas.repo.PoDetailsRepo;



@RequestMapping("/poController")
@RestController
public class PoController {

	
	@Autowired 
	PoDetailsRepo podetailsRepo;
	
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
	
	
	
	
	//@CrossOrigin("*")
	/*@GetMapping("/dashboard_Po")
	public String dashboard(Model model,  HttpServletRequest request) {

			String vendorCode = (String) request.getSession().getAttribute("userName");
			
			//po Details
			int totalProcessPoCount = podetailsRepo.getAllProcessPoCount(vendorCode);
			model.addAttribute("totalProcessPoCount", totalProcessPoCount);
			System.out.println("totalProcessPoCount : "+totalProcessPoCount);
			//request.setAttribute("totalProcessPoCount", totalProcessPoCount);
			
		
			System.out.println("end of dashboard_Po");

		return "dashboard_Po";
	}*/
	
}
