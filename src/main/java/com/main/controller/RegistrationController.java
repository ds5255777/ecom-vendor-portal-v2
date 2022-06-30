package com.main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.SupDetails;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/registrationController")
@RestController
public class RegistrationController {

	@Autowired
	private ServiceManager serviceManager;

	@PostMapping({ "/getPendingRequest" })
	@CrossOrigin("*")
	public String getPendingRequest(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<Object[]> users = serviceManager.supDetailsRepo
					.findByPendingVenStatus(GlobalConstants.PENDING_REQUEST_STATUS);
			data.setMsg("success");
			data.setData(users);

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}
	
	@PostMapping({ "/getApprovedRequest" })
	@CrossOrigin("*")
	public String getApprovedRequest(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<Object[]> users = serviceManager.supDetailsRepo
					.findByPendingVenStatus(GlobalConstants.APPROVED_REQUEST_STATUS);
			data.setMsg("success");
			data.setData(users);

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}
	
	@PostMapping({ "/getRejectedRequest" })
	@CrossOrigin("*")
	public String getRejectedRequest(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<Object[]> users = serviceManager.supDetailsRepo
					.findByPendingVenStatus(GlobalConstants.REJECTED_REQUEST_STATUS);
			data.setMsg("success");
			data.setData(users);

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}
	
	@PostMapping({ "/getQueryRequest" })
	@CrossOrigin("*")
	public String getQueryRequest(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<Object[]> users = serviceManager.supDetailsRepo
					.findByPendingVenStatus(GlobalConstants.QUERY_REQUEST_STATUS);
			data.setMsg("success");
			data.setData(users);

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	// updateVendorRegistrationStatus

	@PostMapping({ "/updateVendorRegistrationStatus" })
	@CrossOrigin("*")
	public String updateVendorRegistrationStatus(HttpServletRequest request, @RequestBody SupDetails obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			obj = serviceManager.supDetailsRepo.findByPid(obj.getPid());
			data.setData(obj);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}
	
	@PostMapping({ "/getAllApprovedVendor" })
	@CrossOrigin("*")
	public String getAllApprovedVendor(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<SupDetails>  approvedVendor= serviceManager.supDetailsRepo.findByVenStatus(GlobalConstants.APPROVED_REQUEST_STATUS);
			data.setData(approvedVendor);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}
	
	@PostMapping({ "/approveRequest" })
	@CrossOrigin("*")
	public String approveRequest(HttpServletRequest request,@RequestBody SupDetails supDetails ) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			serviceManager.supDetailsRepo.approveRequestByPid(supDetails.getPid(), GlobalConstants.APPROVED_REQUEST_STATUS);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}
	
	@PostMapping({ "/rejectedRequest" })
	@CrossOrigin("*")
	public String rejectedRequest(HttpServletRequest request,@RequestBody SupDetails supDetails ) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			serviceManager.supDetailsRepo.approveRequestByPid(supDetails.getPid(), GlobalConstants.REJECTED_REQUEST_STATUS);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}
	
	
	
	@PostMapping({ "/getAllRequest" })
	@CrossOrigin("*")
	public String getAllRequest(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<SupDetails> findAll = serviceManager.supDetailsRepo.findAll();
			data.setData(findAll);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

}
